defmodule Resuelvefc.Compensations.LevelsTest do
  use ExUnit.Case

  alias Resuelvefc.Compensations.Levels
  alias Resuelvefc.Compensations.LevelTeamConfiguration

  test "Relating goals given the player level" do
    # success case
    input = [
      %{"nivel" => "B"},
      %{"nivel" => "A"},
      %{"nivel" => "C"},
      %{"nivel" => "Cuauh"}
    ]

    default_config = %LevelTeamConfiguration{}

    expected = [
      %{"nivel" => "B", goles_minimos: 10},
      %{"nivel" => "A", goles_minimos: 5},
      %{"nivel" => "C", goles_minimos: 15},
      %{"nivel" => "Cuauh", goles_minimos: 20}
    ]

    got = Levels.relate_team_levels_to_goals(input, default_config)

    assert expected == got

    # error case
    input = [
      %{"nivel" => "D"},
      %{"nivel" => "A"},
      %{"nivel" => "C"},
      %{"nivel" => "Cuau"}
    ]

    default_config = %LevelTeamConfiguration{}

    expected = [
      %{"nivel" => "D", error: "invalid 'nivel' value"},
      %{"nivel" => "A", goles_minimos: 5},
      %{"nivel" => "C", goles_minimos: 15},
      %{"nivel" => "Cuau", error: "invalid 'nivel' value"}
    ]

    got = Levels.relate_team_levels_to_goals(input, default_config)

    assert expected == got
  end
end
