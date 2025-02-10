CREATE TABLE pessoa
(
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE engenheiro
(
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    FOREIGN KEY (cpf) REFERENCES pessoa(cpf) ON DELETE CASCADE
);

CREATE TABLE edificacao
(
    id_edificacao SERIAL PRIMARY KEY,
    metragem_total FLOAT NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    responsavel_cpf VARCHAR(14) NOT NULL,
    FOREIGN KEY (responsavel_cpf) REFERENCES engenheiro(cpf) ON DELETE CASCADE
);

CREATE TABLE unidade_residencial
(
    id_unidade SERIAL PRIMARY KEY,
    metragem_unidade FLOAT NOT NULL,
    num_quartos INT NOT NULL,
    num_banheiros INT NOT NULL,
    proprietario_cpf VARCHAR(14) NOT NULL,
    id_edificacao INT NOT NULL,
    FOREIGN KEY (proprietario_cpf) REFERENCES pessoa(cpf) ON DELETE CASCADE,
    FOREIGN KEY (id_edificacao) REFERENCES edificacao(id_edificacao) ON DELETE CASCADE
);

CREATE TABLE predio
(
    id_edificacao SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    num_andares INT NOT NULL,
    apt_por_andar INT NOT NULL,
    FOREIGN KEY (id_edificacao) REFERENCES edificacao(id_edificacao) ON DELETE CASCADE
);

CREATE TABLE casa
(
    id_edificacao SERIAL PRIMARY KEY,
    condominio BOOLEAN NOT NULL,
    FOREIGN KEY (id_edificacao) REFERENCES edificacao(id_edificacao) ON DELETE CASCADE
);

CREATE TABLE casa_sobrado
(
    id_edificacao SERIAL PRIMARY KEY,
    num_andares INT NOT NULL,
    apt_por_andar INT NOT NULL,
    FOREIGN KEY (id_edificacao) REFERENCES edificacao(id_edificacao) ON DELETE CASCADE
)

SELECT 
    UR.id_unidade,
    UR.metragem_unidade,
    UR.num_quartos,
    UR.num_banheiros,
    P.nome AS nome_proprietario,
    E.endereco
FROM 
    Unidade_Residencial UR
JOIN 
    Pessoa P ON UR.id_proprietario = P.id_pessoa
JOIN 
    Edificacao E ON UR.id_edificacao = E.id_edificacao;


