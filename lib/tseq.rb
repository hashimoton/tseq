#! /usr/bin/env ruby
# coding: utf-8
# Print times from FIRST to LAST, in steps of INCREMENT.

require "optparse"
require "time"

class TseqCommand
  
  DEFAULT_DELIMITER = ':'
  
  def initialize()
  end

  def opt_parse(argv)
    opts = {}
    
    OptionParser.new do |opt|
      begin
        opt.version = '0.0.2'
        opt.banner += " [FIRST] [INCREMENT(sec)] [LAST]"
        opt.separator("\nOptions:")
        
        opt.on('-f=FORMAT',
          "Format") {|v| opts[:f] = v}
        
        opt.order!(argv)
      rescue => e
        $stderr.puts "ERROR: #{e}.\n#{opt}"
        exit 1
      end
    end
    
    return opts
  end
  
  
  def tseq(first, last, increment, format)
    t = first
    while t < last
      puts t.strftime(format)
      t += increment
    end
    
    puts t.strftime(format)
  end
  
  
  def main(argv)
    opts = opt_parse(argv)
    
    if opts[:f].nil?
      @format = "%X"
    else
      @format = opts[:f]
    end
    
    
    first_text = argv.shift
    increment_text = argv.shift
    last_text = argv.shift
        
    if first_text.nil? || increment_text.nil? || last_text.nil?
      $stderr.puts "Usage: tseq [options] [FIRST] [INCREMENT(sec)] [LAST]"
      exit 1
    end
    
    first = Time.parse(first_text)
    increment = increment_text.to_i
    last = Time.parse(last_text)
      
    tseq(first, last, increment, @format)
    
  end # main

end # class


################################

Encoding.default_external = 'utf-8'
TseqCommand.new.main(ARGV)

exit 0

# EOF
