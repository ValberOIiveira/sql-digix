-- Criar o banco de dados e definir charset
CREATE DATABASE IF NOT EXISTS jogos
    DEFAULT CHARACTER SET = utf8mb4;

USE jogos;

-- Criar tabela Time
CREATE TABLE time ( 
    id INTEGER PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- Criar tabela Partida
CREATE TABLE partida ( 
    id INTEGER PRIMARY KEY AUTO_INCREMENT, 
    time_1 INTEGER NOT NULL, 
    time_2 INTEGER NOT NULL, 
    time_1_gols INTEGER DEFAULT 0, 
    time_2_gols INTEGER DEFAULT 0, 
    FOREIGN KEY (time_1) REFERENCES time(id) ON DELETE CASCADE, 
    FOREIGN KEY (time_2) REFERENCES time(id) ON DELETE CASCADE
);

-- Inserir times
INSERT INTO time(nome) VALUES 
('CORINTHIANS'), 
('SÃO PAULO'), 
('CRUZEIRO'), 
('ATLETICO MINEIRO'),
('PALMEIRAS');

-- Inserir partidas (id será gerado automaticamente)
INSERT INTO partida(time_1, time_2, time_1_gols, time_2_gols) 
VALUES 
(4,1,0,4), 
(3,2,0,1), 
(1,3,3,0), 
(3,4,0,1), 
(1,2,0,0), 
(2,4,2,2), 
(1,5,1,2),
(5,2,1,2);

-- Verificar dados inseridos
SELECT * FROM time;
SELECT * FROM partida;

-- Criar Procedure para inserir partidas
DELIMITER //

CREATE PROCEDURE inserir_partida(
    IN time_1 INT, 
    IN time_2 INT, 
    IN time_1_gols INT, 
    IN time_2_gols INT
)
BEGIN
    INSERT INTO partida (time_1, time_2, time_1_gols, time_2_gols) 
    VALUES (time_1, time_2, time_1_gols, time_2_gols);
END //

DELIMITER ;

-- Testar a procedure
CALL inserir_partida(1, 2, 3, 1);

-- Verificar se a nova partida foi inserida corretamente
SELECT * FROM partida;


DELIMITER //

CREATE PROCEDURE atualizar_nome_time(
    IN p_id INT, 
    IN p_nome VARCHAR(100)
)
BEGIN
    UPDATE time
    SET nome = p_nome
    WHERE id = p_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Time não encontrado';
    END IF;
END //

DELIMITER ;


DELIMITER ;

CALL atualizar_nome_time(11, 'BOTAFOGO');

SELECT * FROM time;

CREATE PROCEDURE excluir_partida(
    IN p_ID INT
)
BEGIN
    DELETE FROM partida
    WHERE id = p_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Partida não encontrada';
    END IF;
END


CALL excluir_partida(1);


