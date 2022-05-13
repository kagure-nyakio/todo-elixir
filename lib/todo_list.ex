defmodule TodoList do
  alias TodoList.Runtime.TodoServer
  
  use GenServer

  defdelegate new, to: TodoServer, as: :start 

  def add_entry(entry) do
    GenServer.cast(:todo_server, {:add_entry, entry})
  end

  def entries(date) do
    GenServer.call(:todo_server, {:get_entries, date})
  end

  def update_entry(entry_id, updater_fun) do
    GenServer.cast(:todo_server, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(entry_id) do
    GenServer.cast(:todo_server, {:delete_entry, entry_id})
  end
end
