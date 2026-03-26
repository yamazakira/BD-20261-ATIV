-- Atividade 1
CREATE TABLE
    modelo (
        id INT NOT NULL CHECK (id > 0),
        nome VARCHAR(50) NOT NULL UNIQUE CHECK (nome <> ''),
        descricao VARCHAR(100),
        PRIMARY KEY (id)
    );

CREATE TABLE
    item (
        num_serie INT NOT NULL CHECK (num_serie > 0),
        valor_aquisicao DECIMAL(10,2) NOT NULL CHECK (valor_aquisicao > 0),
        modelo_id INT NOT NULL,
        PRIMARY KEY (num_serie),
        FOREIGN KEY (modelo_id) REFERENCES modelo (id)
    );

CREATE TABLE
    cliente (
        cpf CHAR(11) NOT NULL CHECK (cpf NOT LIKE '%[^0-9]%' AND LENGTH(cpf) = 11),
        nome VARCHAR(50) NOT NULL CHECK (nome <> ''),
        data_nasc DATE NULL,
        genero CHAR(1) NULL CHECK (genero IN ('M','F','O') OR genero IS NULL),
        PRIMARY KEY (cpf)
    );

CREATE TABLE
    venda (
        data DATETIME NOT NULL,
        valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
        cpf_comprador CHAR(11) NOT NULL CHECK (cpf_comprador NOT LIKE '%[^0-9]%' AND LENGTH(cpf_comprador) = 11),
        id_item INT NOT NULL,
        FOREIGN KEY (cpf_comprador) REFERENCES cliente (cpf),
        FOREIGN KEY (id_item) REFERENCES item (num_serie),
        PRIMARY KEY (id_item)
    );

INSERT INTO
    modelo (id, nome, descricao)
VALUES
    (1, 'Modelo A', 'Descrição do Modelo A'),
    (2, 'Modelo B', 'Descrição do Modelo B'),
    (3, 'Modelo C', 'Descrição do Modelo C'),
    (4, 'Modelo D', 'Descrição do Modelo D'),
    (5, 'Modelo E', null);

INSERT INTO
    item (num_serie, valor_aquisicao, modelo_id)
VALUES
    (1, 100, 1),
    (2, 150, 1),
    (3, 200, 1),
    (4, 120, 1),
    (5, 180, 2),
    (6, 220, 2),
    (7, 160, 2),
    (8, 250, 3),
    (9, 300, 3),
    (10, 280, 3);

INSERT INTO
    cliente (cpf, nome, data_nasc, genero)
VALUES
    ('12345678901', 'João Silva', '1990-01-01', 'M'),
    ('23456789012', 'Maria Santos', '1985-05-15', 'F'),
    ('34567890123','Pedro Oliveira','1992-10-20','M'),
    ('45678901234', 'Ana Costa', null, null);

INSERT INTO
    venda (data, valor, cpf_comprador, id_item)
VALUES
    ('2023-01-01 00:00:00', 150, '12345678901', 1),
    ('2023-01-02 00:00:00', 200, '23456789012', 2),
    ('2023-01-03 00:00:00', 250, '34567890123', 5), 
    ('2023-01-04 00:00:00', 300, '45678901234', 8), 
    ('2023-01-05 00:00:00', 340, '12345678901', 9); 
    -- modelos: 1, 1, 2, 3, 3
SELECT
    *
FROM
    modelo;

SELECT
    *
FROM
    item;

SELECT
    *
FROM
    cliente;

SELECT
    *
FROM
    venda;