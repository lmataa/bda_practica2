/* Creación de índices para el punto 2.d de la práctica*/

CREATE INDEX indx_nation
ON player(nationality);

CREATE INDEX indx_name_age
ON player(firstName, lastName, edad);


-- DROPS --
/*
CREATE INDEX indx_edad
ON player (edad);

DROP INDEX indx_edad
ON player;
 
DROP INDEX indx_nation
ON player;

DROP INDEX indx_name_age
ON player;
*/