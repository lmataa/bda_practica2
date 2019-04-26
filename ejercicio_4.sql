USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
/*
ALTER TABLE player_stats
ADD COLUMN puntuacion INT;

UPDATE player_stats
SET puntuacion = null;
*/
EXPLAIN UPDATE player_stats
SET puntuacion = (select SUM(assists+goals+shots));
	