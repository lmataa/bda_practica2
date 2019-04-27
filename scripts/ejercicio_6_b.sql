-- Consulta del punto 6.b
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

SELECT p.firstName, p.lastName, COUNT(ps.player_id) AS partidosJugados, SUM(ps.puntuacion) as jugadasRealizadas
FROM player p, player_stats ps , game g
WHERE p.player_id = ps.player_id 
AND g.game_id = ps.game_id
AND YEAR(g.date_time) =2017
GROUP BY p.player_id;
