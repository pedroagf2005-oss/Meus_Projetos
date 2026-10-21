--Vale lembrar que este arquivo contém meu projeto de uma oficina de carros baseados na magazine MYSQL
CREATE DATABASE db_oficina_Pedro
CREATE TABLE tb_sedes (
    id_sede INTEGER PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereço VARCHAR (100) NOT NULL,
    Telefone VARCHAR(14)NOT NULL,
    Nome_Gerente VARCHAR(100) NOT NULL,
    Multa DECIMAL(10,2) NOT NULL
);
CREATE TABLE tb_carros(
    id_carros INT(20) NOT NULL PRIMARY KEY,
    placa_carro VARCHAR(10) NOT NULL,
    Modelo_carro VARCHAR (50) NOT NULL,
    ano_carro VARCHAR (9) NOT NULL,
    cor_carro DECIMAL (10,2) NOT NULL,
    quilometragem DECIMAL(10,2) NOT NULL,
    descrição_carro VARCHAR(100) NOT NULL,
    local_carro INT (10) NOT NULL,
    classecarro INT(10) NOT NULL,
    situação_carro VARCHAR (30) NOT NULL,
    origem_carro INT(10) NOT NULL
    );
    CREATE TABLE tb_classes_carro(
    ID_classe INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_clase VARCHAR (50) NOT NULL,
    Valor_diária float(8,2) NOT NULL
    );
    CREATE TABLE tb_clientes(
        id_cliente INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(50) NOT NULL,
        CNH VARCHAR(50) NOT NULL,
        validade_cnh DATE NOT NULL,
        categoria_cnh VARCHAR (3) NOT NULL
    );
    CREATE TABLE tb_reservas(
    número_reservas INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    diárias int (10) NOT NULL,
    data_locação DATE NOT NULL,
    data_Retorno DATE,
    Quilometros_rodados FLOAT (8,2),
    Carro_reserva INT(10) NOT NULL,
    Cliente_reserva int(10) NOT NULL,
    sede_locação INT(10) NOT NULL,
     sede_devolução INT (10) NOT NULL
    )
