# Using OTP GenServer behaviour
defmodule TodoList.Runtime.TodoServer do
  alias TodoList.Impl.Todo

  use GenServer

  def start do
    GenServer.start(__MODULE__, [], name: :todo_server)
  end

  @impl GenServer
  def init(todo) do
    # :timer.send_interval(5000, :cleanup)
    {:ok, Todo.new(todo)}
  end

  @impl GenServer
  def handle_call({:get_entries, date}, _client_pid, todo_list) do
    {:reply, Todo.entries(todo_list, date), todo_list}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, Todo.add_entry(todo_list, new_entry)}
  end

  @impl GenServer
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    {:noreply, Todo.update_entry(todo_list, entry_id, updater_fun)}
  end

  @impl GenServer
  def handle_cast({:delete_entry, entry_id}, todo_list) do
    {:noreply, Todo.delete_entry(todo_list, entry_id)}
  end

  # Handle info/1 handles messages that are not specific to OTP
  @impl GenServer
  def handle_info(:cleanup, state) do
    IO.puts "performing cleanup..."
    # { :stop, :normal, state }
    {:noreply, state}
  end

end