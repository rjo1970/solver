defmodule Solver do
  @epsilon 0.000001

  @moduledoc """
  Create and solve linear systems of equations.

  # Example:

  Create a function description for converting f to c,
  and another one to convert k to c.
  Together, the entire system of equations can be solved
  given any one input.

  ```
    > f = {[:f, :c], fn f -> (f - 32) * 5/9 end}
    > k = {[:k, :c], fn k -> k - 273.15 end}
    > Solver.solve([f, k], %{c: 37.0})
    %{f: 98.6, c: 37.0, k: 310.15}
  ```
  """

  defdelegate find_zero(f, f_prime, start \\ @epsilon), to: Solver.Newton, as: :newton_iterator
  defdelegate derivative(f, delta \\ @epsilon), to: Solver.Richardson, as: :richardson
  defdelegate converge(iterator, epsilon \\ 0.0000000000001), to: Solver.Convergence
  defdelegate zero_function(f), to: Solver.Newton
  defdelegate reverse(tuple), to: Solver.Reverse
  defdelegate expand(eq_list), to: Solver.Reverse
  defdelegate solve(eq_list, problem), to: Solver.Solver
  defdelegate solve(eq_list), to: Solver.Solver
end
