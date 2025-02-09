CREATE OR REPLACE
FUNCTION fnretornamaiornumero 
    (n1 IN int, n2 IN int) 
    RETURN int
IS
v_maior_numero int;
BEGIN
	IF n1 > n2 
	THEN v_maior_numero := n1;
	ELSE v_maior_numero := n2;		
	END IF;	
    RETURN v_maior_numero;
END retornaMaiorNumero;

SELECT retornaMaiorNumero(10, 2) FROM DUAL;

CREATE OR REPLACE 
FUNCTION fninvertenome
	(nome IN VARCHAR2)
	RETURN VARCHAR2
IS
v_tamanho_nome NUMBER(12,0);
v_nome_invertido VARCHAR2(50);
BEGIN 
	v_nome_invertido := '';
	v_tamanho_nome := LENGTH(nome);
	FOR i IN REVERSE 1..v_tamanho_nome LOOP
	v_nome_invertido := v_nome_invertido || substr(nome, i, 1);
	END LOOP;
	RETURN initcap(v_nome_invertido);
END invertenome;

SELECT invertenome('gabriela') FROM dual;

--function sem parâmetros
CREATE OR REPLACE 
FUNCTION fnobterdepartamento
RETURN NUMBER(4,0)
IS 
v_cd_dept NUMBER(4,0);
BEGIN 
	SELECT e.DEPARTMENT_ID 
	INTO v_cd_dept
	FROM HR.employees e WHERE e.EMPLOYEE_ID = 100;
	RETURN v_cd_dept;
END fnobterdepartamento;


CREATE OR REPLACE 
FUNCTION fnobtercalorias
RETURN NUMBER
IS 
v_calories NUMBER(12,0);
BEGIN 
	SELECT RC.QT_CALORIES
	INTO v_calories
	FROM TB_CALORIES_RECORD RC WHERE RC.ID = 1;
	RETURN v_calories;
END fnobtercalorias;

SELECT fnobtercalorias FROM DUAL;

--aplicando funções criadas em colunas de tabelas
CREATE OR REPLACE 
FUNCTION fnqtdexcedida(p_cal in NUMBER, p_meta_cal IN NUMBER)
RETURN NUMBER
IS 
v_qtd NUMBER(12,0);
BEGIN 
	IF p_cal <= p_meta_cal
	THEN RETURN 0;
	ELSE 
	v_qtd := p_cal - p_meta_cal;	
	RETURN v_qtd;
	END IF;
END fnqtdexcedida;

SELECT
	tcr.ID,
	tcr.QT_CALORIES,
	--chama a function para cada registro
	fnqtdexcedida(tcr.QT_CALORIES, 1650) QT_EXCEDIDA
FROM
	TB_CALORIES_RECORD tcr ;
