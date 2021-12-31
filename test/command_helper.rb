# coding: utf-8

require "open3"

Encoding.default_external = 'utf-8'

class CommandHelper

  attr_accessor :output, :error, :exit_code
  
  def initialize(exe_path)
    @exe = exe_path
  end
  
  def run(arg_line, input = '')
    if arg_line.instance_of?(Array)
      command = arg_line.unshift(@exe)
      puts "COMMAND=[#{command}]"
      puts "INPUT=[#{input}]"
      @output, @error, status = Open3.capture3(*command , stdin_data: input)
    else
      command = "#{@exe} #{arg_line}"
      puts "COMMAND=[#{command}]"
      puts "INPUT=[#{input}]"
      @output, @error, status = Open3.capture3(command , stdin_data: input)
    end

    puts "OUTPUT=[#{@output}]"
    $stderr.puts "ERROR=[#{@error}]"
    @exit_code = status.to_i
  end
  
end


# EOF

