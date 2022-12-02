defmodule Resuelvefc.Compensations.Players do
  @moduledoc """
  Resuelvefc.Compensations.Players contains logic for:
  - Calculate individual performance
  """

  @doc """
  Calculates individual player performance bassed on expected players goals and players scored goals
  Params:
  - players, list of players, :goles, :goles_minimos keys needed
  Returns list of players with :individual_performance value based on :goles / :goles_minimos (max_value = 100)
  """
  @spec calculate_individual_performance(list(map())) :: list(map())
  def calculate_individual_performance(players) do
    Enum.map(players, fn player ->
      indiv_performance = calculate_performance_single_player(player)
      Map.put(player, :individual_performance, indiv_performance)
    end)
  end

  @spec calculate_performance_single_player(map()) :: float()
  defp calculate_performance_single_player(
         %{"goles" => goals, goles_minimos: min_goals} = _player
       )
       when goals >= min_goals and min_goals > 0 and
              not is_nil(goals) and not is_nil(min_goals) do
    100.0
  end

  defp calculate_performance_single_player(
         %{"goles" => goals, goles_minimos: min_goals} = _player
       )
       when goals < min_goals and min_goals > 0 and goals > 0 and
              not is_nil(goals) and not is_nil(min_goals) do
    goals * 100 / min_goals
  end

  defp calculate_performance_single_player(_player) do
    0.0
  end
end
