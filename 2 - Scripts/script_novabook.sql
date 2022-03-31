
CREATE TABLE dim_data (
                sk_data INTEGER NOT NULL,
                nk_data DATE NOT NULL,
                desc_data_completa VARCHAR(60) NOT NULL,
                nr_ano INTEGER NOT NULL,
                nm_trimestre VARCHAR(20) NOT NULL,
                nr_ano_trimestre VARCHAR(20) NOT NULL,
                nr_mes INTEGER NOT NULL,
                nm_mes VARCHAR(20) NOT NULL,
                ano_mes VARCHAR(20) NOT NULL,
                nr_semana INTEGER NOT NULL,
                ano_semana VARCHAR(20) NOT NULL,
                nr_dia INTEGER NOT NULL,
                nr_dia_ano INTEGER NOT NULL,
                nm_dia_semana VARCHAR(20) NOT NULL,
                flag_final_semana CHAR(3) NOT NULL,
                flag_feriado CHAR(3) NOT NULL,
                nm_feriado VARCHAR(60) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT dim_data_pk PRIMARY KEY (sk_data)
);


CREATE SEQUENCE dim_compra_sk_livro_seq;

CREATE TABLE dim_compra (
                sk_livro INTEGER NOT NULL DEFAULT nextval('dim_compra_sk_livro_seq'),
                nk_cliente INTEGER NOT NULL,
                nome_livro VARCHAR NOT NULL,
                ano_publicacao INTEGER NOT NULL,
                autor VARCHAR NOT NULL,
                editora VARCHAR NOT NULL,
                genero VARCHAR NOT NULL,
                idioma VARCHAR NOT NULL,
                preco REAL NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT dim_compra_pk PRIMARY KEY (sk_livro)
);


ALTER SEQUENCE dim_compra_sk_livro_seq OWNED BY dim_compra.sk_livro;

CREATE SEQUENCE dim_filial_sk_filial_seq;

CREATE TABLE dim_filial (
                sk_filial INTEGER NOT NULL DEFAULT nextval('dim_filial_sk_filial_seq'),
                nk_filial INTEGER NOT NULL,
                regiao VARCHAR NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT dim_filial_pk PRIMARY KEY (sk_filial)
);


ALTER SEQUENCE dim_filial_sk_filial_seq OWNED BY dim_filial.sk_filial;

CREATE SEQUENCE dim_cliente_sk_cliente_seq;

CREATE TABLE dim_cliente (
                sk_cliente INTEGER NOT NULL DEFAULT nextval('dim_cliente_sk_cliente_seq'),
                nk_cliente INTEGER NOT NULL,
                nome_cliente VARCHAR NOT NULL,
                dt_nascimento DATE NOT NULL,
                sexo_cliente CHAR(1) NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT dim_cliente_pk PRIMARY KEY (sk_cliente)
);


ALTER SEQUENCE dim_cliente_sk_cliente_seq OWNED BY dim_cliente.sk_cliente;

CREATE TABLE fato_compra (
                sk_cliente INTEGER NOT NULL,
                sk_livro INTEGER NOT NULL,
                sk_filial INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                dd_id_compra INTEGER NOT NULL,
                md_valor REAL NOT NULL
);


ALTER TABLE fato_compra ADD CONSTRAINT dim_data_fato_compra_fk
FOREIGN KEY (sk_data)
REFERENCES dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dim_compra_fato_compra_fk
FOREIGN KEY (sk_livro)
REFERENCES dim_compra (sk_livro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dim_filial_fato_compra_fk
FOREIGN KEY (sk_filial)
REFERENCES dim_filial (sk_filial)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dim_cliente_fato_compra_fk
FOREIGN KEY (sk_cliente)
REFERENCES dim_cliente (sk_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
