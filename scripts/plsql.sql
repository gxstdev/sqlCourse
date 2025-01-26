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





