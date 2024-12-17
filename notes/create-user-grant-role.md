## criando um usuário
<aside>
💡

schemas são criados junto com usuários de um banco de dados. e para aquele usuário, haverá um schema onde serão armazenados todos os seus dados.

</aside>

### script para criar um usuário / schema

```java
   
   -- criando usuario (schema)
   create user gabriela
   		  --senha	
          identified by 2824
          default tablespace oraclecourse
          temporary tablespace TEMP;
  -- permissao para aluno        
  grant create session, connect, resource to gabriela;
  
  alter user gabriela quota unlimited on oraclecourse;
  
  
  --deletar user
  drop user gabriela;
  
  --deletar user os objetos criados
  drop user gabriela cascade;
```

nós podemos criar usuários com o comando CREATE.

podemos alterar com o comando ALTER.

e deletar com o comando DROP, mas quando já há objetos criados por um usuário, temos que utilizar o CASCADE junto com o comando de DROP.

se quisermos alterar a senha do usuário, seria assim →

```sql
alter user gabriela identified by novasenha;
```

## como utilizar objetos de um schema diferente

cada schema tem os seus próprios objetos, e ficam separados um do outro.

- eu estou no schema Gabriela, se quero utilizar uma tabela do schema ANONYMOUS, eu preciso chamar o nome do **schema.nometabela**.
- Ex: ANONYMOUS.nometabela.

## verificando todos os usuários do banco

```sql
SELECT * FROM USER_USERS ;
SELECT * FROM ALL_USERS ;
```

- essas VIEWS carregam as informações de todos os usuários.

## GRANT → dando privilégios a um usuário

- privilégios significa acessos. temos dois tipos de privilégios em banco de dado, os de **objetos** e os de **sistema**.

### privilégios de objetos

privilégios de objetos são aqueles que permitem que o usuário faça comandos DML e DDL.

- insert, select, update, alter, create, delete etc…

nós podemos dar privilégio a apenas para tabelas específicas.

- chamo o schema onde está a tabela que quero dar acesso.
- e executo o comando abaixo para dar o privilégio de SELECT.
- para dar privilégios de outros comandos DML/DDL, é só trocar o select por o comando em si. ALTER, CREATE, UPDATE, DELETE, INSERT.

```sql
GRANT SELECT ON GABRIELA.TB_NF TO GXST;
```

- ou se quisermos dar privilégio para mais de um comando.

```sql
GRANT INSERT, SELECT, UPDATE, DELETE ON GABRIELA.TB_NF TO GXST;
```

- se quisermos dar todos os privilégios, fazemos GRANT ALL. ou para retirar todos os privilégios, REVOKE ALL.

```sql
GRANT ALL ON GABRIELA.TB_NF TO GXST;

REVOKE ALL ON GABRIELA.TB_NF FROM GXST;
```

- também podemos dar privilégio para apenas algumas colunas da tabela

```sql
--dentro dos () são colunas da tabela LOCATIONS
--dando acesso para o usuário TSQL
grant update (POSTAL_CODE, STREET_ADDRESS) on
LOCATIONS to TSQL;
```

para dar acesso a uma sequence, é com o comando abaixo:

```sql
GRANT SELECT ON GABRIELA.CONTRACT_SEQUENCE TO GXST;
```

### também podemos dar privilégios sobre procedures

dando o privilégio para o comando execute de procedures

```sql
grant execute on P_PESQUISA_EMPREGADOS to TSQL;
```

## REVOKE → retirando privilégios de um usuário

```sql
REVOKE SELECT ON GABRIELA.CONTRACT_SEQUENCE FROM GXST;

```

## algo interessante: podemos dar um grant de um privilégio a um user, e também dar o pode desse user dar o mesmo grant de privilégio recebido

ex: dei o grant de select para um user, posso dar também o pode a ele de dar grant de select para outros users.

### WITH GRANT OPTION

adicionando esse comando ao de GRANT, nós damos o poder do usuário dar o grant recebido a outros usuários

```sql
grant select on JOB_HISTORY to TSQL with grant option;
```

## privilégios de sistemas

dá privilégios para o usuário criar objetos, ou para que ele acesse qualquer objeto da base de dados e não só de uma tabela específica de um schema especifico. e muito mais.

- para dar o poder de fazer o select de qualquer tabela de qualquer schema.

```sql
GRANT SELECT ANY TABLE TO gxst;
```

<aside>
💡

lembrando que: embora o user GXST tenha acesso as tabelas de qualquer schema, ainda precisa ser feito o select assim:

SELECT * FROM SCHEMA.NOMETABELA;

isso porque se a tabela está dentro de outro schema, precisamos especificar ele para que a engine do banco saiba onde buscar ela.

</aside>

<aside>
💡

na página 84 do livro: SQL uma abordagem para bancos de dados Oracle tem todos os tipos de grants de sistema.

</aside>

### também podemos dar um grant de sistema a um usuário e permitir que esse usuário de esse mesmo grant para outros usuários

fazemos isso com o comando WITH ADMIN OPTION

```sql
grant CREATE ANY TABLE to TSQL WITH ADMIN OPTION;
```

## roles → grupo de privilégios

uma role é composta por um grupo de privilégios que criamos e depois damos ela a um usuário.

uma role pode ter privilégio de objeto e sistema.

<aside>
💡

as roles servem para definir determinados privilégios com base no tipo de usuário do banco.

- usuário GERENTE terá uma role com privilégios de gerente
- usuário FUNCIONÁRIO terá uma role  com privilégios de funcionário
- etc…
</aside>

### criando uma role

```sql
CREATE ROLE criar_alterar_tabelas;
```

### definindo quais privilégios que irão compor a role

- dando privilégio de sistema com o ANY

```sql
GRANT SELECT ANY TABLE, UPDATE ANY TABLE, 
INSERT ANY TABLE, DELETE ANY TABLE 
TO criar_alterar_tabelas;
```

- dando privilégio de objeto para apenas uma tabela

```sql
GRANT SELECT ON GABRIELA.TB_CONTRACT 
TO criar_alterar_tabelas;
```

### para retirar uma role de um usuário

```sql
revoke criar_alterar_tabelas from GXST;
```

### RESOURCE, CONNECT e DBA

são roles criadas pelo sistema do oracle, que possuem vários privilégios de objetos e sistema

- RESOURCE possui os seguintes privilégios de sistema
    - CREATE CLUSTER
    - CREATE PROCEDURE
    - CREATE SEQUENCE
    - CREATE TABLE
    - CREATE TRIGGER
    - CREATE TYPE

https://www.oreilly.com/library/view/oracle-security/1565924509/ch05s03.html

---

- CONNECT possui os seguintes privilégios de sistema
    - ALTER SESSION
    - CREATE CLUSTER
    - CREATE DATABASE LINK
    - CREATE SEQUENCE
    - CREATE SESSION
    - CREATE SYNONYM
    - CREATE TABLE
    - CREATE VIEW

https://www.oreilly.com/library/view/oracle-security/1565924509/ch05s02.html

<aside>
💡

as roles RESOURCE e CONNECT não são recomendados em ambientes de produção, pois dão mais privilégios que o necessário.

https://chatgpt.com/c/6760d29b-baa0-8012-9047-1e42f2061110

</aside>

- DBA
    - todos os privilégios de sistema (with admin option).

### tabelas do sistemas oracle para encontrar informações sobre roles

- DBA_ROLES
- DBA_ROLE_PRIVS
- ROLE_TAB_PRIVS
- ROLE_SYS_PRIVS
- ROLE_ROLE_PRIVS