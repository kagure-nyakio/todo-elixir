defmodule TodoList do
  alias TodoList.Impl.Todo
  alias TodoList.Type

  @type todo  :: Todo.t 
  @type date  :: Type.date
  @type entry :: Type.entry

  @spec new(list(entry)) :: todo
  defdelegate new(entries \\ []), to: Todo

  @spec add_entry(todo, entry) :: todo
  defdelegate add_entry(todo_list, entry), to: Todo

  @spec entries(todo, date) :: list(entry)
  defdelegate entries(todo_list, date), to: Todo

  @spec update_entry(todo, integer, fun) :: todo
  defdelegate update_entry(todo_list, entry_id, updater_fun), to: Todo

  @spec delete_entry(todo, integer) :: todo 
  defdelegate delete_entry(todo_list, entry_id), to: Todo
end
