strut
-----

# is a semi class
# used when not sure if you need a class yet or not
# allows you to create within the class you are in. if becomes too much, you create a new class

e.g. WIHTOUT STRUT


Person = Struct.new(:name, :age, :gender) do

  def greet_world
    "Hello world, my name is #{name}."
  end

  def ask_question
    "What is your favorite programming language?"
  end

end


stephanie = Person.new("Stephanie", "26", "female")

stephanie.name          # => "Stephanie" 
stephanie.age           # => "26"
stephanie.gender        # => "female"

stephanie.greet_world   # => "Hello world, my name is Stephanie."
stephanie.ask_question  # => "What is your favorite programming language?"

e.g. WITH STRUT


data = [["Stephanie", "female"], ["Matz", "male"], ["Sandi", "female"], ["David", "male"],
["Aaron", "male"]]

class TransparentRoster
  attr_accessor :participants

  def initialize(data)
    @participants = structify(data)
  end

  def sorted_names
    participants.collect { |person| person.name }.sort
  end

  def participant_list
    puts "This year's participants include:"
    sorted_names.each { |name| puts name }
  end

  # here's where we turn the 2D array of data into struct objects

  Person = Struct.new(:name, :gender)

  def structify(data)
    data.collect { |pair| Person.new(pair[0], pair[1]) }
  end

end

