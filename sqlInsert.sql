create database banco;
use banco;

create table contas(idConta int auto_increment primary key, nome varchar(256), cpf int(12),idade int(200), numeroTelefone int(12), email varchar(256));

insert into contas(nome, cpf, idade, numeroTelefone, email) value ("pessoa", 1234567891, 20, 1234567891, "pesssoa@gmail.com");
insert into contas(nome, cpf, idade, numeroTelefone, email) value ("pessoa2", 1234567891, 20, 1234567891, "pesssoa2@gmail.com");


