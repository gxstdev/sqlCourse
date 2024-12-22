CREATE TABLE TB_GERENTE(
	CD_GERENTE INT,
	NM_GERENTE VARCHAR2(50) NOT NULL
);

ALTER TABLE TB_GERENTE 
ADD CONSTRAINT PK_TB_GERENTE PRIMARY KEY (CD_GERENTE);

CREATE TABLE TB_FILIAL (
    CD_FILIAL INT,
    DS_FILIAL VARCHAR2(50) NOT NULL,
    CD_GERENTE INT,
    
  	CONSTRAINT PK_TB_FILIAL PRIMARY KEY(CD_FILIAL)   
  	CONSTRAINT FK_TB_GERENTE FOREIGN KEY(CD_GERENTE) 
  	REFERENCES TB_GERENTE(CD_GERENTE)
);

ALTER TABLE TB_FILIAL ADD UF_FILIAL VARCHAR2(2);

ALTER TABLE GABRIELA.TB_GERENTE_TESTE RENAME TO TB_GERENTE_TESTE;

--deletando tabela que tem constraints de chave estrangeira
DROP TABLE TB_GERENTE CASCADE CONSTRAINTS;

DROP TABLE TB_FILIAL;

CREATE TABLE TB_USUARIO(
	CD_USUARIO INT,
	DS_USERNAME VARCHAR(50) NOT NULL UNIQUE,
	DT_CADASTRO DATE DEFAULT SYSDATE,
	CONSTRAINT "PK_TB_USUARIO" PRIMARY KEY(CD_USUARIO)
);

CREATE SEQUENCE usuario_id_sequence
      INCREMENT BY 1
      START WITH 1
      NOMAXVALUE
      NOCYCLE
      CACHE 10;

INSERT INTO TB_USUARIO(CD_USUARIO, DS_USERNAME)
values(usuario_id_sequence.nextval, 'gxstdev');

INSERT INTO TB_USUARIO(CD_USUARIO, DS_USERNAME, DT_CADASTRO)
values(usuario_id_sequence.nextval, 'lsdev', '12/12/2024');

--criando tabelas a partir de select de outra tabela
CREATE TABLE CENSO_EMBU_GUAÇU AS 
(SELECT * FROM BASE_DE_DADOS bdd WHERE "nome_mun" = 'Embu-Guaçu');

--criando tabelas a partir de um select, mas só trazendo a estrura, sem dado
CREATE TABLE TB_GERENTE_TEST AS (SELECT * FROM tb_gerente WHERE 1 <> 1);

--insert de dados a partir de um select
--as tabelas precisam ter as mesmas colunas
INSERT INTO TB_GERENTE_TESTE (SELECT * FROM TB_GERENTE 
WHERE CD_GERENTE = 2);

INSERT INTO CENSO_EMBU_GUAÇU 
(SELECT * FROM BASE_DE_DADOS bdd WHERE "nome_mun" = 'Embu-Guaçu');

--apaga todas as linhas da tabela, tem mais perfomance que o delete
TRUNCATE TABLE CENSO_EMBU_GUAÇU;
DELETE FROM CENSO_EMBU_GUAÇU;

--criando tabela temporária, dados salvos por transação
create global temporary TABLE temp_table(
	id int PRIMARY KEY,
	text varchar(20)
)
--esse é o comando que faz ser uma tabela temporária por sessão
on commit preserve rows;

INSERT INTO temp_table(id, text)
 values(2, 't2');

COMMIT;

--os dados só são apagados quando a conexão com o banco é fechada
SELECT * FROM temp_table;

--tabela com dados temporários
create global temporary TABLE temp_table_transaction(
	id int PRIMARY KEY,
	text varchar(20)
);

INSERT INTO temp_table_transaction(id, text)
VALUES(1, 'text');

SELECT * FROM temp_table_transaction;

--quando fazemos commit, encerramos uma transação
--então os dados serão apagados
COMMIT;

INSERT INTO temp_table_transaction(id, text)
VALUES(1, 'text');

--comando ddl dentro do sgbd oracle fazem commit implícito
--então os dados da temp table serão apagados
ALTER TABLE temp_table_transaction RENAME TO transaction_temp_table;