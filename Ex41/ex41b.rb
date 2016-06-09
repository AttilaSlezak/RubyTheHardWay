﻿def death()
  quips = ["You died. You kinda suck at this.",
  "Nice job, you died ...jackass.",
  "Such a luser.",
  "I have a small puppy that's better at this."]
  puts quips[rand(quips.length())]
  Process.exit(1)
end

def central_corridor(action)
  
  if action == "shoot!"
    puts "Quick on the draw you yank out your blaster and fire it at the Gothon."
	puts "His clown costume is flowing and moving around his body, which throws"
	puts "off your aim. Your laser hits his costume but misses him entirely. This"
	puts "completely ruins his brend new costume his mother bought him, which"
	puts "makes him fly into an insane rage and blast you repeatedly in the face until"
	puts "you are dead. Then he eats you."
	return :death
	
  elsif action == "dodge!"
	puts "Like a world class boxer you dodge, weave, slip and slide right"
	puts "as the Gothon's blaster cranks a laser past your head."
	puts "In the middle of your artful dodge your foot slips and you"
	puts "bang your head on the metal wall and pass out."
	puts "You wake up shortly after only to die as the Gothon stomps on"
	puts "your head and eats you."
	return :death
	
  elsif action == "tell a joke"
	puts "Lucky for you they made you learn Gothon insults in the academy."
	puts "You tell the one Gothon joke you know:"
	puts "Lbhe zbgure vf fb sng, jura fur fvgf nebhaq gur ubhfr, fur fvgf nebhaq gur ubhfr."
	puts "The Gothon stops, tries to not to laugh, then busts out laughing and can't move."
	puts "While he's laughing you run up and shoot him square in the head"
	puts "putting him down, then jump through the Weapon Armory door."
	return :laser_weapon_armory
	
  else
	puts "DOES NOT COMPUTE!"
	return :central_corridor
  end
end

def laser_weapon_armory(guess)

  code = "%s%s%s" % [rand(9)+1, rand(9)+1, rand(9)+1]
  guesses = 0
  
  while guess != code and guesses < 10
    if guess == "cheat"
	  puts "The first two number: #{code[0..1]}"
	else
	  puts "BZZZZEDDD!"
	  guesses += 1
	end
	print "[keypad]> "
	guess = gets.chomp()
  end
  
  if guess == code
    puts "The container clicks open and the seal breaks, letting gas out."
	puts "You grab the neutron bomb and run as fast as you can to the"
	puts "brige where you must place it in the right spot."
	return :the_bridge
  else
    puts "The lock buzzes one last time and then you hear a sickening"
	puts "melting sound as the mechanism is fused together."
	puts "You decide to sit there, and finally the Gothons blow up the"
	puts "ship from their ship and you die."
	return :death
  end
end

def the_bridge(action)
  
  if action == "throw the bomb"
    puts "In a panic you throw the bomb at the group of Gothons"
	puts "and make a leap for the door. Right as you drop it a"
	puts "Gothon shoots you right in the back killing you."
	puts "As you die you see another Gothon frantically try to disarm"
	puts "the bomb. You die knowing they will probably blow up when"
	puts "it goes off."
	return :death

  elsif action == "slowly place the bomb"	
	puts "You point your blaster at the bomb under your arm"
	puts "and the Gothons put their hands up and start to sweat."
	puts "You inch backward to the door, open it, and then carefully"
	puts "place the bomb on the floor, pointing your blaster at it."
	puts "You then jumb back through the door, punch the close button"
	puts "and blast the lock so the Gothons can't get out."
	puts "Now that the bomb is placed you run to the escape pod to"
	puts "get off this tin can."
	return :escape_pod
  else
    puts "DOES NOT COMPUTE!"
	return :the_bridge
  end
end

def escape_pod(guess)
  
  good_pod = rand(5)+1
  if guess == "cheat"
    guess = good_pod
  end
  
  if guess.to_i != good_pod
    puts "You jump into pod %s and hit the eject button." % guess
	puts "The pod escapes out into the void of space, then"
	puts "implodes as the hull ruptures, crushing your body"
	puts "into jam jelly."
	return :death
  else
    puts "You jump into pod %s and hit the eject button." % guess
	puts "The pod easily slides out into space heading to"
	puts "the planet below. As it flies to the planet, you look"
	puts "back and see your ship implode then explode like a"
	puts "bright star, taking out the Gothon ship at the same"
	puts "time. You won!"
	Process.exit(0)
  end
end
 
ROOMS = {
  :death => method(:death),
  :central_corridor => method(:central_corridor),
  :laser_weapon_armory => method(:laser_weapon_armory),
  :the_bridge => method(:the_bridge),
  :escape_pod => method(:escape_pod)
}

ROOM_DESCRIPTIONS = {
  :central_corridor => <<-CENTRAL_CORRIDOR,
The Gothons of Planet Percal #25 have invaded your ship and destroyed
your entire crew. You are the last surviving member and your last
mission is to get the neutron destruct bomb from the Weapons Armory,
put it in the bridge, and blow the ship up after getting into an
escape pod.

You're running down the central corridor to the Weapons Armory when
a Gothon jumps out, red scaly skin, dark grimy teeth, and evil clown costume
flowing around his hate filled body. He's blocking the door to the
Armory and about to pull a weapon to blast you.
CENTRAL_CORRIDOR
  :laser_weapon_armory => <<-LASER_WEAPON_ARMORY,
You do a dive roll into the Weapon Armory, crouch and scan the room
for more Gothons that might be hiding. It's dead quiet, too quiet.
You stand up an run to the far side of the room and find the
neutron bomb in its container. There's a keypad lock on the box
and you need the code to get the bomb out. If you get the code
wrong 10 times then the lock closes forever and you can't
get the bomb. The code is 3 digits.
LASER_WEAPON_ARMORY
  :the_bridge => <<-THE_BRIDGE,
You burst onto the Bridge with the neutron destruct bomb
under your arm and surprise 5 Gothons who are trying to
take control of the ship. Each of them has an even uglier
clown costume than the last. They haven't pulled their
weapons out yet, as they see the active bomb under your
arm and don't want to set it off.
THE_BRIDGE
  :escape_pod => <<-ESCAPE_POD,
You rush through the ship desperately trying to make it to
the escape pod before the whole ship explodes. It seems like
hardly any Gothons are on the ship, so your run is clear of
interference. You get to the chamber with the escape pods, and
now need to pick ont to take. Some of them could be damaged
but you don't have time to look. There's 5 pods, which one
do you take?
ESCAPE_POD
}

def runner(map, room_descriptions, start)
  next_one = start
  
  while true
    room = map[next_one]
	puts "\n--------"
	room.call() if next_one == :death
	puts room_descriptions[next_one]
	print next_one == :laser_weapon_armory ? "[Keypad]" : ""
	print next_one == :escape_pod ? "[Pod #]>" : "> "
	action = gets.chomp()
	next_one = room.call(action)
  end
end

runner(ROOMS, ROOM_DESCRIPTIONS, :central_corridor)