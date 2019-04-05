
-- Asignatura Bases de Datos Avanzadas - curso 2018-19
-- ETS Ingenieria Sistemas Informaticos - UPM;

-- -----------------------------------------------------
-- Practica 2 - Script de creacion de claves principales
-- -----------------------------------------------------

ALTER TABLE player ADD PRIMARY KEY (player_id);
ALTER TABLE game ADD PRIMARY KEY (game_id);
ALTER TABLE team ADD PRIMARY KEY (team_id);
ALTER TABLE player_stats ADD PRIMARY KEY (game_id, player_id);
ALTER TABLE team_stats ADD PRIMARY KEY (game_id, team_id);
ALTER TABLE player_plays ADD PRIMARY KEY (player_id, play_id);

