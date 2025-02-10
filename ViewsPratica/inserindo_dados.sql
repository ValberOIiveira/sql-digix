-- Inserindo Artistas
INSERT INTO artistas (nome, nacionalidade, genero, ano_inicio) VALUES
('Queen', 'Reino Unido', 'Rock', 1970),
('The Beatles', 'Reino Unido', 'Rock', 1960),
('Beyoncé', 'EUA', 'Pop', 1997);

-- Inserindo Álbuns
INSERT INTO albuns (titulo, artista_id, ano_lancamento, genero) VALUES
('A Night at the Opera', 1, 1975, 'Rock'),
('Abbey Road', 2, 1969, 'Rock'),
('Lemonade', 3, 2016, 'Pop');

-- Inserindo Músicas
INSERT INTO musicas (titulo, album_id, duracao, reproducoes) VALUES
('Bohemian Rhapsody', 1, '00:05:55', 1000000),
('Come Together', 2, '00:04:19', 750000),
('Formation', 3, '00:03:26', 500000);
