-- TABELAS 

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
    foreign key (cliente_id) references cliente (id_cliente)
    ON DELETE CASCADE ,
    foreign key (quarto_id) references quarto (id_quarto)
);

CREATE TABLE servico_reserva (
    servico_id INTEGER,
    reserva_id INTEGER,
    quantidade INTEGER,
    Primary key(servico_id,reserva_id),
    Foreign key (servico_id) references servico (id_servico),
    Foreign key (reserva_id) references reserva (id_reserva) ON DELETE CASCADE
);

CREATE TABLE cliente_removido (
    id_cliente integer,
    nome varchar(20),
    telefone varchar(20),
    email varchar(20),
    endereco_id integer,
    rg varchar(20),
    data_remocao date,
    primary key (id_cliente)
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


-- SQUENCIAS

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
/
CREATE OR REPLACE trigger BI_HOTEL
    BEFORE INSERT ON hotel
    FOR EACH ROW
BEGIN
    SELECT seq_hotel.nextval into :NEW.id_hotel from dual;
END;
/
CREATE OR REPLACE trigger BI_CLIENTE
    BEFORE INSERT ON cliente
    FOR EACH ROW
BEGIN
    SELECT seq_cliente.nextval into :NEW.id_cliente from dual;
END;
/
CREATE OR REPLACE trigger BI_QUARTO
    BEFORE INSERT ON quarto
    FOR EACH ROW
BEGIN
    SELECT seq_quarto.nextval into :NEW.id_quarto from dual;
END;
/
CREATE OR REPLACE trigger BI_SERVICO
    BEFORE INSERT ON servico
    FOR EACH ROW
BEGIN
    SELECT seq_servico.nextval into :NEW.id_servico from dual;
END;
/
CREATE OR REPLACE trigger BI_RESERVA
    BEFORE INSERT ON reserva
    FOR EACH ROW
BEGIN
    SELECT seq_reserva.nextval into :NEW.id_reserva from dual;
END;
/
CREATE OR REPLACE trigger BI_CLIENTE_REMOVIDO
    BEFORE INSERT ON cliente_removido
    FOR EACH ROW
BEGIN
    SELECT seq_cliente_removido.nextval into :NEW.id_cliente from dual;
END;
/
CREATE OR REPLACE trigger BI_RESERVA_REMOVIDA
    BEFORE INSERT ON reserva_removida
    FOR EACH ROW
BEGIN
    SELECT seq_reserva_removida.nextval into :NEW.id_reserva from dual;
END;
/
CREATE OR REPLACE trigger BI_RESERVA_ALTERADA
    BEFORE INSERT ON reserva_alterada
    FOR EACH ROW
BEGIN
    SELECT seq_reserva_alterada.nextval into :NEW.id_reserva from dual;
END;

/
-- INSERIR DADOS


-- Enderecos

INSERT INTO endereco(rua,bairo,cidade,complimento,numero) VALUES('Rua De Consolação','Consolação','São Paulo',null,930);
INSERT INTO endereco(rua,bairo,cidade,complimento,numero) VALUES('Rua Maria Antonio','Consolação','São Paulo',null,123);
INSERT INTO endereco(rua,bairo,cidade,complimento,numero) VALUES('Rua Benedito','Jardim Guapira','São Paulo','Casa',154);
INSERT INTO endereco(rua,bairo,cidade,complimento,numero) VALUES('Rua Verona','Jardim Leonor','São Paulo','Casa',132);
INSERT INTO endereco(rua,bairo,cidade,complimento,numero) VALUES('Rua Aragão','Mazzei','São Paulo','Casa',84);

-- Hoteis

INSERT INTO hotel(nome,telefone,endereco_id) VALUES('Mackenzie','(11) 12345-1234',1);
INSERT INTO hotel(nome,telefone,endereco_id) VALUES('SP Resort','(11) 12345-1234',4);

-- Clientes

INSERT INTO cliente(nome,telefone,email,endereco_id,rg) VALUES('Joao Pedro','(11) 12312-1232','joao@hotmail.com',3,'12.123.123-1');
INSERT INTO cliente(nome,telefone,email,endereco_id,rg) VALUES('Carol Mendes','(11) 53123-5412','carol@hotmail.com',2,'32.142.412-2');
INSERT INTO cliente(nome,telefone,email,endereco_id,rg) VALUES('Daniela Barbosa','(11) 41231-1532','daniela@hotmail.com',5,'45.123.521-3');

-- Quartos 

INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(101,1,1);
INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(201,1,0);
INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(301,1,0);
INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(401,1,0);

INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(1000,2,0);
INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(2000,2,0);
INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(3000,2,0);
INSERT INTO quarto(numero,hotel_id,disponivel) VALUES(4000,2,1);


-- Serviços

INSERT INTO servico(tipo,preco) VALUES('Limpesa',20);
INSERT INTO servico(tipo,preco) VALUES('Almoço',100);
INSERT INTO servico(tipo,preco) VALUES('Janta',150);

INSERT INTO servico(tipo,preco) VALUES('SPA',2000);
INSERT INTO servico(tipo,preco) VALUES('Sauna',1500);
INSERT INTO servico(tipo,preco) VALUES('jacuzzi',3000);

-- Reservas

INSERT INTO reserva(cliente_id,quarto_id,data_inicio,data_fim,preco)
    VALUES(1,1,TO_DATE('2017/11/03', 'yyyy/mm/dd'),TO_DATE('2017/11/06', 'yyyy/mm/dd'),320);

INSERT INTO reserva(cliente_id,quarto_id,data_inicio,data_fim,preco)
    VALUES(3,8,TO_DATE('2017/11/05', 'yyyy/mm/dd'),TO_DATE('2017/11/07', 'yyyy/mm/dd'),1430);

-- Servico_reserva

INSERT INTO servico_reserva(servico_id,reserva_id,quantidade) VALUES(2,1,3);

INSERT INTO servico_reserva(servico_id,reserva_id,quantidade) VALUES(6,2,2);
INSERT INTO servico_reserva(servico_id,reserva_id,quantidade) VALUES(5,2,3);


-- Mostrar Dados

SELECT * FROM endereco;
SELECT * FROM hotel;
SELECT * FROM cliente;
SELECT * FROM quarto;
SELECT * FROM servico;
SELECT * FROM reserva;
SELECT * FROM servico_reserva;


-- Mostrar Sequencias

SELECT * FROM user_sequences;

-- ETAPA 2

-- Procedure para aumentar o preco das reservas que tem contratado um servico especifico de um certo Hotel
DROP PROCEDURE aumenta_preco_reservas;
CREATE OR REPLACE PROCEDURE aumenta_preco_reservas
(
    nomeHotel IN VARCHAR,
    nomeServico IN VARCHAR,
    percentual IN INTEGER
)
IS
    hotelID INTEGER;
    servicoID INTEGER;
BEGIN
    SELECT id_hotel INTO hotelID
    FROM hotel
    WHERE ( nome = nomeHotel);
    
    SELECT id_servico INTO servicoID
    FROM servico
    WHERE tipo = nomeServico;
    
    UPDATE reserva
    SET preco = preco * ( 1 + percentual/100 )
    WHERE id_reserva IN ( SELECT reserva_id FROM servico_reserva
                          WHERE servico_id = servicoID );
    
END aumenta_preco_reservas;
/
-- Execução 
-- Aumentar 20 % o peço das reservas do Hotel Mackenzie que tem contratado o serviço almoço.

SELECT * FROM servico;
SELECT * FROM reserva;
SELECT * FROM servico_reserva;
execute aumenta_preco_reservas ('Mackenzie','Almoço',20);
SELECT * FROM reserva;


-- ETAPA 3 

-- Funcao para retornar o preco total dos servicos contratados

DROP FUNCTION total_servicos;

CREATE OR REPLACE FUNCTION total_servicos
(
    reservaID IN INTEGER,
    servicoNome IN VARCHAR
)
RETURN FLOAT
IS
    servicoID INTEGER;
    total FLOAT;
BEGIN
    SELECT id_servico INTO servicoID
    FROM servico 
    WHERE tipo = servicoNome;
    
    SELECT SUM(sr.quantidade * s.preco) INTO total
    FROM servico_reserva sr
    INNER JOIN servico s
    ON s.id_servico = sr.servico_id
    WHERE (sr.reserva_id = reservaID) AND (s.id_servico = servicoID);

    RETURN total;  
END total_servicos;
/
SELECT * FROM servico;
SELECT * FROM servico_reserva;
SELECT total_servicos(1,'Almoço') FROM dual;

-- Funcao para retornar o numero do quarto reservado por um certo cliente em um certo hotel

DROP FUNCTION dono_quarto;

CREATE OR REPLACE FUNCTION dono_quarto(
    nomeHotel IN VARCHAR,
    nomeCliente IN VARCHAR
)
RETURN INTEGER
IS 
    hotelID INTEGER;
    clienteID INTEGER;
    numeroQuarto INTEGER;
BEGIN
   
    SELECT id_cliente INTO clienteID
    FROM cliente 
    WHERE nome = nomeCliente;

    SELECT id_hotel INTO hotelID
    FROM hotel
    WHERE nome = nomeHotel;

    SELECT q.numero INTO numeroQuarto
    FROM quarto q
    INNER JOIN reserva r 
    ON q.id_quarto = r.id_reserva
    WHERE q.hotel_id = hotelID AND r.cliente_id = clienteID;

    return numeroQuarto;

END dono_quarto;
/
-- Execução 

SELECT dono_quarto('Mackenzie','Joao Pedro') FROM DUAL;


-- ETAPA 4 Trigger Na Insercao, alteracao ou remocao de reserva

DROP TRIGGER controle_reserva;

CREATE OR REPLACE TRIGGER controle_reserva
AFTER
INSERT OR DELETE OR UPDATE OF quarto_id
ON reserva
FOR EACH ROW
BEGIN
        
    IF inserting THEN
        UPDATE quarto
        SET disponivel = 1
        WHERE id_quarto = :NEW.quarto_id;
    ELSIF deleting THEN
        INSERT INTO reserva_removida (data_remocao,cliente_id,quarto_id,data_inicio,data_fim,preco)
            VALUES(sysdate,:OLD.cliente_id,:OLD.quarto_id,:OLD.data_inicio,:OLD.data_fim,:OLD.preco);
        UPDATE quarto
        SET disponivel = 0
        WHERE id_quarto = :OLD.quarto_id;
    ELSIF updating THEN
        INSERT INTO reserva_alterada (id_reserva,data_alteracao,cliente_id,quarto_id_anterior,quarto_id_atual)
            VALUES(:OLD.id_reserva,sysdate,:OLD.cliente_id,:OLD.quarto_id,:NEW.quarto_id);
        UPDATE quarto
        SET disponivel = 0 
        WHERE id_quarto = :OLD.quarto_id;
        UPDATE quarto
        SET disponivel = 1 
        WHERE id_quarto = :NEW.quarto_id;
    END IF;
END;
/
-- Adicionar uma reserva e trocar a disponibilidade do quarto pelo o trigger
SELECT * FROM quarto;
INSERT INTO reserva(cliente_id,quarto_id,data_inicio,data_fim,preco)  VALUES(1,2,TO_DATE('2017/11/03', 'yyyy/mm/dd'),TO_DATE('2017/11/06', 'yyyy/mm/dd'),320);
SELECT * FROM quarto;



-- Remover uma reserva, e adicionar a reserva removida para uma nova tabela como tambem trocar a disponibilidade do quarto
SELECT * FROM reserva_removida;
SELECT * FROM quarto;
DELETE FROM reserva WHERE id_reserva = 2;
SELECT * FROM quarto;
SELECT * FROM reserva_removida;
SELECT * FROM quarto;


-- Trocar o quarto de uma reserva, e o trigger ira trocar a disponibilidade do quarto novo como o quarto anterior, e tambem registrar essa alteracao.

SELECT * FROM quarto;
SELECT * FROM reserva;
SELECT * FROM reserva_alterada;
UPDATE reserva SET quarto_id = 3 WHERE id_reserva = 1;
SELECT * FROM quarto;
SELECT * FROM reserva;
SELECT * FROM reserva_alterada;

-- Trigger para adicionar um cliente removido para a tabela cliente_removido.

DROP TRIGGER controle_cliente;

CREATE OR REPLACE TRIGGER controle_cliente 
BEFORE
DELETE
ON cliente
FOR EACH ROW
DECLARE
    quartoID INTEGER;
    dataInicio DATE;
    dataFim DATE;
    precoReserva FLOAT;
BEGIN
      INSERT INTO cliente_removido ( nome , telefone , email , rg ,endereco_id, data_remocao ) 
        VALUES(:OLD.nome,:OLD.telefone,:OLD.email,:OLD.rg,:OLD.endereco_id,sysdate);

END;    
/


SELECT * FROM cliente_removido;
SELECT * FROM cliente;

DELETE FROM cliente WHERE id_cliente = 1;

SELECT * FROM cliente_removido;
SELECT * FROM cliente;
