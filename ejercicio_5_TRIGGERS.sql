USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

CREATE TRIGGER update_player
AFTER UPDATE ON player_stats
FOR EACH ROW
BEGIN
	UPDATE player
	SET player.asistencias = NEW.assists
    WHERE player.player_id= player_stats.player_id;
	
    /*
    FROM player p
    INNER JOIN player_stats ps 
	ON p.player_id = ps.player_id;
*/END