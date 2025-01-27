-- Criando a tabela cargo
create table cargo 
(
	id INT NOT NULL,
	nome VARCHAR(50),
	PRIMARY KEY(id),
	fk_usuario int,
	CONSTRAINT fk_cargo_usuario FOREIGN KEY(fk_usuario)
	REFERENCES usuario(id)
);

-- Interagindo com colunas (Adicionando, alterando e excluindo)
ALTER TABLE cargo ADD COLUMN salario DECIMAL(10,2);
ALTER TABLE cargo ALTER COLUMN nome TYPE varchar(100);
ALTER TABLE cargo DROP COLUMN salario;

-- Excluindo tabela cargo e usuario
DROP TABLE cargo;
DROP TABLE usuario;

SELECT *
FROM cargo;