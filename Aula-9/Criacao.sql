CREATE DATABASE empresa
    DEFAULT CHARACTER SET = 'utf8mb4';


USE  empresa;

-- Criar as tabelas na ordem correta

CREATE TABLE Empregado (
    Nome VARCHAR(50),
    Endereco VARCHAR(500),
    CPF INT PRIMARY KEY NOT NULL,
    DataNasc DATE,
    Sexo CHAR(10),
    CartTrab INT,
    Salario FLOAT,
    NumDep INT,
    CPFSup INT
);

CREATE TABLE Departamento (
    NomeDep VARCHAR(50),
    NumDep INT PRIMARY KEY NOT NULL,
    CPFGer INT,
    DataInicioGer DATE,
    FOREIGN KEY (CPFGer) REFERENCES Empregado(CPF)
);

ALTER TABLE Empregado 
ADD FOREIGN KEY (NumDep) REFERENCES Departamento(NumDep);

CREATE TABLE Projeto (
    NomeProj VARCHAR(50),
    NumProj INT PRIMARY KEY NOT NULL,
    Localizacao VARCHAR(50),
    NumDep INT,
    FOREIGN KEY (NumDep) REFERENCES Departamento(NumDep)
);

CREATE TABLE Dependente (
    idDependente INT PRIMARY KEY NOT NULL,
    CPFE INT,
    NomeDep VARCHAR(50),
    Sexo CHAR(10),
    Parentesco VARCHAR(50),
    FOREIGN KEY (CPFE) REFERENCES Empregado(CPF)
);

CREATE TABLE Trabalha_Em (
    CPF INT,
    NumProj INT,
    HorasSemana INT,
    FOREIGN KEY (CPF) REFERENCES Empregado(CPF),
    FOREIGN KEY (NumProj) REFERENCES Projeto(NumProj)
);

-- Inserir os dados

-- 1. Criar os departamentos primeiro
INSERT INTO Departamento VALUES ('Dep1', 1, NULL, '1990-01-01'); 
INSERT INTO Departamento VALUES ('Dep2', 2, NULL, '1990-01-01');
INSERT INTO Departamento VALUES ('Dep3', 3, NULL, '1990-01-01');

-- 2. Inserir empregados
INSERT INTO Empregado VALUES ('Joao', 'Rua 1', 123, '1990-01-01', 'M', 123, 1000, 1, NULL);
INSERT INTO Empregado VALUES ('Maria', 'Rua 2', 456, '1990-01-01', 'F', 456, 2000, 2, NULL);
INSERT INTO Empregado VALUES ('Jose', 'Rua 3', 789, '1990-01-01', 'M', 789, 3000, 3, NULL);

-- 3. Atualizar o CPFGer nos departamentos
UPDATE Departamento SET CPFGer = 123 WHERE NumDep = 1;
UPDATE Departamento SET CPFGer = 456 WHERE NumDep = 2;
UPDATE Departamento SET CPFGer = 789 WHERE NumDep = 3;

-- 4. Inserir projetos
INSERT INTO Projeto VALUES ('Proj1', 1, 'Local1', 1);
INSERT INTO Projeto VALUES ('Proj2', 2, 'Local2', 2);
INSERT INTO Projeto VALUES ('Proj3', 3, 'Local3', 3);

-- 5. Inserir dependentes
INSERT INTO Dependente VALUES (1, 123, 'Dep1', 'M', 'Filho');
INSERT INTO Dependente VALUES (2, 456, 'Dep2', 'F', 'Filha');
INSERT INTO Dependente VALUES (3, 789, 'Dep3', 'M', 'Filho');

-- 6. Inserir relação Trabalha_Em
INSERT INTO Trabalha_Em VALUES (123, 1, 40);
INSERT INTO Trabalha_Em VALUES (456, 2, 40);
INSERT INTO Trabalha_Em VALUES (789, 3, 40);

-- Criar função para retornar o salário de um empregado
CREATE OR REPLACE FUNCTION SalarioEmpregado(p_CPF INTEGER) RETURNS FLOAT AS $$
DECLARE 
    salario FLOAT;
BEGIN
    BEGIN
        SELECT Salario INTO salario FROM Empregado WHERE CPF = p_CPF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Erro ao buscar salario';
    END;
    RETURN salario;
END;
$$ LANGUAGE plpgsql;
