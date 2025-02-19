 -- criando tablespace para o projeto BD erp Multi empresa TESTE
 create tablespace erp_mult_tst
         datafile
         'C:\oraclexe\app\oracle\oradata\XE\erp_mult_tst.dbf' 
		size 100m autoextend on next 50m maxsize 500m
         online
         permanent
         extent management local autoallocate
         segment space management auto;

-- criando usuario
create user user_tst
          identified by 2824
          default tablespace erp_mult_tst
          temporary tablespace TEMP;

-- concendendo permissoes para o usuario
grant ALL PRIVILEGES to user_tst;

-- alterando limite de cota para o usuario
alter user user_tst quota unlimited on erp_mult_tst;



 -- criando tablespace para o projeto BD erp Multi empresa PRODUCAO
 create tablespace erp_mult_prd
         datafile
         'C:\oraclexe\app\oracle\oradata\XE\erp_mult_prd.dbf' 
		size 100m autoextend on next 50m maxsize 500m
         online
         permanent
         extent management local autoallocate
         segment space management auto;

-- criando usuario
create user user_prd
          identified by 2824
          default tablespace erp_mult_prd
          temporary tablespace TEMP;

-- concendendo permissoes para o usuario
grant ALL PRIVILEGES to user_prd;

-- alterando limite de cota para o usuario
alter user user_prd quota unlimited on erp_mult_prd;


-- drop objetos
/*
drop user user_prd CASCADE;
drop user user_tst CASCADE;

drop tablespace erp_mult_prd INCLUDING CONTENTS AND DATAFILES;
drop tablespace erp_mult_tst INCLUDING CONTENTS AND DATAFILES;
*/