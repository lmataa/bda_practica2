USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

ALTER TABLE player
ADD COLUMN asistencias INT;

UPDATE player
SET asistencias = ( SELECT assists FROM player_stats);
