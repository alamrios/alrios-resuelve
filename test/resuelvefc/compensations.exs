defmodule Resuelvefc.CompensationsTest do
  use ExUnit.Case

  alias Resuelvefc.Compensations
  alias Resuelvefc.Compensations.LevelTeamConfiguration

  test "Calculate team salary" do
    input = [
      %{
        "nombre" => "Juan Perez",
        "nivel" => "C",
        "goles" => 10,
        "sueldo" => 50000,
        "bono" => 25000,
        "sueldo_completo" => nil,
        "equipo" => "rojo"
      },
      %{
        "nombre" => "EL Cuauh",
        "nivel" => "Cuauh",
        "goles" => 30,
        "sueldo" => 100_000,
        "bono" => 30000,
        "sueldo_completo" => nil,
        "equipo" => "azul"
      },
      %{
        "nombre" => "Cosme Fulanito",
        "nivel" => "A",
        "goles" => 7,
        "sueldo" => 20000,
        "bono" => 10000,
        "sueldo_completo" => nil,
        "equipo" => "azul"
      },
      %{
        "nombre" => "El Rulo",
        "nivel" => "B",
        "goles" => 9,
        "sueldo" => 30000,
        "bono" => 15000,
        "sueldo_completo" => nil,
        "equipo" => "rojo"
      }
    ]

    default_config = %LevelTeamConfiguration{}

    expected = [
      %{
        "nombre" => "Juan Perez",
        "nivel" => "C",
        "goles" => 10,
        "sueldo" => 50000,
        "bono" => 25000,
        "sueldo_completo" => 67833.33,
        "equipo" => "rojo",
        goles_minimos: 15
      },
      %{
        "nombre" => "EL Cuauh",
        "nivel" => "Cuauh",
        "goles" => 30,
        "sueldo" => 100_000,
        "bono" => 30000,
        "sueldo_completo" => 1.3e5,
        "equipo" => "azul",
        goles_minimos: 20
      },
      %{
        "nombre" => "Cosme Fulanito",
        "nivel" => "A",
        "goles" => 7,
        "sueldo" => 20000,
        "bono" => 10000,
        "sueldo_completo" => 3.0e4,
        "equipo" => "azul",
        goles_minimos: 5
      },
      %{
        "nombre" => "El Rulo",
        "nivel" => "B",
        "goles" => 9,
        "sueldo" => 30000,
        "bono" => 15000,
        "sueldo_completo" => 42450.0,
        "equipo" => "rojo",
        goles_minimos: 10
      }
    ]

    got = Compensations.calculate_team_salary(input, default_config)

    Enum.map(expected, fn item -> assert item in got end)
  end
end
