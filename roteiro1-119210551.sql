--BANCO DE DADOS I - ROTEIRO 1
--ALUNO: Kássio Augusto de Moura Silva - MATRICULA: 119210551

--
--QUEST 1 E QUEST 2
--
CREATE TABLE automovel(
	placa VARCHAR(7),
	ano INTEGER,
	marca VARCHAR(15),
	modelo VARCHAR(15)
);

CREATE TABLE segurado(
	cpf VARCHAR(11),
	nome TEXT, 
	telefone VARCHAR(11), 
	endereco TEXT
);

CREATE TABLE perito(
	cpf VARCHAR(11), 
	nome TEXT, 
	telefone VARCHAR(11)
);

CREATE TABLE oficina(
	nome TEXT, 
	telefone VARCHAR(11), 
	endereco TEXT, 
	cnpj INTEGER
);

CREATE TABLE seguro(
	valor NUMERIC,
	automovel_placa VARCHAR(7),
	cpf_segurado VARCHAR(11),
	id_seguro INTEGER
);

CREATE TABLE sinistro(
	automovel_placa VARCHAR(7),
	cpf_segurado VARCHAR(11),
	cpf_perito VARCHAR(11),
	descricao TEXT,
	id_sinistro INTEGER
);

CREATE TABLE pericia(
	laudo TEXT,
	id_sinistro INTEGER,
	id_pericia INTEGER
);

CREATE TABLE reparo(
	cnpj INTEGER,
	id_pericia INTEGER,
	id_reparo INTEGER,
	custo NUMERIC
);

--
--QUEST 3
--
ALTER TABLE automovel ADD PRIMARY KEY (placa);
ALTER TABLE segurado ADD PRIMARY KEY (cpf);
ALTER TABLE perito ADD PRIMARY KEY (cpf);
ALTER TABLE oficina ADD PRIMARY KEY (cnpj);
ALTER TABLE seguro ADD PRIMARY KEY (id_seguro);
ALTER TABLE sinistro ADD PRIMARY KEY (id_sinistro);
ALTER TABLE pericia ADD PRIMARY KEY (id_pericia);
ALTER TABLE reparo ADD PRIMARY KEY (id_reparo);

--
--QUEST 4 e QUEST 5
--
ALTER TABLE seguro ADD CONSTRAINT cpf_segurado_fkey FOREIGN KEY (cpf_segurado) REFERENCES segurado (cpf);
ALTER TABLE sinistro ADD CONSTRAINT cpf_segurado_fkey FOREIGN KEY (cpf_segurado) REFERENCES segurado (cpf);
ALTER TABLE sinistro ADD CONSTRAINT cpf_perito_fkey FOREIGN KEY (cpf_perito) REFERENCES perito (cpf);
ALTER TABLE pericia ADD CONSTRAINT id_sinistro_fkey FOREIGN KEY (id_sinistro) REFERENCES sinistro (id_sinistro);
ALTER TABLE reparo ADD CONSTRAINT reparo_id_pericia_fkey FOREIGN KEY (id_pericia) REFERENCES pericia (id_pericia);

--
--QUEST 6
--
DROP TABLE automovel;
DROP TABLE reparo;
DROP TABLE pericia;
DROP TABLE seguro;
DROP TABLE sinistro;
DROP TABLE segurado;
DROP TABLE oficina;
DROP TABLE perito;

--
--QUEST 7 e QUEST 8
--
CREATE TABLE automovel(
	placa VARCHAR(7) PRIMARY KEY, 
	ano INTEGER, 
	marca VARCHAR(15) NOT NULL, 
	modelo VARCHAR(15) NOT NULL
);

CREATE TABLE segurado(
	cpf VARCHAR(11) CONSTRAINT segurado_pkey PRIMARY KEY,
	nome TEXT NOT NULL,
	telefone VARCHAR(11),
	automovel_placa VARCHAR(15) REFERENCES automovel (placa),
	endereco TEXT
);

CREATE TABLE perito(
	cpf VARCHAR(11) PRIMARY KEY,
	nome TEXT,
	telefone VARCHAR(11) NOT NULL
);

CREATE TABLE oficina(
	nome TEXT Not NULL,
	telefone VARCHAR(11),
	endereco TEXT,
	id_oficina INTEGER CONSTRAINT oficina_pkey PRIMARY KEY
);

CREATE TABLE seguro(
	valor NUMERIC,
	automovel_placa VARCHAR(7) REFERENCES automovel (placa),
	cpf_segurado VARCHAR(11) REFERENCES segurado (cpf),
	descricao TEXT NOT NULL,
	id_seguro INTEGER PRIMARY KEY
);

CREATE TABLE sinistro(
	data DATE,
	automovel_placa VARCHAR(7) REFERENCES automovel (placa),
	cpf_segurado VARCHAR(11) REFERENCES segurado (cpf),
	cpf_perito VARCHAR(11) REFERENCES perito (cpf),
	descricao TEXT,
	id_sinistro INTEGER CONSTRAINT sinistro_pkey PRIMARY KEY
);

CREATE TABLE pericia(
	laudo TEXT NOT NULL,
	id_sinistro INTEGER REFERENCES sinistro (id_sinistro),
	id_pericia INTEGER PRIMARY KEY
);

CREATE TABLE reparo(
	id_oficina INTEGER REFERENCES oficina (id_oficina),
	id_pericia INTEGER REFERENCES pericia (id_pericia),
	id_reparo INTEGER CONSTRAINT reparo_pkey PRIMARY KEY,
	custo_adicional NUMERIC NOT NULL
);

--
--QUEST 9 
--
DROP TABLE reparo;
DROP TABLE seguro;
DROP TABLE pericia;
DROP TABLE oficina;
DROP TABLE sinistro;
DROP TABLE segurado;
DROP TABLE automovel;
DROP TABLE perito;

