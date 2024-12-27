--JOIN 

--OUTER JOIN é feito utilizando o operador (+)

--mesmo que a condição de join no where não seja atendida,
--serão trazidos os registros da coluna direita
--right join
SELECT * FROM hr.EMPLOYEES e, hr.DEPARTMENTS d 
WHERE e.DEPARTMENT_ID(+) = d.DEPARTMENT_ID;

--mesmo que a condição de join no where não seja atendida,
--serão trazidos os registros da coluna a esquerda
--equivalente ao left join
SELECT * FROM tb_gerente tg, TB_FILIAL tf 
WHERE tg.CD_GERENTE = tf.CD_FILIAL(+);

--NATURAL JOIN
--faz o join com base em colunas com o mesmo nome, tipo e tamanho
--caso haja mais de uma coluna com nomes iguais, 
--pode haver incosistência
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, 
LOCATION_ID, STREET_ADDRESS, COUNTRY_ID 
FROM hr.DEPARTMENTS d 
NATURAL JOIN HR.LOCATIONS l
NATURAL JOIN HR.COUNTRIES c; 

--USING
--permite especificar colunas no join
SELECT * FROM hr.LOCATIONS l
JOIN hr.COUNTRIES c 
USING(country_id);

SELECT e.EMPLOYEE_ID, e.FIRST_NAME, DEPARTMENT_Id, D.DEPARTMENT_NAME FROM hr.EMPLOYEES e 
JOIN hr.DEPARTMENTS d 
USING(DEPARTMENT_ID);

--ON
--também permite especificar as colunas

--JOIN (INNER JOIN)
--traz apenas o registros que atendam a condição ON
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.salary,
e.DEPARTMENT_ID, d.DEPARTMENT_NAME,
e.MANAGER_ID 
FROM hr.EMPLOYEES e
JOIN hr.DEPARTMENTS d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
JOIN hr.EMPLOYEES managers ON (e.MANAGER_ID = managers.EMPLOYEE_ID)
AND d.DEPARTMENT_ID IN (90, 20)
AND e.salary >= 10000
ORDER BY e.EMPLOYEE_ID ;

--traz todos os registros da coluna a direita
--e o inner join dos registros que atendam a condição ON
SELECT * FROM hr.LOCATIONS l
RIGHT JOIN hr.COUNTRIES c 
ON(l.COUNTRY_ID = c.COUNTRY_ID);

--traz todos os registros da coluna a esquerda
--e o inner join dos registros que atendam a condição ON
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, 
d.MANAGER_ID, e.EMPLOYEE_ID FROM hr.DEPARTMENTS d
LEFT JOIN hr.EMPLOYEES e ON (d.MANAGER_ID = e.EMPLOYEE_ID);

SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, 
d.MANAGER_ID, e.EMPLOYEE_ID FROM hr.DEPARTMENTS d
JOIN hr.EMPLOYEES e ON (d.MANAGER_ID = e.EMPLOYEE_ID);