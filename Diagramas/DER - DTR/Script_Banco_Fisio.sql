-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE fila_de_espera (
id bigint PRIMARY KEY not null,
data_inclusao date not null,
status integer,
id_secretaria bigint not null,
id_paciente bigint not null
)

CREATE TABLE usuario (
id bigint PRIMARY KEY not null,
senha varchar not null,
user varchar not null,
tipo integer not null
)

CREATE TABLE secretaria (
id bigint PRIMARY KEY not null,
bairro varchar not null,
rg varchar not null,
cpf varchar not null,
estado varchar not null,
rua varchar not null,
complemento varchar not null,
telefone varchar not null,
cep varchar not null,
cidade varchar not null,
numero integer not null,
nome varchar not null,
id_usuario bigint not null,
FOREIGN KEY(id_usuario) REFERENCES usuario (id)
)

CREATE TABLE agenda (
id bigint PRIMARY KEY not null,
hora time not null,
data date not null,
status integer,
id_estagiario bigint not null,
id_secretaria bigint not null ,
id_paciente bigint not null,
FOREIGN KEY(id_secretaria) REFERENCES secretaria (id)
)

CREATE TABLE estagiario (
id bigint PRIMARY KEY not null,
horario_alocado boolean,
estado varchar not null,
bairro varchar not null,
rg varchar not null,
periodo integer not null,
telefone varchar not null,
nome varchar not null,
complemento varchar not null,
cpf varchar not null,
matricula varchar not null,
cidade varchar not null,
cep varchar not null,
numero varchar not null,
rua varchar not null,
id_usuario bigint not null,
FOREIGN KEY(id_usuario) REFERENCES usuario (id)
)

CREATE TABLE atendimento (
id bigint PRIMARY KEY,
data date not null,
hora time not null,
descricao_atendimento varchar,
id_paciente bigint not null,
id_agenda bigint not null,
FOREIGN KEY(id_agenda) REFERENCES agenda (id)
)

CREATE TABLE anamnese (
id bigint PRIMARY KEY not null,
histórico_familiar varchar,
historico_social varchar,
historico_patologico_pregresso varchar,
historico_doenca_atual varchar,
historico_fisiologico varchar,
diagnostico_clinico varchar,
queixa_principal varchar,
periodo_inatividade varchar,
id_supervisor bigint not null ,
id_paciente bigint not null,
id_estagiario bigint not null,
FOREIGN KEY(id_estagiario) REFERENCES estagiario (id)
)

CREATE TABLE paciente (
id bigint PRIMARY KEY,
nome varchar,
cpf varchar,
sexo boolean,
telefone Texto,
valor_pago numeric(15,2),
responsavel Texto,
estado_civil integer,
complemento varchar,
estado varchar,
numero integer,
cep varchar,
cidade varchar,
data_nascimento date,
bairro varchar,
ocupacao_atual Texto,
isencao boolean,
rua varchar,
raca integer,
falta integer,
alta boolean
)

CREATE TABLE supervisor (
id bigint PRIMARY KEY,
complemento varchar,
nome Texto,
rg Texto,
telefone varchar,
cidade varchar,
estado varchar,
numero integer,
rua varchar,
cep Texto,
cpf varchar,
bairro varchar,
id_usuario bigint ,
FOREIGN KEY(id_usuario) REFERENCES usuario (id)
)

ALTER TABLE fila_de_espera ADD FOREIGN KEY(id_secretaria) REFERENCES secretaria (id)
ALTER TABLE fila_de_espera ADD FOREIGN KEY(id_paciente) REFERENCES paciente (id)
ALTER TABLE agenda ADD FOREIGN KEY(id_estagiario) REFERENCES estagiario (id)
ALTER TABLE agenda ADD FOREIGN KEY(id_paciente) REFERENCES paciente (id)
ALTER TABLE atendimento ADD FOREIGN KEY(id_paciente) REFERENCES paciente (id)
ALTER TABLE anamnese ADD FOREIGN KEY(id_supervisor) REFERENCES supervisor (id)
ALTER TABLE anamnese ADD FOREIGN KEY(id_paciente) REFERENCES paciente (id)
