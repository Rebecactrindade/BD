CREATE DATABASE IF NOT EXISTS Biblioteca;
USE Biblioteca;

CREATE TABLE Alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    editora VARCHAR(100),
    ano_publicacao INT,
    quantidade INT DEFAULT 0,
    status ENUM('disponível', 'emprestado') DEFAULT 'disponível'
);

CREATE TABLE Autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Livro_Autor (
    id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES Livros(id) ON DELETE CASCADE,
    FOREIGN KEY (id_autor) REFERENCES Autores(id) ON DELETE CASCADE
);

CREATE TABLE Emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    id_livro INT,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES Alunos(id),
    FOREIGN KEY (id_livro) REFERENCES Livros(id),
    CHECK (data_devolucao >= data_emprestimo)
);

DELIMITER //

CREATE TRIGGER trg_emprestimo_baixa_quantidade
BEFORE INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    DECLARE qtd_atual INT;

    SELECT quantidade INTO qtd_atual
    FROM Livros
    WHERE id = NEW.id_livro;

    IF qtd_atual <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Livro indisponível para empréstimo.';
    ELSE
        UPDATE Livros
        SET quantidade = quantidade - 1
        WHERE id = NEW.id_livro;

        IF qtd_atual - 1 = 0 THEN
            UPDATE Livros
            SET status = 'emprestado'
            WHERE id = NEW.id_livro;
        END IF;
    END IF;
END;
//

DELIMITER ;
