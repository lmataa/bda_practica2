
CREATE INDEX indx_nation
ON player(nationality);

CREATE INDEX indx_name_age
ON player(firstName, lastName, edad);


-- Unused --
CREATE INDEX indx_edad
ON player (edad);

DROP INDEX indx_edad
ON player;
 
DROP INDEX indx_nation
ON player;

DROP INDEX indx_name_age
ON player;