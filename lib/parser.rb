require './lib/chisel'
require 'pry'

class Parser
  attr_reader :incoming_text

  def initialize
      @incoming_text
  end

  def convert_arr(incoming_text)
      incoming_text.split("\n\n")
  end

  def change_hashes(incoming_text)
    lines_arr = incoming_text.split(" ")
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
    when "######"
      replace_with_header(lines_arr, "h6")
    else
      make_paragraph(lines_arr)
    end
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
          word.gsub!(/[*]{3}/, "<strong></em>")
          word.gsub!(/<\/strong>\b<em>\b/, "</strong></em>")
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



end

# puts Chisel.new.incoming_text
