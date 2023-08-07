defmodule Problems do
  @doc """
  Remove duplicates from a list.

  ## Examples

      iex> compress([1, 2, 2, 3, 4, 4, 4, 5])
      [1, 2, 3, 4, 5]

      iex> compress(~w[a b b c d d d e])
      ~w[a b c d e]

  """
  @spec compress([any]) :: [any]
  def compress(list) do
    compress(list, [])
  end

  defp compress([], acc), do: Enum.reverse(acc)
  defp compress([hd | tl], [hd | _] = acc), do: compress(tl, acc)
  defp compress([hd | tl], acc), do: compress(tl, [hd | acc])

  @doc """
  Pack consecutive duplicates of list elements into sublists.

  ## Examples

      iex> pack_compress([1, 2, 2, 3, 4, 4, 4, 5])
      [[1], [2, 2], [3], [4, 4, 4], [5]]

      iex> pack_compress(~w[a b b c d d d e])
      [["a"], ["b", "b"], ["c"], ["d", "d", "d"], ["e"]]

  """
  @spec pack_compress([any]) :: [any]
  def pack_compress([hd | tl]) do
    pack_compress(tl, [hd], [])
  end

  defp pack_compress([], sub, acc), do: Enum.reverse([sub | acc])
  defp pack_compress([hd | tl], [hd | _] = sub, acc), do: pack_compress(tl, [hd | sub], acc)
  defp pack_compress([hd | tl], sub, acc), do: pack_compress(tl, [hd], [sub | acc])
end
