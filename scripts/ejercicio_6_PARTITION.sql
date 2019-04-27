-- Mysql no deja particionar claves que tengan claves foráneas.
-- Eliminar la clave primaria es una mala solución, una alternativa es
-- generar superclave.
-- En este ejercicio creamos una clave primaria para game_id y año.
ALTER TABLE game DROP PRIMARY KEY;

ALTER TABLE game ADD PRIMARY KEY(game_id, date_time);

ALTER TABLE game 
PARTITION BY LIST (YEAR(date_time)) (
	PARTITION part_2017 VALUES IN (2017),
    PARTITION part_resto VALUES IN (2013, 2014, 2015, 2016, 2018)
);

