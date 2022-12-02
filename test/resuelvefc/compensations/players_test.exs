defmodule Resuelvefc.Compensations.PlayersTest do
  use ExUnit.Case

  alias Resuelvefc.Compensations.Players

  test "Calculating player individual performance" do
    input = [
      %{"goles" => 8, goles_minimos: 10},
      %{"goles" => 15, goles_minimos: 5},
      %{"goles" => 15, goles_minimos: 15},
      %{"goles" => 0, goles_minimos: 20}
    ]

    expected = [
      %{"goles" => 8, goles_minimos: 10, individual_performance: 80},
      %{"goles" => 15, goles_minimos: 5, individual_performance: 100},
      %{"goles" => 15, goles_minimos: 15, individual_performance: 100},
      %{"goles" => 0, goles_minimos: 20, individual_performance: 0}
    ]

    got = Players.calculate_individual_performance(input)

    assert got == expected
  end
end
