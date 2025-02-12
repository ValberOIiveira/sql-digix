SELECT * FROM time
SELECT * FROM partida

-- time_1 = id
-- SELECT 
--     p.id AS partida_id, 
--     t1.nome AS time_1, 
--     t2.nome AS time_2, 
--     p.time_1_gols, 
--     p.time_2_gols,
--     CASE 
--         WHEN p.time_1_gols > p.time_2_gols THEN t1.nome
--         WHEN p.time_2_gols > p.time_1_gols THEN t2.nome
--         ELSE 'Empate'
--     END AS vencedor
-- FROM partida p
-- JOIN time t1 ON p.time_1 = t1.id
-- JOIN time t2 ON p.time_2 = t2.id;

-- 1) Crie um view vpartida que retorne a tabela de partida adicionando as colunas 
-- nome_time_1 e nome_time_2 como o nome dos times

CREATE VIEW vpartida AS
SELECT 
    p.id AS partida_id, 
	t1.id AS id_time_1,
	t2.id AS id_time_2,
    t1.nome AS time_1, 
	p.time_1_gols AS gols_time_1,
	p.time_2_gols AS gols_time_2,
	t2.nome AS time_2
FROM partida p
JOIN time t1 ON p.time_1 = t1.id
JOIN time t2 ON p.time_2 = t2.id
ORDER BY p.id ASC;


SELECT * FROM vpartida


-- 2) Realize uma consulta em vpartida que retorne somente os jogos de times que
-- possuam nome que começam com A ou C

SELECT * FROM vpartida
WHERE time_1 ILIKE 'A%' OR time_1 ILIKE 'C%'
   OR time_2 ILIKE 'A%' OR time_2 ILIKE 'C%'
ORDER BY partida_id ASC;



-- 3) Crie um view utilizando a view vpartida que retorne uma coluna de classificacao
-- com o nome do ganhador da partida ou a palavra empate em caso de empate

CREATE VIEW res_partidas AS
SELECT 
    p.id AS partida_id, 
    t1.nome AS time_1, 
    t2.nome AS time_2, 
    p.time_1_gols, 
    p.time_2_gols,
    CASE 
        WHEN p.time_1_gols > p.time_2_gols THEN t1.nome
        WHEN p.time_2_gols > p.time_1_gols THEN t2.nome
        ELSE 'Empate'
    END AS vencedor
FROM partida p
JOIN time t1 ON p.time_1 = t1.id
JOIN time t2 ON p.time_2 = t2.id;

SELECT * FROM res_partidas

-- 4) Crie uma view vtime que retorne a tabela de time adicionando as colunas
-- partidas, vitorias derrotas, empates e pontos

SELECT 
    vencedor,
    COUNT(*) AS qtd_vitorias,
    COUNT(*) * 3 AS pontos
FROM res_partidas
WHERE vencedor != 'Empate'
GROUP BY vencedor
ORDER BY pontos DESC;


SELECT * 
FROM res_partidas
WHERE vencedor = 'Empate'

CREATE VIEW vtime AS
SELECT  
    t.nome AS time,
    COUNT(*) AS partidas,
    SUM(CASE WHEN (p.time_1 = t.id AND p.time_1_gols > p.time_2_gols) OR (p.time_2 = t.id AND p.time_2_gols > p.time_1_gols) THEN 1 ELSE 0 END) AS vitorias,
    SUM(CASE WHEN (p.time_1 = t.id AND p.time_1_gols < p.time_2_gols) OR (p.time_2 = t.id AND p.time_2_gols < p.time_1_gols) THEN 1 ELSE 0 END) AS derrotas,
    SUM(CASE WHEN p.time_1_gols = p.time_2_gols THEN 1 ELSE 0 END) AS empates,
    SUM(CASE WHEN (p.time_1 = t.id AND p.time_1_gols > p.time_2_gols) OR (p.time_2 = t.id AND p.time_2_gols > p.time_1_gols) THEN 3
             WHEN p.time_1_gols = p.time_2_gols THEN 1 ELSE 0 END) AS pontos
FROM time t
LEFT JOIN partida p ON p.time_1 = t.id OR p.time_2 = t.id
GROUP BY t.id
ORDER BY pontos DESC;

SELECT * FROM vtime



-- Funções


-- Retorna o maior valor entre os números
SELECT GREATEST(10, 20, 30, 5); -- Resultado: 30

-- Retorna o menor valor entre os números
SELECT LEAST(10, 20, 30, 5); -- Resultado: 5

-- Raiz quadrada de um número
SELECT SQRT(16); -- Resultado: 4

-- Logaritmo base 10
SELECT LOG10(1000); -- Resultado: 3

-- Seno de um ângulo em radianos
SELECT SIN(PI() / 2); -- Resultado: 1

-- Tangente de um ângulo em radianos
SELECT TAN(PI() / 4); -- Resultado: 1

-- Geração de um número aleatório entre 0 e 1
SELECT RANDOM(); -- Exemplo: 0.674839

-- Converte para maiúsculas
SELECT UPPER('hello world'); -- Resultado: 'HELLO WORLD'

-- Converte para minúsculas
SELECT LOWER('HELLO WORLD'); -- Resultado: 'hello world'

-- Retorna o tamanho da string
SELECT LENGTH('ChatGPT'); -- Resultado: 7

-- Substring (extrai parte da string)
SELECT SUBSTRING('Hello World' FROM 1 FOR 5); -- Resultado: 'Hello'

-- Concatenação de strings
SELECT CONCAT('Hello', ' ', 'World'); -- Resultado: 'Hello World'

-- Remove espaços em branco de uma string
SELECT TRIM('   text   '); -- Resultado: 'text'

-- Retorna a data e hora atuais
SELECT NOW(); -- Exemplo: '2025-02-12 14:30:00'

-- Retorna apenas a data atual
SELECT CURRENT_DATE; -- Exemplo: '2025-02-12'

-- Retorna apenas a hora atual
SELECT CURRENT_TIME; -- Exemplo: '14:30:00'

SELECT AGE ('2025-02-12', '2003-06-18');
SELECT INTERVAL '3 day'


DELIMITER $$

CREATE FUNCTION soma(a INT, b INT) RETURNS INT
DETERMINISTIC
BEGIN
	RETURN a + b;
END $$

DELIMITER ;

SELECT soma(10, 20);

CREATE OR REPLACE function consulta_time() returns time 
as begin
	return query select * from time;
end; 

CREATE OR REPLACE FUNCTION consulta_vencedor_por_time(id_time INTEGER) 
RETURNS VARCHAR(50) AS $$
DECLARE 
    vencedor VARCHAR(50);
BEGIN
    SELECT CASE 
        WHEN time_1_gols > time_2_gols THEN (SELECT nome FROM time WHERE id = time_1)
        WHEN time_1_gols < time_2_gols THEN (SELECT nome FROM time WHERE id = time_2)
        ELSE 'Empate'
    END INTO vencedor
    FROM partida 
    WHERE time_1 = id_time OR time_2 = id_time;

    RETURN vencedor;
END;
$$ LANGUAGE plpgsql;
