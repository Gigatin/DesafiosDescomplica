-- Criação do banco de dados Descomplica
CREATE DATABASE Descomplica;

-- Utiliza o banco de dados Descomplica
USE Descomplica;

-- Remove a tabela dept1 se existir
DROP TABLE IF EXISTS dept1;

-- Cria a tabela dept1
CREATE TABLE dept1 (
    deptno INT PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(20)
);

-- Exibe os dados da tabela dept1 (vazia neste momento)
SELECT * FROM dept1;

-- Insere dados na tabela dept1
INSERT INTO dept1 (deptno, dname, loc)
VALUES
    (1, 'comercial', 'SP'),
    (2, 'financeiro', 'RJ'),
    (3, 'comercial', 'MG'),
    (4, 'gerencia', 'SP');

-- Confirma a transação
COMMIT;

-- Exibe os dados da tabela dept1 após a inserção
SELECT * FROM dept1;

-- Criação da tabela dias_semana
CREATE TABLE dias_semana (
    id INT,
    day VARCHAR(10),
    dia VARCHAR(10)
);

-- Insere dados na tabela dias_semana
INSERT INTO dias_semana (id, day, dia)
VALUES
    (1, 'sun', 'domingo'),
    (2, 'mon', 'segunda'),
    (3, 'tue', 'terca'),
    (4, 'wed', 'quarta'),
    (5, 'thu', 'quinta'),
    (6, 'fri', 'sexta'),
    (7, 'sat', 'sabado');

-- Exibe dados da tabela dual (não usada neste contexto)
SELECT * FROM dual;

-- Exibe os dados da tabela dias_semana
SELECT * FROM dias_semana;

-- Exibe os dados da tabela dept1
SELECT * FROM dept1;

-- Criação da tabela dept2 a partir de dept1
CREATE TABLE dept2 AS SELECT * FROM dept1;

-- Exibe os dados da tabela dept2
SELECT * FROM dept2;

-- Insere dados em dept2 a partir de dept1
INSERT INTO dept2 (SELECT * FROM dept1);

-- Exibe os dados da tabela dept2 após a inserção
SELECT * FROM dept2;

-- Exibe os dados da tabela dias_semana
SELECT * FROM dias_semana;

-- Criação da tabela dest_tab1
CREATE TABLE dest_tab1 (
    id INT,
    description VARCHAR(30)
);

-- Criação da tabela dest_tab2
CREATE TABLE dest_tab2 (
    id INT,
    description VARCHAR(30)
);

-- Criação da tabela dest_tab3
CREATE TABLE dest_tab3 (
    id INT,
    description VARCHAR(30)
);

-- Insere dados em dest_tab1 baseados em dias_semana
INSERT INTO dest_tab1 (id, description)
SELECT
    CASE
        WHEN id <= 2 THEN id
        WHEN id > 4 THEN id
    END,
    day
FROM dias_semana;

-- Exibe a coluna 'id' de dest_tab1
SELECT id FROM dest_tab1;

-- Insere dados em dest_tab2 baseados em dias_semana
INSERT INTO dest_tab2 (id, description)
SELECT
    CASE
        WHEN id <= 2 THEN id
    END,
    dia
FROM dias_semana;

-- Insere dados em dest_tab3 baseados em dias_semana
INSERT INTO dest_tab3 (id, description)
SELECT
    CASE
        WHEN id > 4 THEN id
    END,
    dia
FROM dias_semana;

-- Exibe os dados de dest_tab2
SELECT * FROM dest_tab2;

-- Exibe os dados de dest_tab3
SELECT * FROM dest_tab3;

-- Remove a tabela sexo_externa se existir
DROP TABLE IF EXISTS sexo_externa;

-- Criação da tabela sexo_externa
CREATE TABLE sexo_externa (
    ID INT,
    NOME VARCHAR(50),
    sexo VARCHAR(50)
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4;

-- Carrega dados do arquivo CSV para a tabela sexo_externa
LOAD DATA INFILE 'CaminhoDoComputador/sexo.csv'
INTO TABLE sexo_externa
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Cria a tabela sexo_load a partir de sexo_externa
CREATE TABLE sexo_load AS SELECT * FROM sexo_externa;

-- Exibe os dados da tabela sexo_load
SELECT * FROM sexo_load;

-- Exibe os valores distintos da coluna 'sexo' ordenados
SELECT DISTINCT sexo FROM sexo_load ORDER BY sexo;

-- Atualiza valores da coluna 'sexo' para 'F' em sexo_load
UPDATE sexo_load
SET sexo = 'F'
WHERE sexo IN ('feminino', 'Feminino', 'f', 'fem', 'Fem');

-- Atualiza valores da coluna 'sexo' para 'M' em sexo_load
UPDATE sexo_load
SET sexo = 'M'
WHERE sexo IN ('masculino', 'masc', 'homem');

-- Exclui registros com 'indefinido' e 'outros' em sexo_load
DELETE FROM sexo_load
WHERE sexo IN ('indefinido', 'outros');

-- Exibe os dados da tabela sexo_externa
SELECT * FROM sexo_externa;

-- Conta o número de ocorrências de cada valor em sexo_load com rollup
SELECT sexo, COUNT(sexo)
FROM sexo_load
GROUP BY sexo WITH ROLLUP;

-- Calcula a porcentagem do sexo feminino em sexo_load
SELECT CONCAT(ROUND((COUNT(sexo) / 36 * 100)), '%') AS "porcentagem do sexo feminino"
FROM sexo_load
WHERE sexo = 'F';

-- Calcula a porcentagem do sexo masculino em sexo_load
SELECT CONCAT(ROUND((COUNT(sexo) / 36 * 100)), '%') AS "porcentagem do sexo masculino"
FROM sexo_load
WHERE sexo = 'M';