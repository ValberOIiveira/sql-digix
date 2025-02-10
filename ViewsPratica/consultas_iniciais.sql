-- Listando todas as músicas, seus álbuns e artistas
SELECT m.titulo AS musica, a.titulo AS album, ar.nome AS artista
FROM musicas m
JOIN albuns a ON m.album_id = a.id
JOIN artistas ar ON a.artista_id = ar.id;

-- Mostrando os artistas e a quantidade de álbuns que cada um tem
SELECT ar.nome AS artista, COUNT(al.id) AS total_albuns
FROM artistas ar
LEFT JOIN albuns al ON ar.id = al.artista_id
GROUP BY ar.nome;

-- Ver as músicas mais reproduzidas
SELECT titulo, reproducoes FROM musicas ORDER BY reproducoes DESC;

