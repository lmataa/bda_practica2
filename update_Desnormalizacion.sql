update player p 
set asistencias= (select sum(assists) from player_stats ps where p.player_id=ps.player_id group by ps.player_id)
