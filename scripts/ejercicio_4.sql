USE segundapracticabda;
-- SET GLOBAL query_cache_type = 0;
ALTER TABLE player_stats
ADD COLUMN puntuacion INT;

UPDATE player_stats
SET puntuacion = null;

UPDATE player_stats
SET puntuacion = (select sum(assists+goals+shots)
					group by game_id, player_id);
		