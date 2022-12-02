defmodule Resuelvefc.Compensations do
  @moduledoc """
  Resuelvefc.Compensations contains logic for:
  - Calculate team salary
  """
  alias Resuelvefc.Compensations.Players
  alias Resuelvefc.Compensations.Levels
  alias Resuelvefc.Compensations.Teams

  @doc """
  Calculates de complete salary of a provided players_list
  Params:
  - players, list of players (could be from different teams)
  - config, expected level_team_configuration
  Returns the modified list with the :sueldo_completo of each player
  """
  @spec calculate_team_salary(list(map()), map()) :: list(map())
  def calculate_team_salary(players, config) do
    Levels.relate_team_levels_to_goals(players, config)
    |> Players.calculate_individual_performance()
    |> Teams.calculate_team_performance()
    |> set_measured_performance
    |> set_compensation
    |> filter_fields
  end

  @spec set_measured_performance(list(map())) :: list(map())
  defp set_measured_performance(players) do
    Enum.map(players, fn player ->
      performance = get_measured_performance(player)
      Map.put(player, :measured_performance, performance)
    end)
  end

  @spec get_measured_performance(map()) :: float
  defp get_measured_performance(
         %{
           individual_performance: ip,
           team_performance: tp
         } = _player
       ) do
    (ip + tp) / 2.0 / 100.0
  end

  @spec set_compensation(list(map())) :: list(map())
  defp set_compensation(players) do
    Enum.map(players, fn player ->
      final_compensation = calculate_final_compensation(player)
      Map.put(player, "sueldo_completo", final_compensation)
    end)
  end

  @spec calculate_final_compensation(map()) :: float
  defp calculate_final_compensation(
         %{
           "bono" => bonus,
           "sueldo" => salary,
           measured_performance: performance
         } = _player
       ) do
    (salary + bonus * performance)
    |> Float.round(2)
  end

  @spec filter_fields(list(map())) :: list(map())
  defp filter_fields(raw_data) do
    Enum.map(raw_data, fn item ->
      Map.take(item, [
        "nombre",
        "nivel",
        :goles_minimos,
        "goles",
        "sueldo",
        "bono",
        "sueldo_completo",
        "equipo"
      ])
    end)
  end
end
