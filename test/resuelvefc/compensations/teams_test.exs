defmodule Resuelvefc.Compensations.TeamsTest do
  use ExUnit.Case

  alias Resuelvefc.Compensations.Teams

  test "Calculate single team performance" do
    # single team, one player compensates
    input = [
      %{"goles" => 8, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 15, "equipo" => "A", goles_minimos: 5}
    ]

    expected = [
      %{"goles" => 8, "equipo" => "A", team_performance: 100, goles_minimos: 10},
      %{"goles" => 15, "equipo" => "A", team_performance: 100, goles_minimos: 5}
    ]

    got = Teams.calculate_team_performance(input)

    assert got == expected

    # single team, less than 100 performance
    input = [
      %{"goles" => 8, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 10, "equipo" => "A", goles_minimos: 10}
    ]

    expected = [
      %{"goles" => 8, "equipo" => "A", team_performance: 90, goles_minimos: 10},
      %{"goles" => 10, "equipo" => "A", team_performance: 90, goles_minimos: 10}
    ]

    got = Teams.calculate_team_performance(input)

    assert got == expected

    # single team, every player less than 100 performance
    input = [
      %{"goles" => 8, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 9, "equipo" => "A", goles_minimos: 10}
    ]

    expected = [
      %{"goles" => 8, "equipo" => "A", team_performance: 85, goles_minimos: 10},
      %{"goles" => 9, "equipo" => "A", team_performance: 85, goles_minimos: 10}
    ]

    got = Teams.calculate_team_performance(input)

    assert got == expected
  end

  test "Calculate multiple teams performance" do
    # multiple teams, one player compensates
    input = [
      %{"goles" => 8, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 15, "equipo" => "A", goles_minimos: 5},
      %{"goles" => 15, "equipo" => "B", goles_minimos: 5}
    ]

    expected = [
      %{"goles" => 8, "equipo" => "A", team_performance: 100, goles_minimos: 10},
      %{"goles" => 15, "equipo" => "A", team_performance: 100, goles_minimos: 5},
      %{"goles" => 15, "equipo" => "B", team_performance: 100, goles_minimos: 5}
    ]

    got = Teams.calculate_team_performance(input)

    assert got == expected

    # multiple teams, less than 100 performance
    input = [
      %{"goles" => 8, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 10, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 3, "equipo" => "B", goles_minimos: 5}
    ]

    expected = [
      %{"goles" => 8, "equipo" => "A", team_performance: 90, goles_minimos: 10},
      %{"goles" => 10, "equipo" => "A", team_performance: 90, goles_minimos: 10},
      %{"goles" => 3, "equipo" => "B", team_performance: 60, goles_minimos: 5}
    ]

    got = Teams.calculate_team_performance(input)

    assert got == expected

    # single team, every player less than 100 performance
    input = [
      %{"goles" => 8, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 9, "equipo" => "A", goles_minimos: 10},
      %{"goles" => 6, "equipo" => "B", goles_minimos: 10},
      %{"goles" => 9, "equipo" => "B", goles_minimos: 10}
    ]

    expected = [
      %{"goles" => 8, "equipo" => "A", team_performance: 85, goles_minimos: 10},
      %{"goles" => 9, "equipo" => "A", team_performance: 85, goles_minimos: 10},
      %{"goles" => 6, "equipo" => "B", team_performance: 75, goles_minimos: 10},
      %{"goles" => 9, "equipo" => "B", team_performance: 75, goles_minimos: 10}
    ]

    got = Teams.calculate_team_performance(input)

    assert got == expected
  end
end
