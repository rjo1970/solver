defmodule Solver.SolverImplTest do
  use ExUnit.Case, async: true

  @subject Solver.Solver

  test "Given a list of possible keys and a map, provide a list of undefined keys" do
    assert @subject.free_keys([:a, :b, :c, :d], %{b: 5, c: 3}) == MapSet.new([:a, :d])
  end

  test "Given a problem and an expanded system of equations choose a next step" do
    problem = %{c: 88.0}

    s_of_e =
      Solver.expand([
        {[:a, :b], fn a -> a + 1 end},
        {[:b, :c], fn b -> b + 3 end}
      ])

    result = Solver.Solver.next_step_key(problem, s_of_e)

    assert result == [:c, :b]
  end

  test "Given a problem, a next step key, and a system of equations, solve the whole thing" do
    problem = %{c: 88.0}

    s_of_e =
      Solver.expand([
        {[:a, :b], fn a -> a + 1 end},
        {[:b, :c], fn b -> b + 3 end}
      ])

    next_key = [:c, :b]

    result = Solver.Solver.step(next_key, problem, s_of_e)

    assert result == %{c: 88.0, b: 85.0, a: 84.0}
  end

  test "Solve a system of equations" do
    problem = %{c: 88.0}

    s_of_e = [
      {[:a, :b], fn a -> a + 1 end},
      {[:b, :c], fn b -> b + 3 end}
    ]

    result = @subject.solve(s_of_e, problem)

    assert result == %{c: 88.0, b: 85.0, a: 84.0}
  end

  test "Partially apply a solver" do
    problem = %{c: 88.0}

    s_of_e = [
      {[:a, :b], fn a -> a + 1 end},
      {[:b, :c], fn b -> b + 3 end}
    ]

    result = @subject.solve(s_of_e).(problem)

    assert result == %{c: 88.0, b: 85.0, a: 84.0}
  end

  test "Find the circumference and diameter of a circle with area of 25cm^2" do
    area = fn r -> :math.pi() * r * r end
    circumference = fn r -> 2 * :math.pi() * r end
    diameter = fn r -> 2 * r end

    circle = [
      {[:r, :area], area},
      {[:r, :circumference], circumference},
      {[:r, :diameter], diameter}
    ]

    problem = %{area: 25}

    result = Solver.solve(circle, problem)

    assert_in_delta result[:circumference], 17.724, 0.001
    assert_in_delta result[:diameter], 5.641, 0.001
  end

  test "Find the volume of a cylinder given the radius of the top and bottom circles is 32cm and its height is 5cm" do
    area = fn r -> :math.pi() * r * r end
    volume = fn a, h -> a * h end

    cylinder = [
      {[:r, :area], area},
      {[[:area, :height], :volume], volume}
    ]

    problem = %{height: 5, r: 32}

    result = Solver.solve(cylinder, problem)

    assert_in_delta(result[:volume], 16084.954, 0.001)
  end
end
