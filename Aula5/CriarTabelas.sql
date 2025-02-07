CREATE TABLE atividade
(
    id_atividade SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE instrutor
(
    id_instrutor SERIAL PRIMARY KEY,
    rg INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    titulacao INT NOT NULL
);

CREATE TABLE turma
(
    id_turma SERIAL PRIMARY KEY,
    nome VARCHAR(45),
    horario TIME NOT NULL,
    duracao INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_final DATE NOT NULL,
    instrutor_id INT,
    atividade_id INT,
    FOREIGN KEY (instrutor_id) REFERENCES instrutor(id_instrutor),
    FOREIGN KEY (atividade_id) REFERENCES atividade(id_atividade)
);

CREATE TABLE telefone_instrutor
(
    id_telefone SERIAL PRIMARY KEY,
    numero VARCHAR(45) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    instrutor_id INT,
    FOREIGN KEY (instrutor_id) REFERENCES instrutor(id_instrutor)
);

CREATE TABLE aluno
(
    cod_matricula SERIAL PRIMARY KEY,
    turma_id INT,
    data_matricula DATE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco TEXT NOT NULL,
    telefone INT NOT NULL,
    data_nascimento DATE NOT NULL,
    altura DECIMAL(4,2) NOT NULL,
    peso DECIMAL(4,2) NOT NULL,
    FOREIGN KEY (turma_id) REFERENCES turma(id_turma)
);

CREATE TABLE chamada
(
    id_chamada SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    presente BOOLEAN NOT NULL,  
    matricula_cod INT,
    turma_id INT,
    FOREIGN KEY (matricula_cod) REFERENCES aluno(cod_matricula),
    FOREIGN KEY (turma_id) REFERENCES turma(id_turma)
);
