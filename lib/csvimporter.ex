defmodule TodoList.CsvImporter do

  def todo_from_csv(file) do
    file
      |>open_file()
      |> parse_todo()
      |> Enum.map(&parse_to_entry/1)
      |> TodoList.new()
  end

  defp open_file(file) do
    file
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Enum.to_list()
  end

  defp parse_todo(todo_list) do
    todo_list
      |> Enum.map(&String.split(&1, ","))
  end

  defp parse_to_entry([csv_date, rtitle]) do
    %{
      date:  csv_date |> parse_date(), 
      title: String.trim(rtitle)
    }
  end

  defp parse_date(date) do
    [year, month, date] = date |> String.split("/") |> Enum.map(&String.to_integer/1) 
    {:ok, date} = Date.new(year, month, date) 
    date  
  end
end