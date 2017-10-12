#!/usr/bin/env ruby
require 'open3' # ruby standard library class to handle stderr and stdout
require 'optparse' # ruby standard option parser
require 'shellwords' # escapes strings to run in the shell

class Scrivomatic
  attr_accessor :options
  attr_reader :version, :cmd, :runLog
  VER = '1.0.11'.freeze
  OPT = Struct.new(:input, :output, :to, :command, :envpath, :build, :verbose, :dry_run)
  DEFENVPATH = ENV['HOME'] + '/bin' + ':/usr/local/bin'

  ################################class constructor
  def initialize # set up class
    @options = OPT.new(nil, nil, nil, 'pandocomatic', DEFENVPATH, false, false, false)
    @version = VER
    @cmd = ''
    @toolPath = ''
    @runLog = ''
  end

  ################################build the command line
  def buildCommand
    @toolPath = `which #{@options[:command]}`.chomp
    unless @options[:output].nil?
      @cmd += ' --output ' + @options[:output] + ' '
    end
    @cmd += ' --to "' + @options[:to] + '"' unless @options[:to].nil?
    if @options[:verbose] == true && @options[:command] == 'pandocomatic'
      @cmd += ' --debug'
    elsif @options[:verbose] == true && @options[:command] == 'panzer'
      @cmd += ' ---debug "panzerlogs"'
    end
    unless @options[:input].nil?
      @cmd = @toolPath + @cmd + ' ' + @options[:input] + ' '
    end
  end

  ################################run the command
  def runCommand
    @runLog += ":: Running: #{@cmd}\n"
    if File.exist?(@toolPath) && !options.dry_run
      Open3.popen2e(@cmd) do |_stdin, oe, thread|
        while (line = oe.gets)
          @runLog += '::: ' + line.chomp + "\n"
        end
        exit_status = thread.value
        @runLog += ':: exit status: ' + exit_status.to_s
        unless exit_status.success?
          @runLog += "\n!!!---scrivomatic::runCommand() RETURN non-zero value: #{cmd}!!!"
        end
      end
    elsif !options.dry_run
      @runLog += "Tool doesn't exist!!!"
      @runLog += "\n!!!---scrivomatic::runCommand() Couldn't find #{@toolPath} to run, please supply a proper path!"
    else
      @runLog += 'Dry run, nothing actually executed...'
    end
  end 

  ################################parse inputs
  def parseInputs(_arg)
    optparse = OptionParser.new do |opts|
      opts.banner = 'Scrivomatic V' + @version + "\n"
      opts.banner += "=======================\n"
      opts.banner += "Scrivomatic is a wrapper script around pandocomatic or panzer, that sets up the environment path, enforces UTF8 encoding and other settings so they can be run from any other process.\n\n"
      opts.banner += 'Usage: scrivomatic --input FILE [additional options]'
      opts.on('-i', '--input FILE', 'Input file?') do |v|
        @options[:input] = v.shellescape
      end
      opts.on('-o', '--output [file]', 'Output file? Optional for pandocomatic.') do |v|
        @options[:output] = v.shellescape
      end
      opts.on('-t', '--to [format]', 'Pandoc Format? Optional for pandocomatic.') do |v|
        @options[:to] = v
      end
      opts.on('-c', '--command [command]', 'Tool to use? Default: pandocomatic') do |v|
        @options[:command] = v
      end
      opts.on('-p', '--path [dirpath]', 'Path to Search for Commands?') do |v|
        @options[:envpath] = v.shellescape + ':' + @options[:envpath]
      end
      opts.on('-b', '--build', 'If LaTeX output, try to run latexmk') do |v|
        @options[:build] = v
      end
      opts.on('-d', '--dry-run', 'Dry run?') do |v|
        @options[:dry_run] = v
      end
      opts.on('-v', '--[no-]verbose', 'Verbose output?') do |v|
        @options[:verbose] = v
      end
      opts.on('-h', '--help', 'Prints this help!') do
        puts optparse
        exit(0)
      end
    end # end OptionParser

    optparse.parse!

    #make sure we have an input file
    return unless @options[:input].nil?
    if ARGV.nil?
      puts optparse
      abort "\n\n!!!---scrivomatic::parseInputs requires valid file: --input"
    else
      @options[:input] = ARGV[0] # we assume it was passed without -i flag
    end
  end # end parseInputs

  ################################make env path
  def makePath
    pathtest = ['/Library/TeX/texbin',
      ENV['HOME'] + '/anaconda/bin',
      ENV['HOME'] + '/anaconda3/bin',
      ENV['HOME'] + '/.cabal/bin',
      rvm_check,
      ENV['HOME'] + '/.rbenv/shims']
    pathtest.each do |p|
      if File.directory?(p)
        @options[:envpath] = p + ':' + @options[:envpath]
      end
    end
    ENV['LANG'] = 'en_GB.UTF-8' if ENV['LANG'].nil? # Just in case we have no LANG, which breaks UTF8 encoding
    @options[:envpath].gsub!(/(\/\/)/, '/') # remove double slash
    @options[:envpath].gsub!(/(::)/, ':') # remove double colon
    @options[:envpath].gsub!(/:$/, '') # remove final colon
    ENV['PATH'] = @options[:envpath] + ':' + ENV['PATH']
  end # end makePath()

  ################################check for RVM
  def rvm_check
    rvm_home = ENV['HOME'] + '/.rvm'
    return '' unless File.directory?(rvm_home)
    rvm_home + '/wrappers/default'
  end

  ################################set version
  attr_writer :version

  ################################print initial report
  def printInfo
    if @options[:verbose] == true
      puts "\n=== ##################################################### ==="
      puts '=== Scrivomatic V' + @version + ' Report @ ' + Time.now.to_s + ' ==='
      puts " Running under Ruby #{RUBY_VERSION}"
      puts ' Working directory: ' + `pwd`
      puts '====== Input Options: ======'
      puts @options
      puts '====== Final ENV PATH: ======'
      puts ENV['PATH']
      puts '====== TOOL PATHS: ======'
      puts `echo "---pandoc: $(which pandoc) | V: $(pandoc -v | sed -nE '1 s/^pandoc // gp')"`
      puts `echo "---pandocomatic: $(which pandocomatic) | V: $(pandocomatic -v | sed -En '1 s/(©.+)/''/ p')"`
      puts `echo "---ruby: $(which ruby) | V: $(ruby -v)"`
      %w[rbenv rvm panzer python xelatex].each do |c|
        location = `which #{c}`.chomp
        puts "---#{c}: #{location}" unless location.empty?
      end
      puts "\n … running #{@options[:command]}, please wait …\n"
    end
  end

  # ###############################print summary report
  def printReport
    if @options[:verbose] && @runLog != ''
      puts '====== COMMAND OUTPUT: ======'
      puts @runLog
    end
  end

  # ###############################check if we want to run latexmk
  def postBuild
    if options.build && !(options.dry_run)
      texPath = options.input.gsub(/\.md$/, '.tex')
      if File.exist?(texPath)
        xLog = '' # simple log
        xcmd = "latexmk -logfilewarnings -interaction=nonstopmode -gg -pv -time -xelatex -f #{texPath}"
        puts "\n====== RUN LATEXMK on #{texPath}: ======"
        Open3.popen2e(xcmd) do |_stdin, oe, wait_thr|
          while line = oe.gets
            if line.match?(/^(Latexmk:|Run|LaTeX|This is|===|Accumulated)/)
              xLog += '::: ' + line.chomp + "\n"
              end
            end
          exit_status = wait_thr.value
          xLog += ':: exit status: ' + exit_status.to_s
          if @options[:verbose]
            puts xLog
          end
          if exit_status.success?
            `latexmk -c -quiet`
          else
            puts "!!!---Scrivomatic: errors on build #{xcmd}, check logs!!!"
          end
        end
      end
    end
  end

  # ###############################run all options
  def run
    makePath
    printInfo
    buildCommand
    runCommand
    printReport
    postBuild
  end
end #--------------- end Scrivomatic class

scriv = Scrivomatic.new
scriv.parseInputs(ARGV)
scriv.run
