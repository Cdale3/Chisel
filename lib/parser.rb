require 'pry'
class Parser


  def parse
    # upload = File.open(ARGV[0], ARGV[1])
    upload = File.open('./lib/my_input.md', "r")
    incoming_msg = upload.read.each_line("\\n") {|s| p s.chop}
    upload.close
    @incoming_msg
    # binding.pry
  end

#   def write_encryption
# html_file = @incoming_msg
# # writer = File.write(ARGV[1], html_file)
# writer = File.write('./lib/my_output.html', html_file)
#   end
end

# show_me = Parser.new
#
# show_me = File.open
#
# puts show_me.parse

File.open("./lib/my_output.html", "w"){ |file| File.open('./lib/my_output.html', 'w')}
