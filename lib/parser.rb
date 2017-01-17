# require_relative 'chisel'
require "pry"
class Parser
  attr_reader :incoming_text, :final_convert

  def initialize
      incoming_text
  end

  def convert_arr(incoming_text)
      # binding.pry
      incoming_text.split("\n\n")
  end

  def change_hashes(incoming_text)
    lines_arr = incoming_text.split(" ")
    list_num = (1...100)
    case lines_arr[0]
    when "#"
      replace_with_header(lines_arr, "h1")
    when "##"
      replace_with_header(lines_arr, "h2")
    when "###"
      replace_with_header(lines_arr, "h3")
    when "####"
      replace_with_header(lines_arr, "h4")
    when "#####"
      replace_with_header(lines_arr, "h5")
    when "*"
     convert_ul(lines_arr)
    when "#{list_num}."
     convert_ol(lines_arr)
    else
      make_paragraph(lines_arr)
    end
  end

    def convert_ol(line)
      line.delete_at(0)
      "<ol>\n#{line.join}</ol>\n"
    end

    def convert_ul(line)
      line.delete_at(0)
      "<ul>\n<li>#{line.join}</li>\n</ul>\n"
    end

    def replace_with_header(line, header)
      line.delete_at(0)
      "<#{header}>#{line.join(" ")}</#{header}>"
    end

    def make_paragraph(line)
      "<p>\n#{line.join(" ")}\n</p>\n"
    end

    def change_style(line)
      words = line.split(" ")
      words.map do |word|
        if word.include?("***") || word.include?("**") || word.include?("*")    #run two ** before *, double needs to find two, where I fear single will try to do itself twice
          # word.gsub!(/[*]{3}/, "<strong></em>")
          # word.gsub!(/<\/strong>\b<em>\b/, "</strong></em>")
          word.gsub!(/[*]{2}/, "</strong>")
          word.gsub!(/<\/strong>\b/, "<strong>")
          word.gsub!(/[*]{1}/, "</em>")
          word.gsub!(/<\/em>\b/, "<em>")
        else
          word
        end
      end
      words.join(" ")
    end

    def replace_characters(line)
      if line.include?("\"") || line.include?("\'") || line.include?("&")
        # line.gsub!(/["'&]/, "\"" => "\"", "\'" => "'", "&" => "&")                   # i'm not sure if this is correct or bad, it seems bad.
        line.gsub!(/[&"']/, "&" => "&amp;", "\"" => "&quot;", "\'" => "&quot;")
      else
        line
      end
    end

    def full_convert(incoming_text)
      final_arr = convert_arr(incoming_text)
      final_convert = final_arr.map do |line|
      first = change_hashes(line)
      final = change_style(first)
      replace_characters(final)
    end
      final_convert.join("\n\n")
    end
end
