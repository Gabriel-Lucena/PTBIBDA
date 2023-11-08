create database consultorio;

use consultorio;

create table pessoas
(
    id int not null primary key identity,
    nome varchar(100) not null,
    data_nascimento date not null,
    genero varchar(50),
    estado_civil varchar(50),
    rg varchar(14) not null
);

insert into pessoas
values
    ('Igor', '1986-05-21', 'Masculino', 'Casado', '22.222.222-2');
insert into pessoas
    (nome, data_nascimento, rg)
values
    ('Luiz', '1983-05-23', '33.333.333-3');

select *
from pessoas;

update pessoas set
	estado_civil = 'Casado'
where
	id = 2;

create table telefones
(
    id_pessoa int not null,
    ddd int not null,
    telefone varchar(10) not null,
    primary key (id_pessoa, ddd, telefone),
    foreign key (id_pessoa) references pessoas (id)
);

insert into telefones
values
    (3, 11, '99999-9999');
insert into telefones
values
    (2, 16, '99999-9988');
insert into telefones
values
    (1, 11, '99999-9888');

select id_pessoa as [Código da Pessoa], ddd, telefone
from telefones
where
	id_pessoa = 1;

create table enderecos
(
    id int not null identity,
    id_pessoa int not null,
    logradouro varchar(50),
    numero varchar(10) not null,
    cep varchar(9) not null,
    bairro varchar(50),
    cidade varchar(50),
    estado varchar(50),
    primary key (id, id_pessoa),
    foreign key (id_pessoa) references pessoas (id)
);

insert into enderecos
values
    (
        2, 'Rua 10', '10', '10100-100', 'Bairro Centenário', 'São Paulo', 'SP');

select *
from enderecos;

create table pacientes
(
    id_pessoa int not null primary key,
    convenio varchar(50),
    foreign key (id_pessoa) references pessoas (id)
);

insert into pacientes
values
    (1, 'SUS');

create table medicos
(
    id_pessoa int not null primary key,
    crm varchar(10),
    foreign key (id_pessoa) references pessoas (id)
);

insert into medicos
values(2, '5555');

select *
from medicos;

create table consultas
(
    id int not null primary key identity,
    data datetime not null,
    diagnostico varchar(100),
    id_medico int not null,
    id_paciente int not null,
    foreign key (id_medico) references medicos (id_pessoa),
    foreign key (id_paciente) references pacientes (id_pessoa)
);

insert into consultas
values
    (getDate(), 'Stress', 2, 1);

select *
from consultas;

create table exames
(
    id int not null primary key identity,
    id_consulta int not null,
    data datetime not null,
    exame varchar(100)
        foreign key (id_consulta) references consultas (id)
);

insert into exames
values
    (1, getDate(), 'Sangue');
insert into exames
values
    (1, getDate(), 'RX');

select *
from exames
where
	id_consulta = 1;

select *
from exames
where
	exame like '%a%';

delete from exames;