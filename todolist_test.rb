require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'final_todo_list_code'

class TodoListTest < MiniTest::Test

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

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size, "They are not the same size")
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end


  def test__raised_type_error
    assert_raises(TypeError) { @list.add(1) }
    assert_raises(TypeError) { @list.add('hi') }
  end

  def test_shovel_method
    todo4 = Todo.new("Go to dentist")
    @list << todo4
    assert_equal([@todo1, @todo2, @todo3, todo4], @list.to_a)
  end

  def test_that_the_add_and_shovel_method_are_aliases
    todo4 = Todo.new("Go to dentist")
    @list << todo4
    @list.add(todo4)
    assert_equal([@todo1, @todo2, @todo3, todo4, todo4], @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) {@list.item_at(3)}
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
  end

  def test_mark_done_at
    assert_raises(IndexError) {@list.mark_done_at(3)}
    @list.mark_done_at(2)
    assert_equal(true, @todo3.done?)
  end

  def test_mark_udone_at
    assert_raises(IndexError) {@list.mark_undone_at(3)}
    @todo1.done!
    @todo2.done!
    @todo3.done!
    @list.mark_undone_at(2)
    assert_equal(false, @todo3.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo1.done?)
  end

  def test_done!
    @todo1.done!
    @todo2.done!
    @todo3.done!
    assert_equal(true, @list.done?)
    @todo1.undone!
    @todo2.undone!
    @todo3.undone!
    assert_equal(false, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    
    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    @todo1.done!
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    @todo1.done!
    @todo2.done!
    @todo3.done!
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    
    assert_equal(output, @list.to_s)
  end

  def test_each
    random_array = []
    @list.each do |item|
      random_array << item
    end
    assert_equal(random_array, @todos)
  end

  def test_each_return
    random_array = []
    return_value = @list.each do |item|
      random_array << item
    end
    assert_equal(return_value, @list)
  end

  def test_select
    @todo1.done!
    @todo3.done!
    new_selection = @list.select{|item| item.done? == true}
    assert_equal(new_selection.todos, [@todo1, @todo3])
  end
end