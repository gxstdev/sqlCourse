# cursores

<aside>
💡

cursores servem para que possamos manipular um conjunto de dados retornados por um select.

- com o cursores conseguimos interagir/manipular várias linhas retornadas por um select em pl/sql.
- podemos fazer o loop, e assim acessar linha a linha retornada por um select.

</aside>

## definimos um cursor da mesma forma para definir atributos

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
### EXIT WHEN nomecursor%notfound

essa é uma clausula para sair do cursor quando não houver mais dados dentro dele.

sempre deixar o EXIT WHEN após o FETCH, assim não irá se repetir o print o último valor dentro do cursor.

## usando condições para abrir o cursor

em um código grande, podemos não saber se o cursor está aberto ou não. e caso a gente tente abrir um cursor que já está aberto, irá ocorrer um erro.

por isso temos uma condição para verificar se o cursor está aberto ou não.

```sql
DECLARE
CURSOR c_tb_nf IS SELECT * FROM tb_nf;
qtd_item_invalida EXCEPTION;

v_id_nf  tb_nf.ID_NF%TYPE;
v_dt tb_nf.DT_EMISSION%TYPE;
v_nr_item tb_nf.nr_item%TYPE; 

BEGIN
--aqui usamos o IF mais o NOT, que valida se o retorno
--é false, então executa o then
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
```

## cursores implícitos

os cursores implícitos não precisam dos comandos OPEN, CLOSE, FETCH INTO etc.

esses comandos são feitos automaticamente pela engine do banco. 

- **aqui, v_usuario é uma variável que irá receber as linhas retornadas pelo cursor implicito**.
- se não fosse um cursor implicito, teriámos que declarar uma variável v_usuario, como nos exemplos acima.
- e o retorno do cursor seria atribuido a v_usuario com o INTO.

```sql
BEGIN
   FOR v_usuario IN (SELECT id, nome FROM usuarios WHERE ativo = 'S') LOOP
      DBMS_OUTPUT.PUT_LINE('ID: ' || v_usuario.id || ' - Nome: ' || v_usuario.nome);
   END LOOP;
END;
```

### passando parâmetros para o cursor

podemos passar parâmetros para o cursor e esses parâmetros serão usados no select.

- mas para passar parâmetros para um cursor, esse cursor não pode ser implícito. temos que declarar ele como no exemplo abaixo.
- mas ainda podemos usar o FOR IN de cursores implícitos, embora nós tenhamos que declarar o curso, a abertura e fechamento dele é feito pela engine do banco automaticamente.

```sql
DECLARE
   CURSOR c_usuarios(p_ativo CHAR) IS 
      SELECT id, nome FROM usuarios WHERE ativo = p_ativo;
BEGIN
   FOR r_usuario IN c_usuarios('S') LOOP
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_usuario.id || ' - Nome: ' || r_usuario.nome);
   END LOOP;
END;
```