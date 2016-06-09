require './ex42b.rb'

class Engine
  
  def initialize(start)
    @quips = [
	"You died. You kinda suck at this.",
    "Nice job, you died ...jackass.",
    "Such a luser.",
    "I have a small puppy that's better at this."]
	@start = start
	puts "in init @start = " + @start.inspect
  end
  
  def play()
    puts "@start => " + @start.inspect
	next_room = @start
	the_game = Game.new
	
	while true
	  puts "\n--------"
	  death() if next_room == :death
	  room = the_game.method(next_room)
	  next_room = room.call()
	end
  end
  
  def death()
    puts @quips[rand(@quips.length())]
    Process.exit(1)
  end
end

a_game = Engine.new(:central_corridor)
a_game.play()