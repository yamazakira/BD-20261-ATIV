CREATE DATABASE seguradora;
USE seguradora;

CREATE TABLE Cliente (
    cpf CHAR(11) PRIMARY KEY CHECK (cpf NOT LIKE '%[^0-9]%' AND LENGTH(TRIM(cpf)) = 11),
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL
    -- pontuacao INT NULL
);

CREATE TABLE Telefones (
    cliente_cpf CHAR(11),
    telefone VARCHAR(20) CHECK (telefone NOT LIKE '%[^0-9]%' AND LENGTH(TRIM(telefone)) > 0),

    PRIMARY KEY (cliente_cpf, telefone),

    CONSTRAINT fk_telefone_cliente
        FOREIGN KEY (cliente_cpf)
        REFERENCES Cliente(cpf)
        ON DELETE CASCADE
);

CREATE TABLE Corretor (
    cpf CHAR(11) PRIMARY KEY CHECK (cpf NOT LIKE '%[^0-9]%' AND LENGTH(TRIM(cpf)) = 11),
    -- numero_susep INT UNIQUE NOT NULL,
    numero_susep VARCHAR(30) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL
);

-- disjunção total de bens
CREATE TABLE Automovel (
    codigo_bem INT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),

    modelo VARCHAR(100) NOT NULL
);

CREATE TABLE Imovel (
    codigo_bem INT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),

    localizacao VARCHAR(200) NOT NULL
);

CREATE TABLE Seguro (
    numero_apolice INT PRIMARY KEY,
    periodo_cobertura VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    franquia DECIMAL(10,2) NOT NULL CHECK (franquia > 0),
    automovel_codigo_bem INT NULL,
    imovel_codigo_bem INT NULL,

    FOREIGN KEY (automovel_codigo_bem)
        REFERENCES Automovel(codigo_bem),

    FOREIGN KEY (imovel_codigo_bem)
        REFERENCES Imovel(codigo_bem)
);

CREATE TABLE Seguro_Aquisicao (
    seguro_apolice INT PRIMARY KEY,
    cliente_cpf CHAR(11) NOT NULL,
    corretor_cpf CHAR(11) NOT NULL,
    data_aquisicao DATE NOT NULL,

    CONSTRAINT fk_aquisicao_seguro
        FOREIGN KEY (seguro_apolice)
        REFERENCES Seguro(numero_apolice)
        ON DELETE CASCADE,

    CONSTRAINT fk_aquisicao_cliente
        FOREIGN KEY (cliente_cpf)
        REFERENCES Cliente(cpf),

    CONSTRAINT fk_aquisicao_corretor
        FOREIGN KEY (corretor_cpf)
        REFERENCES Corretor(cpf)
);

CREATE TABLE Perito (
    cpf CHAR(11) PRIMARY KEY CHECK (cpf NOT LIKE '%[^0-9]%' AND LENGTH(TRIM(cpf)) = 11),
    nome VARCHAR(100) NOT NULL,
    especialidade ENUM(
        'escpecialidade',
        'especialidade2'
    ) NOT NULL
);

CREATE TABLE Sinistro (
    numero INT PRIMARY KEY,
    seguro_apolice INT NOT NULL,
    descricao TEXT NOT NULL,
    valor DECIMAL(12,2) NOT NULL CHECK (valor > 0),

    CONSTRAINT fk_sinistro_seguro
        FOREIGN KEY (seguro_apolice)
        REFERENCES Seguro(numero_apolice)
);

CREATE TABLE Sinistro_Avaliacao (
    perito_cpf CHAR(11),
    sinistro_num INT,
    obs TEXT,
    data_vistoria DATE NOT NULL,

    PRIMARY KEY (perito_cpf, sinistro_num),

    CONSTRAINT fk_avaliacao_perito
        FOREIGN KEY (perito_cpf)
        REFERENCES Perito(cpf)
        ON DELETE CASCADE,

    CONSTRAINT fk_avaliacao_sinistro
        FOREIGN KEY (sinistro_num)
        REFERENCES Sinistro(numero)
        ON DELETE CASCADE
);