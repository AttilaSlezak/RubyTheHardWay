## Animal is-a object (yes, sort of confusing) look at the extra credit
class Animal

  attr_reader :energy

  def initialize()
    @energy = 100
  end
  
  def sleep(hour)
    @energy += hour * 10
	@energy = 100 if @energy > 100
  end

end

## Dog is-a object inherited from Animal
class Dog < Animal

  attr_reader :name

  def initialize(name)
    ## Dog has-a name
	super()
	@name = name
  end

  def run(distance)
    @energy -= distance
  end
  
end

## Cat is-a object inherited from Animal
class Cat < Animal

  attr_reader :name

  def initialize(name)
    ## Cat has-a name
	@name = name
  end
  
  def run(distance)
    @energy -= distance * 0.9
  end

end

## Person is-a object
class Person

  attr_accessor :pet
  attr_reader :energy
  
  def initialize(name)
    ## Person has-a name
    @name = name
	@energy = 100
  
  def sleep(hour)
    @energy += hour * 10
	@energy = 100 if @energy > 100
  end
  
    ## Person has-a pet of some kind
    @pet = nil
  end

end

## Employee is-a object inherited from Person
class Employee < Person

  attr_accessor :salary

  def initialize(name, salary)
    ## This calls the initializer method of the parent class 
	## and set the name of the Employee
	super(name)
	## Employee has-a salary
	@salary = salary
  end

  def work(hour)
    @energy -= hour * 5
  end

  def raise_salary(how_much)
    @salary += how_much
  end
  
end

## Fish is-a object
class Fish < Animal

  def initialize()
    super()
  end
  
  def swim(distance)
    @energy -= distance * 1.1
  end
  
end

## Salmon is-a object inherited from Fish
class Salmon < Fish

  def initialize()
    super()
  end

end

## Halibut is-a object inherited from Fish
class Halibut < Fish

  def initialize()
    super()
  end

end

class Shark < Fish

  def initialize()
    super()
  end

  def fight(one_fish)
	puts "The shark ate a " + one_fish.class.name
	one_fish = nil
  end
  
end

## rover is-a Dog
rover = Dog.new("Rover")

## copper is-a Dog
copper = Dog.new("Copper")

## satan is-a Cat
satan = Cat.new("Satan")

## mary is-a Person
mary = Person.new("Mary")

## mary has-a Cat 'satan'
mary.pet = satan

## frank is-a Employee
frank = Employee.new("Frank", 120000)

## frank has-a Dog 'rover'
frank.pet = [rover, copper]

## flipper is-a Fish
flipper = Fish.new

## crouse is-a Salmon
crouse = Salmon.new

## harry is-a Halibut
harry = Halibut.new

## hai is-a Shark
hai = Shark.new

puts "Rover's - the dog's - energy before running:"
puts rover.energy
rover.run(20)
puts "Rover's energy after running:"
puts rover.energy
rover.sleep(1)
puts "Rover's energy after sleeping 1 hour:"
puts rover.energy
puts "\nThe Salmon's 'crouse' energy: "

puts crouse.energy
crouse = hai.fight(crouse)
puts "So crouse the salmon doesn't exist anymore:"
begin
  puts crouse.energy
  rescue NoMethodError
    puts "The ask for printing crouse's energy caused 'NoMethodError'"
  else
    puts "There was another exception..."
end

puts "\nHow many animals has Frank?"
puts frank.pet.length
puts "Namely:"
frank.pet.each do |one_animal|
  puts one_animal.name + " who a " + one_animal.class.name + " is."
end
puts "\nFrank's salary is:"
puts "#{frank.salary} $"
puts "After he got a 5000 $ rise:"
frank.raise_salary(5000)
puts "#{frank.salary} $"

puts "\nFrank's energy: "
puts frank.energy
puts "Frank's energy after worked 8 hours: "
frank.work(8)
puts frank.energy
puts "Frank's energy after slept 8 hours: "
frank.sleep(8)
puts frank.energy