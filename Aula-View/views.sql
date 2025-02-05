CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

INSERT INTO categorias (nome) VALUES ('Eletrônicos');
INSERT INTO categorias (nome) VALUES ('Roupas');
INSERT INTO categorias (nome) VALUES ('Alimentos');


INSERT INTO produtos (nome, preco, quantidade_estoque, categoria_id) VALUES
('Smartphone', 1200.00, 30, 1),
('Camiseta', 50.00, 100, 2),
('Notebook', 3000.00, 20, 1),
('Arroz', 20.00, 200, 3),
('Calça Jeans', 100.00, 50, 2);


CREATE VIEW produtos_ordem_preco AS
SELECT p.id, p.nome, p.preco, p.quantidade_estoque, c.nome AS categoria
FROM produtos p
JOIN categorias c ON p.categoria_id = c.id
ORDER BY p.preco ASC

SELECT *
FROM produtos_ordem_preco

CREATE VIEW produtos_ordem_alfabetica AS
SELECT p.nome, p.preco, c.nome AS categoria
FROM produtos p
JOIN categorias c ON p.categoria_id = c.id
ORDER BY p.nome

SELECT * FROM produtos_ordem_alfabetica




