-- Criando a tabela Clientes
CREATE TABLE Clientes (
    ClienteID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(100)
);

-- Criando a tabela Pedidos
CREATE TABLE Pedidos (
    PedidoID SERIAL PRIMARY KEY,
    ClienteID INT REFERENCES Clientes(ClienteID),
    Valor DECIMAL(10,2),
    DataPedido DATE
);

-- Inserindo dados na tabela Clientes
INSERT INTO Clientes (Nome, Email) VALUES
('Ana Silva', 'ana@email.com'),
('Carlos Souza', 'carlos@email.com'),
('Mariana Lima', 'mariana@email.com');

-- Inserindo dados na tabela Pedidos
INSERT INTO Pedidos (ClienteID, Valor, DataPedido) VALUES
(1, 250.00, '2025-02-10'),
(2, 150.50, '2025-02-11'),
(1, 300.75, '2025-02-12');

-- Criando uma tabela temporária para armazenar clientes que possuem pedidos
CREATE TEMP TABLE ClientesComPedidos AS
SELECT DISTINCT c.ClienteID, c.Nome, c.Email
FROM Clientes c
JOIN Pedidos p ON c.ClienteID = p.ClienteID;

-- Criando uma tabela temporária para armazenar pedidos de um cliente específico (ex: ClienteID = 1)
CREATE TEMP TABLE PedidosCliente1 AS
SELECT * FROM Pedidos WHERE ClienteID = 1;

-- Consultando as tabelas temporárias
SELECT * FROM ClientesComPedidos;
SELECT * FROM PedidosCliente1;

