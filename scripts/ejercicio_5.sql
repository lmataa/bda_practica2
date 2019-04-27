USE segundapracticabda;
-- SET GLOBAL query_cache_type = 0;

SELECT sql_no_cache firstName, lastName, edad, goles, media_goles, SUM(assists) AS asistencias, AVG(assists) AS media_asis
FROM player p INNER JOIN player_stats ps ON p.player_id = ps.player_id
WHERE edad BETWEEN '25' AND '33'
GROUP BY firstName, lastName, edad, goles, media_goles;
