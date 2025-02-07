-- Inserindo atividades
INSERT INTO atividade (nome) VALUES ('Crossfit'), ('Yoga'), ('Pilates'), ('Musculação');

-- Inserindo instrutores
INSERT INTO instrutor (rg, nome, data_nascimento, titulacao) VALUES
(123456, 'Carlos Silva', '1980-05-15', 1),
(789012, 'Ana Souza', '1985-07-22', 2),
(345678, 'Pedro Lima', '1990-02-10', 3),
(901234, 'Mariana Alves', '1995-09-30', 1);

-- Inserindo telefones dos instrutores
INSERT INTO telefone_instrutor (numero, tipo, instrutor_id) VALUES
('11999999999', 'Celular', 1),
('11888888888', 'Celular', 2),
('11777777777', 'Fixo', 3),
('11666666666', 'Fixo', 4);

-- Inserindo turmas
INSERT INTO turma (nome, horario, duracao, data_inicio, data_final, instrutor_id, atividade_id) VALUES
('Manhã Crossfit', '08:00:00', 60, '2025-01-10', '2025-06-10', 1, 1),
('Tarde Yoga', '15:00:00', 60, '2025-01-15', '2025-06-15', 2, 2),
('Noite Pilates', '19:00:00', 45, '2025-02-01', '2025-07-01', 3, 3),
('Manhã Musculação', '07:00:00', 90, '2025-02-10', '2025-07-10', NULL, 4);

-- Inserindo alunos
INSERT INTO aluno (turma_id, data_matricula, nome, endereco, telefone, data_nascimento, altura, peso) VALUES
(1, '2025-01-11', 'João Oliveira', 'Rua A, 100', 11911111111, '2000-05-20', 1.75, 70.5),
(1, '2025-01-12', 'Maria Santos', 'Rua B, 200', 11922222222, '1998-08-15', 1.60, 60.2),
(1, '2025-01-13', 'Fernando Costa', 'Rua C, 300', 11933333333, '1995-03-10', 1.82, 80.0),
(2, '2025-01-16', 'Ana Lima', 'Rua D, 400', 11944444444, '1997-11-25', 1.65, 55.5),
(2, '2025-01-17', 'Carlos Pereira', 'Rua E, 500', 11955555555, '1996-07-05', 1.70, 68.0),
(2, '2025-01-18', 'Juliana Mendes', 'Rua F, 600', 11966666666, '1999-04-30', 1.58, 52.3),
(2, '2025-01-19', 'Ricardo Souza', 'Rua G, 700', 11977777777, '2001-02-15', 1.75, 72.0),
(3, '2025-02-02', 'Bruna Ferreira', 'Rua H, 800', 11988888888, '1994-09-10', 1.63, 57.8);

-- Inserindo chamadas (presença dos alunos)
INSERT INTO chamada (data, presente, matricula_cod, turma_id) VALUES
('2025-02-01', TRUE, 1, 1),
('2025-02-01', TRUE, 2, 1),
('2025-02-01', TRUE, 3, 1),
('2025-02-02', TRUE, 4, 2),
('2025-02-02', FALSE, 5, 2),
('2025-02-02', TRUE, 6, 2),
('2025-02-02', TRUE, 7, 2),
('2025-02-03', TRUE, 8, 3);
