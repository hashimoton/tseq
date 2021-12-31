# coding: utf-8

require 'minitest'
require 'minitest/autorun'
require './command_helper.rb'

class TestTseq < MiniTest::Test

  def setup
    @ch = CommandHelper.new
    @exe = '../bin/tseq'
  end

  def teardown
    @ch = nil
  end

  def test_empty
    @ch.run("#{@exe}", nil)
    assert_equal "", @ch.output
  end
  
  def test_no_option_min_increment
    @ch.run("#{@exe} 09:59:58 1 10:00:00", nil)
    assert_equal "09:59:58\n09:59:59\n10:00:00\n", @ch.output
  end
  
  def test_no_option_mid_increment
    @ch.run("#{@exe} 10:00:00 1200 11:19:59", nil)
    assert_equal "10:00:00\n10:20:00\n10:40:00\n11:00:00\n", @ch.output
  end
 
   # Need to resolve "'..' is not recognized as an internal or external command,operable program or batch file."
#  def test_f_option
#    @ch.run("#{@exe} -f %H%M 11:45 900 13:15", nil)
#    assert_equal "1145\n1200\n1215\n1230\n1245\n1300\n1315\n", @ch.output
#  end

end

# EOF

