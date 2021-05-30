--BANCO DE DADOS I - ROTEIRO 3
--ALUNO: Kássio Augusto de Moura Silva - MATRICULA: 119210551

-- ESTADOS DO BRASIL
CREATE TYPE estado AS ENUM ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO');

-- A FARMACIAS PODE SER SEDE (S) OU FILIAL (F)
CREATE TABLE farmacia (
	id INTEGER PRIMARY KEY,
	bairro VARCHAR(30) UNIQUE,
	cidade VARCHAR(30),
	current_estado estado,
	tipo CHAR(1),
	CHECK (tipo = 'S' OR tipo = 'F')
);

-- A FARMACIA SÓ PODE TER UMA SEDE
ALTER TABLE farmacia ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'S');

-- UM FUNCIONARIO PODE NAO ESTAR LOTADO EM NENHUMA FARMACIA
CREATE TABLE funcionario (
	cpf CHAR(11) PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	tipo CHAR(1),
	CHECK (tipo = 'F' OR tipo = 'V' OR tipo = 'E' OR tipo = 'C' OR tipo = 'A')
);

-- CADA FUNCIONARIO PODE ESTAR LOTADO EM UMA UNICA FARMACIA
CREATE TABLE funcionario_farmacia(
	cpf_funcionario CHAR(11) REFERENCES funcionario(cpf) UNIQUE,
	id_farm INTEGER REFERENCES farmacia(id)
);

-- AS FARMACIAS DEVEM POSSUIR APENAS UM GERENTE
-- OS GERENTES DEVEM SER APENAS FARMACEUTICOS OU ADMINISTRADORES
CREATE TABLE gerente_farmacia (
	cpf_gerente CHAR(11) REFERENCES funcionario(cpf),
	id_farmacia INTEGER REFERENCES farmacia(id) UNIQUE,
	tipo_gerente CHAR(1),
	CHECK (tipo_gerente = 'F' OR tipo_gerente = 'A')
);

-- OS CLIENTES DEVEM SER MAIORES DE IDADE
CREATE TABLE cliente (
	cpf CHAR(11) PRIMARY KEY,
	nome VARCHAR (50),
	telefone CHAR(11),
	nascimendo DATE,
	CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, nascimendo)) > 17)
);

-- CADA CLIENTE PODE TER MAIS DE UM ENDERECO
CREATE TABLE endereco_cliente (
	codigo INTEGER PRIMARY KEY,
	cpf_cliente CHAR(11) REFERENCES cliente(cpf),
	endereco VARCHAR (100),
	tipo CHAR(1),
	CHECK (tipo = 'R' OR tipo = 'T' OR tipo = 'O')
);

-- EXISTEM MEDICAMENTOS QUE SAO VENDIDOS APENAS COM RECEITA
CREATE TABLE medicamento (
	somente_com_receita BOOLEAN,
	nome VARCHAR(50) NOT NULL,
	codigo INTEGER PRIMARY KEY,
	preco NUMERIC NOT NULL
);

-- APENAS FUNCIONARIOS VENDEDORES PODEM EFETUAR VENDAS
CREATE TABLE venda (
	codigo INTEGER PRIMARY KEY,
	id_farm INTEGER REFERENCES farmacia(id) NOT NULL,
	cpf_func CHAR(11) REFERENCES funcionario(cpf) ON DELETE RESTRICT,
	cpf_cliente CHAR(11) REFERENCES cliente(cpf),
	tipo_func CHAR(1),
	CHECK (tipo_func = 'V')
);

-- QUAIS MEDICAMENTOS ESTAO ASSOCIADOS A CADA VENDA
-- SE EH UM MEDICAMENTO QUE PRECISA DE RECEITA O CLIENTE DEVE ESTAR CADASTRADO
CREATE TABLE venda_medicamento (
	codigo INTEGER REFERENCES venda(codigo),
	cod_med INTEGER REFERENCES medicamento(codigo) ON DELETE RESTRICT,
	cpf_cliente CHAR(11) REFERENCES cliente(cpf),
	somente_com_receita BOOLEAN,
	CHECK (somente_com_receita = 'false' OR (somente_com_receita = 'true' AND cpf_cliente IS NOT NULL))
);

-- UMA ENTREGA SO PODE SER FEITA A UM CLIENTE CADASTRADO E COM ENDERECO CADASTRADO
CREATE TABLE entrega (
	num_entrega INTEGER PRIMARY KEY NOT NULL,
	endereco_cliente INTEGER REFERENCES endereco_cliente(codigo) NOT NULL,
	cod_venda INTEGER REFERENCES venda(codigo) NOT NULL
);


-- COMANDOS QUE DEVEM FUNCIONAR
INSERT INTO farmacia (id, bairro, cidade, current_estado, tipo) VALUES (1, 'Catolé', 'Campina Grande', 'PB', 'S');
INSERT INTO farmacia (id, bairro, cidade, current_estado, tipo) VALUES (2, 'Pina', 'Recife', 'PE', 'F');
INSERT INTO funcionario (cpf, nome, tipo) VALUES ('14525873601', 'Geandro da Silva', 'F');
INSERT INTO funcionario (cpf, nome, tipo) VALUES ('45862473019', 'Maria José', 'A');
INSERT INTO gerente_farmacia (cpf_gerente, id_farmacia, tipo_gerente) VALUES ('45862473019', 1, 'A');
INSERT INTO gerente_farmacia (cpf_gerente, id_farmacia, tipo_gerente) VALUES ('14525873601', 2, 'F');

-- COMANDOS QUE NÃO DEVEM FUNCIONAR
INSERT INTO farmacia (id, bairro, cidade, current_estado, tipo) VALUES (1, 'Catolé', 'Campina Grande', 'PB', 'S');
INSERT INTO farmacia (id, bairro, cidade, current_estado, tipo) VALUES (2, 'Catolé', 'Campina Grande', 'PB', 'F');
INSERT INTO farmacia (id, bairro, cidade, current_estado, tipo) VALUES (2, 'Malvinas', 'Campina Grande', 'PB', 'S');
INSERT INTO farmacia (id, bairro, cidade, current_estado, tipo) VALUES (2, 'Catolé', 'Campina Grande', 'PB', 'D');
INSERT INTO funcionario (cpf, nome, tipo) VALUES ('36521470891', 'José Agostinho', 'B');
INSERT INTO gerente_farmacia (cpf_gerente, id_farmacia, tipo_gerente) VALUES ('54103789260', 1, 'F');
