-- Inserindo pessoas
INSERT INTO pessoa (nome, cpf) VALUES ('João Silva', '123.456.789-10');
INSERT INTO pessoa (nome, cpf) VALUES ('Maria Oliveira', '234.567.890-11');
INSERT INTO pessoa (nome, cpf) VALUES ('Carlos Souza', '345.678.901-12');
INSERT INTO pessoa (nome, cpf) VALUES ('Fernanda Pereira', '456.789.012-13');
INSERT INTO pessoa (nome, cpf) VALUES ('Rafael Costa', '567.890.123-14');
INSERT INTO pessoa (nome, cpf) VALUES ('Lucas Almeida', '678.901.234-15');
INSERT INTO pessoa (nome, cpf) VALUES ('Ana Santos', '789.012.345-16');
INSERT INTO pessoa (nome, cpf) VALUES ('Ricardo Lima', '890.123.456-17');
INSERT INTO pessoa (nome, cpf) VALUES ('Juliana Rocha', '901.234.567-18');
INSERT INTO pessoa (nome, cpf) VALUES ('Gustavo Martins', '012.345.678-19');

-- Inserindo engenheiros
INSERT INTO engenheiro (id_pessoa, crea) VALUES (3, 12345);  -- Carlos Souza
INSERT INTO engenheiro (id_pessoa, crea) VALUES (5, 67890);  -- Rafael Costa
INSERT INTO engenheiro (id_pessoa, crea) VALUES (8, 11223);  -- Ricardo Lima