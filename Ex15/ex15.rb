filename = ARGV.first

prompt = "> "
txt = File.open(filename)

puts "Here's your file: #{filename}"
puts txt.read() # in this line we read and print the whole file
txt.close() # here we close the file, which is important when we are done with it.

puts "I'll also ask you to type it again:"
print prompt
file_again = STDIN.gets.chomp()

puts gets.chomp(), gets.chomp(), gets.chomp()

txt_again = File.open(file_again)

puts txt_again.read()
txt_again.close()
