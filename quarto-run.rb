#!/usr/bin/env ruby 
# encoding: utf-8 

# This script rewrites markdown from Scrivener to be compatible with
# the cross-referencing system used by Quarto. It also adds paths for
# LaTeX, python and others so that compilation works directly from
# Scrivener (which by default doesn't use the user environment). 
# Version: 0.1.7

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'tempfile' # temp file tools
require 'fileutils' # ruby standard library to deal with files
#require 'debug/open_nonstop' # debugger

def makePath() # this method augments our environment path
	home = ENV['HOME'] + '/'
	envpath = ''
	pathtest = [home+'.rbenv/shims', home+'.pyenv/shims', '/usr/local/bin',
		'/usr/local/opt/ruby/bin', '/usr/local/lib/ruby/gems/2.7.0/bin', 
		'/Library/TeX/texbin', '/opt/homebrew/bin',
		home+'anaconda/bin', home+'anaconda3/bin', home+'miniconda/bin', home+'miniconda3/bin',
		home+'.cabal/bin', home+'.local/bin']
	pathtest.each { |p| envpath = envpath + ':' + p if File.directory?(p) }
	envpath.gsub!(/\/{2}/, '/')
	envpath.gsub!(/:{2}/, ':')
	envpath.gsub!(/(^:|:$)/, '')
	ENV['PATH'] = envpath + ':' + ENV['PATH']
	ENV['LANG'] = 'en_GB.UTF-8' if ENV['LANG'].nil? # Just in case we have no LANG, which breaks UTF8 encoding
	puts "--> Modified path: #{ENV['PATH'].chomp}"
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

tstart = Time.now
infilename = File.expand_path(ARGV[0])
puts "--> Input Filename: #{infilename}"
fail "The specified file does not exist!" unless infilename and File.file?(infilename)

fileType = ARGV[1]
if fileType.nil? || fileType !~ /(plain|markdown|html|pdf|epub|docx|latex|odt|beamer|revealjs|pptx)/
	fileType = ''
end

makePath()
outfilename = infilename.gsub(/\.[q]?md$/,"2.qmd") # output to [name]2.qmd
tfile = Tempfile.new('fix-x-refs') # create a temp file
lineSeparator = "\n"

begin
	File.open(infilename, 'r') do |file|
		text = file.read

		# cosmetic only: remove long runs (4 or more) of newlines
		text.gsub!(/\n{4,}/,"\n\n")

		# This regex puts {#id} onto end of $$ math block lines
		text.gsub!(/\$\$ ?\n\{\#eq/,'$$ {#eq')

		# this finds all reference-link figures with cross-refs and moves
		# the reference down to the reference link
		figID = /^!\[(?<id>\{#fig-.+?\} ?)(?<cap>.+?)\]\[(?<ref>.+?)\]/
		refs = text.scan(figID)
		refs.each {|ref|
			puts "--> CrossRef figure details: Label=#{ref[0]} | #{ref[1]} | #{ref[2]}"
			re = Regexp.compile("^(\\[" + ref[2] + "\\]: *)([^{\\n]+)({(.+)})?$")
			mtch = text.match(re)
			label = ref[0].gsub(/\{([^\}]+?)\}/,'\1').strip
			if mtch.nil?
				puts "----> Failed to match #{label} in the references"
			elsif mtch[4].nil?
				text.gsub!(re, '\0 {' + label + '}')
			else
				text.gsub!(re, '\1\2 {' + label + ' \4}')
			end
		}
		# We now need to remove all #{label} from figure captions
		text.gsub!(figID, '![\k<cap>][\k<ref>]')

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
	cmd = "quarto render #{outfilename} --log-level=INFO --verbose"
else
	cmd = "quarto render #{outfilename} --to #{fileType} --log-level=INFO --verbose"
end
puts "\n--> Running Command: #{cmd}"
puts %x(#{cmd})

# now try to open the resultant file
fileType = 'html' if fileType.match(/revealjs|s5|slidous|html5/)
res = outfilename.gsub(/\.qmd$/, '.' + fileType)
if File.file?(res) && isRecent(res)
	`open #{res}`
else
	puts "There was some problem opening #{res}, check compiler log…"
end

# open any log file (generated from scrivener's post-processing)
`open Quarto.log` if File.file?('Quarto.log') and isRecent('Quarto.log')
