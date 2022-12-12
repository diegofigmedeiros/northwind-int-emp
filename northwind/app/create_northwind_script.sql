
CREATE TABLE public.dim_transportadora (
                transp_sk INTEGER NOT NULL,
                transp_cod_transportadora INTEGER DEFAULT -1 NOT NULL,
                transp_nm_empresa VARCHAR(40),
                version INTEGER,
                date_from TIMESTAMP,
                date_to TIMESTAMP,
                CONSTRAINT transp_sk PRIMARY KEY (transp_sk)
);


CREATE TABLE public.dim_produto (
                prod_sk INTEGER NOT NULL,
                prod_cod_produto INTEGER DEFAULT -1 NOT NULL,
                prod_nm_produto VARCHAR(40),
                prod_qtd_p_unidade VARCHAR(25),
                prod_prec_unit NUMERIC(10,2),
                prod_unids_estoque SMALLINT,
                prod_unids_pedidas SMALLINT,
                prod_descontinuado VARCHAR(10),
                prod_cod_categoria INTEGER,
                prod_nm_categoria VARCHAR(15),
                prod_cod_forn INTEGER,
                prod_nm_empresa_forn VARCHAR(40),
                prod_cidade_forn VARCHAR(15),
                version INTEGER,
                date_from TIMESTAMP,
                date_to TIMESTAMP,
                CONSTRAINT prod_sk PRIMARY KEY (prod_sk)
);
COMMENT ON TABLE public.dim_produto IS 'Produto e seus fornecedores';


CREATE SEQUENCE public.dim_tempo_tp_sk_seq;

CREATE TABLE public.dim_tempo (
                tp_sk INTEGER NOT NULL DEFAULT nextval('public.dim_tempo_tp_sk_seq'),
                tp_data DATE,
                tp_dia INTEGER,
                tp_mes INTEGER,
                tp_ano INTEGER,
                tp_semana VARCHAR,
                tp_mes_extenso VARCHAR(3),
                tp_dia_semana VARCHAR(3),
                version INTEGER,
                date_from TIMESTAMP,
                date_to TIMESTAMP,
                CONSTRAINT tp_pk PRIMARY KEY (tp_sk)
);
COMMENT ON TABLE public.dim_tempo IS 'Dimensao com calendario, a ser vinculada as datas do pedido, envio e entrega';
COMMENT ON COLUMN public.dim_tempo.tp_sk IS 'Surrogate key da dimensao de tempo';
COMMENT ON COLUMN public.dim_tempo.tp_data IS 'Data';
COMMENT ON COLUMN public.dim_tempo.tp_dia IS 'Dia da data';
COMMENT ON COLUMN public.dim_tempo.tp_mes IS 'Mes da data, no formato numerico';
COMMENT ON COLUMN public.dim_tempo.tp_ano IS 'Ano da data';
COMMENT ON COLUMN public.dim_tempo.tp_mes_extenso IS 'Mes abreviado da data';
COMMENT ON COLUMN public.dim_tempo.tp_dia_semana IS 'Dia da semana abreviado da data';
COMMENT ON COLUMN public.dim_tempo.version IS 'Versao da surrogate key (utilizado pela plataforma de ETL)';
COMMENT ON COLUMN public.dim_tempo.date_from IS 'Data de inicio de validade da surrogate key (utilizado pela plataforma de ETL)';
COMMENT ON COLUMN public.dim_tempo.date_to IS 'Data de termino de validade da surrogate key (utilizado pela plataforma de ETL)';


ALTER SEQUENCE public.dim_tempo_tp_sk_seq OWNED BY public.dim_tempo.tp_sk;

CREATE TABLE public.dim_vendedor (
                vnd_sk INTEGER NOT NULL,
                vnd_cod_vendedor INTEGER DEFAULT -1 NOT NULL,
                vnd_nome VARCHAR(40) DEFAULT 'NAO INFORMADO',
                vnd_dt_nasc DATE,
                vnd_dt_contratacao DATE,
                vnd_pais VARCHAR(15),
                version INTEGER,
                date_from TIMESTAMP,
                date_to TIMESTAMP,
                CONSTRAINT vnd_sk PRIMARY KEY (vnd_sk)
);
COMMENT ON COLUMN public.dim_vendedor.vnd_sk IS 'Surrogate key da dimensao de vendedor';
COMMENT ON COLUMN public.dim_vendedor.vnd_cod_vendedor IS 'Codigo do vendedor';
COMMENT ON COLUMN public.dim_vendedor.vnd_nome IS 'Nome do vendedor (envolve o nome e sobrenome do mesmo)';
COMMENT ON COLUMN public.dim_vendedor.vnd_dt_contratacao IS 'Data de contratacao do vendedor';
COMMENT ON COLUMN public.dim_vendedor.version IS 'Versao da surrogate key (utilizado pela plataforma de ETL)';
COMMENT ON COLUMN public.dim_vendedor.date_from IS 'Data de inicio de validade da surrogate key (utilizado pela plataforma de ETL)';
COMMENT ON COLUMN public.dim_vendedor.date_to IS 'Data de termino de validade da surrogate key (utilizado pela plataforma de ETL)';


CREATE TABLE public.dim_cliente (
                cli_sk INTEGER NOT NULL,
                cli_cod_cliente VARCHAR(5) DEFAULT 'NI' NOT NULL,
                cli_nome VARCHAR(40) DEFAULT 'NAO INFORMADO',
                cli_cidade VARCHAR(15) DEFAULT 'NAO INFORMADO',
                cli_pais VARCHAR(15) DEFAULT 'NAO INFORMADO',
                cli_pais_iso VARCHAR(15) DEFAULT 'NAO INFORMADO',
                cli_nm_contato VARCHAR(30),
                cli_telefone VARCHAR(24),
                cli_fax VARCHAR(24),
                version INTEGER,
                date_from TIMESTAMP,
                date_to TIMESTAMP,
                CONSTRAINT cli_pk PRIMARY KEY (cli_sk)
);
COMMENT ON TABLE public.dim_cliente IS 'Dimensao de Clientes';
COMMENT ON COLUMN public.dim_cliente.cli_sk IS 'Surrogate key da dimensao de cliente';
COMMENT ON COLUMN public.dim_cliente.cli_cod_cliente IS 'Codigo do Cliente';
COMMENT ON COLUMN public.dim_cliente.cli_nome IS 'Nome do cliente';
COMMENT ON COLUMN public.dim_cliente.cli_cidade IS 'Cidade do cliente';
COMMENT ON COLUMN public.dim_cliente.cli_pais IS 'Pais do cliente';
COMMENT ON COLUMN public.dim_cliente.version IS 'Versao da surrogate key (utilizado pela plataforma de ETL)';
COMMENT ON COLUMN public.dim_cliente.date_from IS 'Data de inicio de validade da surrogate key (utilizado pela plataforma de ETL)';
COMMENT ON COLUMN public.dim_cliente.date_to IS 'Data de termino de validade da surrogate key (utilizado pela plataforma de ETL)';


CREATE TABLE public.fat_pedidos (
                fat_vnd_sk INTEGER NOT NULL,
                fat_cli_sk INTEGER NOT NULL,
                fat_tp_ped_sk INTEGER NOT NULL,
                fat_tp_env_sk INTEGER NOT NULL,
                fat_tp_entr_sk INTEGER NOT NULL,
                fat_prod_sk INTEGER NOT NULL,
                fat_transp_sk INTEGER NOT NULL,
                fat_nupedido INTEGER DEFAULT -1 NOT NULL,
                fat_qtde SMALLINT,
                fat_prec_unit NUMERIC(14,2),
                fat_valor_bruto NUMERIC(14,2),
                fat_desconto_perc NUMERIC(14,2),
                fat_desconto_real NUMERIC(14,2),
                fat_dt_pedido DATE,
                fat_dt_entrega DATE,
                fat_dt_envio DATE,
                fat_frete NUMERIC(14,2),
                fat_cidade_destino VARCHAR(15),
                fat_pais_destino VARCHAR(15),
                CONSTRAINT fat_pedidos_pk PRIMARY KEY (fat_vnd_sk, fat_cli_sk, fat_tp_ped_sk, fat_tp_env_sk, fat_tp_entr_sk, fat_prod_sk, fat_transp_sk)
);
COMMENT ON COLUMN public.fat_pedidos.fat_vnd_sk IS 'Surrogate key da dimensao de vendedor';
COMMENT ON COLUMN public.fat_pedidos.fat_cli_sk IS 'Surrogate key da dimensao de cliente';
COMMENT ON COLUMN public.fat_pedidos.fat_tp_ped_sk IS 'Surrogate key da dimensso de tempo do pedido';
COMMENT ON COLUMN public.fat_pedidos.fat_tp_env_sk IS 'Surrogate key da dimensao de tempo de envio';
COMMENT ON COLUMN public.fat_pedidos.fat_tp_entr_sk IS 'Surrogate key da dimensao de tempo de entrega';
COMMENT ON COLUMN public.fat_pedidos.fat_nupedido IS 'Numero do pedido';
COMMENT ON COLUMN public.fat_pedidos.fat_qtde IS 'Quantidade do item vendido';
COMMENT ON COLUMN public.fat_pedidos.fat_prec_unit IS 'Preco unitario do item vendido';
COMMENT ON COLUMN public.fat_pedidos.fat_valor_bruto IS 'Total do item vendido (Preco unitario x Quantidade)';
COMMENT ON COLUMN public.fat_pedidos.fat_desconto_perc IS 'Desconto percentual dado no item vendido';
COMMENT ON COLUMN public.fat_pedidos.fat_desconto_real IS 'Desconto dado em reais no item vendido';


ALTER TABLE public.fat_pedidos ADD CONSTRAINT dim_transportadora_fat_pedidos_fk
FOREIGN KEY (fat_transp_sk)
REFERENCES public.dim_transportadora (transp_sk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fat_pedidos ADD CONSTRAINT dim_produto_fat_pedidos_fk
FOREIGN KEY (fat_prod_sk)
REFERENCES public.dim_produto (prod_sk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fat_pedidos ADD CONSTRAINT dim_tempo_fat_vendas_fk
FOREIGN KEY (fat_tp_ped_sk)
REFERENCES public.dim_tempo (tp_sk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fat_pedidos ADD CONSTRAINT dim_tempo_fat_vendas_fk1
FOREIGN KEY (fat_tp_env_sk)
REFERENCES public.dim_tempo (tp_sk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fat_pedidos ADD CONSTRAINT dim_tempo_fat_vendas_fk2
FOREIGN KEY (fat_tp_entr_sk)
REFERENCES public.dim_tempo (tp_sk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fat_pedidos ADD CONSTRAINT dim_vendedor_fat_vendas_fk
FOREIGN KEY (fat_vnd_sk)
REFERENCES public.dim_vendedor (vnd_sk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fat_pedidos ADD CONSTRAINT dim_cliente_fat_vendas_fk
FOREIGN KEY (fat_cli_sk)
REFERENCES public.dim_cliente (cli_sk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
