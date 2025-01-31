SELECT * 
FROM cargo;

SELECT * 
FROM usuario;

-- Selecionando apenas o nome da tabela cargo de maneiras diferentes

SELECT nome
FROM cargo;

SELECT nome AS nome_cargo
FROM cargo;

SELECT c.nome 
FROM cargo c;

-- Utilizando condicionais no SELECT

SELECT nome
FROM cargo
WHERE id = 1;

SELECT nome
FROM usuario
WHERE nome = 'Bianca';

-- Utilizando operadores no SELECT

SELECT *
FROM usuario
WHERE id = 2 OR id = 3;


-- IN aponta as linhas onde os valores são exatos

SELECT *
FROM cargo
WHERE salario in (4000.00, 8000.00)

SELECT * 
FROM cargo
WHERE salario BETWEEN 4000.00 AND 8000.00

SELECT * 
FROM cargo
WHERE salario NOT BETWEEN 4000.00 AND 8000.00

-- Utilizando operadores de pesquisa 

SELECT *
FROM usuario
-- O LIKE procura por valores na tabela que contenham ao menos o pedaço procurado
WHERE nome LIKE 'Jo%'

SELECT *
FROM usuario
WHERE nome LIKE '%ão'

-- Utilizando operadores de comparação

SELECT *
FROM usuario
WHERE id >= 10;

SELECT *
FROM usuario
WHERE id <= 10;



-- Operadores de ordenação

SELECT * 
FROM usuario
ORDER BY id
DESC;


-- Utilizando Limit para trazer apenas 5 linhas de resultado
SELECT *
FROM usuario
ORDER BY id DESC
LIMIT 5;


-- Utilizando agrupamento no SELECT
SELECT c.nome, u.id
FROM usuario u, cargo c
WHERE u.id = c.fk_usuario
GROUP BY c.nome, u.id;





-- Usando COUNT
SELECT COUNT(nome) AS "Salario entre 4k e 6k"
FROM cargo
WHERE salario BETWEEN 4000.00 AND 6000.00;


