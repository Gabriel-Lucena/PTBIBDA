CREATE DATABASE hospital;

USE hospital;

CREATE TABLE tblGenero(
    idGenero INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tblConvenio(
    idConvenio INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tblEstadoCivil(
    idEstadoCivil INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tblMedico(
    crm INT NOT NULL PRIMARY KEY
);

CREATE TABLE tblDiagnostico(
    idDiagnostico INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tblConsulta(
    idConsulta INT NOT NULL IDENTITY,
    data DATE NOT NULL,
    crmMedico INT NOT NULL,
    idDiagnostico INT NOT NULL,
    idPaciente INT NOT NULL,
    FOREIGN KEY(crmMedico) REFERENCES tblMedico(crm),
    FOREIGN KEY(idDiagnostico) REFERENCES tblDiagnostico(idDiagnostico),
    FOREIGN KEY(idPaciente) REFERENCES tblPaciente(idPaciente),
    PRIMARY KEY(idConsulta, idPaciente)
);

CREATE TABLE tblExame(
    idExame INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    idConsulta INT NOT NULL,
    FOREIGN KEY(idConsulta) REFERENCES tblConsulta(idConsulta)
);

CREATE TABLE tblPaciente(
    idPaciente INT NOT NULL IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    dataNascimento DATE NOT NULL,
    idGenero INT NOT NULL,
    idConvenio INT NOT NULL,
    idEstadoCivil INT NOT NULL,
    rg INT NOT NULL UNIQUE,
    telefone INT NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    FOREIGN KEY(idGenero) REFERENCES tblGenero(idGenero),
    FOREIGN KEY(idConvenio) REFERENCES tblConvenio(idConvenio),
    FOREIGN KEY(idEstadoCivil) REFERENCES tblEstadoCivil(idEstadoCivil)
);
