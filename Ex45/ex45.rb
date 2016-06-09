## Animal is-a object (yes, sort of confusing) look at the extra credit
class Animal

end

## Dog is-a object inherited from Animal
class Dog < Animal

  def initialize(name)
    ## Dog has-a name
	@name = name
  end

end

## Cat is-a object inherited from Animal
class Cat < Animal

  def initialize(name)
    ## Cat has-a name
	@name = name
  end

end

## Person is-a object
class Person

  attr_accessor :pet
  
  def initialize(name)
    ## Person has-a name
    @name = name
  
    ## Person has-a pet of some kind
    @pet = nil
  end

end

## Employee is-a object inherited from Person
class Employee < Person

  def initialize(name, salary)
    ## This calls the initializer method of the parent class 
	## and set the name of the Employee
	super(name)
	## Employee has-a salary
  end

end

## Fish is-a object
class Fish

end

## Salmon is-a object inherited from Fish
class Salmon < Fish

end

## Halibut is-a object inherited from Fish
class Halibut < Fish

end

## rover is-a Dog
rover = Dog.new("Rover")

## satan is-a Cat
satan = Cat.new("Satan")

## mary is-a Person
mary = Person.new("Mary")

## mary has-a Cat 'satan'
mary.pet = satan

## frank is-a Employee
frank = Employee.new("Frank", 120000)

## frank has-a Dog 'rover'
frank.pet = rover

## flipper is-a Fish
flipper = Fish.new

## crouse is-a Salmon
crouse = Salmon.new

## harry is-a Halibut
harry = Halibut.new
