require 'pry'

class Parser
  attr_reader :incoming_text, :final_convert

  # def initialize(incoming_text = nil)
  #     @incoming_text = incoming_text
  # end

  def convert_arr(incoming_text)
      incoming_text.split("\n")
  end

  def change_hashes(incoming_text)
    lines_arr = incoming_text.split(" ")
    # binding.pry
    # num = (1...100)
    case lines_arr[0]
    when nil
      ""
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
      array = []
      array << convert_ul(lines_arr)
      # binding.pry
      array.join
    when "1.", "2.", "3.", "4."
      array = []
      array << convert_ol(lines_arr)
      array.join
    else
      make_paragraph(lines_arr)
    end
  end

    def convert_ul(line)
      line.map do |word|
        if word == "*"
          word.gsub!("*", "<li>")
        else
           word << "</li>"
        end
      end
      line.unshift("<ul>")
      line.push("</ul>")
    end

    def convert_ol(line)
        line.map do |word|
        if word == "1."
            word.gsub!("1.", "<li>")
        elsif word == "2."
            word.gsub!("2.", "<li>")
        elsif word == "3."
            word.gsub!("3.", "<li>")
        else
            word << "</li>"
        end
      end
        line.unshift("<ol>")
        line.push("</ol>")
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
          if word.include?("**")
            word.gsub!("**", "<strong>")
          elsif word.include?("*")
            word.gsub!("*", "<em>")
            # binding.pry
          if word.end_with?("<strong>")
              word.chomp("strong") + ("</strong>")
          elsif word.end_with?("*")
            word.gsub!("*", "</em>")
          else
            word
            end
          end
        end
        words.join(" ")
      end

    def replace_characters(line)
      if line.include?("\"") || line.include?("\'") || line.include?("&")
        line.gsub!(/[&"']/, "&" => "&amp;", "\"" => "&quot;", "\'" => "&quot;")
      else
        line
      end
    end

    def full_convert(incoming_text, second)
       final_arr = convert_arr(incoming_text)
       final_convert = final_arr.map do |line|
       first = change_hashes(line)
       final = change_style(first)
       replace_characters(final)
      end
       final_convert.join("\n")
    end
end
