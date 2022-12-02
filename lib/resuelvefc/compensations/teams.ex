defmodule Resuelvefc.Compensations.Teams do
  @moduledoc """
  Resuelvefc.Compensations.Teams contains logic for:
  - Calculate team performance
  """

  @doc """
  Calculates team performance based on expected players goals and players scored goals from all team players
  Params:
  - players, list of players, :equipo, :goles and :goles_minimos keys needed
  Returns list of players with team_performance value respective to each team by "equipo" key
  """
  @spec calculate_team_performance(list(map())) :: list(map())
  def calculate_team_performance(players) do
    by_team = Enum.group_by(players, fn %{"equipo" => team} = _player -> team end)
    teams = Map.keys(by_team)

    Enum.map(teams, fn team ->
      cur_team = Map.fetch!(by_team, team)
      get_performance_by_team(cur_team)
    end)
    |> List.flatten()
  end

  @spec get_performance_by_team(list(map())) :: list()
  defp get_performance_by_team(players) do
    scored = get_team_scored_goals(players)
    minimum = get_minimum_goals_by_team(players)
    t_c = calculate_performance_by_team(scored, minimum)

    Enum.map(players, fn player ->
      Map.put(player, :team_performance, t_c)
    end)
  end

  @spec get_team_scored_goals(list(map())) :: integer()
  defp get_team_scored_goals(players) do
    Enum.reduce(players, 0, fn %{"goles" => goals} = _player, acc -> goals + acc end)
  end

  @spec get_minimum_goals_by_team(list(map())) :: integer()
  defp get_minimum_goals_by_team(players) do
    Enum.reduce(players, 0, fn %{goles_minimos: min_goals} = _player, acc ->
      min_goals + acc
    end)
  end

  @spec calculate_performance_by_team(integer(), integer()) :: float
  defp calculate_performance_by_team(scored_goals, minimum_goals)
       when scored_goals >= minimum_goals do
    100.0
  end

  defp calculate_performance_by_team(scored_goals, minimum_goals)
       when scored_goals < minimum_goals and minimum_goals > 0 do
    scored_goals * 100 / minimum_goals
  end

  defp calculate_performance_by_team(_, _) do
    0.0
  end
end
