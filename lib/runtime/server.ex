defmodule TodoList.Runtime.Server do

  alias TodoList.Impl.Todo
  # client interface
  def start do
    spawn(fn -> 
      Process.register(self(), :todo_server)
      loop(Todo.new([])) end)
  end

  def add_entry(entry) do
    send(:todo_server, {:add_entry, entry})
  end


  def entries(date) do 
    send(:todo_server, {:get_entries, self(), date})
    receive do
      {:entries, entries} -> entries
    after
      5000 -> {:error, :timeout}
    end
  end 

  def update_entry(entry_id, updater_fun) do 
    send(:todo_server, {:update_entry, entry_id, updater_fun}) 
  end

  def delete_entry(entry_id) do 
    send(:todo_server, {:delete_entry, entry_id})
  end
  
  # Server Implementation
  defp loop(todo_list) do
    new_todo = 
      receive do
        message -> process_message(todo_list, message)
      end
      loop(new_todo)
  end

  defp process_message(todo_list, {:add_entry, new_entry}) do
    Todo.add_entry(todo_list, new_entry)
  end

  defp process_message(todo_list, {:get_entries, caller, date}) do
    send(caller, {:entries, Todo.entries(todo_list, date)})
    todo_list
  end

  defp process_message(todo_list, {:update_entry, entry_id, updater_fun}) do
    Todo.update_entry(todo_list, entry_id, updater_fun)
  end

  defp process_message(todo_list, {:delete_entry, entry_id}) do
    Todo.delete_entry(todo_list, entry_id)
  end

  defp process_message(_todo_list, message) do
    IO.puts("#{inspect message} not supported")
  end
end