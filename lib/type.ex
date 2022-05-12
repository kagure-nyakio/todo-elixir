defmodule TodoList.Type do
  @type date :: Calendar.date()

  @type entry :: %{
    date: date,
    title: list(String.t)
  }
end