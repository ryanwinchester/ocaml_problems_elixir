defmodule Problems do
  @moduledoc """
  OCaml problems. See: https://ocaml.org/problems
  All the doc examples are tested with doctests.
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

  @doc """
  Run-length encoding of a list.

  ## Examples

      iex> encode(~w[a a a a b c c a a d e e e e])
      [{4, "a"}, {1, "b"}, {2, "c"}, {2, "a"}, {1, "d"}, {4, "e"}]

  """
  def encode(list) do
    list
    |> pack()
    |> Enum.map(&{len(&1), hd(&1)})
  end

  @doc """
  Modified run-length encoding.
  If an element has no duplicates it is simply copied into the result list.
  Only elements with duplicates are transferred as (N E) lists.

  ## Examples

      iex> modified_encode(~w[a a a a b c c a a d e e e e])
      [{4, "a"}, "b", {2, "c"}, {2, "a"}, "d", {4, "e"}]

  """
  def modified_encode(list) do
    list
    |> pack()
    |> Enum.map(fn
      [char] -> char
      chars -> {len(chars), hd(chars)}
    end)
  end

  @doc """
  Decode a run-length encoded list.

  ## Examples

      iex> decode([{4, "a"}, {1, "b"}, {2, "c"}, {2, "a"}, {1, "d"}, {4, "e"}])
      ~w[a a a a b c c a a d e e e e]

      iex> decode([{4, "a"}, "b", {2, "c"}, {2, "a"}, "d", {4, "e"}])
      ~w[a a a a b c c a a d e e e e]

  """
  def decode(list) do
    Enum.map(list, fn
      {count, char} when is_integer(count) -> List.duplicate(char, count)
      char -> char
    end)
    |> flatten()
  end

  @doc """
  Don't explicitly create the sublists containing the duplicates, as in problem
  "Pack consecutive duplicates of list elements into sublists", but only count
  them

  ## Examples

      iex> modified_encode_direct(~w[a a a a b c c a a d e e e e])
      [{4, "a"}, "b", {2, "c"}, {2, "a"}, "d", {4, "e"}]

  """
  def modified_encode_direct([current | tl]) do
    modified_encode_direct(tl, current, [])
  end

  defp modified_encode_direct([], current, acc),
    do: reverse([current | acc])

  defp modified_encode_direct([hd | tl], hd, acc),
    do: modified_encode_direct(tl, {2, hd}, acc)

  defp modified_encode_direct([hd | tl], {count, hd}, acc),
    do: modified_encode_direct(tl, {count + 1, hd}, acc)

  defp modified_encode_direct([hd | tl], current, acc),
    do: modified_encode_direct(tl, hd, [current | acc])

  @doc """
  Duplicate the elements of a list.

  ## Examples

      iex> duplicate(~w[a b c c d])
      ~w[a a b b c c c c d d]

  """
  def duplicate(list) do
    duplicate(list, [])
  end

  defp duplicate([], acc), do: reverse(acc)
  defp duplicate([hd | tl], acc), do: duplicate(tl, [hd, hd | acc])

  @doc """
  Replicate the elements of a list a given number of times.

  ## Examples

      iex> replicate(~w[a b c], 3)
      ~w[a a a b b b c c c]

  """
  def replicate(list, n) do
    replicate(list, n, 1, [])
  end

  defp replicate([], _, _, acc), do: reverse(acc)
  defp replicate([hd | tl], n, n, acc), do: replicate(tl, n, 1, [hd | acc])
  defp replicate([hd | _] = list, n, i, acc), do: replicate(list, n, i + 1, [hd | acc])

  @doc """
  Drop every N'th element from a list.

  ## Examples

      iex> drop(~w[a b c d e f g h i k], 3)
      ~w[a b d e g h k]

  """
  def drop(list, n) do
    drop(list, n, 1, [])
  end

  defp drop([], _, _, acc), do: reverse(acc)
  defp drop([_ | tl], n, n, acc), do: drop(tl, n, 1, acc)
  defp drop([hd | tl], n, i, acc), do: drop(tl, n, i + 1, [hd | acc])

  @doc """
  Split a list into two parts; the length of the first part is given.

  If the length of the first part is longer than the entire list, then the
  first part is the list and the second part is empty.

  ## Examples

      iex> split(~w[a b c d e f g h i j], 3)
      {~w[a b c], ~w[d e f g h i j]}

      iex> split(~w[a b c d], 5)
      {~w[a b c d], []}

  """
  def split(list, n) do
    split(list, n, 0, [])
  end

  defp split([], _, _, acc), do: {reverse(acc), []}
  defp split(list, n, n, acc), do: {reverse(acc), list}
  defp split([hd | tl], n, i, acc), do: split(tl, n, i + 1, [hd | acc])
end
