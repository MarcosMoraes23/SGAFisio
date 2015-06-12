/*--------------*/

create database fisioterapia
/*---------------*/



create table usuario (

	id bigint notnull,
	usuario varchar(60),
	senha varchar(60),
	tipo enum(supevisor, estagiario, secretaria) notnull,

        constraint usuario_pk primary key (id)

);




create table supervisor (
	id bigint notnull,
	cpf varchar(11),
	telefone varchar(20),
	rg varchar(15),
	nome varchar(256),
	cidade  varchar(160),
	cep varchar(8),
	rua varchar (160),
	bairro varchar (160),
	id_usuario bigint notnull,

	constraint supervisor_pk primary key (id),
	constraint supervisor_1_fk foreign key (id_usuario) references usuario (id) on delete no action on update cascade

);




create table estagiario (

	id bigint notnull,
	cpf varchar(11),
	telefone varchar(20),
	rg varchar(15),
	nome varchar(256),
	cidade varchar(160),
	cep varchar(8),
	rua varchar (160),
	bairro varchar (160),
	horario_alocado timestamp,
	periodo smallint,
	matricula varchar(20),
	id_usuario bigint notnull,

	constraint estagiario_pk primary key (id),
	constraint estagiario_1_fk foreign key (id_usuario) references usuario (id) on delete no action on update cascade

);




create table secretaria (
	
	id bigint notnull,
	cpf varchar(11),
	telefone varchar(20),
	rg varchar(15),
	nome varchar(256),
	cidade  varchar(160),
	cep varchar(8),
	rua varchar (160),
	bairro varchar (160),
	id_usuario bigint notnull,

	constraint secretaria_pk primary key (id),
	constraint secretaria_1_fk foreign key (id_usuario) references usuario (id) on delete no action on update cascade

);




create table paciente (

	id bigint notnull,
	cpf varchar(11),
	ocupacao_atual varchar (60),
	nome varchar (256),
	estado_civil enum (solteiro, casado, divorciado, viuvo),
	telefone varchar(20),
	responsavel varchar (256),
	data_nascimento date,
	isencao boolean,
	valor_pago numeric (15,2),
	sexo enum (masculino, feminino)
	cidade  varchar(160),
	cep varchar(8),
	rua varchar (160),
	bairro varchar (160),
	raca enum (branco, pardo, indigena, negro),
	estado varchar (2),

	constraint paciente_pk primary key (id),

);



create table fila_espera (
	id bigint notnull,
	data_inclusao date,
	status boolean,
	id_secretaria bigint notnull,
	id_paciente bigint notnull,

	constraint fila_espera_pk primary key (id),
	constraint fila_espera_1_fk foreign key (id_secretaria) references secretaria (id) on delete no action on update cascade,
	constraint fila_espera_2_fk foreign key (id_paciente) references paciente (id) on delete cascade on update cascade

);




create table atendimento (
	id bigint notnull,
	queixa_principal varchar (160),
	historico_fisiologico varchar (256),
	historico_familiar varchar (256),
	historico_social varchar (256),
	id_paciente bigint notnull,

	constraint atendimento_pk primary key (id),
	constraint atendimento_1_fk foreign key (id_paciente) references (paciente) on delete no action on update cascade

);



create table agenda (

	id bigint notnull,
	hora timestamp,
	data_sessao date,
	status boolean,
	id_estagiário bigint notnull,
	id_paciente bigint notnull,

	constraint agenda_pk primary key (id),
	constraint agenda_1_fk foreign key (id_estagiario) references estagiario (id) on delete no action on update cascade,
	constraint agenda_2_fk foreign key (id_paciente) references paciente (id) on delete no action on update cascade
	

);




create table anamnese (

	id bigint notnull,
	historico_doenca_atual varchar (256),
	diagnostico_clinico varchar (256),
	historico_patologico_pregresso varchar(256),
	id_supervisor bigint not null,
	id_estagiario bigint not null,
	id_paciente bigint not null,

	constraint anamnese_pk primary key (id),
	constraint anamnese_1_fk foreign key (id_supervisor) references supervisor (id) on delete no action on update cascade,
	constraint anamnese_2_fk foreign key (id_estagiario) references estagiario (id) on delete no action on update cascade,
	constraint anamnese_3_fk foreign key (id_paciente) references paciente (id) on delete no action on update cascade
	
);




create table secretaria_atendimento (

	id_secretaria bigint notnull,
	id_atendimento bigint notnull,
	???

	constraint secretaria_atendimento_pk primary key (id_secretaria, id_atendimento),
	constraint secretaria_atendimento_1_fk foreign key (id_secretaria) references secretaria (id) on delete no action on update cascade,
	constraint secretaria_atendimento_2_fk foreign key (id_atendimento) references atendimento (id) on delete cascade on update cascade,

);




create table secretaria_agenda (

	id_secretaria bigint notnull,
	id_agenda bigint notnull,

	constraint secretaria_agenda_pk primary key (id_secretaria, id_agenda),
	constraint secretaria_agenda_1_fk foreign key (id_secretaria) references secretaria (id) on delete no action on update cascade,
	constraint secretaria_agenda_2_fk foreign key (id_agenda) references agenda (id) on delete cascade on update cascade,

);




	





