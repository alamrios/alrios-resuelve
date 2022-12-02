defmodule Resuelvefc.Compensations.Levels do
  @moduledoc """
  Resuelvefc.Compensations.Levels contains logic for:
  - Relate team levels to goals
  """

  @doc """
  Relates level_team_configuration with the given list of players
  Params:
  - players, list of players, :nivel key needed
  - _config, given level_team_configuration, :level_team_goals key needed
  Returns a list of players with :goles_minimos respective to given level team configuration or :error if :nivel was not found
  """
  @spec relate_team_levels_to_goals(list(map()), map()) :: list(map())
  def relate_team_levels_to_goals(players, %{level_team_goals: team_levels} = _config) do
    Enum.map(players, fn %{"nivel" => level} = player ->
      with {:ok, value} <- Map.fetch(team_levels, level) do
        Map.put(player, :goles_minimos, value)
      else
        :error -> Map.put(player, :error, "invalid 'nivel' value")
      end
    end)
  end
end
