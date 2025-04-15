CREATE DATABASE BancoDigital;
USE BancoDigital;

CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    cpf CHAR(11) UNIQUE,
    telefone VARCHAR(15),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    conta_ativa BOOLEAN DEFAULT TRUE
);

CREATE TABLE Conta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    saldo DECIMAL(10,2) DEFAULT 0.00,
    rendimento_mensal DECIMAL(5,2),
    tipo_conta ENUM('Corrente', 'Poupança') DEFAULT 'Corrente',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

CREATE TABLE Transacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_conta INT,
    tipo ENUM('PIX', 'TED', 'DOC', 'Pagamento', 'Estorno'),
    valor DECIMAL(10,2),
    data_transacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT,
    autenticado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_conta) REFERENCES Conta(id)
);

CREATE TABLE Cartao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    tipo ENUM('Débito', 'Crédito'),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

CREATE TABLE Suporte (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    mensagem TEXT,
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    resolvido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

INSERT INTO Usuario (nome_completo, email, senha, cpf, telefone) VALUES
('João Silva', 'joao@email.com', 'senha123', '12345678901', '11999999999'),
('Maria Souza', 'maria@email.com', 'senha456', '09876543210', '11988888888');

INSERT INTO Conta (id_usuario, saldo, rendimento_mensal, tipo_conta) VALUES
(1, 2500.00, 0.50, 'Corrente'),
(2, 10500.00, 0.60, 'Poupança');

INSERT INTO Transacao (id_conta, tipo, valor, descricao, autenticado) VALUES
(1, 'PIX', 200.00, 'Pagamento de aluguel', TRUE),
(1, 'Estorno', 200.00, 'Estorno de aluguel', FALSE),
(2, 'Pagamento', 350.00, 'Conta de luz', TRUE);

INSERT INTO Cartao (id_usuario, tipo) VALUES
(1, 'Débito'),
(1, 'Crédito'),
(2, 'Crédito');

INSERT INTO Suporte (id_usuario, mensagem, resolvido) VALUES
(1, 'Problema ao fazer transferência', FALSE),
(2, 'Como bloquear o cartão?', TRUE);

SELECT * FROM Usuario;
SELECT * FROM Conta;
SELECT * FROM Transacao;
SELECT * FROM Cartao;
SELECT * FROM Suporte;
