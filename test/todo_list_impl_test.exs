defmodule TodoListImplTest do
  use ExUnit.Case
  alias TodoList.Impl.Todo

  test "a new todo list is created from a list of entries" do
    todolist = Todo.new([
        %{date: ~D[2018-12-19], title: "Dentist"},
        %{date: ~D[2018-12-20], title: "Shopping"},
        %{date: ~D[2018-12-19], title: "Movies"}
      ])
    assert map_size(todolist) > 0
  end

  test "a new todolist is created" do
    todolist = Todo.new([])
    assert todolist.auto_id === 1
  end

  test "an entry is added to the todo list" do
    todolist = Todo.new([
      %{date: ~D[2018-12-19], title: "Dentist"},
      %{date: ~D[2018-12-20], title: "Shopping"},
    ])
    
    todolist = Todo.add_entry(todolist, %{date: ~D[2018-12-19], title: "Movies"})
    assert map_size(todolist) === 3
  end

  test "an entry is recoverable from the todo list" do
    todolist = Todo.new([
      %{date: ~D[2018-12-19], title: "Dentist"},
      %{date: ~D[2018-12-20], title: "Shopping"},
    ])

    assert Todo.entries(todolist, ~D[2018-12-19]) === [%{date: ~D[2018-12-19], id: 1, title: "Dentist"}]
  end

  test "an entry is updatable" do
    todolist = Todo.new([
      %{date: ~D[2018-12-19], title: "Dentist"},
      %{date: ~D[2018-12-20], title: "Shopping"},
    ])

    todolist = Todo.update_entry(todolist, 1, &Map.put(&1, :title, "Cleaning"))
    assert Map.fetch(todolist.entries, 1) == {:ok, %{date: ~D[2018-12-19], id: 1, title: "Cleaning"}, }
  end

  test "an entry can be deleted from the list" do
    todolist = Todo.new([
      %{date: ~D[2018-12-19], title: "Dentist"},
      %{date: ~D[2018-12-20], title: "Shopping"},
    ])

    todolist = Todo.delete_entry(todolist, 1)

    assert map_size(todolist.entries) === 1
  end
end
