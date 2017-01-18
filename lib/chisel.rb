require './lib/parser'
require 'pry'
class Chisel
    attr_reader :incoming_text, :final_convert, :mark_down
    # def initialize(incoming_text = nil)
    #   @incoming_text = incoming_text
    # end
    def start
      # input = File.open('./lib/my_input.md', "r")
      input = File.open(ARGV[0], "r")
      # binding.pry
      @incoming_text = input.read
      # binding.pry
      # binding.pry
      input.close
      input
    end

    def output_html
      # html_file = @incoming_text
      @mark_down = Parser.new
      # binding.pry
      convert = mark_down.full_convert(incoming_text, self)

      # File.write("./lib/my_output.html", html_file)
      html_file = File.open(ARGV[1], "w")
      html_file.write(convert)
      html_file.close
      html_file
      #   p "Converted #{ARGV[0]}" #{number_of_lines_original} to #{ARGV[1]} #{number_of_lines_converted}"
      #   system("open my_output.html")
    end

  end

  translate = Chisel.new
  translate.start
  translate.output_html
