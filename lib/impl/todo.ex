defmodule TodoList.Impl.Todo do
  alias TodoList.Type

  @type t :: %__MODULE__{
    auto_id: integer,
    entries: Type.entry
  }

  defstruct(
    auto_id: 1,
    entries: %{}
  )

  # Create a new todo list 
  # new todo list from a list of entries
  def new(entries \\ []) do 
    entries 
      |> Enum.reduce(%__MODULE__{}, &add_entry(&2, &1))
  end 

  # Add new Entries
  # Set ID for new entry, auto increment the auto_id field, add new entry to the collection
  def add_entry(todo_list, entry) do
    entry       = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %__MODULE__{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  # Get entry by date
  def entries(todo_list, date) do
    todo_list.entries
      |> Stream.filter(fn {_, entry} -> entry.date == date end)
      |> Enum.map(fn {_, entry} -> entry end)    
  end

  # update an entry, by id 
  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    new_entry   =  Map.fetch(todo_list.entries, entry_id) |> fetch_value(todo_list, updater_fun)
    new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
    %__MODULE__{todo_list | entries: new_entries}
  end

  def delete_entry(todo_list, entry_id) do
    %__MODULE__{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end

  defp fetch_value(:error, todo_list, _updater_fun) do
    todo_list
  end

  defp fetch_value({:ok, old_entry}, _todo_list, updater_fun) do
    updater_fun.(old_entry)
  end

end