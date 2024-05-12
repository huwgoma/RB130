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

  def each
    todos.each { |todo| yield(todo) } 
    self
  end

  def select
    selections = self.class.new(name)
    each { |todo| selections << todo if yield(todo) }
    selections
  end

  def to_a
    todos.dup
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

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

# todo1.done!
list.mark_done_at(0)

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect
#=> [#<Todo:0x007fd88c0ad9f0 @title="Buy milk", @description="", @done=true>]