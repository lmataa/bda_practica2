-- Asignatura Bases de Datos Avanzadas - curso 2018-19
-- ETS Ingenieria Sistemas Informaticos - UPM;

-- ---------------------------------------------------
-- Practica 2 - Script de creacion claves foraneas
-- ---------------------------------------------------

ALTER TABLE game ADD CONSTRAINT home_team_id
	  FOREIGN KEY (home_team_id) REFERENCES team (team_id);
ALTER TABLE game ADD CONSTRAINT away_team_id
	  FOREIGN KEY (away_team_id) REFERENCES team (team_id);      
ALTER TABLE player_stats ADD CONSTRAINT player_stats_game_id
	  FOREIGN KEY (game_id) REFERENCES game (game_id);
ALTER TABLE player_stats ADD CONSTRAINT player_stats_player_id
	  FOREIGN KEY (player_id) REFERENCES player (player_id);
ALTER TABLE team_stats ADD CONSTRAINT team_stats_team_id
	  FOREIGN KEY (team_id) REFERENCES team (team_id); 
ALTER TABLE team_stats ADD CONSTRAINT team_stats_game_id
	  FOREIGN KEY (game_id) REFERENCES game (game_id);       

      