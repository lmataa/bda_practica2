USE segundapracticabda;
SET GLOBAL query_cache_type = 0;

SELECT firstName, lastName, edad, goles, media_goles, asistencias, media_asistencias
FROM player p
WHERE edad BETWEEN '25' AND '33'
GROUP BY firstName, lastName, edad, goles, media_goles;
