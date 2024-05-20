require 'pry'
# Create a To-do list, which contains a collection of To-do objects (in an Array)

# To-do class:
# - Each to-do object has a name and description, as well as a
# "done" flag (show if the to-do object is done or not)

class Todo
  DONE = 'X'
  NOT_DONE = ' '

  attr_accessor :name, :description, :done

  def initialize(name, description='')
    @name, @description = name, description
    @done = false
  end

  def done!
    self.done = true
  end

  def done? 
    done  
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE : NOT_DONE}] #{name}"
  end

  def ==(other)
    name == other.name &&
      description == other.description &&
      done == other.done
  end
end

# To-do List
class TodoList
  attr_reader :name

  def initialize(name)
    @name = name
    @todos = []
  end

  

  def add(item)
    raise TypeError.new('Can only add Todo objects!') unless item.is_a?(Todo)
    todos << item
  end

  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos.dup
  end

  def done?
    todos.all?(&:done?)
  end

  def item_at(index)
    todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def done!
    todos.each(&:done!)
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    todos.delete_at(index) || raise(IndexError.new('Index out of bounds'))
  end

  def to_s
    header = "---- Today's Todos ----"
    todos.each_with_object(header) do |todo, str|
      str << "\n#{todo.to_s}"
    end
  end

  private

  attr_reader :todos
end


# Client Code - Given:
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding -----
list.add(todo1) # adds todo1 to end of list, returns list
list.add(todo2) # adds todo2 to end of list, returns list
# #<< - aliased to #add 
list << todo3   # adds todo3 to end of list, returns list
# list.add(1)   # raises TypeError with message "Can only add Todo objects"

# ---- Interrogating -----
# size
list.size == 3

# first
list.first == todo1 # true

# last
list.last  == todo3 # true

#to_a
list.to_a  # returns an array of all items in the list

#done?
list.done? # => false 

# ---- Retrieving an item in the list ----
# item_at
# list.item_at             # raises ArgumentError
list.item_at(1) == todo2 # returns 2nd item in list (zero based index)
# list.item_at(100)        # raises IndexError (Out of bounds)

# ---- Marking items in the list -----

# mark_done_at
# list.mark_done_at       # raises ArgumentError
list.item_at(1).done? #=> false
list.mark_done_at(1)    # marks the 2nd item as done
list.item_at(1).done? #=> true
# list.mark_done_at(100)  # raises IndexError

# mark_undone_at
# list.mark_undone_at             # raises ArgumentError
list.item_at(1).done? #=> true
list.mark_undone_at(1)          # marks the 2nd item as not done
list.item_at(1).done? #=> false
# list.mark_undone_at(100)        # raises IndexError

# done!
list.done!   # marks all items as done
list.done? #=> true

# ---- Deleting from the list -----

# shift
# list.shift == todo1 # removes and returns the first item in list

# pop
# list.pop == todo3  # removes and returns the last item in list

# remove_at
# list.remove_at             # raises ArgumentError
# list.remove_at(1) == todo2 # removes and returns the 2nd item

# list.remove_at(100)        # raises IndexError

# ---- Outputting the list -----

# to_s
puts list.to_s                      # returns string representation of the list

# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym