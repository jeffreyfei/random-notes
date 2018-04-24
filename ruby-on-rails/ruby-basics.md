## Ruby Basics
### Operators
```ruby
  variable = "lol"
  variable.upcase! # ! operator mutates the variable

  # Combined comparison Operators
  # returns 0 if first is equal to second
  # 1 if first is greater than second
  # 2 if first is less than second
  first <=> second

  # Conditional assignment
  # Only assign "LOL" if variable is nil
  variable ||= "LOL"
```
### Statements
```ruby
  # Opposite of if
  unless booleanExpression
    # something
  else
    # something
  end

  # Simplier control statements
  statement if booleanExpression
  statement unless booleanExpression

  for n in 1...100
    # everything from 1 to 99
    # .. will include 100

    # break statement
    break if booleanExpression
    # skip to next value
    next if booleanExpression
  end

  object.each do |x|
    # do something with x
  end
  # Self explanatory
  object.each_key {}
  object.each_value {}

  # Do something to every element in the collection, same as map
  object.collect {|x| # Do something to x }
  object.map {}

  # print gg 100 times
  100.times { print "gg" }

  # print 1 up to 100 inclusive
  1.upto(100) { |x| print x }
  100.downto(1) { |x| print x } # self explanatory

  # Saves the block in the variable
  saved_block = Proc.new {}

  object.map(&saved_block)
  # Pass in lib method as a block using symbol
  object.map(&:to_s)

  # Lambdas
  lam = lambda { expressions }
```
### Methods
- Will return the last evaluated statement of the method if no return statement
is specified

```ruby
  variable = gets.chomp # waits for user input and assigns to variable
  variable.include? "s" # returns true if s is a substring of variable

  variable.gsub!(/s/, "lol") # replaces s with lol

  # if the method can be called upon the given object
  object.respond_to?(:method_name)

  # Yield keyword
  # The statements inside the block will be executed in the place of yield keyword
  def block_method(x)
    # Do something
    yield(x)
    # Do something
  end
  block_method { |x| #Do something in the block }
```

### Data Structure
```ruby
  # Hash

  # Create new Hash table
  htable = Hash.new
  # can pass in a default argument for hashes
  htable = Hash.new(0)

  # or
  table = {
    "lol" => 123,
    "gg" => true
  }

  # Sorting
  # Sort by key
  htable.sort_by do |key, value|
    key
  end
  # Sort by value  
  htable.sort_by do |key, value|
    value
  end
```

### Symbols

```ruby
  # Kind of like enums in C++/Java
  # Can be used as keys in a hash table
  :symb1
  :symb2

  hash = {
    :symb => true,
    :lol => false
  }

  # Converts to string "symb1"
  :symb1.to_s

  # Converts to symbol :symb1
  "symb1".to_sym

  # Internalizes string to symbol :symb1

  "symb1".intern
```

### Class
- methods are public by default
```ruby
  class MyClass
    @instance_var = "this is an instance variable"
    @@class_var = "class variable, like static variable"
    $global_var = "global variable"

    # Constructor
    def initialize(param)
      @some_var = param
    end

    # Shorthand for accessor methods
    attr_reader :instance_var
    attr_writer :instance_var

    # Or you can specify this to have both
    attr_accessor :instance_var

    public
    def method_1
      # Do something
    end

    # class method (static)
    def MyClass.class_method
      # Do something
    end
    private
    # Do something
  end

  # Usage
  instance = MyClass.new("lol")
  put instance.instance_var
  put MyClass.class_var
  put $global_var

  # Inheritance
  class ChildClass < MyClass
    # Will inherit all the methods of the parent class
    # Methods can be overriden

    # Override the parent method
    def method_1
      super # Calls the method of the parent class
    end
  end
```

### Modules

```ruby
  module MyModule
  end

  require 'MyModule'

  class MyClass
    # Includes the scope of the module
    include MyModule
    # Inherit all the methods from MyModule
    extend MyModule
  end
```