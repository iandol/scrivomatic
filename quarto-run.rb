#!/usr/bin/env ruby 
# encoding: utf-8 

# This script rewrites markdown compiled from Scrivener to be compatible
# with the cross-referencing system used by Quarto. It also adds paths for
# LaTeX, python and others so that compilation works directly from Scrivener
# (Scrivener doesn't use the user's environment or path by default).
# Version: 0.1.13

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'tempfile' # temp file tools
require 'fileutils' # ruby standard library to deal with files
#require 'debug/open_nonstop' # debugger, use binding.break to stop

def makePath() # this method augments our environment path
	envpath = ''
	home = ENV['HOME'] + '/'
	paths = [home+'.rbenv/shims', home+'.pyenv/shims', '/opt/homebrew/bin', '/usr/local/bin',
		'/usr/local/opt/ruby/bin', '/usr/local/lib/ruby/gems/2.7.0/bin',
		home+'Library/TinyTeX/bin/universal-darwin', '/Library/TeX/texbin',
		home+'anaconda/bin', home+'anaconda3/bin', home+'miniconda/bin', home+'miniconda3/bin',
		home+'micromamba/bin', home+'.cabal/bin', home+'.local/bin']
	paths.each { |p| envpath = envpath + ':' + p if File.directory?(p) } #ENV['PATH'] = paths.select { |p| File.directory?(p) }.join(':') + ':' + ENV['PATH']
	envpath.gsub!(/[:\/]+/, ':')
	envpath.gsub!(/^:|:$/, '')
	ENV['PATH'] = envpath + ':' + ENV['PATH']
	ENV['LANG'] = 'en_GB.UTF-8' if ENV['LANG'].nil? # Just in case we have no LANG, which breaks UTF8 encoding
	puts "--> Modified path: #{ENV['PATH'].chomp}"
end # end makePath()

def isRecent(infile) # checks if a file is less than 3 minutes old
	return false if !File.file?(infile)
	filetime = File.mtime(infile) # modified time
	Time.now - filetime <= 180 # compare to now
end

tstart = Time.now
infilename = File.expand_path(ARGV[0])
puts "--> Input Filename: #{infilename}"
fail "The specified file does not exist!" unless infilename and File.file?(infilename)

fileType = ARGV[1]
if fileType.nil? || fileType !~ /(plain|markdown|typst|html|pdf|epub|docx|latex|odt|beamer|revealjs|pptx)/
	fileType = ''
end

makePath()
outfilename = infilename.gsub(/\.[q]?md$/,".qmd") # output to [name].qmd
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

		# This regex puts {#id} onto end of $$ math block lines
		text.gsub!(/\$\$ ?\n\{\#eq/,'$$ {#eq')

		# This regex removes {sizes} from images, e.g. [Fig1]: Fig1.pdf {width=596 height=233}
		text.gsub!(/^(\[[\d\w\s]+\]:[^\{]+)(\{.+\})/, '\1')

		# this finds all reference-link figures with cross-refs and moves
		# the reference down to the reference link
		figID = /^!\[(?<markup>[ \*_]*?)(?<id>\{#fig-.+?\} ?)(?<cap>.+?)\]\[(?<ref>.+?)\]/
		refs = text.scan(figID)
		refs.each {|ref|
			puts "--> CrossRef figure details: Label=#{ref[0]} | #{ref[1]} | #{ref[2]} | | #{ref[3]}"
			re = Regexp.compile("^(\\[" + ref[3] + "\\]: *)([^{\\n]+)({(.+)})?$")
			mtch = text.match(re)
			label = ref[1].gsub(/\{([^\}]+?)\}/,'\1').strip
			if mtch.nil?
				puts "----> Failed to match #{label} in the references"
			elsif mtch[4].nil?
				text.gsub!(re, '\0 {' + label + '}')
			else
				text.gsub!(re, '\1\2 {' + label + ' \4}')
			end
		}
		# We now need to remove all #{label} from figure captions
		text.gsub!(figID, '![\k<markup>\k<cap>][\k<ref>]')

		tfile.puts text
	end
	tfile.close
	FileUtils.mv(tfile.path, outfilename)
ensure
	tfile.close
	tfile.delete
end

puts "--> Modified File with fixed cross-references: #{outfilename}"
tend = Time.now - tstart
puts "--> Parsing took: " + tend.to_s + "s"

# Build and run our quarto command
if fileType.empty?
	cmd = "quarto render \"#{outfilename}\" --log-level=INFO --verbose"
else
	cmd = "quarto render \"#{outfilename}\" --to #{fileType} --log-level=INFO --verbose"
end
puts "\n--> Running Command: #{cmd}"
puts %x(#{cmd})

# now try to open the resultant file
fileType = 'html' if fileType.match(/revealjs|s5|slidous|html5/)
res = outfilename.gsub(/\.qmd$/, '.' + fileType)
if File.file?(res) && isRecent(res)
	`open "#{res}"`
else
	puts "There was some problem opening \"#{res}\", check compiler log…"
end

# open any log file (generated from scrivener's post-processing)
`open Quarto.log` if File.file?('Quarto.log') and isRecent('Quarto.log')
