defmodule TodoList do
  alias TodoList.Runtime.Server

  defdelegate new(), to: Server, as: :start

  defdelegate add_entry(entry), to: Server

  defdelegate entries(date), to: Server

  defdelegate update_entry(entry_id, updater_fun), to: Server

  defdelegate delete_entry(entry_id), to: Server
end
