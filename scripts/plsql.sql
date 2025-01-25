SELECT SUM(tni.VL_PRODUCT), SUM(tni.QT_ITEM) 
FROM TB_NF_ITEM tni 
WHERE TRUNC(tni.DT_EMISSAO) < TO_DATE('15/01/2025', 'dd/mm/yyyy') ;

--somar o valor total de tds as notas
--e qtd item total das notas
--das notas com emissão anterior a 15 janeiro

--habilita a impressão de valores pelo comando -> DBMS_OUTPUT.PUT_LINE(valor)
--no dbeaver não é necessário utilizar
--SET serveroutput ON 
--palavra DECLARE para declarar as variáveis
DECLARE

--nome variável e tipo
v_vl_total_nfs NUMBER(12, 2);
v_qtd_total_item_nfs int;
v_dt_emissao DATE;

--inicializar variáveis e pl/sql
--:= operador de atribuição como o = em programação
BEGIN
v_dt_emissao := to_date('15/01/2025', 'dd/mm/yyyy');
SELECT sum(tni.VL_PRODUCT), sum(tni.QT_ITEM)
--INTO atribui os valores retornado pelo select, as variáveis
--na mesma ordem em que as variáveis estão definidas
INTO v_vl_total_nfs, v_qtd_total_item_nfs
FROM TB_NF_ITEM tni WHERE trunc(tni.DT_EMISSAO) < v_dt_emissao;

DBMS_OUTPUT.PUT_LINE('Valor total de notas emitidas antes de ' || v_dt_emissao || ' é:' ||to_char(v_vl_total_nfs, 'fmL999999999.00'));
DBMS_OUTPUT.PUT_LINE('Quantidade de itens de todas as notas é: ' || v_qtd_total_item_nfs);

END;