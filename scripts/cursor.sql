DECLARE 
CURSOR c_tb_calories IS SELECT * FROM TB_CALORIES_RECORD tcr WHERE tcr.qt_calories <= 1800;
v_tcr TB_CALORIES_RECORD%rowtype;
BEGIN
	OPEN c_tb_calories;
	LOOP		
		FETCH c_tb_calories INTO v_tcr;
		EXIT WHEN c_tb_calories%notfound;
		dbms_output.put_line(v_tcr.ID || ' ' || v_tcr.DT_RECORD || ' ' || v_tcr.QT_CALORIES);		
	END LOOP;
	CLOSE c_tb_calories;
END;

DECLARE
CURSOR c_tb_nf IS SELECT * FROM tb_nf;
qtd_item_invalida EXCEPTION;

v_id_nf  tb_nf.ID_NF%TYPE;
v_dt tb_nf.DT_EMISSION%TYPE;
v_nr_item tb_nf.nr_item%TYPE; 

BEGIN
	IF NOT c_tb_nf%ISOPEN THEN 
		OPEN c_tb_nf;
	END IF;

	FOR i IN 0..10 LOOP
		BEGIN
			
		FETCH c_tb_nf INTO v_id_nf, v_dt, v_nr_item;
		CASE WHEN v_nr_item > 28 
		THEN 
		RAISE qtd_item_invalida;
		ELSE 			
		dbms_output.put_line(v_id_nf || v_dt || v_nr_item);	
		END CASE; 
	
		EXCEPTION 
		WHEN qtd_item_invalida THEN 
		dbms_output.put_line('quantidade de item inválida.');
		END;
	END LOOP;
	CLOSE c_tb_nf;
END;
