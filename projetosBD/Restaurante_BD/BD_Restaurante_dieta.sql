DROP DATABASE IF EXISTS db_drop_table_dieta;
CREATE DATABASE db_drop_table_dieta;
USE db_drop_table_dieta;

CREATE TABLE tb_categorias (
    cod_categoria INT NOT NULL PRIMARY KEY,
    nome_categoria VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE tb_fornecedores (
    cod_fornecedor INT NOT NULL PRIMARY KEY,
    nome_fornecedor VARCHAR(60) NOT NULL,
    cidade VARCHAR(40) NOT NULL
);

CREATE TABLE tb_funcionarios (
    cod_funcionario INT NOT NULL PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    cargo VARCHAR(40) NOT NULL,
    salario DECIMAL(10,2) NOT NULL CHECK (salario > 0)
);

CREATE TABLE tb_clientes (
    cod_cliente INT NOT NULL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('F','M'))
);

CREATE TABLE tb_produtos (
    cod_produto INT NOT NULL PRIMARY KEY,
    nome_produto VARCHAR(60) NOT NULL,
    preco DECIMAL(8,2) NOT NULL,
    cod_categoria INT NOT NULL,
    cod_fornecedor INT NOT NULL,
    FOREIGN KEY (cod_categoria) REFERENCES tb_categorias(cod_categoria),
    FOREIGN KEY (cod_fornecedor) REFERENCES tb_fornecedores(cod_fornecedor)
);

CREATE TABLE tb_estoque (
    cod_produto INT NOT NULL PRIMARY KEY,
    quantidade INT NOT NULL,
    ultima_contagem DATE,
    FOREIGN KEY (cod_produto) REFERENCES tb_produtos(cod_produto)
);

CREATE TABLE tb_pedidos (
    num_pedido INT NOT NULL PRIMARY KEY,
    data_pedido DATE NOT NULL,
    cod_cliente INT NOT NULL,
    cod_funcionario INT NOT NULL,
    FOREIGN KEY (cod_cliente) REFERENCES tb_clientes(cod_cliente),
    FOREIGN KEY (cod_funcionario) REFERENCES tb_funcionarios(cod_funcionario)
);

CREATE TABLE tb_itens_pedido (
    num_pedido INT NOT NULL,
    cod_produto INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (num_pedido, cod_produto),
    FOREIGN KEY (num_pedido) REFERENCES tb_pedidos(num_pedido),
    FOREIGN KEY (cod_produto) REFERENCES tb_produtos(cod_produto)
);

INSERT INTO tb_categorias VALUES
(1, 'Pizzas'),
(2, 'Lanches'),
(3, 'Combos'),
(4, 'Porcoes'),
(5, 'Bebidas'),
(6, 'Pratos do Chef');

INSERT INTO tb_fornecedores VALUES
(1, 'Distribuidora Farinha Fiada', 'Brasília'),
(2, 'Frigorífico Boi Nervoso', 'Goiânia'),
(3, 'Hortifruti Sem Troco', 'Taguatinga'),
(4, 'Bebidas Lágrima Viva', 'Brasília');

INSERT INTO tb_funcionarios VALUES
(1, 'Gabriel', 'Gerente', 3500.00),
(2, 'Pedro', 'Chef de cozinha', 2800.00),
(3, 'Guilherme', 'Garçom', 1900.00),
(4, 'Daniel', 'Caixa', 1800.00),
(5, 'Matheus', 'Estoquista', 2000.00);

INSERT INTO tb_clientes VALUES
(1, 'João Caloteiro', 'Brasília', 'M'),
(2, 'Carlos Sem Limites', 'Taguatinga', 'M'),
(3, 'Roberto Fome Zero', 'Brasília', 'M'),
(4, 'Cleiton do Pix', 'Ceilândia', 'M'),
(5, 'Marlene do Fiado', 'Taguatinga', 'F');

INSERT INTO tb_produtos VALUES
(1, 'Pizza do Desespero', 49.90, 1, 1),
(2, 'Hambúrguer do Pedro', 32.90, 2, 2),
(3, 'Combo do Gerente', 59.90, 3, 2),
(4, 'Batata da Discórdia', 18.90, 4, 3),
(5, 'Suco de Lágrimas', 9.90, 5, 4),
(6, 'Prato Misterioso do Chef', 39.90, 6, 3);

INSERT INTO tb_estoque VALUES
(1, 12, '2026-11-02'),
(2, 30, '2026-11-02'),
(3, 0, '2026-11-02'),
(4, 45, '2026-11-02'),
(5, 80, '2026-11-02'),
(6, 3, '2026-11-02');

INSERT INTO tb_pedidos VALUES
(1, '2026-11-02', 1, 3),
(2, '2026-11-02', 2, 3),
(3, '2026-11-03', 2, 3),
(4, '2026-11-03', 3, 4),
(5, '2026-11-04', 4, 3),
(6, '2026-11-05', 1, 4),
(7, '2026-11-06', 2, 3),
(8, '2026-11-06', 3, 3);

INSERT INTO tb_itens_pedido VALUES
(1, 1, 1),
(1, 5, 2),
(2, 3, 1),
(2, 4, 1),
(3, 2, 2),
(3, 5, 2),
(4, 6, 1),
(5, 1, 2),
(5, 4, 1),
(6, 5, 1),
(7, 3, 2),
(7, 2, 1),
(8, 1, 1),
(8, 6, 1),
(8, 5, 3);

-- BASICAS

SELECT * FROM tb_funcionarios ORDER BY nome ASC;

SELECT nome, cargo FROM tb_funcionarios WHERE salario > 2000;

SELECT nome_produto, preco FROM tb_produtos WHERE preco BETWEEN 10 AND 40;

SELECT nome FROM tb_clientes WHERE nome LIKE 'C%';

SELECT DISTINCT cidade FROM tb_clientes;

SELECT nome_produto AS "Produto", preco AS valor FROM tb_produtos ORDER BY preco DESC;

SELECT nome FROM tb_funcionarios WHERE cargo IN ('Garçom', 'Caixa');

-- INTERMEDIARIAS

SELECT AVG(salario) AS media_salarial FROM tb_funcionarios;

SELECT SUM(salario) AS folha_de_pagamento FROM tb_funcionarios;

SELECT MAX(preco) AS maior_preco, MIN(preco) AS menor_preco FROM tb_produtos;

SELECT cidade, COUNT(*) AS total_de_clientes
FROM tb_clientes
GROUP BY cidade;

SELECT cod_cliente, COUNT(*) AS total_de_pedidos
FROM tb_pedidos
GROUP BY cod_cliente
HAVING COUNT(*) > 1;

SELECT tb_produtos.nome_produto, tb_categorias.nome_categoria
FROM tb_produtos, tb_categorias
WHERE tb_produtos.cod_categoria = tb_categorias.cod_categoria;

SELECT tb_pedidos.num_pedido, tb_clientes.nome AS cliente, tb_funcionarios.nome AS atendente
FROM tb_pedidos
JOIN tb_clientes ON tb_pedidos.cod_cliente = tb_clientes.cod_cliente
JOIN tb_funcionarios ON tb_pedidos.cod_funcionario = tb_funcionarios.cod_funcionario
ORDER BY tb_pedidos.num_pedido;

-- AVANCADAS

SELECT tb_clientes.nome, SUM(tb_itens_pedido.quantidade * tb_produtos.preco) AS total_gasto
FROM tb_clientes
JOIN tb_pedidos ON tb_clientes.cod_cliente = tb_pedidos.cod_cliente
JOIN tb_itens_pedido ON tb_pedidos.num_pedido = tb_itens_pedido.num_pedido
JOIN tb_produtos ON tb_itens_pedido.cod_produto = tb_produtos.cod_produto
GROUP BY tb_clientes.nome
ORDER BY total_gasto DESC;

SELECT tb_produtos.nome_produto, SUM(tb_itens_pedido.quantidade) AS total_vendido
FROM tb_produtos
JOIN tb_itens_pedido ON tb_produtos.cod_produto = tb_itens_pedido.cod_produto
GROUP BY tb_produtos.nome_produto
ORDER BY total_vendido DESC;

SELECT tb_clientes.nome, COUNT(tb_pedidos.num_pedido) AS total_de_pedidos
FROM tb_clientes
LEFT JOIN tb_pedidos ON tb_clientes.cod_cliente = tb_pedidos.cod_cliente
GROUP BY tb_clientes.nome;

SELECT tb_produtos.nome_produto, tb_estoque.quantidade
FROM tb_produtos
JOIN tb_estoque ON tb_produtos.cod_produto = tb_estoque.cod_produto
WHERE tb_estoque.quantidade < 10;

SELECT nome_produto, preco
FROM tb_produtos
WHERE preco > (SELECT AVG(preco) FROM tb_produtos);

SELECT nome
FROM tb_clientes
WHERE cod_cliente NOT IN (SELECT cod_cliente FROM tb_pedidos);

DELIMITER $$
CREATE FUNCTION aumentoPreco(preco_atual DECIMAL(8,2))
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    RETURN preco_atual * 1.10;
END $$
DELIMITER ;

SELECT nome_produto, preco, aumentoPreco(preco) AS preco_com_aumento FROM tb_produtos;

DELIMITER $$
CREATE PROCEDURE InserirCliente(
    IN p_cod INT,
    IN p_nome VARCHAR(60),
    IN p_cidade VARCHAR(40),
    IN p_sexo CHAR(1)
)
BEGIN
    INSERT INTO tb_clientes (cod_cliente, nome, cidade, sexo)
    VALUES (p_cod, p_nome, p_cidade, p_sexo);
END $$
DELIMITER ;

CALL InserirCliente(6, 'Valdemar da Conta Aberta', 'Brasília', 'M');

SELECT * FROM tb_clientes;
