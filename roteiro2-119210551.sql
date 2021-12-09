--BANCO DE DADOS I - ROTEIRO 2
--ALUNO: Kássio Augusto de Moura Silva - MATRICULA: 119210551

--QUESTAO 1

-- CRIACAO DA TABELA
CREATE TABLE tarefas(
	id BIGINT,
 	descricao VARCHAR (100),
 	cpf CHAR (11),
 	setor INTEGER,
  	classificacao CHAR(1)
);

-- COMANDOS QUE DEVEM FUNCIONAR
INSERT INTO tarefas VALUES (2147483646, 'limpar o chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
INSERT INTO tarefas VALUES (null, null, null, null, null);

-- COMANDOS QUE NAO DEVEM FUNCIONAR
INSERT INTO tarefas VALUES (2147483644, 'limpar o chão do corredor superior', '987654323211', 0, 'F');
INSERT INTO tarefas VALUES (2147483643, 'limpar o chão do corredor superior', '98765432321', 0, 'FF');

-- QUESTAO 2

-- COMANDOS QUE DEVEM FUNCIONAM 
INSERT INTO tarefas VALUES (2147483648, 'limpar portas do téreo', '32323232955', 4, 'A');


-- QUESTAO 3

-- MUDANÇA REQUIRIDA
ALTER TABLE tarefas ALTER COLUMN setor TYPE SMALLINT;

-- COMANDOS QUE DEVEM FUNCIONAR
INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'A');
INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'A');

-- COMANDOS QUE NAO DEVEM FUNCIONAR
INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');
INSERT INTO tarefas VALUES (2147483650, 'limpar janelas da entrada principal', '32333233288', 32769, 'A');


-- QUESTAO 4

-- MUDANÇAS REQUERIDAS
DELETE FROM tarefas WHERE id IS NULL;
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN setor SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN classificacao SET NOT NULL;
ALTER TABLE tarefas RENAME COLUMN cpf TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN setor TO prioridade;
ALTER TABLE tarefas RENAME COLUMN classificacao TO status;

-- QUESTAO 5

-- MUDANÇAS REQUERIDAS
ALTER TABLE tarefas ADD UNIQUE (id);

-- COMANDOS QUE DEVEM FUNCIONAR
INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');

-- COMANDOS QUE NAO DEVEM FUNCIONAR
INSERT INTO tarefas VALUES(2147483653, 'aparar grama da area frontal', '32323232911', 3, 'A');

-- QUESTAO 6

-- A
-- O ATRIBUTO JÁ FOI CONSTRUIDO COM ESSA RESTRICAO

-- B
-- ATUALIZACOES REQUERIDAS
UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

-- USANDO O CHECK
ALTER TABLE tarefas ADD CONSTRAINT tipo_status CHECK (status = 'P' OR status = 'E' OR status = 'C');

-- QUESTAO 7

-- ATUALIZACOES REQUERIDAS
UPDATE tarefas SET prioridade = 5 WHERE prioridade > 5;

ALTER TABLE tarefas ADD CONSTRAINT tipo_prioridade CHECK (prioridade = 0 OR prioridade = 1 OR prioridade = 2 OR prioridade = 3 OR prioridade = 4 OR prioridade = 5);

-- QUESTAO 8
--CRIACAO DA TABELA
CREATE TABLE funcionario (
	cpf CHAR(11) PRIMARY KEY,
	data_nasc DATE NOT NULL,
	nome VARCHAR(50) NOT NULL,
	funcao VARCHAR(11) NOT NULL,
	CHECK (funcao = 'LIMPEZA' OR funcao = 'SUP_LIMPEZA'),
	nivel CHAR(1) NOT NULL,
	CHECK (nivel = 'J' OR nivel = 'P' OR nivel = 'S'),
	superior_cpf CHAR(11) REFERENCES funcionario (cpf),
	CHECK ((superior_cpf IS NOT NULL AND funcao = 'LIMPEZA') OR funcao = 'SUP_LIMPEZA')
);

-- COMANDOS QUE DEVEM FUNCIONAR
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

-- COMANDOS QUE NAO DEVEM FUNCIONAR
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);

-- COMANDOS QUE DEVEM FUNCIONAR
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-02-07', 'Rejane Rodrigues', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1980-01-07', 'Arthur Lopes', 'LIMPEZA', 'J', '12345678913');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1980-12-07', 'Renildo Dantas', 'LIMPEZA', 'P', '12345678913');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1980-11-07', 'Karla Jarlita', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1980-10-07', 'Flávio Miguel', 'LIMPEZA', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1980-09-07', 'Antônio Lopes', 'LIMPEZA', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1980-08-07', 'Augusto César', 'LIMPEZA', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1980-07-07', 'Livia Andrade', 'LIMPEZA', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1980-05-07', 'Victoria Sabrina', 'LIMPEZA', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1980-06-07', 'Davi Figueredo', 'LIMPEZA', 'J', '12345678916');

-- COMANDOS QUE NAO DEVE FUNCIONAR
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1980-05-07', 'Antônio Lopes', 'LIMPEZA', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1980-05-07', 'Antônio Lopes', 'LIMPEZA', 'J', '12345678925');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678924', '1980-05-07', 'Antônio Lopes', 'LIMPEZA', 'A', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678925', '1980-05-07', 'Antônio Lopes', 'LIMPEZA_GERAL', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678926', '1980-05-07', 'Antônio Lopes', 'LOMPEZA', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1980-05-07', 'Antônio Lopes', 'LIMPEZA', 'K', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678927', '1980-05-07', 'Antônio Lopes', 'LIMPEZA', 'J', '12345678936');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678928', '1980-05-07', 'Antônio Lopes', 'LIMPEZAS', 'J', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1980-05-07', 'Antônio Lopes', 'LIMPEZA', 'R', '12345678916');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678930', '1980-05-07', 'Antônio Lopes', 'LIMPEZA', 'J', '12345678931');

-- QUESTAO 10

-- CRIANDO FOREIGN KEY
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1989-06-07', 'Jéssica Gabriele', 'LIMPEZA', 'J', '12345678913');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1998-07-09', 'João Lucas', 'LIMPEZA', 'J', '12345678913');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1988-04-03', 'Alice Moura', 'LIMPEZA', 'J', '12345678913');
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1988-04-03', 'Amanda Vitoria', 'LIMPEZA', 'J', '12345678913');

-- ADICIONANDO FOREIGN KEY
ALTER TABLE tarefas ADD CONSTRAINT chave_estrangeira FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;

-- QUESTAO 11

ALTER TABLE tarefas ADD CONSTRAINT func_resp_cpf CHECK ((status IS NOT NULL AND status = 'E') OR (status IS NOT NULL AND status = 'C') OR status = 'P');