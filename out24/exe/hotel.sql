CREATE DATABASE Hotel;

USE Hotel;

CREATE TABLE tblCategoria(
    idCategoria INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valorDiaria MONEY NOT NULL
);

CREATE TABLE tblProduto(
    idProduto INT NOT NULL IDENTITY PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL,
    precoVenda MONEY NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE tblPessoa(
    cpf INT NOT NULL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(30) NOT NULL
);

CREATE TABLE tblTelefone (
    cpf INT NOT NULL,
    ddi CHAR(3) NOT NULL,
    ddd CHAR(3) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    nomeContato VARCHAR(20) NOT NULL,
    descricao VARCHAR(30),
    FOREIGN KEY(cpf) REFERENCES tblPessoa(cpf),
    PRIMARY KEY (cpf, ddi, ddd, telefone)
);

CREATE TABLE tblCliente(
    cpf INT NOT NULL PRIMARY KEY,
    dataNascimento DATE NOT NULL,
    FOREIGN KEY(cpf) REFERENCES tblPessoa(cpf)
);

CREATE TABLE tblFuncionario(
    cpf INT NOT NULL PRIMARY KEY,
    dataEfetivacao DATE NOT NULL,
    CargaHorariaSemanal INT NOT NULL,
    FOREIGN KEY(cpf) REFERENCES tblPessoa(cpf)
);

CREATE TABLE tblEmail(
    cpf INT NOT NULL PRIMARY KEY,
    email VARCHAR(256) NOT NULL,
    FOREIGN KEY(cpf) REFERENCES tblCliente(cpf)
);

CREATE TABLE tblApartamento(
    numero INT NOT NULL PRIMARY KEY,
    status VARCHAR(20) NOT NULL,
    idCategoria INT NOT NULL,
    FOREIGN KEY(idCategoria) REFERENCES tblCategoria(idCategoria)
);

CREATE TABLE tblReserva(
    idReserva INT NOT NULL IDENTITY PRIMARY KEY,
    dataInicio DATE NOT NULL,
    dataPrevistaSaida DATE NOT NULL,
    numeroApartamento INT NOT NULL,
    cpfCliente INT NOT NULL,
    cpfFuncionario INT NOT NULL,
    FOREIGN KEY(numeroApartamento) REFERENCES tblApartamento(numero),
    FOREIGN KEY(cpfCliente) REFERENCES tblCliente(cpf),
    FOREIGN KEY(cpfFuncionario) REFERENCES tblFuncionario(cpf)
);

CREATE TABLE tblHospedagem(
    idHospedagem INT NOT NULL IDENTITY PRIMARY KEY,
    dataInicio DATE NOT NULL,
    dataTermino DATE NOT NULL,
    status BIT NOT NULL,
    valorTotal MONEY NOT NULL,
    idReserva INT NOT NULL,
    cpfFuncionarioAbertura INT NOT NULL,
    cpfFuncionarioEncerramento INT NOT NULL,
    FOREIGN KEY(idReserva) REFERENCES tblReserva(idReserva),
    FOREIGN KEY(cpfFuncionarioAbertura) REFERENCES tblFuncionario(cpf),
    FOREIGN KEY(cpfFuncionarioEncerramento) REFERENCES tblFuncionario(cpf)
);

CREATE TABLE tblConsumo(
    idHospedagem INT NOT NULL,
    idProduto INT NOT NULL,
    quantidade INT NOT NULL,
    precoUnitario MONEY NOT NULL,
    FOREIGN KEY(idHospedagem) REFERENCES tblHospedagem(idHospedagem),
    FOREIGN KEY(idProduto) REFERENCES tblProduto(idProduto),
    PRIMARY KEY(idHospedagem, idProduto)
);
