File.open('./lib/my_input.md', 'r') do |f1|
  while line = f1.gets
    File.open('./lib/my_output.html', 'w') do |f2|
      f2.puts line

    end
  end
end
