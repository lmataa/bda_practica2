/*Segunda consulta de la práctica, punto 3.b primera sentencia*/
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