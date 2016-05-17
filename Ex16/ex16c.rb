filename = ARGV.first
script = $0

puts "We're going to erase #{filename}."
puts "If you don't want that, hit CTRL-C (^C)."
puts "If you do want that, hit RETURN."

print "? "
STDIN.gets

puts "Opening the file..."
target = File.open(filename, 'w')

puts "Truncating the file. Goodbye!"
target.truncate(target.size) # actually this line is not necessary

puts "Now I'm going to ask you for three lines."

print "line 1: "; line = STDIN.gets.chomp()
print "line 2: "; line += STDIN.gets.chomp()
print "line 3: "; line += STDIN.gets.chomp()

puts "I'm going to write these to the file."

targer.write(line)

puts "And finally, we close it."
target.close()