SET GLOBAL query_cache_type = 0;
use practica2;
select t.team_id,teamName,SUM(tshots) as tiros,AVG(tgoals) as gol_partido,count(*) as numPartidos
from team t inner join team_stats ts on t.team_id=ts.team_id 
	inner join game g on ts.game_id=g.game_id
where year(date_time)=2017 and month(date_time)>=7 
group by t.team_id, teamName
having numPartidos >= ALL( select count(*) as numPartidos
							from team t inner join team_stats ts on t.team_id=ts.team_id 
									inner join game g on ts.game_id=g.game_id
							where year(date_time)=2017 and month(date_time)>=7 
                            group by t.team_id);