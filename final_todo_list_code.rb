# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
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
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end




# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo_item)
    raise TypeError, 'can only add Todo objects' if !todo_item.instance_of?(Todo)
    todos << todo_item
  end
  alias_method :<<, :add

  # rest of class needs implementation

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
    todos.to_a
  end

  def done?
    todos.all?{|todos| todos.done? == true}
  end

  def item_at(num)
    todos.fetch(num)
  end

  def mark_done_at(num)
    todos[num].done!
  end

  def mark_undone_at(num)
    todos[num].undone!
  end

  def done!
    todos.each {|items| items.done!}
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(num)
    todos.delete_at(num)
  end

  def to_s
    puts "---- Today's Todos ----"
    todos.each do |item|
      puts item.to_s
    end
    ""
  end

  def each(&block)
    todos.each do |item|
      yield(item)
    end
    self
  end

  def select(&block)
    selected = TodoList.new("New list")
    each do |item| 
      selected.todos << item if yield(item)
    end
    selected
  end

  def find_by_title(name)
    each do |item|
      return item if item.title == name
    end
    nil
  end

  def all_done
    select do |item|
      item.done? == true
    end
  end

  def all_not_done
    select do |item|
      item.done? == false
    end
  end

  def mark_done(name)
    find_by_title(name).done!
  end

  def mark_all_done
    each do |item|
      item.done!
    end
  end

  def mark_all_undone
    each do |item|
      item.undone!
    end
  end


  protected

  attr_reader :todos
end

=begin

TEST CODE

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)



list.mark_all_undone
puts list

=end