CREATE DATABASE db_formula1;
USE db_formula1;


CREATE TABLE tb_paises (
    cod_pais INT PRIMARY KEY,
    nome_pais VARCHAR(100) NOT NULL
);

CREATE TABLE tb_equipes (
    sigla VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cod_pais INT,
    FOREIGN KEY (cod_pais) REFERENCES tb_paises(cod_pais)
);

CREATE TABLE tb_pilotos (
    numero_piloto INT PRIMARY KEY,
    nome_piloto VARCHAR(100) NOT NULL,
    cod_pais INT,
    sigla_equipe VARCHAR(10),
    FOREIGN KEY (cod_pais) REFERENCES tb_paises(cod_pais),
    FOREIGN KEY (sigla_equipe) REFERENCES tb_equipes(sigla)
);

CREATE TABLE tb_corridas (
    sigla_gp VARCHAR(10) PRIMARY KEY,
    nome_gp VARCHAR(100) NOT NULL,
    cod_pais INT,
    qtd_voltas INT,
    FOREIGN KEY (cod_pais) REFERENCES tb_paises(cod_pais)
);

CREATE TABLE tb_participantes (
    sigla_gp VARCHAR(10),
    numero_piloto INT,
    posicao_largada INT,
    PRIMARY KEY (sigla_gp, numero_piloto),
    FOREIGN KEY (sigla_gp) REFERENCES tb_corridas(sigla_gp),
    FOREIGN KEY (numero_piloto) REFERENCES tb_pilotos(numero_piloto)
);

INSERT INTO tb_paises (cod_pais, nome_pais) VALUES
(1, 'Brasil'),
(2, 'Itália'),
(3, 'França'),
(4, 'Estados Unidos'),
(5, 'Alemanha'),
(6, 'Mônaco');

INSERT INTO tb_equipes (sigla, nome, cod_pais) VALUES
('GAM', 'Gambiarra Racing', 1),
('FER', 'Ferrari', 2),
('ALP', 'Alpine', 3),
('HAS', 'Haas', 4),
('MER', 'Mercedes', 5);

INSERT INTO tb_pilotos (numero_piloto, nome_piloto, cod_pais, sigla_equipe) VALUES
(7, 'Gabriel Freio de Bicicleta', 1, 'GAM'),
(13, 'Daniel Cupim de Ferro', 1, 'GAM'),
(22, 'Matheus Sem Câmbio', 1, 'GAM'),
(33, 'Pedro Verstapobre', 1, 'GAM'),
(99, 'Guilherme Drift', 1, 'GAM'),
(5, 'Alberto Ascari', 2, 'FER'),
(21, 'Giancarlo Fisichella', 2, 'FER'),
(12, 'Kimi Antonelli', 2, 'MER'),
(10, 'Pierre Gasly', 3, 'ALP'),
(31, 'Esteban Ocon', 3, 'HAS'),
(16, 'Charles Leclerc', 6, 'FER'),
(27, 'Nico Hülkenberg', 5, 'HAS');

INSERT INTO tb_corridas (sigla_gp, nome_gp, cod_pais, qtd_voltas) VALUES
('BRA', 'GP do Brasil', 1, 71),
('ITA', 'GP da Itália', 2, 53),
('FRA', 'GP da França', 3, 53),
('EUA', 'GP dos Estados Unidos', 4, 56),
('MON', 'GP de Mônaco', 6, 78);

INSERT INTO tb_participantes (sigla_gp, numero_piloto, posicao_largada) VALUES
('BRA', 33, 1),
('BRA', 10, 2),
('BRA', 12, 3),
('BRA', 31, 4),
('BRA', 21, 5),
('BRA', 5, 6),
('BRA', 99, 7),
('BRA', 22, 8),
('BRA', 13, 9),
('BRA', 7, 10),
('ITA', 5, 1),
('ITA', 21, 2),
('ITA', 12, 3),
('ITA', 10, 4),
('ITA', 33, 5),
('ITA', 27, 6),
('MON', 10, 1),
('MON', 31, 2),
('MON', 12, 3),
('MON', 99, 4),
('MON', 7, 5),
('MON', 16, 6);

SELECT nome_pais FROM tb_paises WHERE nome_pais LIKE 'B%L';

SELECT nome_piloto FROM tb_pilotos WHERE cod_pais IN (1, 2, 3);

SELECT nome_piloto FROM tb_pilotos;

SELECT nome_gp AS "Grande Prêmio", qtd_voltas AS voltas FROM tb_corridas;

SELECT tb_pilotos.nome_piloto, tb_paises.nome_pais
FROM tb_pilotos, tb_paises
WHERE tb_pilotos.cod_pais = tb_paises.cod_pais;

ALTER TABLE tb_pilotos ADD salario DECIMAL(10,2);

UPDATE tb_pilotos SET salario = 1500.00 WHERE numero_piloto = 7;
UPDATE tb_pilotos SET salario = 1500.00 WHERE numero_piloto = 13;
UPDATE tb_pilotos SET salario = 50000.00 WHERE numero_piloto = 22;
UPDATE tb_pilotos SET salario = 100000.00 WHERE numero_piloto = 33;
UPDATE tb_pilotos SET salario = 75000.00 WHERE numero_piloto = 99;
UPDATE tb_pilotos SET salario = 120000.00 WHERE numero_piloto = 5;
UPDATE tb_pilotos SET salario = 80000.00 WHERE numero_piloto = 21;
UPDATE tb_pilotos SET salario = 70000.00 WHERE numero_piloto = 12;
UPDATE tb_pilotos SET salario = 95000.00 WHERE numero_piloto = 10;
UPDATE tb_pilotos SET salario = 90000.00 WHERE numero_piloto = 31;
UPDATE tb_pilotos SET salario = 110000.00 WHERE numero_piloto = 16;
UPDATE tb_pilotos SET salario = 85000.00 WHERE numero_piloto = 27;

SELECT nome_piloto, salario FROM tb_pilotos WHERE salario BETWEEN 70000 AND 100000;

SELECT cod_pais, ROUND(AVG(salario),2) AS media_salarial FROM tb_pilotos GROUP BY cod_pais;

SELECT DISTINCT salario FROM tb_pilotos ORDER BY salario ASC;
