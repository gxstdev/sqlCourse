SELECT
	SUM(tni.VL_PRODUCT),
	SUM(tni.QT_ITEM)
FROM
	TB_NF_ITEM tni
WHERE
	TRUNC(tni.DT_EMISSAO) < TO_DATE('15/01/2025', 'dd/mm/yyyy') ;

--somar o valor total de tds as notas
--e qtd item total das notas
--das notas com emissão anterior a 15 janeiro

--habilita a impressão de valores pelo comando -> DBMS_OUTPUT.PUT_LINE(valor)
--no dbeaver não é necessário utilizar
--SET serveroutput ON 

--palavra DECLARE para declarar as variáveis
DECLARE
	--nome variável e tipo
	v_vl_total_nfs NUMBER(12,
	2) DEFAULT 0;

v_qtd_total_item_nfs int;

v_dt_emissao DATE;
--inicializar variáveis e pl/sql
--:= operador de atribuição como o = em programação
BEGIN
	v_dt_emissao := to_date('15/01/2025', 'dd/mm/yyyy');

SELECT
	sum(tni.VL_PRODUCT),
	sum(tni.QT_ITEM)
	--INTO atribui os valores retornado pelo select, as variáveis
	--na mesma ordem em que as variáveis estão definidas
INTO
	v_vl_total_nfs,
	v_qtd_total_item_nfs
FROM
	TB_NF_ITEM tni
WHERE
	trunc(tni.DT_EMISSAO) < v_dt_emissao;

DBMS_OUTPUT.PUT_LINE('Valor total de notas emitidas antes de ' || v_dt_emissao || ' é: ' || to_char(v_vl_total_nfs, 'fmL9G999G999D00'));

DBMS_OUTPUT.PUT_LINE('Quantidade de itens de todas as notas é: ' || v_qtd_total_item_nfs);
END;

DECLARE
	v_vl_product TB_NF_ITEM.VL_PRODUCT%TYPE DEFAULT 0;

BEGIN 
SELECT
	tni.VL_PRODUCT
INTO
	v_vl_product
FROM
	TB_NF_ITEM tni
WHERE
	tni.VL_PRODUCT = 45.52;

DBMS_OUTPUT.PUT_LINE('Variável do tipo coluna -> ' || v_vl_product);
END;

DECLARE
	v_reg_tb_nf_item TB_NF_ITEM%ROWTYPE;

BEGIN 
SELECT
	*
INTO
	v_reg_tb_nf_item
FROM
	TB_NF_ITEM tni
WHERE
	tni.CD_NF = 10000;

DBMS_OUTPUT.PUT_LINE('id:' || v_reg_tb_nf_item.CD_NF);

DBMS_OUTPUT.PUT_LINE('cd produto:' || v_reg_tb_nf_item.CD_PRODUCT);

DBMS_OUTPUT.PUT_LINE('data:' || v_reg_tb_nf_item.DT_EMISSAO);

DBMS_OUTPUT.PUT_LINE('valor:' || v_reg_tb_nf_item.VL_PRODUCT);

DBMS_OUTPUT.PUT_LINE('qtd item:' || v_reg_tb_nf_item.QT_ITEM);
--podemos lançar exceptions também em pl/sql
--precisa ser a extruta EXCEPTION WHEN (nome exception)
--THEN uma ação para quando a EXCEPTION ocorrer
EXCEPTION
WHEN no_data_found THEN
DBMS_OUTPUT.PUT_LINE('código nf inexistente');
END;

DECLARE 
--criando tipos de dados personalizados
--estrutura para criar um tipo -> TYPE nometipo IS RECORD()
TYPE TGerente IS RECORD(
	codigo_gerente int,
	nome_gerente varchar2(50)	
);
--declarando uma variável do tipo que criamos -> TGerente
v_gerente TGerente;
BEGIN 
	SELECT tg.CD_GERENTE, INITCAP(LOWER(tg.NM_GERENTE))
	INTO v_gerente.codigo_gerente, v_gerente.nome_gerente
	FROM TB_GERENTE tg
	WHERE tg.CD_GERENTE = 1; 
DBMS_OUTPUT.PUT_LINE('cd: ' || v_gerente.codigo_gerente || chr(10));
DBMS_OUTPUT.PUT_LINE('nm: ' || v_gerente.nome_gerente);
END;	
	
--escopo -> podemos aninhar blocos
--blocos são definidos por DECLARE BEGIN END
<<blocoprincipal>>
DECLARE 
vNome VARCHAR2(50);
BEGIN
	vNome := 'Gabriela';
	<<blocointerno>>
	DECLARE
	vNome VARCHAR2(50);
	BEGIN
		vNome := 'Teste';
		DBMS_OUTPUT.PUT_LINE('valor para vNome - bloco principal: ' ||  blocoprincipal.VNome);
		DBMS_OUTPUT.PUT_LINE('valor para vNome - bloco interno: ' ||  blocointerno.VNome);
		<<blocomaisinternoainda>>
		DECLARE 
		vNome VARCHAR2(50);
		BEGIN 
		vNome := 'ChatGPT';	
		DBMS_OUTPUT.PUT_LINE(chr(10) || 'não é com ' || vNome);
		DBMS_OUTPUT.PUT_LINE(chr(10) || 'a label serve como o this em java ' || blocointerno.vNome);
		END;		
	END;
DBMS_OUTPUT.PUT_LINE(chr(10) || vNome);
END;	

--controle de fluxo / IF ELSE
DECLARE 
v_num NUMBER(12,0);
BEGIN
	v_num := 21;
	IF MOD(v_num, 2) <> 0
	THEN 
	DBMS_OUTPUT.PUT_LINE('o número ' || v_num || ' é impar');
	ELSE
	DBMS_OUTPUT.PUT_LINE('o número ' || v_num || ' é par');
	END IF;
END;


DECLARE 
v_num1 NUMBER(12,0);
v_num2 NUMBER(12,0);
v_num3 NUMBER(12,0);
BEGIN
	v_num1 := 15;
	v_num2 := 3;
	v_num3 := 11;
	IF v_num1 < v_num2 AND v_num1 < v_num3 
	THEN 
	DBMS_OUTPUT.PUT_LINE('o menor é ' || v_num1);
	ELSIF v_num2 < v_num1 AND v_num2 < v_num3
	THEN 
	DBMS_OUTPUT.PUT_LINE('o menor é ' || v_num2);
	ELSE 
	DBMS_OUTPUT.PUT_LINE('o menor é ' || v_num3);	
	END IF;
END;


DECLARE 
v_num1 NUMBER(12,0);
v_num2 NUMBER(12,0);
v_num3 NUMBER(12,0);
BEGIN
	v_num1 := 15;
	v_num2 := 3;
	v_num3 := 11;
	CASE WHEN v_num1 < v_num2 AND v_num1 < v_num3 
	THEN 
	DBMS_OUTPUT.PUT_LINE('o menor é ' || v_num1);
	WHEN v_num2 < v_num1 AND v_num2 < v_num3
	THEN 
	DBMS_OUTPUT.PUT_LINE('o menor é ' || v_num2);
	ELSE 
	DBMS_OUTPUT.PUT_LINE('o menor é ' || v_num3);	
	END CASE;
END;


--GOTO
DECLARE
    v_contador NUMBER := 1;
BEGIN
    <<inicio>>
    DBMS_OUTPUT.PUT_LINE('Valor de v_contador: ' || v_contador);
    
    v_contador := v_contador + 1;
    
    --loop infinito 
	--<<fim>>
	--DBMS_OUTPUT.PUT_LINE('Valor de v_contador: ' || v_contador);
    
	IF v_contador <= 5 THEN
        GOTO inicio; -- Pula para o rótulo 'inicio'
    ELSE 
	    IF v_contador > 5  THEN
	    	GOTO fim;
	    END IF;
    END IF;
	<<fim>>
	DBMS_OUTPUT.PUT_LINE('Valor de v_contador: ' || v_contador);
    DBMS_OUTPUT.PUT_LINE('Fim do loop.');
END;

DECLARE 
	v_qtd_cal NUMBER(12, 2) DEFAULT 0;
	v_num_row NUMBER(12, 0) DEFAULT 1;
	v_limite_id NUMBER(12, 0) DEFAULT 1;
BEGIN 
	SELECT COUNT(tcr.ID) 
	INTO v_limite_id
	FROM TB_CALORIES_RECORD tcr;

	<<s1>>
	SELECT tcr.QT_CALORIES 
	INTO v_qtd_cal
	FROM TB_CALORIES_RECORD tcr 
	WHERE tcr.ID = v_num_row;

	DBMS_OUTPUT.PUT_LINE('id: ' || v_num_row || ' cal: ' || v_qtd_cal);
	
	v_num_row := v_num_row + 1;
	
	IF v_limite_id >= v_num_row
	THEN GOTO s1;	
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('fim');
END;

--FOR
DECLARE
BEGIN
	FOR i IN 0..10 LOOP
		INSERT INTO TB_CALORIES_RECORD(ID, DT_RECORD, QT_CALORIES)
		VALUES(tcr_sequence.nextval, TRUNC(SYSDATE) - i, 1850 - i);		
	END LOOP;	
END;

DECLARE
v_limite NUMBER(12, 0) DEFAULT 0;
BEGIN
	SELECT COUNT(tcr.ID) 
	INTO v_limite
	FROM TB_CALORIES_RECORD tcr;

	FOR i IN 1..v_limite LOOP
		UPDATE TB_CALORIES_RECORD tcr
		SET tcr.QT_CALORIES = 1650
		WHERE tcr.DT_RECORD = TO_DATE('31/01/2025', 'dd/mm/yyyy');
	END LOOP;	
END;

--WHILE
DECLARE 
TYPE TNf IS RECORD(
	codigo NUMBER(38,0),
	valor NUMBER(12,2)
);

v_num_row NUMBER(12,0);
v_limite_id NUMBER(12,0);
v_nf TNf;
BEGIN
	v_num_row := 1;

	SELECT COUNT(tni.CD_NF) 
	INTO v_limite_id
	FROM TB_NF_ITEM tni;
	
	<<wloop>>
	WHILE v_num_row <= v_limite_id
	LOOP
		EXIT WHEN v_num_row = 22;
	
		SELECT tni.CD_NF, nvl(tni.VL_PRODUCT, 0) 
		INTO v_nf.codigo, v_nf.valor
		FROM TB_NF_ITEM tni WHERE tni.CD_NF = v_num_row; 
	
		v_num_row := v_num_row + 1;
	
		CASE 
			WHEN v_nf.valor <= 500 	THEN CONTINUE wloop;
			ELSE DBMS_OUTPUT.PUT_LINE('código: ' || v_nf.codigo || ' valor: ' || v_nf.valor);
		END CASE;		
	END LOOP;
	
	DBMS_OUTPUT.PUT_LINE(v_num_row);	
END;

--LOOP
DECLARE 
v_cal NUMBER(12,2) DEFAULT 0;
v_limite_id NUMBER(12,0) DEFAULT 1;
v_num_row NUMBER(12,0) DEFAULT 0;
BEGIN 	
	SELECT COUNT(tcr.ID) 
	INTO v_limite_id
	FROM TB_CALORIES_RECORD tcr;
	DBMS_OUTPUT.PUT_LINE('limite: ' || v_limite_id);
	LOOP
		v_num_row := v_num_row + 1;
		EXIT WHEN v_num_row > v_limite_id;
	
		SELECT tcr.QT_CALORIES 
		INTO v_cal
		FROM TB_CALORIES_RECORD tcr
		WHERE tcr.ID = v_num_row;
		
		IF v_cal > 2500 
		THEN DBMS_OUTPUT.PUT_LINE('cal excedida: ' || v_cal);
		END IF;
		
		CONTINUE WHEN v_cal > 1900;
		DBMS_OUTPUT.PUT_LINE('cals: ' || v_cal);
	
	END LOOP;	
END;

--exception não definidas pela oracle
--tratamos elas com o operador OTHER
DECLARE
  v_code NUMBER;
  v_errm VARCHAR2(200);
BEGIN
  -- simulando um erro de divisão por zero
  DECLARE
    v_num NUMBER := 1;
  BEGIN
    v_num := v_num / 0;
  EXCEPTION
    WHEN OTHERS THEN
      v_code := SQLCODE;
      v_errm := SQLERRM;
      DBMS_OUTPUT.PUT_LINE('Erro ' || v_code || ': ' || v_errm);
  END;
END;

--para pegar exceptions dentro de um loop, precisamos add
--esse loop a um bloco begin..end
DECLARE
  v_result NUMBER;
BEGIN
  FOR i IN 1..5 LOOP
	  
    BEGIN  
      IF i = 3 THEN
        v_result := 1 / 0; 
      ELSE
        DBMS_OUTPUT.PUT_LINE('Iteração ' || i || ' concluída.');
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro na iteração ' || i || ': ' || SQLERRM);
    END;
  END LOOP;
END;

DECLARE 
v_exc1 EXCEPTION;
BEGIN
	IF trunc(SYSDATE - 1) = TO_DATE('01/02/2025', 'dd/mm/yyyy') 
	THEN RAISE v_exc1;
	END IF;

	EXCEPTION
	WHEN v_exc1 THEN 
	dbms_output.put_line('exception lançada: '||SQLERRM);
END;