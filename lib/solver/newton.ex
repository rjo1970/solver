defmodule Solver.Newton do
  @moduledoc """
  Find the zero given a function and its derivative.
  """

  def newton_iterator(f, f_prime) do
    newton_iterator(f, f_prime, 0)
  end

  def newton_iterator(f, f_prime, start) do
    Stream.unfold(start, fn x ->
      result = x - f.(x) / not_zero(f_prime.(x))
      {result, result}
    end)
  end

  defp not_zero(x) do
    if x == 0.0 do
      0.00001
    else
      x
    end
  end

  def zero_function(f) do
    fn k ->
      fn x -> f.(x) - k end
    end
  end

  def zero_function(f, k) do
    zero_function(f).(k)
  end
end
