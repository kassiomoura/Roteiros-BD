-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-04-29 21:22:57.411

-- tables
-- Table: joga
CREATE TABLE joga (
    jogador_cpf char(11)  NOT NULL,
    posicao varchar(20)  NOT NULL,
    partida_id_partida int  NOT NULL,
    CONSTRAINT joga_pk PRIMARY KEY (jogador_cpf,posicao,partida_id_partida)
);

-- Table: jogador
CREATE TABLE jogador (
    cpf char(11)  NOT NULL,
    p_nome varchar(15)  NOT NULL,
    u_nome varchar(50)  NOT NULL,
    id_time int  NOT NULL,
    CONSTRAINT jogador_pk PRIMARY KEY (cpf)
);

-- Table: participa
CREATE TABLE participa (
    time_id_time int  NOT NULL,
    partida_id_partida int  NOT NULL,
    CONSTRAINT participa_pk PRIMARY KEY (time_id_time,partida_id_partida)
);

-- Table: partida
CREATE TABLE partida (
    id_partida int  NOT NULL,
    time1 int  NOT NULL,
    time2 int  NOT NULL,
    time1_gols int  NOT NULL,
    time2_gols int  NOT NULL,
    CONSTRAINT partida_pk PRIMARY KEY (id_partida)
);

-- Table: time
CREATE TABLE time (
    id_time int  NOT NULL,
    nome varchar(50)  NOT NULL,
    CONSTRAINT time_pk PRIMARY KEY (id_time)
);

-- foreign keys
-- Reference: joga_jogador (table: joga)
ALTER TABLE joga ADD CONSTRAINT joga_jogador
    FOREIGN KEY (jogador_cpf)
    REFERENCES jogador (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: joga_partida (table: joga)
ALTER TABLE joga ADD CONSTRAINT joga_partida
    FOREIGN KEY (partida_id_partida)
    REFERENCES partida (id_partida)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: jogador_time (table: jogador)
ALTER TABLE jogador ADD CONSTRAINT jogador_time
    FOREIGN KEY (id_time)
    REFERENCES time (id_time)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: participa_partida (table: participa)
ALTER TABLE participa ADD CONSTRAINT participa_partida
    FOREIGN KEY (partida_id_partida)
    REFERENCES partida (id_partida)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: participa_time (table: participa)
ALTER TABLE participa ADD CONSTRAINT participa_time
    FOREIGN KEY (time_id_time)
    REFERENCES time (id_time)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

--POPULANDO O BANCO DE DADOS

-- Jogador 
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('00000000000', 'Diego', 'Alves', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('11111111111', 'Mauricio', 'Isla', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('22222222222', 'Felipe', 'Luiz', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('33333333333', 'Rodrigo', 'Caio', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('44444444444', 'Bruno', 'Viana', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('55555555555', 'Willian', 'Arão', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('66666666666', 'Gerson', 'Silva', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('77777777777', 'Victor', 'Santos', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('88888888888', 'De', 'Arrascaeta', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('99999999999', 'Bruno', 'Henrique', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678900', 'Pedro', 'Santos', 1);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678901', 'Gabriel', 'Barbosa', 1);

INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678902', 'Keylor', 'Navas', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678903', 'Colin', 'Dagba', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678904', 'Abdou', 'Diallo', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678905', 'Marcos', 'Corrêa', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678906', 'Presnel', 'Kimpembe', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678907', 'Danilo', 'Pereira', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678908', 'Idrissa', 'Gueye', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678909', 'Di', 'Maria', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678910', 'Julian', 'Draxler', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678911', 'Neymar', 'Junior', 2);
INSERT INTO jogador (cpf, p_nome, u_nome, id_time) VALUES ('12345678912', 'Kylian', 'Mbappe', 2);


-- Time
INSERT INTO time (id_time, nome) VALUES (1, 'Flamengo');
INSERT INTO time (id_time, nome) VALUES (2, 'PSG');

-- Partida
INSERT INTO partida (id_partida, time1, time2, time1_gols, time2_gols) VALUES (1, 1, 2, 0, 2);
INSERT INTO Partida (id_partida, time1, time2, time1_gols, time2_gols) VALUES (2, 1, 2, 2, 0);

-- Joga
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('00000000000', 'goleiro', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('11111111111', 'lateralD', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('22222222222', 'lateralE', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('44444444444', 'zagueiro', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('33333333333', 'zagueiro', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('55555555555', 'meia', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('66666666666', 'meia', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('77777777777', 'pontaD', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('88888888888', 'pontaE', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('99999999999', 'atacante', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678900', 'atacante', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678901', 'centro avante', 1);

INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678902', 'goleiro', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678903', 'lateralD', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678904', 'lateralE',  1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678905', 'zagueiro', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678906', 'zagueiro', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678907', 'meia', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678908', 'meia', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678909', 'pontaD', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678910', 'pontaE', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678911', 'centro avante', 1);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678912', 'atacante', 1);

INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('00000000000', 'goleiro', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('11111111111', 'lateralD', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('22222222222', 'lateralE', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('33333333333', 'zagueiro', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('44444444444', 'zagueiro', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('55555555555', 'meia', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('66666666666', 'meia', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('77777777777', 'pontaD', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('88888888888', 'pontaE', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('99999999999', 'atacante', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678900', 'atacante', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678901', 'centro avante', 2);

INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678902', 'goleiro', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678903', 'lateralD', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678904', 'lateralE',  2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678905', 'zagueiro', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678906', 'zagueiro', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678908', 'meia', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678907', 'meia', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678909', 'pontaD', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678910', 'pontaE', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678912', 'centro avante', 2);
INSERT INTO joga (jogador_cpf, posicao, partida_id_partida) VALUES ('12345678911', 'atacante', 2);

-- Participa
INSERT INTO participa (time_id_time, partida_id_partida) VALUES (1, 1);
INSERT INTO participa (time_id_time, partida_id_partida) VALUES (2, 1);

INSERT INTO participa (time_id_time, partida_id_partida) VALUES (1, 2);
INSERT INTO participa (time_id_time, partida_id_partida) VALUES (2, 2);

-- End of file.