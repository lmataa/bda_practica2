/*Primera consulta de la práctica, punto 2.a*/
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;
SELECT firstName,lastName,edad,count(*) as partidosJugados
from player p inner join player_stats ps on p.player_id=ps.player_id
where nationality='CAN' or nationality='USA'
group by firstName, lastName, edad	
having partidosJugados >= ALL(select avg(partidosJugados)
							from (select player_id,count(*) as partidosJugados
									from player_stats
									group by player_id) as td)
order by edad desc, lastName asc,firstName asc;
			