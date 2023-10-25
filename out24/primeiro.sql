
-- cria o banco

CREATE DATABASE OlaMundo;

-- seleciona o banco

USE OlaMundo;

-- cria a tabela e atributos

CREATE TABLE Exemplo(
    ID INT NOT NULL IDENTITY,
    Nome VARCHAR(50)
);

-- determina pk

ALTER TABLE Exemplo
    ADD CONSTRAINT PK_Exemplo PRIMARY KEY (ID);

-- adiciona atributo

ALTER TABLE Exemplo
    ADD DataNascimento DATE;

-- deleta atributo

ALTER TABLE Exemplo
    DROP COLUMN DataNascimento;

CREATE TABLE Tabela2(
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Telefone VARHCAR(20) NOT NULL,
    ID_Exemplo INT NOT NULL,
    FOREIGN KEY(ID_Exemplo) REFERENCES Exemplo(ID));

-- apagar as tabelas

DROP TABLE Tabela2;
DROP TABLE Exemplo;

-- desselecionar

USE master;

-- apagar o banco

DROP DATABASE OlaMundo;
