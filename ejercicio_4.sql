USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
/*
ALTER TABLE player_stats
ADD COLUMN puntuacion INT;

UPDATE player_stats
SET puntuacion = null;
*/
-- EXPLAIN
update player_stats
set puntuacion = (select sum(assists+goals+shots)
from player_stats
group by game_id, player_id);

UPDATE player_stats
SET puntuacion = (select sum(assists+goals+shots)
					group by game_id, player_id);
	