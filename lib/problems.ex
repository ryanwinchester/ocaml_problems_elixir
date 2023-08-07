defmodule Problems do
  @moduledoc """
  OCaml problems.
  See: https://ocaml.org/problems
  """

  @doc """
  Returns the last element of a list.

  ## Examples

      iex> last(~w[a b c d])
      "d"

      iex> last([])
      nil

  """
  def last([]), do: nil
  def last([last]), do: last
  def last([_ | tl]), do: last(tl)

  @doc """
  Returns the last two element of a list.

  ## Examples

      iex> last_two(~w[a b c d])
      {"c", "d"}

      iex> last_two(["a"])
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

      iex> nth(~w[a b c d e], 0)
      "a"

      iex> nth(~w[a b c d e], 2)
      "c"

      iex> nth(~w[a b c d e], 5)
      ** (ArgumentError) nth

      iex> nth([], 0)
      ** (ArgumentError) nth

  """
  def nth(list, at) do
    nth(list, at, 0)
  end

  defp nth([hd | _], at, at), do: hd
  defp nth([_ | tl], at, i), do: nth(tl, at, i + 1)
  defp nth([], _, _), do: raise(ArgumentError, message: "nth")

  @doc """
  Find the number of elements of a list.

  ## Examples

      iex> len(~w[a b c])
      3

      iex> len([])
      0

  """
  def len(list), do: len(list, 0)

  defp len([], acc), do: acc
  defp len([_ | tl], acc), do: len(tl, acc + 1)

  @doc """
  Reverse a list.

  ## Examples

      iex> reverse(~w[a b c])
      ~w[c b a]

  """
  def reverse(list), do: reverse(list, [])

  defp reverse([], acc), do: acc
  defp reverse([hd | tl], acc), do: reverse(tl, [hd | acc])

  @doc """
  Find out whether a list is a palindrome.

  ## Examples

      iex> is_palindrome(~w[x a m a x])
      true

      iex> is_palindrome(~w[a b])
      false

  """
  def is_palindrome(list) do
    list == reverse(list)
  end

  @doc """
  Flatten a nested list structure.

  ## Examples

      iex> flatten(["a", ["b", ["c", "d"], "e"]])
      ~w[a b c d e]

  """
  def flatten(list) do
    flatten(list, []) |> reverse()
  end

  defp flatten([], acc), do: acc
  defp flatten([hd | tl], acc) when is_list(hd), do: flatten(tl, flatten(hd, acc))
  defp flatten([hd | tl], acc), do: flatten(tl, [hd | acc])

  @doc """
  Eliminate consecutive duplicates of list elements.

  ## Examples

      iex> compress(~w[a b b c d d d e])
      ~w[a b c d e]

  """
  def compress(list) do
    compress(list, [])
  end

  defp compress([], acc), do: reverse(acc)
  defp compress([hd | tl], [hd | _] = acc), do: compress(tl, acc)
  defp compress([hd | tl], acc), do: compress(tl, [hd | acc])

  @doc """
  Pack consecutive duplicates of list elements into sublists.

  ## Examples

      iex> pack(~w[a b b c d d d e])
      [["a"], ["b", "b"], ["c"], ["d", "d", "d"], ["e"]]

  """
  def pack([hd | tl]) do
    pack(tl, [hd], [])
  end

  defp pack([], sub, acc), do: reverse([sub | acc])
  defp pack([hd | tl], [hd | _] = sub, acc), do: pack(tl, [hd | sub], acc)
  defp pack([hd | tl], sub, acc), do: pack(tl, [hd], [sub | acc])
end
