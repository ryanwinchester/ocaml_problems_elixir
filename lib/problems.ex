defmodule Problems do
  @moduledoc """
  OCaml problems.
  See: https://ocaml.org/problems
  """

  @doc """
  Returns the last element of a list.

  ## Examples

      iex> last([1, 2, 3])
      3

      iex> last([])
      nil

  """
  def last([]), do: nil
  def last([last]), do: last
  def last([_ | tl]), do: last(tl)

  @doc """
  Returns the last two element of a list.

  ## Examples

      iex> last_two([1, 2, 3])
      {2, 3}

      iex> last_two([1])
      nil

      iex> last_two([])
      nil

  """
  def last_two([last_1, last_2]), do: {last_1, last_2}
  def last_two([_ | tl]), do: last_two(tl)
  def last_two(list) when is_list(list), do: nil

  @doc """
  Find the N'th element of a list.

  ## Examples

      iex> nth([1, 2, 3], 0)
      1

      iex> nth([1, 2, 3], 2)
      3

      iex> nth([1, 2, 3], 3)
      nil

      iex> nth([], 0)
      nil

  """
  def nth(list, at) do
    nth(list, at, 0)
  end

  defp nth([], _, _), do: nil
  defp nth([hd | _], at, at), do: hd
  defp nth([_ | tl], at, i), do: nth(tl, at, i + 1)

  @doc """
  Eliminate consecutive duplicates of list elements.

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

      iex> pack([1, 2, 2, 3, 4, 4, 4, 5])
      [[1], [2, 2], [3], [4, 4, 4], [5]]

      iex> pack(~w[a b b c d d d e])
      [["a"], ["b", "b"], ["c"], ["d", "d", "d"], ["e"]]

  """
  @spec pack([any]) :: [any]
  def pack([hd | tl]) do
    pack(tl, [hd], [])
  end

  defp pack([], sub, acc), do: Enum.reverse([sub | acc])
  defp pack([hd | tl], [hd | _] = sub, acc), do: pack(tl, [hd | sub], acc)
  defp pack([hd | tl], sub, acc), do: pack(tl, [hd], [sub | acc])
end
