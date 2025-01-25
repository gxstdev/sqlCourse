--criando view
CREATE OR REPLACE
VIEW employe_job_desc 
AS 
SELECT
	e.EMPLOYEE_ID,
	e.FIRST_NAME,
	e.JOB_ID,
	j.JOB_TITLE
FROM
	HR.EMPLOYEES e ,
	hr.JOBS j
WHERE
	e.JOB_ID = j.JOB_ID ;

--renomeando view
RENAME employe_job_desc TO v_employe_job_desc;

SELECT * FROM v_employe_job_desc v
WHERE v.EMPLOYEE_ID = 206;

--alterando uma view
--apenas repetimos o comando para criar e add as alterações
CREATE OR REPLACE
VIEW v_employe_job_desc 
AS 
SELECT
	e.EMPLOYEE_ID id,
	e.FIRST_NAME name,
	e.JOB_ID id_job,
	j.JOB_TITLE ds_jobe
FROM
	HR.EMPLOYEES e ,
	hr.JOBS j
WHERE
	e.JOB_ID = j.JOB_ID ;

CREATE OR REPLACE
VIEW v_nfs 
AS
SELECT * FROM TB_NF tn 
UNION all
SELECT * FROM TB_NF tn 
WHERE to_char(trunc(tn.DT_EMISSION), 'dd/mm/yyyy') = '20/12/2024' ;

SELECT dt_emission FROM v_nfs;

--criando uma view a partir de outra
CREATE OR REPLACE
VIEW v2_nfs 
AS
SELECT * FROM v_nfs;

SELECT * FROM v2_nfs;


SELECT * FROM hr.EMPLOYEES e;

SELECT * FROM TB_NF tn
WHERE to_char(TRUNC(tn.DT_EMISSION), 'dd/mm/yyyy') = '20/12/2024';