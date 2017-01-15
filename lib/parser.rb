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

  def change_lines(incoming_text)
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
      lines_arr
      # replace_with_header(lines_arr, "<p>")
    end
  end

    def replace_with_header(line, header)
      line.delete_at(0)
      "<#{header}>#{line.join(" ")}</#{header}>"
    end

end

puts Chisel.new.incoming_text
