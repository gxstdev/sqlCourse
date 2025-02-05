# cursores

<aside>
💡

cursores servem para que possamos manipular um conjunto de dados retornados por um select.

- com o cursores conseguimos interagir/manipular várias linhas retornadas por um select em pl/sql.
- podemos fazer o loop, e assim acessar linha a linha retornada por um select.

</aside>

## definimos um cursos da mesma forma para definir atributos

dentro da clausula DECLARE, iremos definir nosso cursor, junto com as demais variáveis

```sql
DECLARE
CURSOR c_tb_calories IS SELECT * FROM TB_CALORIES_RECORD tcr WHERE tcr.qt_calories <= 1800;
BEGIN
--PL/SQL
END;
```

- aqui, criamos o cursor **c_tb_calories**.
- dentro dele terá o retorno do SELECT que fizemos.

## usando um cursor

### OPEN e CLOSE

para utilizar o cursor, precisamos abrir ele. e sempre fechamos, pois o cursor aberto consome recursos do banco de dados.

```sql
DECLARE 
CURSOR c_tb_calories IS SELECT * FROM TB_CALORIES_RECORD tcr WHERE tcr.qt_calories <= 1800;
v_tcr%rowtype;
BEGIN
	OPEN c_tb_calories;
	LOOP
		
	END LOOP;
	CLOSE c_tb_calories;
END;
```

### FETCH

**fetch irá interagir com cada linha retornada pelo cursor**.

a palavra into em pl/sql é para atribuir um valor, então o fetch busca a linha dentro do cursor e atribui a uma variável.

```sql
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
```