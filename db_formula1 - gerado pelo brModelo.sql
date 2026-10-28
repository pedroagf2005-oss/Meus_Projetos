CREATE TABLE tb_paises (
    cod_pais INT PRIMARY KEY,
    nome_pais VARCHAR(100) NOT NULL
);
CREATE TABLE tb_equipes (
    sigla VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cod_pais INT
);
CREATE TABLE tb_pilotos (
    numero_piloto INT PRIMARY KEY,
    nome_piloto VARCHAR(100) NOT NULL,
    cod_pais INT,
    sigla_equipe VARCHAR(10)
);
CREATE TABLE tb_corridas (
    sigla_gp VARCHAR(10) PRIMARY KEY,
    nome_gp VARCHAR(100) NOT NULL,
    cod_pais INT,
    qtd_voltas INT
);
CREATE TABLE tb_participantes (
    sigla_gp VARCHAR(10),
    numero_piloto INT,
    posicao_largada INT,
    PRIMARY KEY (sigla_gp, numero_piloto)
);
 
ALTER TABLE tb_equipes ADD CONSTRAINT FK_tb_equipes_2
    FOREIGN KEY (cod_pais)
    REFERENCES tb_paises (cod_pais);
 
ALTER TABLE tb_pilotos ADD CONSTRAINT FK_tb_pilotos_2
    FOREIGN KEY (cod_pais)
    REFERENCES tb_paises (cod_pais);
 
ALTER TABLE tb_pilotos ADD CONSTRAINT FK_tb_pilotos_3
    FOREIGN KEY (sigla_equipe)
    REFERENCES tb_equipes (sigla);
 
ALTER TABLE tb_corridas ADD CONSTRAINT FK_tb_corridas_2
    FOREIGN KEY (cod_pais)
    REFERENCES tb_paises (cod_pais);
 
ALTER TABLE tb_participantes ADD CONSTRAINT FK_tb_participantes_2
    FOREIGN KEY (sigla_gp)
    REFERENCES tb_corridas (sigla_gp);
 
ALTER TABLE tb_participantes ADD CONSTRAINT FK_tb_participantes_3
    FOREIGN KEY (numero_piloto)
    REFERENCES tb_pilotos (numero_piloto);
