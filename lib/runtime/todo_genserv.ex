defmodule TodoList.Runtime.TodoGenServ do

  alias TodoList.Impl.Todo
  alias TodoList.Runtime.GenServ
  
  def start() do
    GenServ.start(__MODULE__)
  end

  def init() do
    Todo.new([])
  end

  def handle_call({:get_entries, date}, todo_list) do
    {Todo.entries(todo_list, date), todo_list}
  end

  def handle_cast({:add_entry, new_entry}, todo_list) do
    Todo.add_entry(todo_list, new_entry)
  end

  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    Todo.update_entry(todo_list, entry_id, updater_fun)
  end

  def handle_cast({:delete_entry, entry_id}, todo_list) do
    Todo.delete_entry(todo_list, entry_id)
  end
end