-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE usuario (
id inteiro PRIMARY KEY,
senha texto,
user texto,
tipo inteiro
)

CREATE TABLE paciente (
sexo boolean,
id inteiro PRIMARY KEY,
telefone Texto,
valor_pago numerico,
cpf texto,
responsavel Texto,
estado_civil inteiro,
nome texto,
complemento texto,
estado texto,
numero inteiro,
cep texto,
cidade texto,
data_nascimento data,
bairro texto,
ocupacao_atual Texto,
isencao boolean,
rua texto,
etnia inteiro,
falta inteiro,
alta boolean
)

CREATE TABLE fila_de_espera (
data_inclusao data,
status inteiro,
id inteiro PRIMARY KEY,
id_secretaria texto,
id_paciente inteiro,
FOREIGN KEY(id_paciente) REFERENCES paciente (id)
)

CREATE TABLE atendimento (
id inteiro PRIMARY KEY,
hora hora,
descricao_atendimento Texto,
data_atendimento data,
id_agenda inteiro
)

CREATE TABLE agenda (
hora hora,
id inteiro PRIMARY KEY,
status inteiro,
data_agenda data,
id_estagiario inteiro,
id_secretaria texto,
id_paciente inteiro,
FOREIGN KEY(id_paciente) REFERENCES paciente (id)
)

CREATE TABLE supervisor (
id inteiro PRIMARY KEY,
complemento texto,
nome Texto,
rg Texto,
telefone texto,
cidade texto,
estado texto,
numero inteiro,
rua texto,
cep Texto,
cpf texto,
bairro texto,
matricula texto,
data_nascimento data,
id_usuario inteiro,
FOREIGN KEY(id_usuario) REFERENCES usuario (id)
)

CREATE TABLE secretaria (
bairro texto,
rg texto,
cpf texto,
estado texto,
rua texto,
complemento texto,
id texto PRIMARY KEY,
telefone texto,
cep texto,
cidade texto,
numero inteiro,
nome texto,
matricula texto,
data_nascimento data,
id_usuario inteiro,
FOREIGN KEY(id_usuario) REFERENCES usuario (id)
)

CREATE TABLE anamnese (
id inteiro PRIMARY KEY,
histórico_familiar texto,
historico_social texto,
historico_patologico texto,
historico_doenca_atual texto,
historico_fisiologico texto,
diagnostico_clinico texto,
queixa_principal texto,
periodo_inatividade texto,
data_anamnese data,
cirurgias texto,
medicacoes_atuais texto,
exames_complementares texto,
metas_paciente texto,
dependencias_quimicas texto,
dependencias_fisiologicas texto,
id_supervisor inteiro,
id_paciente inteiro,
id_estagiario inteiro,
FOREIGN KEY(id_supervisor) REFERENCES supervisor (id),
FOREIGN KEY(id_paciente) REFERENCES paciente (id)
)

CREATE TABLE estagiario (
turno_alocado inteiro,
id inteiro PRIMARY KEY,
estado texto,
bairro texto,
rg Texto,
periodo inteiro,
telefone texto,
nome Texto,
complemento texto,
cpf texto,
matricula Texto,
cidade texto,
cep texto,
numero texto,
rua texto,
data_nascimento data,
id_usuario inteiro,
FOREIGN KEY(id_usuario) REFERENCES usuario (id)
)

ALTER TABLE fila_de_espera ADD FOREIGN KEY(id_secretaria) REFERENCES secretaria (id)
ALTER TABLE atendimento ADD FOREIGN KEY(id_agenda) REFERENCES agenda (id)
ALTER TABLE agenda ADD FOREIGN KEY(id_estagiario) REFERENCES estagiario (id)
ALTER TABLE agenda ADD FOREIGN KEY(id_secretaria) REFERENCES secretaria (id)
ALTER TABLE anamnese ADD FOREIGN KEY(id_estagiario) REFERENCES estagiario (id)
