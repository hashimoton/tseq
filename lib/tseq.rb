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
        opt.version = '0.0.1'
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
    while t <= last
      puts t.strftime(format)
      t += increment
    end
  end
  
  
  def main(argv)
    opts = opt_parse(argv)
    
    if opts[:f].nil?
      @format = "%X"
    else
      @format = opts[:f]
    end
    
    
    first_text = argv.shift
    first = Time.parse(first_text)
    
    increment_text = argv.shift
    increment = increment_text.to_i
    
    last_text = argv.shift
    last = Time.parse(last_text)
      
    tseq(first, last, increment, @format)
    
  end # main

end # class


################################

Encoding.default_external = 'utf-8'
TseqCommand.new.main(ARGV)

exit 0

# EOF
