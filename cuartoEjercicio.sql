SET GLOBAL query_cache_type = 0;
select firstName,lastName,edad,goles,media_goles,sum(assists) as asistencias, avg(assists) as media_asis
from player p inner join player_stats ps on p.player_id=ps.player_id
where edad between '25' and '33'
group by firstName,lastName,edad,goles,media_goles;