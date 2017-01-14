require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require 'pry'

class ParserTest < MiniTest::Test

  def test_it_sends_the_output
    parser = Parser.new
    parser.parse
    binding.pry
    assert_equal File.open('./lib/my_input.md', &:gets), parser.parse
  end
end
