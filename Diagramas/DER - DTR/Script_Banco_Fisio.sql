-----------------------------------------SCRIPT BANCO SGAFisio-----------------------------------------------------

CREATE TABLE fila_de_espera (
id bigint not null,
data_inclusao date not null,
status integer,

id_secretaria bigint not null,
id_paciente bigint not null
)

CREATE TABLE usuario (
id bigint not null,
usuario varchar(128) not null,
senha varchar(128) not null,
tipo integer not null
)

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
)

CREATE TABLE agenda (
id bigint not null,
hora time not null,
data_agenda date not null,
status integer,

id_estagiario bigint not null,
id_secretaria bigint not null ,
id_paciente bigint not null
)

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
horario_alocado boolean,
periodo integer not null,

id_usuario bigint not null
)

CREATE TABLE atendimento (
id bigint not null,
data date not null,
hora time not null,
descricao_atendimento text,

id_paciente bigint not null,
id_agenda bigint not null
)

CREATE TABLE anamnese (
id bigint not null,
data_anamnese date not null,
histórico_familiar text not null,
historico_social text not null,
historico_patologico_pregresso text not null,
historico_doenca_atual text not null,
historico_fisiologico text not null,
diagnostico_clinico text not null,
queixa_principal text not null,
periodo_inatividade text not null,

id_supervisor bigint not null ,
id_paciente bigint not null,
id_estagiario bigint not null
)

CREATE TABLE paciente (
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
raca integer not null,
estado_civil integer not null,
sexo boolean,
ocupacao_atual varchar,
responsavel varchar,
isencao boolean not null,
valor_pago numeric(15,2) default 0, --DEVIDO AO RELATÓRIO FINANCEIRO, OS CÁLCULOS PRECISAM ENCONTRAR 0 E NÃO NULL--
falta integer not null default 0, --DEVIDO AO RELATÓRIO ATENDIMENTO, OS CÁLCULOS PRECISAM ENCONTRAR 0 E NÃO NULL--
alta boolean
)

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
)

--------------------------------------------PRIMARY KEYS------------------------------------------------------
ALTER TABLE secretaria ADD CONSTRAINT secretaria_pk PRIMARY KEY (id)
ALTER TABLE supervisor ADD CONSTRAINT supervisor_pk PRIMARY KEY (id)
ALTER TABLE estagiaro ADD CONSTRAINT estagiario_pk PRIMARY KEY (id)
ALTER TABLE agenda ADD CONSTRAINT agenda_pk PRIMARY KEY (id)
ALTER TABLE atendimento ADD CONSTRAINT atendimento_pk PRIMARY KEY (id)
ALTER TABLE anamnese ADD CONSTRAINT anamnese_pk PRIMARY KEY (id)
ALTER TABLE fila_de_espera ADD CONSTRAINT fila_de_espera_pk PRIMARY KEY (id)
--------------------------------------------------------------------------------------------------------------



--------------------------------------------FOREIGN KEYS------------------------------------------------------

-- SECRETARIA --> (USUARIO) --
ALTER TABLE secretaria ADD CONSTRAINT secretaria_1_fk FOREIGN KEY(id_usuario) REFERENCES usuario (id) 


-- SUPERVISOR --> (USUARIO) --
ALTER TABLE supervisor ADD CONSTRAINT supervisor_1_fk FOREIGN KEY(id_usuario) REFERENCES usuario (id)


-- ESTAGIARIO --> (USUARIO) --
ALTER TABLE estagiaro ADD CONSTRAINT estagiario_1_fk FOREIGN KEY(id_usuario) REFERENCES usuario (id)


-- AGENDA --> (SECRETARIA, ESTAGIARIO, PACIENTE) --
ALTER TABLE agenda ADD CONSTRAINT agenda_1_fk FOREIGN KEY(id_secretaria) REFERENCES secretaria (id)
ALTER TABLE agenda ADD CONSTRAINT agenda_2_fk FOREIGN KEY(id_estagiario) REFERENCES estagiario (id)
ALTER TABLE agenda ADD CONSTRAINT agenda_3_fk FOREIGN KEY(id_paciente) REFERENCES paciente (id)



-- ATENDIMENTO --> (AGENDA, PACIENTE) --
ALTER TABLE atendimento ADD CONSTRAINT atendimento_1_fk FOREIGN KEY(id_agenda) REFERENCES agenda (id)
ALTER TABLE atendimento ADD CONSTRAINT atendimento_2_fk FOREIGN KEY(id_paciente) REFERENCES paciente (id)


-- ANAMNESE --> (ESTAGIARIO, SUPERVISOR, PACIENTE) --
ALTER TABLE anamnese ADD CONSTRAINT anamnese_1_fk FOREIGN KEY(id_estagiario) REFERENCES estagiario (id)
ALTER TABLE anamnese ADD CONSTRAINT anamnese_2_fk FOREIGN KEY(id_supervisor) REFERENCES supervisor (id)
ALTER TABLE anamnese ADD CONSTRAINT anamnese_3_fk FOREIGN KEY(id_paciente) REFERENCES paciente (id)


-- FILA DE ESPERA --> (SECRETARIA, PACIENTE) --
ALTER TABLE fila_de_espera ADD CONSTRAINT fila_de_espera_1_fk FOREIGN KEY(id_secretaria) REFERENCES secretaria (id)
ALTER TABLE fila_de_espera ADD CONSTRAINT fila_de_espera_2_fk FOREIGN KEY(id_paciente) REFERENCES paciente (id)

-----------------------------------------------------------------------------------------------------------------------





