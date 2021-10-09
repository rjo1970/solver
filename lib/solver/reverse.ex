defmodule Solver.Reverse do
  def reverse({[{a, b}], f}), do: reverse({[a, b], f})

  def reverse({[a, b], f}) do
    fz = Solver.zero_function(f)

    reverse = fn x ->
      zero_fn = fz.(x)
      zero_prime = Solver.derivative(zero_fn)

      zero_fn
      |> Solver.find_zero(zero_prime)
      |> Solver.converge()
    end

    {[b, a], reverse}
  end

  def expand(eq_list) do
    eq_list =
      eq_list
      |> Enum.map(&normalize_conversion_designation/1)

    reversals =
      eq_list
      |> Enum.map(&reverse/1)

    Map.merge(Map.new(reversals), Map.new(eq_list))
  end

  defp normalize_conversion_designation({[{a, b}], f}), do: {[a, b], f}
  defp normalize_conversion_designation(x), do: x
end
