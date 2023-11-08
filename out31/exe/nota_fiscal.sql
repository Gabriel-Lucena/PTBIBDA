CREATE DATABASE nota_fiscal;

USE nota_fiscal;

CREATE TABLE tblProduto(
    idProduto INT NOT NULL IDENTITY PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL,
    cfop INT NOT NULL,
    unidade INT NOT NULL,
    peso DOUBLE NOT NULL,
    cst INT NOT NULL,
    ncm INT NOT NULL,
    preco money NOT NULL,
    icms INT NOT NULL
);

CREATE TABLE tblCidade(
    idCidade INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE tblEstado(
    idEstado INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE tblEndereco(
    cep INT NOT NULL PRIMARY KEY,
    idCidade INT NOT NULL,
    idEstado INT NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    FOREIGN KEY(idCidade) REFERENCES tblCidade(idCidade),
    FOREIGN KEY(idEstado) REFERENCES tblEstado(idEstado)
);

CREATE TABLE tblCliente(
    cnpj INT NOT NULL PRIMARY KEY,
    razaoSocial VARCHAR(30) NOT NULL,
    inscricaoEstadual INT NOT NULL,
    numeroEndereco INT NOT NULL,
    cep INT NOT NULL,
    FOREIGN KEY(cep) REFERENCES tblEndereco(cep)
);

CREATE TABLE tblOperacao(
    idOperacao INT NOT NULL IDENTITY PRIMARY KEY,
    naturezaOperacao VARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE tblNotaFiscal(
    numero INT NOT NULL IDENTITY,
    serie INT NOT NULL IDENTITY,
    idOperacao INT NOT NULL,
    chaveAcesso INT NOT NULL,
    dataEmissao DATEHOUR NOT NULL,
    dadosAdicionais VARCHAR(250) NOT NULL,
    PRIMARY KEY(numero, serie),
    FOREIGN KEY(idOperacao) REFERENCES tblOperacao(idOperacao)
);

CREATE TABLE tblProduto_NotaFiscal(
    idProduto INT NOT NULL,
    serie INT NOT NULL,
    numero INT NOT NULL,
    valorItem money NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY(idProduto, numero, serie),
    FOREIGN KEY(idProduto) REFERENCES tblProduto(idProduto),
    FOREIGN KEY(serie) REFERENCES tblNotaFiscal(serie),
    FOREIGN KEY(numero) REFERENCES tblNotaFiscal(numero)
);

CREATE TABLE tblFatura(
    numeroFiscal INT NOT NULL IDENTITY PRIMARY KEY,
    serie INT NOT NULL,
    numero INT NOT NULL,
    vencimento DATE NOT NULL,
    valor money NOT NULL,
    FOREIGN KEY(serie) REFERENCES tblNotaFiscal(serie),
    FOREIGN KEY(numero) REFERENCES tblNotaFiscal(numero)
);

CREATE TABLE tblTransportadora(
    cnpj INT NOT NULL PRIMARY KEY,
    inscricaoEstadual INT NOT NULL,
    razaoSocial VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    cep INT NOT NULL,
    FOREIGN KEY(cep) REFERENCES tblEndereco(cep)
);

CREATE TABLE tblImposto(
    numero INT NOT NULL,
    serie INT NOT NULL,
    imposto VARCHAR(20) NOT NULL,
    baseCalculo money NOT NULL,
    valorImposto money NOT NULL,
    desconto money NOT NULL,
    PRIMARY KEY(numero, serie),
    FOREIGN KEY(numero) REFERENCES tblNotaFiscal(Numero),
    FOREIGN KEY(serie) REFERENCES tblNotaFiscal(serie)
);

CREATE TABLE tblEmpresa(
    cnpj INT NOT NULL PRIMARY KEY,
    razaoSocial VARCHAR(50) NOT NULL,
    protocoloNF INT NOT NULL,
    inscricaoEstadual INT NOT NULL,
    numero INT NOT NULL,
    cep INT NOT NULL,
    FOREIGN KEY(cep) REFERENCES tblEndereco(cep)
);

CREATE TABLE tblTelefone(
    cnpj INT NOT NULL,
    ddi INT NOT NULL,
    ddd INT NOT NULL,
    numero INT NOT NULL,
    PRIMARY KEY(cnpj, ddi, ddd, numero),
    FOREIGN KEY(cnpj) REFERENCES tblEmpresa(cnpj)
);
