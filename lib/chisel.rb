require './lib/parser'
class Chisel
    attr_reader :incoming_text, :final_convert, :mark_down
    # def initialize(incoming_text = nil)
    #   @incoming_text = incoming_text
    # end
    def begin
      # input = File.open('./lib/my_input.md', "r")
      input = File.open(ARGV[0], "r")
      @incoming_text = input.read
      input.close
      input
    end

    def output_html
      @mark_down = Parser.new
      convert = mark_down.full_convert(incoming_text, self)

      # File.write("./lib/my_output.html", html_file)
      html_file = File.open(ARGV[1], "w")
      html_file.write(convert)
      html_file.close
      html_file
      # system("open my_output.html")
    end

    translate = Chisel.new
    translate.begin
    translate.output_html
  end
