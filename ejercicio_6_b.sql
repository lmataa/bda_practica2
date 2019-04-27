-- Consulta del punto 6.b
USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

SELECT p.firstName, p.lastName, COUNT(ps.player_id) AS partidosJugados, COUNT(pp.player_id) AS jugadasRealizadas
-- FROM player p, player_stats ps, player_plays pp, game g
FROM /*
player p inner join player_stats ps on p.player_id = ps.player_id 
inner join player_plays pp on pp.player_id = ps.player_id, game g*/
player p inner join player_plays pp on p.player_id = pp.player_id inner join
player_stats ps on ps.player_id = pp.player_id inner join
game g on ps.game_id = g.game_id
WHERE -- p.player_id = pp.player_id 
-- AND ps.player_id = pp.player_id
-- AND  
-- ps.game_id = g.game_id 
-- AND 
YEAR(g.date_time)=2017
GROUP BY p.firstName, p.lastName;