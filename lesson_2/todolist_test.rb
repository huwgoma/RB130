require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < Minitest::Test
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    first_todo = @list.shift

    assert_equal(@todo1, first_todo)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    last_todo = @list.pop

    assert_equal(@todo3, last_todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
    @todos.each(&:done!) # Mark all todos as done.
    assert_equal(true, @list.done?)
  end

  def test_add_error
    assert_raises(TypeError) { @list.add('Not a todo') }
  end

  def test_shovel
    walk_dog = Todo.new('Walk dog')

    @list << walk_dog
    @todos << walk_dog

    assert_equal(@todos, @list.to_a)
  end

  def test_add
    walk_dog = Todo.new('Walk dog')

    @list.add(walk_dog)
    @todos << walk_dog

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) { @list.item_at(999) }
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(999) }

    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(999) }

    @todos.each(&:done!) # Mark all todos as done

    @list.mark_undone_at(0)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_done!
    # Marks all todos as done
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)

    @list.done!

    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(999) }
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s_uncompleted
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_one_completed
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    @todo1.done!
    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_completed
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @todos.each(&:done!)
    assert_equal(output, @list.to_s)
  end

  def test_each_iteration
    todos = []
    @list.each { |todo| todos << todo }
    assert_equal(@todos, todos)
  end

  def test_each_return
    each_return = @list.each { |todo| todo }
    assert_equal(@list, each_return)
  end

  def test_select
    selections = @list.select { |todo| todo.name.split.size == 2 }
    
    assert_equal([@todo1, @todo2], selections.to_a)
    refute_same(@list, selections)
  end
end
