SELECT * FROM player;

-- Comprobación UPDATE
UPDATE player_stats
SET assists = 8 
WHERE game_id=2012020011 AND player_id=8448208;

-- Deshacer UPDATE
UPDATE player_stats
SET assists = 2
WHERE game_id=2012020011 AND player_id=8448208;

-- Comprobación INSERT
INSERT INTO player_stats(game_id,player_id,assists)
VALUES (2012020001, 8448208, 188);

-- Comprobación DELETE
DELETE FROM player_stats WHERE game_id = 2012020001 AND player_id = 8448208 AND assists = 188;
