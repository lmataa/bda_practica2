USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

ALTER TABLE player
ADD COLUMN asistencias INT,
ADD COLUMN media_asistencias INT;


UPDATE player p 
SET asistencias = (
	SELECT SUM(assists) 
    FROM player_stats ps 
    WHERE p.player_id = ps.player_id 
    GROUP BY ps.player_id),
media_asistencias = (
	SELECT AVG(assists)
        FROM player_stats ps 
		WHERE p.player_id = ps.player_id 
		GROUP BY ps.player_id);
	