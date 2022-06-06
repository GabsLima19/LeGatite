CREATE TABLE dim_item_pedido (
                nk_pedido INTEGER NOT NULL,
                id_produto VARCHAR NOT NULL
);

CREATE TABLE dim_pedido (
                sk_pedido INTEGER NOT NULL,
                nk_pedido INTEGER NOT NULL,
                id_cliente INTEGER NOT NULL,
                id_filial INTEGER NOT NULL,
                valor INTEGER,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                versao INTEGER NOT NULL,
                CONSTRAINT dim_pedido_pk PRIMARY KEY (sk_pedido)
);

CREATE SEQUENCE dim_livro_sk_livro_seq;

CREATE TABLE dim_livro (
                sk_livro INTEGER NOT NULL DEFAULT nextval('dim_livro_sk_livro_seq'),
                nk_livro INTEGER NOT NULL,
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
                CONSTRAINT dim_livro_pk PRIMARY KEY (sk_livro)
);

ALTER SEQUENCE dim_livro_sk_livro_seq OWNED BY dim_livro.sk_livro;

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
                sk_pedido INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                md_valor REAL NOT NULL
);

/*
Warning: Relationship has no columns to map:
*/

ALTER TABLE fato_compra ADD CONSTRAINT dim_pedido_fato_compra_fk
FOREIGN KEY (sk_pedido)
REFERENCES dim_pedido (sk_pedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dim_data_fato_compra_fk
FOREIGN KEY (sk_data)
REFERENCES dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dim_compra_fato_compra_fk
FOREIGN KEY (sk_livro)
REFERENCES dim_livro (sk_livro)
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