require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require 'pry'

class ParserTest < MiniTest::Test

  def setup
    @parse = Parser.new
  end

  def test_can_make_each_line_an_array
    parser = @parse.convert_arr("string\n\nstring")
    assert_equal ["string", "string"], parser
  end

  def test_check_each_line
    parser_1 = @parse.change_hashes("# My life in Desserts")
    parser_2 = @parse.change_hashes("## My life in Desserts")
    parser_3 = @parse.change_hashes("### My life in Desserts")
    parser_4 = @parse.change_hashes("#### My life in Desserts")
    parser_5 = @parse.change_hashes("##### My life in Desserts")
    parser_6 = @parse.change_hashes("###### My life in Desserts")
    parser_7 = @parse.change_hashes("You just")
    assert_equal "<h1>My life in Desserts</h1>", parser_1
    assert_equal "<h2>My life in Desserts</h2>", parser_2
    assert_equal "<h3>My life in Desserts</h3>", parser_3
    assert_equal "<h4>My life in Desserts</h4>", parser_4
    assert_equal "<h5>My life in Desserts</h5>", parser_5
    assert_equal "<h6>My life in Desserts</h6>", parser_6
    assert_equal "<p>\nYou just\n</p>\n", parser_7
  end

  def test_it_changes_word_style
    style_1 = @parse.change_style("*italicize* this word")
    style_2 = @parse.change_style("**strong** this word")
    style_3 = @parse.change_style("**strong multiple words**")
    style_4 = @parse.change_style("*strong **words** italicized*")
    style_5 = @parse.change_style("**italicized *words made* strong**")
    style_6 = @parse.change_style("***strong*** and italicized at the beginning")
    assert_equal "<em>italicize</em> this word", style_1
    assert_equal "<strong>strong</strong> this word", style_2
    assert_equal "<strong>strong multiple words</strong>", style_3
    assert_equal "<em>strong <strong>words</strong> italicized</em>", style_4
    assert_equal "<strong>italicized <em>words made</em> strong</strong>", style_5
    assert_equal "<strong><em>strong</em></strong>and italicized at the beginning", style_6
  end

end
