defmodule TodoList do

  alias TodoList.Runtime.TodoGenServ, as: MyServer
  alias TodoList.Runtime.GenServ

  def new() do
    MyServer.start()
  end

  def add_entry(server_pid, entry) do
    GenServ.cast(server_pid, {:add_entry, entry})
  end

  def entries(server_pid, date) do
    GenServ.call(server_pid, {:get_entries, date})
  end

  def update_entry(server_pid, entry_id, updater_fun) do
    GenServ.cast(server_pid, {:update_entry, entry_id, updater_fun})
  end

  def delete_entry(server_pid, entry_id) do
    GenServ.cast(server_pid, {:delete_entry, entry_id})
  end
end
