-- Tables 

REATE TABLE endereco (
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
