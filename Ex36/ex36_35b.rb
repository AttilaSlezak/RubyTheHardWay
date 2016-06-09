require 'date'
require './ex36_35b_module.rb'

if ARGV.size == 1 and ARGV.first.downcase == "key"
    puts "You have activated your magic key!"
end

def have_key_to_gold_room()
  key_to_gold_room = false
  
  if ARGV.size == 1 and ARGV.first.downcase == "key"
    key_to_gold_room = true
  end
  
  key_to_gold_room
end

def prompt()
  print "> "
end

def gold_room()
  puts "This room is full of gold. How much do you take?"
   
  prompt; next_move = STDIN.gets.chomp
  
  if next_move.respond_to?(:to_i)
    hom_much = next_move.to_i()
  else
    dead("Man, learn to type a number.")
  end
  
  if hom_much < 50
    puts "Nice, you're not greedy, you win!"
    Process.exit(0)
  else
    dead("You greedy bastard!")
  end
end

def date_checker(got_date)
  current_date = Date.parse "2014-01-01"
  begin
    current_date = Date.parse got_date
	current_date
  rescue ArgumentError => err
    current_date
  end
end

def password_to_the_door()
  password_source = Password.new()
  password = password_source.password().downcase
  bear_angry = false
  
  while true
    prompt; next_move = STDIN.gets.chomp
	
	if next_move.downcase == password or next_move.downcase == password[0...password.length-1]
      puts "'Congratulations! The answer is correct!' - said the door."
	  puts "The door opened and you could go in."
	  gold_room()
	elsif next_move.include? "key" and have_key_to_gold_room
	  puts "You put your magic key into the keyhole and the door opened."
	  gold_room()
	elsif next_move.include? "key" and not have_key_to_gold_room
	  puts "You don't have the magic key to this door!"
	  puts "So, you have to answer the question of the door."
	elsif next_move.include? "ask the bear" and not bear_angry
	  puts "The bear got angry:"
	  puts "'Do you know anything, at all??? You should know it!"
	  puts "Don't ask me again if you value your life!!!' - shouted the bear."
	  bear_angry = true
	elsif next_move.include? "bear" and bear_angry
	  dead("The bear gets pissed off and took your head off.")
	elsif next_move.downcase.include? "let"
	  puts "The answer is not complete."
	else
	  puts "The answer is incorrect."
    end
  end
end

def door_opening()
  puts "You stepped to the door. Then suddenly the door began to speak:"
  puts "'I need to know the current date!' - said the door."
  puts "Please add the current date in format: YYYY-MM-DD"
  
  while true
    prompt; next_move = STDIN.gets.chomp
	current_date = date_checker(next_move)
	yesterday = Date.today - 1
	
	if current_date == Date.today
	  puts "'The answer is correct. But I need the password, too.' - said the door."
	  password_to_the_door()
	elsif next_move.include? "key" and have_key_to_gold_room()
	  puts "You put your magic key into the keyhole and the door opened."
	  gold_room()
	elsif next_move.include? "key" and not have_key_to_gold_room()
	  puts "You don't have the magic key to this door!"
	  puts "So, you have to answer the question of the door."
	elsif next_move.include? "ask the bear"
	  puts "The bear looked at the table where a yesterday's newspaper was."
	  puts "'It's " + yesterday.to_s + " today...' - answered the bear and continued to eat the honey."
	else
      puts "'This is not the correct answer.' - said the door"
	end
  end
end  

def bear_room()
  puts "There is a bear here."
  puts "The bear has a bunch of honey."
  puts "The fat bear is in front of another door."
  puts "How are you going to move the bear?"
  bear_moved = false
  
  while true
    prompt; next_move = STDIN.gets.chomp
	
	if next_move == "take honey"
	  dead("The bear looks at you then slaps your face off.")
	elsif next_move == "taunt bear" and not bear_moved
	  puts "The bear has moved from the door. You can go through it now."
	  bear_moved = true
	elsif next_move == "taunt bear" and bear_moved
	  dead("The bear gets pissed off and chews your leg off.")
	elsif next_move == "open door" and bear_moved
	  door_opening()
	else
	  puts "I got no idea what that means."
	end
  end
end

def cthulu_room()
  puts "Here you see the great evil Cthulu."
  puts "He, it, whatever stares at you and you go insane."
  puts "Do you flee for your life or eat your head?"
  
  prompt; next_move = STDIN.gets.chomp
  
  if next_move.include? "flee"
    start()
  elsif next_move.include? "head"
    dead("Well that was tasty!")
  else
    cthulu_room()
  end
end

def dead(why)
  puts "#{why} Good job!"
  Process.exit(0)
end

def start()
  puts "You are in a dark room."
  puts "There is a door to your right and left."
  puts "Which one do you take?"
  
  prompt; next_move = STDIN.gets.chomp
  
  if next_move == "left"
    bear_room()
  elsif next_move == "right"
    cthulu_room()
  else
    dead("You stumble around the room until you starve.")
  end
end

start()