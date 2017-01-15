require 'pry'
class Chisel
    attr_reader :incoming_text

    def initialize
      input = File.open('./lib/my_input.md', "r")
      # input = File.open("", "r")  ARGV[0]
      @incoming_text = input.read
      # binding.pry
      input.close
    end

    def output_html
      html_file = @incoming_text
      File.write("./lib/my_output.html", html_file)
      # File.write(ARGV[1], html_file)
      #   p "Converted #{ARGV[0]}" #{number_of_lines_original} to #{ARGV[1]} #{number_of_lines_converted}"
      #   system("open my_output.html")
    end

  end

  translate = Chisel.new
  translate.output_html
