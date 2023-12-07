#!/usr/bin/env ruby 
# encoding: utf-8 

# This script rewrites markdown compiled from Scrivener to be compatible
# with the cross-referencing system used by Typst. It also adds paths for
# LaTeX, python and others so that compilation works directly from Scrivener
# (Scrivener doesn't use the user's environment or path by default).
# Version: 0.1.0

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'tempfile' # temp file tools
require 'fileutils' # ruby standard library to deal with files
#require 'debug/open_nonstop' # debugger, use binding.break to stop

def makePath() # this method augments our environment path
	home = ENV['HOME'] + '/'
	envpath = ''
	pathtest = [home+'.rbenv/shims', home+'.pyenv/shims', '/opt/homebrew/bin', '/usr/local/bin',
		'/usr/local/opt/ruby/bin', '/usr/local/lib/ruby/gems/2.7.0/bin',
		home+'Library/TinyTeX/bin/universal-darwin', '/Library/TeX/texbin',
		home+'anaconda/bin', home+'anaconda3/bin', home+'miniconda/bin', home+'miniconda3/bin',
		home+'micromamba/bin', home+'.cabal/bin', home+'.local/bin']
	pathtest.each { |p| envpath = envpath + ':' + p if File.directory?(p) }
	envpath.gsub!(/\/{2}/, '/')
	envpath.gsub!(/:{2}/, ':')
	envpath.gsub!(/(^:|:$)/, '')
	ENV['PATH'] = envpath + ':' + ENV['PATH']
	ENV['LANG'] = 'en_GB.UTF-8' if ENV['LANG'].nil? # Just in case we have no LANG, which breaks UTF8 encoding
	puts "--> Modified path: #{ENV['PATH'].chomp}"
	lap = ENV['HOME'] + '/.local/share/pandoc/custom/lapreprint.typ'
	if File.exist?(lap)
		puts "--> Copied #{lap} to current directory"
		FileUtils.cp(lap, './')
	end
end # end makePath()

def isRecent(infile) # checks if a file is less than 3 minutes old
	return false if !File.file?(infile)
	filetime = File.mtime(infile) # modified time
	difftime = Time.now - filetime # compare to now
	if difftime <= 180
		return true
	else
		return false
	end
end

infilename = File.expand_path(ARGV[0])
puts "--> Input Filename: #{infilename}"
fail "The specified file does not exist!" unless infilename and File.file?(infilename)

defType = ARGV[1]
if defType.nil?
	defType = 'lapreprint'
end
tstart = Time.now

#binding.break

# we choose to create several files rather than rewrite the same one to
# check transformations at each stage
makePath()
outfilename = infilename.gsub(/\.[q]?md$/,"-typst.md") # output to [name]-typst.md
outfilename2 = infilename.gsub(/\.[q]?md$/,"-typst.typ") # output to [name]-typst.typ
#outfilename3 = infilename.gsub(/\.[q]?md$/,"-typst2.typ") # output to [name]-typst2.typ
tfile = Tempfile.new('fix-x-refs') # create a temp file
lineSeparator = "\n"

# begin our regex replacements
begin
	File.open(infilename, 'r') do |file|
		text = file.read

		# replace any ${USERHOME} with the user's home directory
		text.gsub!(/\${USERHOME}\//, ENV['HOME']+'/')

		# cosmetic only: remove long runs (4 or more) of newlines
		text.gsub!(/\n{4,}/,"\n\n")

		# NOW HANDLED BY LUA FILTER ↓
		# This regex replaces @fig-… as a @reference
		# otherwise Pandoc treats it as a citation
		#text.gsub!(/(@fig-\w+)/, "\\1[Figure]")
		# This regex replaces @tbl-… as a @reference
		# otherwise Pandoc treats it as a citation
		#text.gsub!(/(@tbl-\w+)/, "\\1[Table]")
		# This regex replaces @eq-… as a @reference
		# otherwise Pandoc treats it as a citation
		#text.gsub!(/(@eq-\w+)/, "\\1[Equation]")

		# This regex replaces {#eq-} as a <label> to end of $$ math block lines
		text.gsub!(/\$\$\s*\n\s*{#(eq-.+?)}/,"$$\n<\\1>")

		# This regex replaces table cross-refs with <label>
		text.gsub!(/{#(tbl-.+?)}/,"<\\1>")
		text.gsub!(/(<tbl-.+?>)\s*$/,"\n\n\\1\n")

		# This regex replaces listing cross-refs with <label>
		text.gsub!(/{#(lst-.+?)}/,"<\\1>")
		text.gsub!(/(<lst-.+?>)\s*$/,"\n\n\\1\n")

		# This regex first replaces figure cross-refs with raw <label>
		text.gsub!(/(?<=!\[){#(fig-.+?)}/,"<\\1>")
		# this finds all figure labels  and moves them below the figure block
		figID = /^!\[(?<markup>[ \*_]*?)(?<id>\<fig-.+?\> ?)(?<cap>.+?)\]\[(?<ref>.+?)\]/
		text.gsub!(figID, "![\\k<markup>\\k<cap>][\\k<ref>]\n\n\\k<id>\n\n")

		# This regex removes {sizes} from images, e.g. [Fig1]: Fig1.pdf {width=596 height=233}
		text.gsub!(/width=\d+\s+height=\d+/, '')

		tfile.puts text
	end
	tfile.close
	FileUtils.mv(tfile.path, outfilename)
ensure
	tfile.close
	tfile.delete
end

# Build and run our pandoc command
cmd = "pandoc -d #{defType} -o #{outfilename2} #{outfilename}"
puts "\n--> Running Command: #{cmd}"
puts %x(#{cmd})

# Process Typst File: Now fix the figure widths in the typst file
#tfile = Tempfile.new('typst-mod') # create a temp file
#begin
#	File.open(outfilename2, 'r') do |file|
#		text = file.read
#		# These two regexes are not needed anymore for Pandoc >3.19
#		# This regex wraps table in figure
#		#text.gsub!(/^#align\(center\)\[#table\(/, "#figure(table(")
#		# This regex converts the table text to a figure caption
#		#text.gsub!(/\)\n#align\(center, \[(.+?)(<tbl-.+?>)\]\)\n\s*\]/, "),\ncaption: [\\1]\n) \\2")
#		# This regex replaces widths
#		#text.gsub!(/(#figure\(\[#box\(width:\s*).+?pt/, "\\1 100%")
#		tfile.puts text
#	end
#	tfile.close
#	FileUtils.mv(tfile.path, outfilename3)
#ensure
#	tfile.close
#	tfile.delete
#end

puts "--> Modified File with fixed cross-references: #{outfilename}"
tend = Time.now - tstart
puts "--> All Parsing took: " + tend.to_s + "s"

# Build and run our typst command
tstart = Time.now
outpdf = infilename.gsub(/\.[q]?md$/,".pdf")
cmd = "typst compile #{outfilename2} #{outpdf}"
puts "\n--> Running Command: #{cmd}"
puts %x(#{cmd})
tend = Time.now - tstart
puts "--> Typst took: " + tend.to_s + "s"

# open any log file (generated from scrivener's post-processing)
#`open Typst.log` if File.file?('Typst.log') and isRecent('Typst.log')
