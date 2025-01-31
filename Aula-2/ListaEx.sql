CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY,
    senha VARCHAR(60),
    nome VARCHAR(256),
    ramal VARCHAR(10),
    especialidade VARCHAR(100)
);

CREATE TABLE maquina (
    id_maquina INT PRIMARY KEY,
    tipo VARCHAR(60),
    velocidade DECIMAL(10,2),
    hd DECIMAL(10,2),
    placa_rede VARCHAR(50),
    memoria_ram DECIMAL(10,2)    
);

CREATE TABLE software (
    id_software INT PRIMARY KEY,
    produto VARCHAR(60),
    hd DECIMAL(10,2),
    memoria_ram DECIMAL(10,2)
);

CREATE TABLE maquina_software (
    maquina_id INT,
    software_id INT,
    PRIMARY KEY (maquina_id, software_id),
    FOREIGN KEY (maquina_id) REFERENCES maquina(id_maquina),
    FOREIGN KEY (software_id) REFERENCES software(id_software)
);

CREATE TABLE maquina_usuario (
    usuario_id INT,
    maquina_id INT,
    PRIMARY KEY (usuario_id, maquina_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario),
    FOREIGN KEY (maquina_id) REFERENCES maquina(id_maquina)
);

-- Inserindo usuários com especialidades diversas, incluindo "Técnico"
INSERT INTO usuario (id_usuario, senha, nome, ramal, especialidade) VALUES
(1, 'senha123', 'Carlos Silva', '1001', 'Técnico'),
(2, 'senha456', 'Ana Souza', '1002', 'Desenvolvimento'),
(3, 'senha789', 'João Pedro', '1003', 'Técnico'),
(4, 'senha321', 'Mariana Lima', '1004', 'Redes'),
(5, 'senha654', 'Ricardo Alves', '1005', 'Banco de Dados');

-- Inserindo máquinas com diferentes tipos e velocidades
INSERT INTO maquina (id_maquina, tipo, velocidade, hd, placa_rede, memoria_ram) VALUES
(1, 'Core II', 2.5, 500, 'Intel Gigabit', 8),
(2, 'Pentium', 2.2, 256, 'Realtek 8111', 4),
(3, 'Core III', 3.0, 1000, 'Broadcom 100Mb/s', 16),
(4, 'Core V', 3.5, 2000, 'Realtek 1Gb/s', 32),
(5, 'Dual Core', 2.6, 512, 'Intel 10Mb/s', 8);

-- Inserindo softwares com diferentes requisitos de memória e HD
INSERT INTO software (id_software, produto, hd, memoria_ram) VALUES
(1, 'Windows 10', 20, 4),
(2, 'Linux Ubuntu', 15, 2),
(3, 'Photoshop', 30, 8),
(4, 'AutoCAD', 40, 16),
(5, 'Microsoft Office', 10, 4);

-- Relacionando máquinas com softwares (incluindo C++ e Word)
INSERT INTO maquina_software (maquina_id, software_id) VALUES
(1, 1), (1, 3), (2, 2), (3, 4), (4, 5);

-- Relacionando usuários a máquinas
INSERT INTO maquina_usuario (usuario_id, maquina_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);


-- 1) Todos os atributos da tabela Usuários para aqueles usuários com especialidade igual a técnico.

SELECT *
FROM usuario
WHERE especialidade ILIKE 'técnico'

-- 2) Todas as combinações de tipo e velocidade das máquinas.
SELECT tipo, velocidade
FROM maquina
GROUP BY tipo, velocidade;

-- 3) O tipo e a velocidade dos computadores dos tipos Core II e Pentium.
SELECT tipo, velocidade
FROM maquina
WHERE tipo = 'Core II' OR tipo = 'Pentium';

-- 4)  A identificação, o tipo dos computadores 
-- e a taxa de transmissão da placa de rede, 
-- para máquinas com placa de rede com taxa menor do que 10 Mb/s.

-- 5) Os nomes dos usuários que utilizam computadores do tipo Core III ou Core V.

SELECT u.nome
FROM usuario u
JOIN maquina_usuario mu ON u.id_usuario = mu.usuario_id
JOIN maquina m ON mu.maquina_id = m.id_maquina
WHERE m.tipo = 'Core III' OR m.tipo = 'Core V';


-- 6️) A identificação das máquinas com Photoshop instalado.

SELECT m.id_maquina
FROM maquina m
JOIN maquina_software ms ON m.id_maquina = ms.maquina_id
JOIN software s ON ms.software_id = s.id_software
WHERE s.produto = 'Photoshop';

-- 7) A identificação das máquinas, 
-- sua quantidade de memória RAM, 
-- o produto 
-- e a quantidade de memória RAM necessária dos produtos que não podem rodar, 
-- devido à quantidade exigida dessa memória.

SELECT m.id_maquina, m.memoria_ram, s.produto, s.memoria_ram
FROM maquina m
JOIN maquina_software ms ON m.id_maquina = ms.maquina_id
JOIN software s ON ms.software_id = s.id_software
WHERE m.memoria_ram < s.memoria_ram;


-- 8) O nome dos usuários e a velocidade de suas máquinas.

SELECT u.nome, m.velocidade
FROM usuario u
JOIN maquina_usuario mu ON u.id_usuario = mu.usuario_id
JOIN maquina m ON mu.maquina_id = m.id_maquina;

 

-- 9) O nome e identificação dos usuários que tenham ID menor que o ID de Mariana Lima.

SELECT nome, id_usuario
FROM usuario
WHERE id_usuario < (SELECT id_usuario FROM usuario WHERE nome = 'Mariana Lima')

-- 10) O número total de máquinas com velocidade maior do que 2,4 GHz.

SELECT DISTINCT(COUNT(id_maquina))
FROM maquina
WHERE velocidade > 2.4;

-- 11) O número de usuários das máquinas.

SELECT COUNT(DISTINCT u.id_usuario)
FROM usuario u
JOIN maquina_usuario mu ON u.id_usuario = mu.usuario_id
JOIN maquina m ON mu.maquina_id = m.id_maquina;

-- 12) O número de usuários agrupados pelo tipo de máquinas.

SELECT COUNT( u.id_usuario), m.tipo
FROM usuario u
JOIN maquina_usuario mu ON u.id_usuario = mu.usuario_id
JOIN maquina m ON mu.maquina_id = m.id_maquina
GROUP BY m.tipo;

 -- 13) O número de usuários de máquinas do tipo Dual Core.
 
SELECT COUNT(DISTINCT u.id_usuario)
FROM usuario u
JOIN maquina_usuario mu ON u.id_usuario = mu.usuario_id
JOIN maquina m ON mu.maquina_id = m.id_maquina
WHERE m.tipo = 'Dual Core';

-- 14) A quantidade de disco rígido necessária 
-- para instalar Photoshop e AutoCAD juntos na mesma máquina.

SELECT SUM(s.hd) AS "qtd_necessaria"
FROM maquina m
JOIN maquina_software ms ON m.id_maquina = ms.maquina_id
JOIN software s ON ms.software_id = s.id_software
WHERE s.produto = 'Photoshop' OR s.produto = 'AutoCAD';

-- 15) A quantidade de disco rígido utilizada em cada máquina 
-- para os produtos instalados em cada uma delas.

SELECT m.id_maquina, SUM(s.hd) AS "qtd_necessaria"
FROM maquina m
JOIN maquina_software ms ON m.id_maquina = ms.maquina_id
JOIN software s ON ms.software_id = s.id_software
GROUP BY m.id_maquina;

-- 16) A quantidade média de disco rígido necessária por produto.
SELECT ROUND(AVG(hd),2)
FROM software;

-- 17) O número total de máquinas de cada tipo.

SELECT COUNT(*), tipo
FROM maquina
GROUP BY tipo;


-- 18) O número de produtos cuja instalação consuma entre 
-- 20 e 40 GB de disco rígido.
SELECT COUNT(*)
FROM software
WHERE hd BETWEEN 20 AND 40;

-- 19) A identificação e o respectivo produto, 
-- em cujo nome tenha a letra O em sua composição.

SELECT id_software, produto
FROM software
WHERE produto ILIKE '%O%'


-- 20) O produto e a capacidade do disco rígido para 
-- máquinas com capacidade de instalação de qualquer produto individualmente.

SELECT m.id_maquina, m.hd, s.produto
FROM maquina m
JOIN maquina_software ms ON m.id_maquina = ms.maquina_id
JOIN software s ON ms.software_id = s.id_software
WHERE m.hd >= s.hd;


-- 21) A relação dos produtos instalados em pelo menos uma máquina

SELECT m.id_maquina, s.produto
FROM maquina m
JOIN maquina_software ms ON m.id_maquina = ms.maquina_id
JOIN software s ON ms.software_id = s.id_software




    
