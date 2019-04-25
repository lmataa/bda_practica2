use practica2;
update player_stats
set puntuacion = (select sum(assists+goals+shots)
group by game_id, player_id);

	