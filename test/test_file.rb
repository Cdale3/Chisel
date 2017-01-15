require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require './lib/chisel'

require 'pry'

class ChiselTest < MiniTest::Test

  def test_does_it_know_hasthag
    file = Chisel.new
    assert file.incoming_text.include?("#")
    assert file.incoming_text.include?("##")

  end

  def test_does_it_know_asterisk
    file = Chisel.new
    assert file.incoming_text.include?("*")
    assert file.incoming_text.include?("**")
  end

  def test_line_counter
    file = Chisel.new
    assert_equal 6, file.incoming_text.lines.count
  end

  def test_does_it_change_hashtag
    skip
  end

end
