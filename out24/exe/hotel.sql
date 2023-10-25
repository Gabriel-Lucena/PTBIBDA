CREATE DATABASE Hotel;

Use Hotel;

CREATE TABLE tblCategoria(
    idCategoria INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valorDiaria DOUBLE(6, 2) NOT NULL
);

CREATE TABLE tblProduto(
    idProduto INT NOT NULL IDENTITY PRIMARY KEY,
    descricao VARHCAR(50) NOT NULL,
    precoVenda DOUBLE(6, 2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE tblPessoa(
    cpf INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(30) NOT NULL
);

CREATE TABLE tblTelefone (
    cpfPessoa INT NOT NULL PRIMARY KEY,
    ddi CHAR(3) NOT NULL PRIMARY KEY,
    ddd CHAR(3) NOT NULL PRIMARY KEY,
    telefone VARCHAR(20) NOT NULL PRIMARY KEY,
    nomeContato VARCHAR(20) NOT NULL,
    descricao VARCHAR(30),
    FOREIGN KEY(cpfPessoa) REFERENCES tblPessoa(cpf)
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

CREATE TABLE tblConsumo(
    idHospedagem INT NOT NULL PRIMARY KEY,
    idProduto INT NOT NULL PRIMARY KEY,
    quantidade INT NOT NULL,
    precoUnitario DOUBLE(6, 2) NOT NULL,
    FOREIGN KEY(idHospedagem) REFERENCES tblHospedagem(idHospedagem),
    FOREIGN KEY(idProduto) REFERENCES tblProduto(idProduto)
);
