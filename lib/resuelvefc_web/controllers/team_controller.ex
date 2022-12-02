defmodule ResuelvefcWeb.TeamController do
  use ResuelvefcWeb, :controller
  alias Resuelvefc.Compensations
  alias Resuelvefc.Compensations.LevelTeamConfiguration

  @doc """
  This endpoint is the responsible to accept a list of football players and calculates its complete salary.
  Route: /api/team/calculate-salary
  Params;
   - jugadores :: []Player
  Definitions:
   - Player: {
         "nombre"::string,
         "nivel"::string,
         "goles"::int,
         "sueldo"::float,
         "bono"::float,
         "sueldo_completo"::float,
         "equipo"::string
      }
  """
  @spec calculate_salary(Plug.Conn.t(), map()) :: map()
  def calculate_salary(conn, params) do
    defaultLevelTeamConfig = %LevelTeamConfiguration{}
    players = Compensations.calculate_team_salary(params["jugadores"], defaultLevelTeamConfig)

    json(conn, %{
      jugadores: players
    })
  end
end
