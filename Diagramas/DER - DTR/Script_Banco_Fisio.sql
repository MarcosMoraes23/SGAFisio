-----------------------------------------SCRIPT BANCO SGAFisio-----------------------------------------------------
CREATE DATABASE fisioterapia;

create sequence sequence_usuario;
create sequence sequence_anamnese;
create sequence sequence_paciente;
create sequence sequence_secretaria;
create sequence sequence_supervisor;
create sequence sequence_atendimento;
create sequence sequence_agenda;
create sequence sequence_fila_de_espera;
create sequence sequence_estagiario;

CREATE TABLE fila_de_espera (
id bigint not null,
data_inclusao date not null,
status integer,

id_secretaria bigint not null,
id_paciente bigint not null
);

CREATE TABLE usuario (
id bigint not null,
usuario varchar(128) not null,
senha varchar(128) not null,
tipo integer not null
);

CREATE TABLE secretaria (
id bigint not null,
nome varchar(256) not null,
data_nascimento date not null,
matricula varchar(64) not null,
cpf varchar(11) not null,
rg varchar(11),
telefone varchar(64),
estado varchar(64) not null,
cidade varchar(64) not null,
bairro varchar(64) not null,
rua varchar(64) not null,
cep varchar(10),
numero integer not null,
complemento varchar(64) not null,

id_usuario bigint not null
);

CREATE TABLE agenda (
id bigint not null,
hora time not null,
data_agenda date not null,
status integer,

id_estagiario bigint not null,
id_secretaria bigint not null ,
id_paciente bigint not null
);

CREATE TABLE estagiario (
id bigint not null,
nome varchar(256) not null,
data_nascimento date not null,
matricula varchar(64) not null,
cpf varchar(11) not null,
rg varchar(11),
telefone varchar(64),
estado varchar(64) not null,
cidade varchar(64) not null,
bairro varchar(64) not null,
rua varchar(64) not null,
cep varchar(10),
numero integer not null,
complemento varchar(64) not null,
turno_alocado integer,
periodo integer not null,

id_usuario bigint not null
);

CREATE TABLE atendimento (
id bigint not null,
data_atendimento date not null,
hora time not null,
descricao_atendimento text,

id_agenda bigint not null
);

CREATE TABLE anamnese (
id bigint not null,
data_anamnese date,
histórico_familiar text,
historico_social text,
historico_patologico text,
historico_doenca_atual text,
historico_fisiologico text,
diagnostico_clinico text ,
queixa_principal text,
periodo_inatividade text,
cirurgias text,
medicacoes_atuais text,
exames_complementares text,
metas_paciente text,
dependencias_quimicas text,
dependencias_fisiologicas text,


id_supervisor bigint not null ,
id_paciente bigint not null,
id_estagiario bigint not null
);

CREATE TABLE paciente (
id bigint not null,
nome varchar(256) not null,
data_nascimento date not null,
cpf varchar(11) not null,
rg varchar(11),
telefone varchar(64),
estado varchar(64) not null,
cidade varchar(64) not null,
bairro varchar(64) not null,
rua varchar(64) not null,
cep varchar(10),
numero integer not null,
complemento varchar(64) not null,
etnia integer not null,
estado_civil integer not null,
sexo boolean,
ocupacao_atual varchar,
responsavel varchar,
isencao boolean not null,
valor_pago numeric(15,2) default 0, --DEVIDO AO RELATÓRIO FINANCEIRO, OS CÁLCULOS PRECISAM ENCONTRAR 0 E NÃO NULL--
falta integer not null default 0, --DEVIDO AO RELATÓRIO ATENDIMENTO, OS CÁLCULOS PRECISAM ENCONTRAR 0 E NÃO NULL--
alta boolean
);

CREATE TABLE supervisor (
id bigint not null,
nome varchar(256) not null,
data_nascimento date not null,
matricula varchar(64) not null,
cpf varchar(11) not null,
rg varchar(11),
telefone varchar(64),
estado varchar(64) not null,
cidade varchar(64) not null,
bairro varchar(64) not null,
rua varchar(64) not null,
cep varchar(10),
numero integer not null,
complemento varchar(64) not null,

id_usuario bigint not null
);

--------------------------------------------PRIMARY KEYS------------------------------------------------------
ALTER TABLE secretaria ADD CONSTRAINT secretaria_pk PRIMARY KEY (id);
ALTER TABLE supervisor ADD CONSTRAINT supervisor_pk PRIMARY KEY (id);
ALTER TABLE estagiario ADD CONSTRAINT estagiario_pk PRIMARY KEY (id);
ALTER TABLE agenda ADD CONSTRAINT agenda_pk PRIMARY KEY (id);
ALTER TABLE atendimento ADD CONSTRAINT atendimento_pk PRIMARY KEY (id);
ALTER TABLE anamnese ADD CONSTRAINT anamnese_pk PRIMARY KEY (id);
ALTER TABLE fila_de_espera ADD CONSTRAINT fila_de_espera_pk PRIMARY KEY (id);
ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY (id);
ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY (id);
--------------------------------------------------------------------------------------------------------------

------------------------------------------UNIQUES--------------------------------------------------------------
ALTER TABLE usuario ADD CONSTRAINT usuario_uk UNIQUE(usuario);
ALTER TABLE paciente ADD CONSTRAINT paciente_uk UNIQUE (cpf);
ALTER TABLE secretaria ADD CONSTRAINT secretaria_uk UNIQUE (cpf);
ALTER TABLE supervisor ADD CONSTRAINT supervisor_uk UNIQUE (cpf);
--------------------------------------------FOREIGN KEYS------------------------------------------------------

-- SECRETARIA --> (USUARIO) --
ALTER TABLE secretaria ADD CONSTRAINT secretaria_1_fk FOREIGN KEY(id_usuario) REFERENCES usuario (id); 


-- SUPERVISOR --> (USUARIO) --
ALTER TABLE supervisor ADD CONSTRAINT supervisor_1_fk FOREIGN KEY(id_usuario) REFERENCES usuario (id);


-- ESTAGIARIO --> (USUARIO) --
ALTER TABLE estagiario ADD CONSTRAINT estagiario_1_fk FOREIGN KEY(id_usuario) REFERENCES usuario (id);


-- AGENDA --> (SECRETARIA, ESTAGIARIO, PACIENTE) --
ALTER TABLE agenda ADD CONSTRAINT agenda_1_fk FOREIGN KEY(id_secretaria) REFERENCES secretaria (id);
ALTER TABLE agenda ADD CONSTRAINT agenda_2_fk FOREIGN KEY(id_estagiario) REFERENCES estagiario (id);
ALTER TABLE agenda ADD CONSTRAINT agenda_3_fk FOREIGN KEY(id_paciente) REFERENCES paciente (id);



-- ATENDIMENTO --> (AGENDA) --
ALTER TABLE atendimento ADD CONSTRAINT atendimento_1_fk FOREIGN KEY(id_agenda) REFERENCES agenda (id);


-- ANAMNESE --> (ESTAGIARIO, SUPERVISOR, PACIENTE) --
ALTER TABLE anamnese ADD CONSTRAINT anamnese_1_fk FOREIGN KEY(id_estagiario) REFERENCES estagiario (id);
ALTER TABLE anamnese ADD CONSTRAINT anamnese_2_fk FOREIGN KEY(id_supervisor) REFERENCES supervisor (id);
ALTER TABLE anamnese ADD CONSTRAINT anamnese_3_fk FOREIGN KEY(id_paciente) REFERENCES paciente (id);


-- FILA DE ESPERA --> (SECRETARIA, PACIENTE) --
ALTER TABLE fila_de_espera ADD CONSTRAINT fila_de_espera_1_fk FOREIGN KEY(id_secretaria) REFERENCES secretaria (id);
ALTER TABLE fila_de_espera ADD CONSTRAINT fila_de_espera_2_fk FOREIGN KEY(id_paciente) REFERENCES paciente (id);

-----------------------------------------------------------------------------------------------------------------------





