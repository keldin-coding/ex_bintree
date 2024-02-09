defmodule Bintree do
  alias Bintree.Node

  @moduledoc """

  """

  def build([]), do: nil

  def build(data) do
    Enum.reduce(data, nil, fn element, acc ->
      insert_node(acc, element)
    end)
  end

  def insert(%Node{} = tree, element), do: insert_node(tree, element)

  def breadth_first_print(%Node{} = tree), do: do_breadth_first_print([{tree, 0}])

  defp do_breadth_first_print([]), do: nil

  defp do_breadth_first_print([{node, _} | rest]) when is_nil(node),
    do: do_breadth_first_print(rest)

  defp do_breadth_first_print([{node, level} | rest]) do
    %Node{left: left, right: right, data: data, red: red} = node

    IO.puts("Level: #{level} | Data: #{data} | Red? #{red}")

    do_breadth_first_print(rest ++ [{left, level + 1}, {right, level + 1}])
  end

  defp insert_node(nil, element), do: %Node{data: element, red: true}

  defp insert_node(%Node{data: data, left: left} = tree, element) when element < data do
    %{tree | left: insert_node(left, element)}
  end

  defp insert_node(%Node{data: data, right: right} = tree, element) when element > data do
    %{tree | right: insert_node(right, element)}
  end

  defp insert_node(%Node{data: data} = tree, element) when element == data, do: tree
end
