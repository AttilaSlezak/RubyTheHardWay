def my_function(arg)
  puts arg
  if arg.is_a? Array
    puts "It's an array. It has #{arg.size} elements."
  elsif arg.is_a? Integer
	puts "It's an integer."
	puts arg > 100 ? "And it's bigger than 100." : "And it's smaller than 101."
  elsif arg.is_a? String
    puts "It's a string. And it contents #{arg.length} characters."
  elsif arg.is_a? Float
    puts "It's a float."
  end
end

my_function([12, "Empty", 23])
my_function(23)
my_function(102)
my_function(4.5)
my_function(12.0)
my_function("My text.")

longer_text = <<LONGER_TEXT
This is a longer text here.
You should know it.
But now I finish it.
LONGER_TEXT

my_function(longer_text)