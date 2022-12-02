# Prueba Ingeniería Resuelve
¡Hola!,

Esta es mi solución a la prueba de ingeniería de Resuelve ([link](https://github.com/resuelve/prueba-ing-backend)).

## Descripción
Este proyecto expone el siguiente endpoint:

| Ruta | Método |
| ---- | ------ |
| /api/team/calculate-salary | POST |

Y debe de contener en el body a los jugadores de la siguiente manera (tomando el ejemplo del problema):

```json
{
   "jugadores" : [  
      {  
         "nombre":"Juan Perez",
         "nivel":"C",
         "goles":10,
         "sueldo":50000,
         "bono":25000,
         "sueldo_completo":null,
         "equipo":"rojo"
      },
      {  
         "nombre":"EL Cuauh",
         "nivel":"Cuauh",
         "goles":30,
         "sueldo":100000,
         "bono":30000,
         "sueldo_completo":null,
         "equipo":"azul"
      },
      {  
         "nombre":"Cosme Fulanito",
         "nivel":"A",
         "goles":7,
         "sueldo":20000,
         "bono":10000,
         "sueldo_completo":null,
         "equipo":"azul"

      },
      {  
         "nombre":"El Rulo",
         "nivel":"B",
         "goles":9,
         "sueldo":30000,
         "bono":15000,
         "sueldo_completo":null,
         "equipo":"rojo"

      }
   ]
}
```

Este endpoint devolverá la siguiente respuesta en caso de no encontrar algún problema:

```json
{
    "jugadores": [
        {
            "goles_minimos": 20,
            "bono": 30000,
            "equipo": "azul",
            "goles": 30,
            "nivel": "Cuauh",
            "nombre": "EL Cuauh",
            "sueldo": 100000,
            "sueldo_completo": 1.3e5
        },
        {
            "goles_minimos": 5,
            "bono": 10000,
            "equipo": "azul",
            "goles": 7,
            "nivel": "A",
            "nombre": "Cosme Fulanito",
            "sueldo": 20000,
            "sueldo_completo": 3.0e4
        },
        {
            "goles_minimos": 15,
            "bono": 25000,
            "equipo": "rojo",
            "goles": 10,
            "nivel": "C",
            "nombre": "Juan Perez",
            "sueldo": 50000,
            "sueldo_completo": 67833.33
        },
        {
            "goles_minimos": 10,
            "bono": 15000,
            "equipo": "rojo",
            "goles": 9,
            "nivel": "B",
            "nombre": "El Rulo",
            "sueldo": 30000,
            "sueldo_completo": 42450.0
        }
    ]
}
```
## Deploy en Gigalixir
El proyecto está preparado para el deploy en Gigalixir (siguiendo la [getting-started-guide](https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html)). De tal manera que para publicar un nuevo cambio realizado en el projecto, bastará con marcar los cambios en un commit y ejecutar el siguiente comando:
```shell
git push gigalixir
```