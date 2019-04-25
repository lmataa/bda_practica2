USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
SELECT firstName, lastName, edad, COUNT(*) AS partidos_jugados
FROM player p INNER JOIN player_stats ps
			ON (p.player_id = ps.player_id)
WHERE nationality = 'USA' OR nationality = 'CAN'
GROUP BY firstName, lastName, edad;	