CREATE TABLE sala (
    id_sala SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    capacidade INT 
);

CREATE TABLE diretor (
    id_diretor SERIAL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE genero (
    id_genero SERIAL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE premiacao (
    id_premiacao SERIAL PRIMARY KEY,
    nome VARCHAR(45),
    ano DATE
);

CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    horario TIMESTAMP NOT NULL
);

CREATE TABLE funcao (
    id_funcao SERIAL PRIMARY KEY,
    nome VARCHAR(45)
);


CREATE TABLE filme (
    id_filme SERIAL PRIMARY KEY,
    nome_BR VARCHAR(45) NOT NULL,
    nome_EN VARCHAR(45),
    ano_lancamento DATE,
    diretor_id INT REFERENCES diretor(id_diretor) ON DELETE SET NULL,
    sinopse TEXT,
    genero_id INT REFERENCES genero(id_genero) ON DELETE SET NULL
);

CREATE TABLE funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(45),
    carteira_trabalho BIGINT,
    data_contratacao DATE,
    salario DECIMAL(10,2)
);

-- Tabelas que dependem de múltiplas tabelas
CREATE TABLE filme_exibido_sala (
    filme_id INT REFERENCES filme(id_filme) ON DELETE CASCADE,
    sala_id INT REFERENCES sala(id_sala) ON DELETE CASCADE,
    horario_id INT REFERENCES horario(id_horario) ON DELETE CASCADE
);

CREATE TABLE filme_has_premiacao (
    filme_id INT REFERENCES filme(id_filme) ON DELETE CASCADE,
    premiacao_id INT REFERENCES premiacao(id_premiacao) ON DELETE CASCADE,
    ganhou BOOLEAN DEFAULT FALSE NOT NULL
);

CREATE TABLE horario_trabalho_funcionario (
    horario_id INT REFERENCES horario(id_horario) ON DELETE CASCADE,
    funcionario_id INT REFERENCES funcionario(id_funcionario) ON DELETE CASCADE,
    funcao_id INT REFERENCES funcao(id_funcao) ON DELETE CASCADE
);


INSERT INTO sala (nome, capacidade) VALUES
('Sala 1', 100),
('Sala 2', 150),
('Sala 3', 200),
('Sala 4', 120),
('Sala 5', 180);


INSERT INTO diretor (nome) VALUES
('Christopher Nolan'),
('Quentin Tarantino'),
('Steven Spielberg'),
('James Cameron'),
('Greta Gerwig');


INSERT INTO genero (nome) VALUES
('Ação'),
('Drama'),
('Comédia'),
('Ficção Científica'),
('Terror');

INSERT INTO premiacao (nome, ano) VALUES
('Oscar', '2023-01-01'),
('Globo de Ouro', '2023-01-01'),
('BAFTA', '2023-01-01'),
('Cannes', '2023-01-01'),
('Sundance', '2023-01-01');

INSERT INTO horario (horario) VALUES
('2023-10-01 14:00:00'),
('2023-10-01 16:00:00'),
('2023-10-01 18:00:00'),
('2023-10-01 20:00:00'),
('2023-10-01 22:00:00');



INSERT INTO funcao (nome) VALUES
('Gerente'),
('Atendente'),
('Projecionista'),
('Limpeza'),
('Segurança');


INSERT INTO funcionario (nome, carteira_trabalho, data_contratacao, salario) VALUES
('João Silva', 123456789, '2020-01-15', 3000.00),
('Maria Oliveira', 987654321, '2019-05-20', 3200.00),
('Carlos Souza', 456789123, '2021-03-10', 2800.00),
('Ana Costa', 321654987, '2018-11-30', 3500.00),
('Pedro Rocha', 789123456, '2022-07-25', 2900.00);

INSERT INTO filme (nome_BR, nome_EN, ano_lancamento, diretor_id, sinopse, genero_id) VALUES
('Interestelar', 'Interstellar', '2014-11-06', 1, 'Um grupo de exploradores viaja através de um buraco de minhoca no espaço.', 4),
('Pulp Fiction', 'Pulp Fiction', '1994-10-14', 2, 'As vidas de dois assassinos da máfia, um boxeador e um casal se entrelaçam.', 2),
('O Parque dos Dinossauros', 'Jurassic Park', '1993-06-11', 3, 'Um parque temático com dinossauros clonados sai do controle.', 4),
('Avatar', 'Avatar', '2009-12-18', 4, 'Um marine paraplégico é enviado a Pandora em uma missão única.', 4),
('Lady Bird', 'Lady Bird', '2017-11-03', 5, 'Uma jovem navega pelos altos e baixos do último ano do ensino médio.', 2);


INSERT INTO filme_exibido_sala (filme_id, sala_id, horario_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(1, 2, 1),  -- Filme 1 exibido em outra sala
(2, 3, 2);  -- Filme 2 exibido em outra sala




INSERT INTO filme_has_premiacao (filme_id, premiacao_id, ganhou) VALUES
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, FALSE),
(4, 4, TRUE),
(5, 5, FALSE);

INSERT INTO horario_trabalho_funcionario (horario_id, funcionario_id, funcao_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(1, 2, 2),  -- Outro funcionário no mesmo horário
(2, 3, 3);  -- Outro funcionário no mesmo horário


-- 1) Retornar a média dos salários dos funcionários
SELECT ROUND(AVG(salario), 2) AS "Média dos salários"
FROM funcionario

-- 2) Listar os funcionários e suas funções, incluindo aqueles sem função definida
SELECT f.nome, fu.nome
FROM funcionario f, funcao fu;

-- 3) Retornar o nome de todos os funcionários que possuem o mesmo horário
-- de trabalho que algum outro funcionário

SELECT DISTINCT f.nome
FROM funcionario f
JOIN horario_trabalho_funcionario htf ON f.id_funcionario = htf.funcionario_id
WHERE htf.horario_id IN (
    SELECT horario_id
    FROM horario_trabalho_funcionario
    GROUP BY horario_id
    HAVING COUNT(*) > 1
);

-- 4) Encontrar filmes que foram exibidos em pelo menos duas salas diferentes
SELECT f.nome_BR
FROM filme f
JOIN filme_exibido_sala fes ON f.id_filme = fes.filme_id
GROUP BY f.id_filme
HAVING COUNT(DISTINCT fes.sala_id) > 1;

-- 5) Listar os filmes e seus respectivos gêneros garantindo que não haja
-- duplicata

SELECT DISTINCT nome_BR, genero_id
FROM filme

-- 6) Encontrar os filmes que receberam prêmios e que tiveram exibição
-- em pelo menos uma sala

SELECT f.nome_BR
FROM filme f
JOIN filme_has_premiacao fhp ON f.id_filme = fhp.filme_id
JOIN filme_exibido_sala fes ON f.id_filme = fes.filme_id
WHERE fhp.ganhou = TRUE
GROUP BY f.id_filme
HAVING COUNT(DISTINCT fes.sala_id) >= 1;

-- 7) Listar os filmes que não receberam nenhum prêmio
SELECT f.nome_BR
FROM filme f
JOIN filme_has_premiacao fhp ON f.id_filme = fhp.filme_id
WHERE fhp.ganhou = FALSE

-- 8) Exibir os diretores que dirigiram pelo menos dois filmes

SELECT d.nome AS nome_diretor
FROM diretor d
JOIN filme f ON d.id_diretor = f.diretor_id
GROUP BY d.id_diretor, d.nome
HAVING COUNT(f.id_filme) >= 2;

-- 9) Listar os funcionários e os horários que trabalham, ordenados pelo 
-- horário mais cedo

SELECT f.nome, h.horario
FROM funcionario f
JOIN horario_trabalho_funcionario htf ON f.id_funcionario = htf.funcionario_id
JOIN horario h ON htf.horario_id = h.id_horario
ORDER BY h.horario;

-- 10) Listar os filmes que foram exibidos na mesma sala em horários diferentes

SELECT f.nome_BR
FROM filme f
JOIN filme_exibido_sala fes ON f.id_filme = fes.filme_id
JOIN horario h ON fes.horario_id = h.id_horario
GROUP BY f.id_filme, fes.sala_id
HAVING COUNT(DISTINCT h.horario) > 1;

-- 11) Unir os diretores e os funcionarios em uma unica lista de pessoas
SELECT nome AS nome_pessoa, 'Diretor' AS tipo_pessoa
FROM diretor
UNION
SELECT nome AS nome_pessoa, 'Funcionario' AS tipo_pessoa
FROM funcionario;

-- 12) Exibir todas as funcoes diferentes que os funcionarios 
-- exercem e a quantidade de funcionarios em cada uma


SELECT fu.nome AS "Função", COUNT(fu.nome) AS "Quantidade"
FROM funcionario f
JOIN horario_trabalho_funcionario htf ON f.id_funcionario =  htf.funcionario_id
JOIN funcao fu ON htf.funcao_id = fu.id_funcao
GROUP by fu.nome

-- 13) Encontrar os filmes que foram exibidos em salas com capacidade superior
-- a média de todas as salas

SELECT f.nome_BR
FROM filme f
JOIN filme_exibido_sala fes ON f.id_filme = fes.filme_id
JOIN sala s ON fes.sala_id = s.id_sala
WHERE s.capacidade > (SELECT AVG(capacidade) FROM sala)


-- 14) Calcular o salário anual dos funcionários (considerando 12 meses)


SELECT salario*12 AS "Salário Anual" FROM funcionario

-- 15) Exibir a relação entre a capacidade da sala e o número total de
-- filmes exibidos nela

SELECT s.capacidade, COUNT(fes.filme_id) AS num_filmes_exibidos
FROM sala s
JOIN filme_exibido_sala fes ON s.id_sala = fes.sala_id
GROUP BY s.id_sala, s.capacidade;


























