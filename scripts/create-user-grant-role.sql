--criar usuário
CREATE USER GXST 
IDENTIFIED BY gxst123;

CREATE USER TEST
IDENTIFIED BY test123;

--alterando informações de usuário
ALTER USER GXST IDENTIFIED BY GXST;

GRANT CREATE SESSION, CONNECT TO GXST;

-- dando acessos para o usuário
--privilégios de objetos
GRANT INSERT ON GABRIELA.TB_NF TO GXST;
GRANT SELECT ON GABRIELA.CONTRACT_SEQUENCE TO GXST;
REVOKE SELECT ON GABRIELA.CONTRACT_SEQUENCE FROM GXST;
GRANT ALL ON GABRIELA.TB_NF TO GXST;
REVOKE ALL ON GABRIELA.TB_NF FROM GXST;

--privilégios de sistema
GRANT SELECT ANY TABLE, ALTER ANY TABLE, DROP ANY TABLE TO gxst;

REVOKE CREATE ANY TABLE, SELECT ANY TABLE, 
ALTER ANY TABLE, DROP ANY TABLE FROM gxst; 

--roles (grupo de privilégios)
GRANT RESOURCE, CONNECT TO TEST;
CREATE ROLE criar_alterar_tabelas;
GRANT SELECT ANY TABLE, UPDATE ANY TABLE, 
INSERT ANY TABLE, DELETE ANY TABLE TO criar_alterar_tabelas;
GRANT SELECT ON GABRIELA.TB_CONTRACT TO criar_alterar_tabelas;
GRANT criar_alterar_tabelas TO TEST;
REVOKE criar_alterar_tabelas from TEST;
