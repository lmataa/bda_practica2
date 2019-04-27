USE segundapracticabda;
-- SET GLOBAL query_cache_type = 0;

create trigger update_asistencias after update
on player_stats for each row
update player
set asistencias=asistencias+new.assists-old.assists,
	media_asistencias = AVG(NEW.assists)-- (SELECT AVG(assists) FROM player_stats GROUP BY player_id)
where player.player_id=player_id;


create trigger update2_asistencias after insert
on player_stats for each row
update player 
set asistencias=asistencias+new.assists,
	media_asistencias =NEW.AVG(assists)-- (SELECT AVG(assists) FROM player_stats GROUP BY player_id)
where player.player_id=new.player_id ;


create trigger update3_asistencias before delete
on player_stats for each row
update player
set asistencias=asistencias-old.assists,
	media_asistencias =NEW.AVG(assists)-- (SELECT AVG(assists) FROM player_stats GROUP BY player_id)
where player.player_id=old.player_id;


