
-- Eliminación de claves foráneas

ALTER TABLE game DROP FOREIGN KEY home_team_id;
ALTER TABLE game DROP FOREIGN KEY away_team_id;      
ALTER TABLE player_stats DROP FOREIGN KEY player_stats_game_id;
ALTER TABLE player_stats DROP FOREIGN KEY player_stats_player_id;
ALTER TABLE team_stats DROP FOREIGN KEY team_stats_team_id; 
ALTER TABLE team_stats DROP FOREIGN KEY team_stats_game_id;    
-- Por si el sistema deja los índices creados:
ALTER TABLE game DROP INDEX home_team_id;
ALTER TABLE game DROP INDEX away_team_id;
ALTER TABLE player_stats DROP INDEX player_stats_player_id;
ALTER TABLE team_stats DROP INDEX team_stats_team_id;       


      