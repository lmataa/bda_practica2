/* Creación de índices para el punto 3.b, ambas consulta*/

CREATE INDEX indx_dtime
ON game(date_time);

CREATE INDEX indx_team_id_name
ON team(team_id, teamName);


