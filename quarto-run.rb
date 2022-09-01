#!/usr/bin/env ruby 
# encoding: utf-8 

# This script rewrites markdown from Scrivener to be compatible with the
# cross-referencing system used by Quarto. It also adds LaTeX and others to
# the path so that comilation works directly from Scrivener. 
# Version: 0.1.1

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'tempfile' # temp file tools
require 'fileutils' # ruby standard library to deal with files
#require 'debug/open_nonstop' # debugger

def makePath() # this method builds our path
	home = ENV['HOME']
	envpath = ''
	pathtest = ["#{home}/.rbenv/shims", '/usr/local/bin',
		'/usr/local/opt/ruby/bin', '/usr/local/lib/ruby/gems/2.7.0/bin', 
		'/Library/TeX/texbin', '/opt/homebrew/bin',
		home+'/anaconda/bin', home+'/anaconda3/bin',
		home+'/miniconda/bin', home+'/miniconda3/bin',
		home+'/.cabal/bin', home+'/.local/bin']
	pathtest.each { |p| envpath = envpath + ':' + p if File.directory?(p) }
	ENV['LANG'] = 'en_GB.UTF-8' if ENV['LANG'].nil? # Just in case we have no LANG, which breaks UTF8 encoding
	envpath.gsub!(%r{(//)}, '/') # remove double slash
	envpath.gsub!(/(::)/, ':') # remove double colon
	envpath.gsub!(/:$/, '') # remove final colon
	envpath.gsub!(/^:/, '') # remove first colon
	ENV['PATH'] = envpath + ':' + ENV['PATH']
	puts "--> Modified path: #{ENV['PATH'].chomp}"
end # end makePath()
makePath() #run the method to build up the path

tstart = Time.now
infilename = File.expand_path(ARGV[0])
puts "--> Input Filename: #{infilename}"
fail "The specified file does not exist!" unless infilename and File.file?(infilename)

fileType = ARGV[1]
if fileType.nil? || fileType !~ /(html|pdf|epub|docx|odt|md)/
	fileType = 'html' 
end

outfilename = infilename.gsub(/\.md$/,"2.qmd")
temp_file = Tempfile.new('fix-x-refs')
lineSeparator = "\n"

begin
	File.open(infilename, 'r') do |file|
		text = file.read
		figID = /^!\[(?<id>\{#fig-.+?\} ?)(?<cap>.+?)\]\[(?<ref>.+?)\]/
		
		# This regex puts {#id} onto end of $$ math blocks
		text.gsub!(/\$\$ ?\n\{\#eq/,'$$ {#eq')
		
		# this finds all reference-link figures with cross-refs and moves
		# the reference down to the link
		refs = text.scan(figID)
		refs.each {|ref|
			puts "--> CrossRef figures details: #{ref[0]} #{ref[1]} #{ref[2]}"
			re = Regexp.compile("^(\\[" + ref[2] + "\\]: *?.+)$")
			text.gsub!(re, '\1 ' + ref[0])
		}
		# We now need to remove #{id} from figure captions
		text.gsub!(figID, '![\k<cap>][\k<ref>]')

		temp_file.puts text
	end
	temp_file.close
	FileUtils.mv(temp_file.path, outfilename)
ensure
	temp_file.close
	temp_file.unlink
end

puts "--> Modified File with fixed cross-references: #{outfilename}"
tend = Time.now - tstart
puts "--> Parsing took: " + tend.to_s + "s"

cmd = "quarto render #{outfilename} --to #{fileType}"
puts "\n--> Running Command: #{cmd}"
puts %x(#{cmd})

# open any log file (generated from scrivener post-processing)
`open Quarto.log` if File.file?('Quarto.log')

# finally try to open the resultant file
res = outfilename.gsub(/\.qmd$/, '.' + fileType)
`open #{res}` if File.file?(res)
