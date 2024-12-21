#!/usr/bin/env ruby 
# encoding: utf-8 

# This script rewrites markdown compiled from Scrivener and runs Pandoc.
# Version: 0.1.04

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'tempfile' # temp file tools
require 'fileutils' # ruby standard library to deal with files
#require 'debug/open_nonstop' # debugger, use binding.break to stop

bib = '/Users/ian/.local/share/pandoc/Core.json'
filter = '/Users/ian/.local/share/pandoc/filters/pretty-urls.lua'

def makePath() # this method augments our environment path
	home = ENV['HOME'] + '/'
	envpath = ''
	pathtest = [home+'.pixi/bin', home+'.rbenv/shims', home+'.pyenv/shims'
			home+'bin', '/opt/homebrew/bin', '/usr/local/bin', 
			'/usr/local/opt/ruby/bin', '/usr/local/lib/ruby/gems/2.7.0/bin', 
			home+'Library/TinyTeX/bin/universal-darwin', '/Library/TeX/texbin', 
			home+'anaconda/bin', home+'anaconda3/bin',
			home+'miniconda/bin', home+'miniconda3/bin', home+'micromamba/bin',
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
	Time.now - filetime <= 180 # compare to now
end

#binding.break
tstart = Time.now
infilename = File.expand_path(ARGV[0])
puts "--> Input Filename: #{infilename}"
fail "The specified file does not exist!" unless infilename and File.file?(infilename)

fileType = ARGV[1]
if fileType.nil? || fileType !~ /(txt|md|typst|html|pdf|epub|docx|latex|odt|beamer|revealjs|pptx)/
	fileType = 'docx'
end
puts "--> Output Filetype: #{fileType}"

makePath()
editedFile = infilename.gsub(/\.[q]?md$/,"-edit.md") # output to [name]-edit.md
tfile = Tempfile.new('fix-x-refs') # create a temp file
lineSeparator = "\n"

# begin our regex replacements
begin
	File.open(infilename, 'r') do |file|
		tout = ""
		text = file.read
		text.gsub!(/\\_/,"_") #replace escaped underscores with normal underscores
		tfile.puts text
	end
	tfile.close
	FileUtils.mv(tfile.path, editedFile)
ensure
	tfile.close
	tfile.delete
end

puts "--> Modified File with fixed footnotes: #{editedFile}"
tend = Time.now - tstart
puts "--> Parsing took: " + tend.to_s + "s"

output = infilename.gsub(/\.[q]?md$/,".#{fileType}")
cmd = 'pandoc -s --verbose --citeproc --lua-filter="' + filter + 
	'" --bibliography="' + bib + '" --to=' + fileType + ' --output="' + output + '" "' + editedFile + '"'

# Build and run our pandoc command
puts "\n--> Running Command: #{cmd}"
puts %x(#{cmd})

# now try to open the resultant file
if File.file?(output) && isRecent(output)
	`open "#{output}"`
else
	puts "There was some problem opening #{output}, check compiler log…"
end

# open any log file (generated from scrivener's post-processing)
`open pandoc-run.log` if File.file?('pandoc-run.log') and isRecent('pandoc-run.log')
