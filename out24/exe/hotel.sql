CREATE DATABASE Hotel;

USE Hotel;

CREATE TABLE tblCategoria(
    idCategoria INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valorDiaria DECIMAL(6, 2) NOT NULL
);

CREATE TABLE tblProduto(
    idProduto INT NOT NULL IDENTITY PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL,
    precoVenda DECIMAL(6, 2) NOT NULL,
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
    cpfPessoa INT NOT NULL,
    ddi CHAR(3) NOT NULL,
    ddd CHAR(3) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    nomeContato VARCHAR(20) NOT NULL,
    descricao VARCHAR(30),
    FOREIGN KEY(cpfPessoa) REFERENCES tblPessoa(cpf),
    PRIMARY KEY (cpfPessoa, ddi, ddd, telefone)
);

CREATE TABLE tblCliente(
    cpfPessoa INT NOT NULL PRIMARY KEY,
    dataNascimento DATE NOT NULL,
    FOREIGN KEY(cpfPessoa) REFERENCES tblPessoa(cpf)
);

CREATE TABLE tblFuncionario(
    cpfPessoa INT NOT NULL PRIMARY KEY,
    dataEfetivacao DATE NOT NULL,
    CargaHorariaSemanal INT NOT NULL,
    FOREIGN KEY(cpfPessoa) REFERENCES tblPessoa(cpf)
);

CREATE TABLE tblEmail(
    cpfCliente INT NOT NULL PRIMARY KEY,
    email VARCHAR(256) NOT NULL,
    FOREIGN KEY(cpfCliente) REFERENCES tblCliente(cpfPessoa)
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
    FOREIGN KEY(cpfCliente) REFERENCES tblCliente(cpfPessoa),
    FOREIGN KEY(cpfFuncionario) REFERENCES tblFuncionario(cpfPessoa)
);

CREATE TABLE tblHospedagem(
    idHospedagem INT NOT NULL IDENTITY PRIMARY KEY,
    dataInicio DATE NOT NULL,
    dataTermino DATE NOT NULL,
    status BIT NOT NULL,
    valorTotal DECIMAL(6, 2) NOT NULL,
    idReserva INT NOT NULL,
    cpfFuncionarioAbertura INT NOT NULL,
    cpfFuncionarioEncerramento INT NOT NULL,
    FOREIGN KEY(idReserva) REFERENCES tblReserva(idReserva),
    FOREIGN KEY(cpfFuncionarioAbertura) REFERENCES tblFuncionario(cpfPessoa),
    FOREIGN KEY(cpfFuncionarioEncerramento) REFERENCES tblFuncionario(cpfPessoa)
);

CREATE TABLE tblConsumo(
    idHospedagem INT NOT NULL,
    idProduto INT NOT NULL,
    quantidade INT NOT NULL,
    precoUnitario DECIMAL(6, 2) NOT NULL,
    FOREIGN KEY(idHospedagem) REFERENCES tblHospedagem(idHospedagem),
    FOREIGN KEY(idProduto) REFERENCES tblProduto(idProduto),
    PRIMARY KEY(idHospedagem, idProduto)
);
