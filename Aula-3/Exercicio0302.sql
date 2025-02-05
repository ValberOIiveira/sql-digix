CREATE TABLE empregado (
    Nome VARCHAR(256),
    Endereco VARCHAR(256),
    Cpf VARCHAR(11) PRIMARY KEY,
    Data_nasc DATE,
    Sexo VARCHAR(10),
    Cart_trab VARCHAR(20),
    Salario DECIMAL(10,2),
    NumDep INT,
    CpfSuper VARCHAR(11),
    FOREIGN KEY (CpfSuper) REFERENCES empregado(Cpf)
);

CREATE TABLE departamento (
    NomeDep VARCHAR(256),
    NumDep INT PRIMARY KEY,
    CpfGer VARCHAR(11),
    Data_inicio_ger DATE,
    FOREIGN KEY (CpfGer) REFERENCES empregado(Cpf)
);

CREATE TABLE projeto (
    NomeProj VARCHAR(256),
    NumProj INT PRIMARY KEY,
    Localizacao VARCHAR(256),
    NumDep INT,
    FOREIGN KEY (NumDep) REFERENCES departamento(NumDep)
);

CREATE TABLE dependente (
    Cpfe VARCHAR(11),
    IdDep INT,
    NomeDep VARCHAR(256),
    Sexo VARCHAR(10),
    Parentesco VARCHAR(40),
    PRIMARY KEY (Cpfe, IdDep),
    FOREIGN KEY (Cpfe) REFERENCES empregado(Cpf)
);

CREATE TABLE trabalha_em (
    Cpfe VARCHAR(11),
    NumProj INT,
    Horas DECIMAL(5,2),
    PRIMARY KEY (Cpfe, NumProj),
    FOREIGN KEY (Cpfe) REFERENCES empregado(Cpf),
    FOREIGN KEY (NumProj) REFERENCES projeto(NumProj)
);




INSERT INTO empregado (Nome, Endereco, Cpf, Data_nasc, Sexo, Cart_trab, Salario, NumDep, CpfSuper)
VALUES
('Eduardo Costa', 'Av. Brasil, 234', '52098765432', '1983-11-25', 'Masculino', '112233778', 4500.00, 1, NULL),
('Fernanda Martins', 'Rua das Flores, 562', '62143578901', '1992-02-17', 'Feminino', '778899665', 3200.00, 1, '52098765432'),
('Gustavo Lima', 'Rua São José, 101', '73025678450', '1990-09-08', 'Masculino', '334455667', 3900.00, 2, '62143578901'),
('Patricia Souza', 'Alameda Amazonas, 1005', '45098712367', '1987-04-02', 'Feminino', '667788990', 3600.00, 2, '62143578901'),
('Juliana Gomes', 'Rua do Sol, 88', '56123478903', '1995-12-14', 'Feminino', '556677889', 2700.00, 1, '52098765432');


INSERT INTO departamento (NomeDep, NumDep, CpfGer, Data_inicio_ger)
VALUES
('Desenvolvimento de Software', 1, '52098765432', '2015-04-10'),
('Recursos Humanos', 2, '62143578901', '2017-08-01');


INSERT INTO projeto (NomeProj, NumProj, Localizacao, NumDep)
VALUES
('Desenvolvimento do Sistema de Gestão de Vendas', 1, 'São Paulo', 1),
('Implementação do Programa de Benefícios', 2, 'Belo Horizonte', 2);


INSERT INTO dependente (Cpfe, IdDep, NomeDep, Sexo, Parentesco)
VALUES
('52098765432', 1, 'Lucas Costa', 'Masculino', 'Filho'),
('62143578901', 1, 'Carla Martins', 'Feminino', 'Esposa'),
('73025678450', 2, 'Renata Lima', 'Feminino', 'Esposa'),
('56123478903', 1, 'Carlos Gomes', 'Masculino', 'Filho');


INSERT INTO trabalha_em (Cpfe, NumProj, Horas)
VALUES
('52098765432', 1, 40.00),
('62143578901', 2, 35.50),
('73025678450', 1, 38.00),
('45098712367', 2, 42.00),
('56123478903', 1, 40.00);



