-- Criação das tabelas para o banco de dados da oficina

CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(100),
    tipo_cliente ENUM('Pessoa Física', 'Pessoa Jurídica') NOT NULL,
    endereco VARCHAR(200)
);

CREATE TABLE Funcionario (
    funcionario_id INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50)
);

CREATE TABLE Servico (
    servico_id INT PRIMARY KEY,
    descricao VARCHAR(200),
    preco DECIMAL(10, 2)
);

CREATE TABLE OrdemServico (
    ordem_servico_id INT PRIMARY KEY,
    cliente_id INT,
    funcionario_id INT,
    data_inicio DATE,
    data_fim DATE,
    status ENUM('Pendente', 'Em Andamento', 'Concluído', 'Cancelado') NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionario(funcionario_id)
);

CREATE TABLE Servico_Ordem (
    ordem_servico_id INT,
    servico_id INT,
    quantidade INT,
    PRIMARY KEY (ordem_servico_id, servico_id),
    FOREIGN KEY (ordem_servico_id) REFERENCES OrdemServico(ordem_servico_id),
    FOREIGN KEY (servico_id) REFERENCES Servico(servico_id)
);

CREATE TABLE Pagamento (
    pagamento_id INT PRIMARY KEY,
    ordem_servico_id INT,
    valor DECIMAL(10, 2),
    metodo_pagamento VARCHAR(50),
    data_pagamento DATE,
    FOREIGN KEY (ordem_servico_id) REFERENCES OrdemServico(ordem_servico_id)
);

-- Inserção de dados para teste

-- Inserir clientes
INSERT INTO Cliente (cliente_id, nome, tipo_cliente, endereco) VALUES
(1, 'João Silva', 'Pessoa Física', 'Rua A, 123'),
(2, 'AutoPeças Ltda.', 'Pessoa Jurídica', 'Avenida B, 456');

-- Inserir funcionários
INSERT INTO Funcionario (funcionario_id, nome, cargo) VALUES
(1, 'Carlos Souza', 'Mecânico'),
(2, 'Ana Pereira', 'Atendente');

-- Inserir serviços
INSERT INTO Servico (servico_id, descricao, preco) VALUES
(1, 'Troca de Óleo', 50.00),
(2, 'Alinhamento de Direção', 100.00),
(3, 'Reparo de Motor', 500.00);

-- Inserir ordens de serviço
INSERT INTO OrdemServico (ordem_servico_id, cliente_id, funcionario_id, data_inicio, data_fim, status) VALUES
(1, 1, 1, '2025-01-15', '2025-01-16', 'Concluído'),
(2, 2, 2, '2025-01-17', '2025-01-18', 'Em Andamento');

-- Inserir serviços nas ordens
INSERT INTO Servico_Ordem (ordem_servico_id, servico_id, quantidade) VALUES
(1, 1, 1), -- Troca de Óleo
(1, 2, 1), -- Alinhamento de Direção
(2, 3, 2); -- Reparo de Motor

-- Inserir pagamentos
INSERT INTO Pagamento (pagamento_id, ordem_servico_id, valor, metodo_pagamento, data_pagamento) VALUES
(1, 1, 150.00, 'Dinheiro', '2025-01-16'),
(2, 2, 1000.00, 'Cartão de Crédito', '2025-01-18');

-- Consultas SQL

-- 1. Recuperar todas as ordens de serviço com informações do cliente e status
SELECT o.ordem_servico_id, c.nome AS cliente, o.status
FROM OrdemServico o
JOIN Cliente c ON o.cliente_id = c.cliente_id;

-- 2. Recuperar a quantidade total de serviços realizados em uma ordem
SELECT o.ordem_servico_id, SUM(so.quantidade) AS total_servicos
FROM OrdemServico o
JOIN Servico_Ordem so ON o.ordem_servico_id = so.ordem_servico_id
GROUP BY o.ordem_servico_id;

-- 3. Filtrar ordens de serviço por status 'Em Andamento'
SELECT o.ordem_servico_id, c.nome AS cliente, o.data_inicio, o.data_fim
FROM OrdemServico o
JOIN Cliente c ON o.cliente_id = c.cliente_id
WHERE o.status = 'Em Andamento';

-- 4. Consultar o total de pagamentos realizados por ordem de serviço
SELECT o.ordem_servico_id, SUM(p.valor) AS total_pago
FROM OrdemServico o
JOIN Pagamento p ON o.ordem_servico_id = p.ordem_servico_id
GROUP BY o.ordem_servico_id;

-- 5. Ordenar os serviços por preço
SELECT s.descricao, s.preco
FROM Servico s
ORDER BY s.preco DESC;

-- 6. Recuperar todos os serviços realizados em uma ordem específica
SELECT s.descricao, so.quantidade, (so.quantidade * s.preco) AS total_servico
FROM Servico_Ordem so
JOIN Servico s ON so.servico_id = s.servico_id
WHERE so.ordem_servico_id = 1;

-- 7. Verificar a soma total de todos os pagamentos realizados na oficina
SELECT SUM(valor) AS total_pago_oficina
FROM Pagamento;
