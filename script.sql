-- Tables 

DROP TABLE endereco cascade constraint;
DROP TABLE HOTEL cascade constraint;
DROP TABLE cliente cascade constraint;
DROP TABLE quarto cascade constraint;
DROP TABLE servico cascade constraint;
DROP TABLE reserva cascade constraint;
DROP TABLE servico_reserva cascade constraint;
DROP TABLE cliente_removido cascade constraint;
DROP TABLE reserva_removida cascade constraint;
DROP TABLE reserva_alterada cascade constraint;

CREATE TABLE endereco (
    id_endereco integer,
    bairo varchar(20),
    rua varchar(20),
    cidade varchar (20),
    complimento varchar(20),
    numero integer,
    Primary key(id_endereco)
);


CREATE TABLE HOTEL (
    id_hotel integer,
    nome varchar(50),
    telefone varchar(20),
    endereco_id integer,
    Primary key (id_hotel),
    foreign key (endereco_id) References endereco (id_endereco)
);



CREATE TABLE cliente (
    id_cliente integer,
    nome varchar(20),
    telefone varchar(20),
    email varchar(40),
    endereco_id integer,
    rg varchar(20),
    primary key (id_cliente),
    foreign key (endereco_id) references endereco (id_endereco)
);



CREATE TABLE quarto (
    id_quarto integer,
    numero integer,
    hotel_id integer,
    disponivel integer,
    primary key (id_quarto),
    foreign key (hotel_id) references hotel (id_hotel)
);



CREATE TABLE servico (
    id_servico integer,
    tipo varchar(20),
    preco float,
    primary key (id_servico)
);



CREATE TABLE reserva (
    id_reserva integer,
    cliente_id integer,
    quarto_id integer,
    data_inicio date,
    data_fim date,
    preco float,
    primary key (id_reserva),
    foreign key (cliente_id) references cliente (id_cliente),
    foreign key (quarto_id) references quarto (id_quarto)
);

CREATE TABLE servico_reserva (
    servico_id INTEGER,
    reserva_id INTEGER,
    quantidade INTEGER,
    Primary key(servico_id,reserva_id),
    Foreign key (servico_id) references servico (id_servico),
    Foreign key (reserva_id) references reserva (id_reserva)
);

CREATE TABLE cliente_removido (
    id_cliente integer,
    nome varchar(20),
    telefone varchar(20),
    email varchar(20),
    endereco_id integer,
    rg varchar(10),
    primary key (id_cliente),
    foreign key (id_cliente) references cliente (id_cliente)
);



CREATE TABLE reserva_removida (
    id_reserva integer,
    data_remocao date,
    cliente_id integer,
    quarto_id integer,
    data_inicio date,
    data_fim date,
    preco float,
    primary key (id_reserva)
);



CREATE TABLE reserva_alterada (
    id_reserva integer,
    data_alteracao date,
    cliente_id integer,
    quarto_id_anterior integer,
    quarto_id_atual integer,
    primary key (id_reserva)    
);


-- SEQUENCES

DROP SEQUENCE seq_endereco;
DROP SEQUENCE seq_hotel;
DROP SEQUENCE seq_cliente;
DROP SEQUENCE seq_quarto;
DROP SEQUENCE seq_servico;
DROP SEQUENCE seq_reserva;
DROP SEQUENCE seq_cliente_removido;
DROP SEQUENCE seq_reserva_removida;
DROP SEQUENCE seq_reserva_alterada;

CREATE SEQUENCE seq_endereco START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_hotel START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cliente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_quarto START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_servico START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reserva START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cliente_removido START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reserva_removida START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reserva_alterada START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE trigger BI_ENDERECO
    BEFORE INSERT ON endereco
    FOR EACH ROW
BEGIN
    SELECT seq_endereco.nextval into :NEW.id_endereco from dual;
END;
\
CREATE OR REPLACE trigger BI_HOTEL
    BEFORE INSERT ON hotel
    FOR EACH ROW
BEGIN
    SELECT seq_hotel.nextval into :NEW.id_hotel from dual;
END;
\
CREATE OR REPLACE trigger BI_CLIENTE
    BEFORE INSERT ON cliente
    FOR EACH ROW
BEGIN
    SELECT seq_cliente.nextval into :NEW.id_cliente from dual;
END;
\
CREATE OR REPLACE trigger BI_QUARTO
    BEFORE INSERT ON quarto
    FOR EACH ROW
BEGIN
    SELECT seq_quarto.nextval into :NEW.id_quarto from dual;
END;
\
CREATE OR REPLACE trigger BI_SERVICO
    BEFORE INSERT ON servico
    FOR EACH ROW
BEGIN
    SELECT seq_servico.nextval into :NEW.id_servico from dual;
END;
\
CREATE OR REPLACE trigger BI_RESERVA
    BEFORE INSERT ON reserva
    FOR EACH ROW
BEGIN
    SELECT seq_reserva.nextval into :NEW.id_reserva from dual;
END;
\
CREATE OR REPLACE trigger BI_CLIENTE_REMOVIDO
    BEFORE INSERT ON cliente_removido
    FOR EACH ROW
BEGIN
    SELECT seq_cliente_removido.nextval into :NEW.id_cliente from dual;
END;
\
CREATE OR REPLACE trigger BI_RESERVA_REMOVIDA
    BEFORE INSERT ON reserva_removida
    FOR EACH ROW
BEGIN
    SELECT seq_reserva_removida.nextval into :NEW.id_reserva from dual;
END;
\
CREATE OR REPLACE trigger BI_RESERVA_ALTERADA
    BEFORE INSERT ON reserva_alterada
    FOR EACH ROW
BEGIN
    SELECT seq_reserva_alterada.nextval into :NEW.id_reserva from dual;
END;


