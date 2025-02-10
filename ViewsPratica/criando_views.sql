-- CRIANDO UMA VIEW PARA LISTAR MÚSICAS COM SEUS ÁLBUNS E ARTISTAS
CREATE VIEW vw_musicas_detalhes AS
SELECT 
    m.titulo AS musica, 
    a.titulo AS album, 
    ar.nome AS artista, 
    m.duracao, 
    m.reproducoes
FROM musicas m
JOIN albuns a ON m.album_id = a.id
JOIN artistas ar ON a.artista_id = ar.id;

-- Criando uma View para Mostrar os Artistas e a Quantidade de Álbuns
CREATE VIEW vw_artistas_albuns AS
SELECT 
    ar.nome AS artista, 
    COUNT(al.id) AS total_albuns
FROM artistas ar
LEFT JOIN albuns al ON ar.id = al.artista_id
GROUP BY ar.nome;

-- Criando uma View para as Músicas Mais Reproduzidas
CREATE VIEW vw_musicas_populares AS
SELECT titulo, reproducoes 
FROM musicas 
WHERE reproducoes > 500000 
ORDER BY reproducoes DESC;


SELECT * FROM vw_musicas_detalhes;
SELECT * FROM vw_artistas_albuns;
SELECT * FROM vw_musicas_populares;


-- Modificando uma view com OR REPLACE
CREATE OR REPLACE VIEW vw_musicas_populares AS
SELECT titulo, reproducoes 
FROM musicas 
WHERE reproducoes > 300000 
ORDER BY reproducoes DESC;

-- Excluindo uma view
DROP VIEW vw_musicas_populares;


