-- Tabela de Artistas
CREATE TABLE artistas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    genero VARCHAR(50),
    ano_inicio INT
);

-- Tabela de Álbuns
CREATE TABLE albuns (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    artista_id INT REFERENCES artistas(id) ON DELETE CASCADE,
    ano_lancamento INT,
    genero VARCHAR(50)
);

-- Tabela de Músicas
CREATE TABLE musicas (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    album_id INT REFERENCES albuns(id) ON DELETE CASCADE,
    duracao TIME,
    reproducoes INT DEFAULT 0
);
