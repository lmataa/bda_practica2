USE segundapracticabda;
create trigger update_asistencias after update
on player_stats for each row
update player
set asistencias=asistencias+new.assists-old.assists,
 media_asistencias=(select avg(assists) from player_stats where player_id=new.player_id  group by player_id)
 where player.player_id=new.player_id;



create trigger update2_asistencias after insert
on player_stats for each row 
update player 
set asistencias=asistencias+new.assists,
 media_asistencias=(select avg(assists) from player_stats where player_id=new.player_id  group by player_id)
where player_id=new.player_id ;


create trigger update3_asistencias after delete
on player_stats for each row
update player
set asistencias=asistencias-old.assists ,
 media_asistencias=(select avg(assists) from player_stats where player_id=old.player_id  group by player_id)
where player.player_id=old.player_id;

