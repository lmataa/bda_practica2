-- Consulta del punto 6.d
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

SELECT p.firstName, p.lastName, COUNT(ps.player_id) AS partidosJugados, SUM(ps.puntuacion) as jugadasRealizadas
FROM player p, player_stats ps , game PARTITION(part_2017)
WHERE p.player_id = ps.player_id 
AND game.game_id = ps.game_id
GROUP BY p.player_id;
