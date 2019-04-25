---
title: "Memoria diseño modelo relacional"
author: [Luis Mata bm0613, Javier Morate bm0620]
date: "05-04-2019"
subtitle: "Segunda Práctica de Bases de Datos Avanzadas - UPM"
logo: logo.png
titlepage: "True"
toc: "True"
toc-own-page: "True"
listings-no-page-break: "True"
...

# Memoria de trabajo sobre técnicas de aceleración de consultas


## 1. Introducción y forma de trabajo

## 2. Puntos pedidos

### 1. Se realizará la importación del esquema y datos de las cuatro tablas

> Mediante la opción “Data Import” del menú Server de MySqlWorkbench con el fichero “dumpBDAprac2.sql” disponible en el Moodle de la asignatura.


### 2. Estudio de paneles de consulta e índices.

#### a. Crear una consulta SQL que permita obtener el número de partidos jugados por cada jugador para aquellos jugadores de nacionalidad estadounidense (USA) o canadiense (CAN) que hayan jugado más partidos que la media del número de partidos jugados por todos los jugadores. La consulta devolverá el nombre y apellido del jugador y su edad actual, así como el número de partidos jugados, pero el resultado estará ordenado descendentemente por edad e a igual edad por apellido seguido de nombre pero ascendentemente.

```SQL
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
SELECT firstName,lastName,edad,count(*) AS partidosJugados
FROM player p INNER JOIN player_stats ps ON p.player_id = ps.player_id
WHERE nationality='CAN' OR nationality='USA'
GROUP BY firstName,lastName,edad
HAVING partidosJugados >= ALL(select avg(partidosJugados)
	FROM (SELECT player_id,count(*) as partidosJugados
		FROM player_stats
		GROUP BY by player_id) as td)
ORDER BY edad DESC, lastName ASC, firstName ASC
```

#### b. Estudiar el plan de consulta, tomando nota de los costes del mismo y comentarlo.

![Plan de consulta sin índices ni claves]()
![Coste del plan de consulta sin índices ni claves]()

#### c. Crear las claves principales y foráneas mediante los ficheros script CrearClavesPrimarias.sql y CrearClavesForeaneas.sql, y nuevamente estudiar el pland e consulta, comparando costes con el punto anterior.

![Plan de consulta con claves]()
![Coste del plan de consulta con claves]()

#### d. Crear los índices que se estimen necesarios para mejorar la consulta.

Creamos un índice para nacionaldad, ya que ésta se situa en la cláusula WHERE, por lo que la consulta es susceptible de mejorar con un índice, además se trata de una cadena de 3 caracteres por lo que no resultaría costoso.

El otro índice que creamos va para la triada firstName, lastName y edad situada en la cláusula GROUP BY, por lo que también es susceptible de mejora.

```SQL
CREATE INDEX indx_nation
ON player(nationality);

CREATE INDEX indx_name_age
ON player(firstName, lastName, edad);
```

#### e. Estudiar el plan de consulta con los nuevos índices y comparar resultados con los obtenidos en los puntos anteriores.

![Plan de consulta con índices y claves]()

![Coste del plan de consulta con índices y claves]()

### 3. Optimización de consultas y estudio de planes de consulta

#### a. Eliminar los índices creados en el apartado anterior, manteniendo claves primarias y foráneas.

```SQL
DROP INDEX indx_nation
ON player;

DROP INDEX indx_name_age
ON player;
```

#### b. Definir en SQL al menos dos sentencias diferentes que permitan obtener los datos de los equipos que hayan jugado más partidos en los últimos seis meses del año 2017, devolviendo los atributos: identificador del equipo, nombre del equipo, número de partidos jugados, total de tiros (tshots) realizados en esos seis meses, media de goles del equipo por partido.

```SQL
-- Primera consulta
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
SELECT t.team_id, teamName, SUM(tshots) AS tiros, AVG(tgoals) AS avg_gol_partido, count(*) AS numPartidos
FROM team t INNER JOIN team_stats ts ON t.team_id=ts.team_id 
INNER JOIN game g ON ts.game_id = g.game_id
WHERE date_time BETWEEN '2017-07-1' AND '2017-12-31'
GROUP BY t.team_id, teamName
HAVING numPartidos >= ALL(SELECT count(*) AS numPartidos
	FROM team t INNER JOIN team_stats ts ON t.team_id=ts.team_id 
    		    INNER JOIN game g ON ts.game_id=g.game_id
	WHERE date_time BETWEEN '2017-07-1' AND '2017-12-31'
	GROUP BY t.team_id);
```
```SQL
-- Segunda consulta
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
SELECT t.team_id,teamName,SUM(tshots) AS tiros, AVG(tgoals) AS gol_partido, count(*) AS numPartidos
FROM team t INNER JOIN team_stats ts ON t.team_id=ts.team_id
INNER JOIN game g ON ts.game_id=g.game_id
WHERE YEAR(date_time)=2017 AND MONTH(date_time)>=7
GROUP BY t.team_id, teamName
HAVING numPartidos >= ALL(SELECT count(*) AS numPartidos
	FROM team t INNER JOIN team_stats ts ON t.team_id=ts.team_id
    		    INNER JOIN game g ON ts.game_id=g.game_id
	WHERE YEAR(date_time)=2017 AND MONTH(date_time)>=7
	GROUP BY t.team_id);
```

#### c. Crear los índices que permitan optimizar el coste de las consultas, analizando plan de consulta y coste para cada uno de los casos, justificando que solución es la más óptima.

En la primera consulta realizada en este apartado no usamos funciones para la fecha y se encuentra en la cláusula WHERE, por lo tanto es susceptible de mejora con índice.

En ambas consultas realizamos un GROUP BY por team_id y teamName, por lo que un índice para ambos valores es considerado en ambas para optimizar. 

```SQL
-- Creación de índices para la primera consulta
CREATE INDEX indx_dtime
ON game(date_time);
CREATE INDEX indx_team_id_name
ON team(team_id, teamName);
```
```SQL
-- Creación de índices para la segunda consulta
CREATE INDEX indx_team_id_name
ON team(team_id, teamName);
```

- Los resultados obtenidos en este apartado para las consultas realizadas indican una mejora sustancial en cuanto al uso de índices. Veamos:

![Coste consulta A sin índices](capturas/3_b_A_cost.png)
    
![Coste consulta A con índices](capturas/3_b_A_cost_windex.png)
    
![Coste consulta B sin índices](capturas/3_b_B_cost.png)
    
![Coste consulta B con índices](capturas/3_b_B_cost_windex.png)
    
- En cuanto a los planes de ejecución:

![Plan de ejecución A sin índices](capturas/3_c_A_ex.png)
    
![Plan de ejecución A con índices](capturas/3_c_A_ex_windex.png)
    
![Plan de ejecución B sin índices](capturas/3_c_B_ex.png)
    
![Plan de ejecución B con índices](capturas/3_c_B_ex_windex.png)
    

### 4. Estudio de índices en actualizaciones.

#### a. Eliminar los índices creados en el apartado anterior manteniendo claves primarias y foráneas.

```SQL
DROP INDEX indx_dtime
ON game;

DROP INDEX indx_team_id_name
ON team;
```

#### b. Crear un atributo en la tabla "player_stats" que se denomine "puntuación"que sea un número entero. El contenido de dicho atributo, para cada estadística de cada partido será un valor que se corresponderá con la suma de las cantidades de los atributos goals, shots y assists (es decir, en cada fila se sumarán los valores de estos atributos y se actualizará en el nuevo atributo "puntuación" con esa suma.) Actualizar la tabla player_stats para que contenga dicha información tomando nota de su tiempo de ejecución.

```SQL
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

ALTER TABLE player_stats
ADD COLUMN puntuacion INT;

EXPLAIN UPDATE player_stats
SET puntuacion = (select SUM(assists+goals+shots));
```

![Coste de la actualización](capturas/4_b_cost.png)

#### c. Volver a actualizar a null el atributo puntuación en todas las filas.

```SQL
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
UPDATE player_stats
SET puntuacion = null;
```

#### d. Por preverse un tipo de consultas con ordenación muy complicada, se desea crear un índice en la tabla "player_stats" por los atributos goals, shots, game_id, assists, player_id y puntuación, en ese orden. Crear el índice.

```SQL
CREATE INDEX indx_stats
ON player_stats(goals, shots, game_id, assists, player_id, puntuacion);
```

#### e. Volver a ejecutar la sentencia que establece los valores del atributo puntuación a la suma comentada anteriormente. Comprobar tiempo de ejecución y compararlo razonadamente con el contenido del punto 4.b.

![Coste de actualización con índices](capturas/4_e_cost.png)

### 5. Desnormalización

#### a. Eliminar los índices creados en el apartado anterior, manteniendo claves primarias y foráneas.

```SQL
DROP INDEX indx_stats
ON player_stats;
```

#### b. Crear una consulta que devuelva, para cada jugador su nombre, apellido, edad, total de asistencias (assists) y media de asistencias por partido, total de goles (goals) y media por partido para aquellos jugadores que tengan una edad entre 25 y 33 años.

```SQL
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
SELECT firstName, lastName, edad, goles, media_goles, SUM(assists) AS asistencias, AVG(assists) AS media_asis
FROM player p INNER JOIN player_stats ps ON p.player_id = ps.player_id
WHERE edad BETWEEN '25' AND '33'
GROUP BY firstName, lastName, edad, goles, media_goles;
```

#### c. Aplicar la técnica de desnormalización que se considere más adecuada para acelerar la consulta del apartado 5.b, creando los scripts sql necesarios para modificar el esquema de la base de datos.




#### d. Crear un script que actualice los datos implicados en la desnormalización.

#### e. Crear los triggers necesarios para mantener actualizados los datos implicados en la desnormalización.

#### f. Realizar la consulta 5.b sobre la base de datos desnormalizada. Estudiar coste y plan comparándolo con el obtenido en el apartado 5b.

### 6. Particionamiento.

#### a. Eliminar las claves foráneas con el script proporcionado “EliminarClavesForaneas.sql”.

#### b. Crear una consulta sql que obtenga, para cada jugador, su apellido, nombre, el número de partidos jugados y el número de jugadas realizadas por el jugador durante el año 2017. Estudiar coste y plan.

#### c. Razonar justificadamente (sin necesidad de implementarla realmente en SQL) una variante de la estructura existente realizando un particionamiento horizontal de los datos con el objeto de mejorar el tipo de consultas (con diferentes años) que se ha realizado en el apartado 6.a

#### d. Implementar en MySQL un particionamiento horizontal (mediante la sentencia ALTER TABLE …. PARTITION ….) que separe los datos de los partidos jugados en el año 2017 del resto. Realizar de nuevo la consulta 6.a y estudiar coste y plan comparándolo con lo obtenido en el apartado 6.a. Si se necesita modificar la clave primaria, hágase mediante la sentencia ALTER TABLE.

## 3. Conclusiones
