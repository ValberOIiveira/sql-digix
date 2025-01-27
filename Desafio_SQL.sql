-- Criando a tabela aluno
CREATE TABLE aluno
(
    idt_aluno INT NOT NULL,
    num_grau INT,
    des_nome VARCHAR(255),
    PRIMARY KEY (idt_aluno)
);

-- Criando a tabela curtida
CREATE TABLE curtida
(
    idt_aluno1 INT NOT NULL,
    idt_aluno2 INT NOT NULL,
    FOREIGN KEY (idt_aluno1) REFERENCES aluno(idt_aluno),
    FOREIGN KEY (idt_aluno2) REFERENCES aluno(idt_aluno)
);

-- Criando a tabela amigo
CREATE TABLE amigo
(
    idt_aluno1 INT NOT NULL,
    idt_aluno2 INT NOT NULL,
    FOREIGN KEY (idt_aluno1) REFERENCES aluno(idt_aluno),
    FOREIGN KEY (idt_aluno2) REFERENCES aluno(idt_aluno),
);

-- Inserindo alunos
INSERT INTO aluno (idt_aluno, num_grau, des_nome) 
VALUES
(1, 1, 'Carlos Silva'),
(2, 2, 'Maria Oliveira'),
(3, 3, 'João Pereira'),
(4, 4, 'Ana Costa'),
(5, 5, 'Lucas Almeida'),
(6, 6, 'Beatriz Santos'),
(7, 7, 'Ricardo Souza'),
(8, 8, 'Fernanda Lima'),
(9, 9, 'Gabriel Rocha'),
(10, 10, 'Juliana Pereira');

-- Inserindo amizades
INSERT INTO amigo (idt_aluno1, idt_aluno2)
VALUES
(1, 2),  -- Carlos e Maria são amigos
(2, 3),  -- Maria e João são amigos
(3, 4),  -- João e Ana são amigos
(4, 5),  -- Ana e Lucas são amigos
(5, 6),  -- Lucas e Beatriz são amigos
(6, 7),  -- Beatriz e Ricardo são amigos
(7, 8),  -- Ricardo e Fernanda são amigos
(8, 9),  -- Fernanda e Gabriel são amigos
(9, 10), -- Gabriel e Juliana são amigos
(1, 10); -- Carlos e Juliana são amigos

-- Inserindo curtidas
INSERT INTO curtida (idt_aluno1, idt_aluno2)
VALUES
(1, 2),  -- Carlos curtiu Maria
(2, 3),  -- Maria curtiu João
(3, 4),  -- João curtiu Ana
(4, 5),  -- Ana curtiu Lucas 
(5, 6),  -- Lucas curtiu Beatriz
(6, 7),  -- Beatriz curtiu Ricardo
(7, 8),  -- Ricardo curtiu Fernanda
(8, 9),  -- Fernanda curtiu Gabriel
(9, 10), -- Gabriel curtiu Juliana
(1, 10); -- Carlos curtiu Juliana


SELECT 
    a1.des_nome AS amigo1, 
    a2.des_nome AS amigo2
FROM 
    amigo m
JOIN 
    aluno a1 ON m.idt_aluno1 = a1.idt_aluno
JOIN 
    aluno a2 ON m.idt_aluno2 = a2.idt_aluno;
 
