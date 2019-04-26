/*Segunda consulta de la práctica, punto 3.b segunda sentencia*/
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