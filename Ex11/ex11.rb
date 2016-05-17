print "How old are you? "
# age = gets.chomp()
age = gets
age.chomp!
print "How tall are you? "
height = gets.chomp()
print "How much do you weigh? "
weight = gets.chomp()

puts "So, you're #{age} old, #{height} tall and #{weight} heavy."