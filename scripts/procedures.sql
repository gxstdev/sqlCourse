CREATE OR REPLACE 
PROCEDURE p_retorna_pop_embu_guacu
IS 
	CURSOR c_censo_embu_guacu 
	IS 
	SELECT "ano", "nome_uf", "nome_mun" 
	FROM tb_censo WHERE "nome_mun" = 'Embu-Guaçu';

BEGIN 
	FOR v_linha_retornada IN c_censo_embu_guacu 
	LOOP 
	DBMS_OUTPUT.PUT_LINE('ANO: ' || v_linha_retornada."ano");
	DBMS_OUTPUT.PUT_LINE('ESTADO: ' || v_linha_retornada."nome_uf");
	DBMS_OUTPUT.PUT_LINE('MUNICÍPIO: ' || v_linha_retornada. "nome_mun");
	END LOOP; 
END;

BEGIN
	p_retorna_pop_embu_guacu;
END;	

CREATE OR REPLACE PROCEDURE p_retorna_nf
IS 
	CURSOR c_tabela_nf
	IS 
	SELECT DT_EMISSION, NR_ITEM 
	FROM tb_nf;

BEGIN 
	FOR v_linha_retornada IN c_tabela_nf 
	LOOP 
		DBMS_OUTPUT.PUT_LINE('data: ' || v_linha_retornada.DT_EMISSION);
		DBMS_OUTPUT.PUT_LINE('nr item: ' || v_linha_retornada.NR_ITEM);
	END LOOP; 
END;

BEGIN
	p_retorna_nf;
END;

