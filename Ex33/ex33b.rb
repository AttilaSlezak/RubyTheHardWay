def while_function(num, max_num)
  numbers = []
  while num < max_num
    puts "At the top num is #{num}"
    numbers.push(num)
  
    num += 8
    puts "Numbers now: #{numbers}"
    puts "At the bottom num is #{num}"
  end
  numbers
end

numbers = while_function(3, 28)

puts "The numbers: "

for num in numbers
  puts num
end