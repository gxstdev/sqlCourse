## procedures
procedure é um bloco pl/sql que executa uma ou mais instruções.

- procedure possuí cabeçalho e corpo.
- cabeçalho: nome da procedure, os parâmetros que essa procedure recebe e as variáveis declaradas.
- corpo: contém as instruções que a procedure irá executar, ou seja, o código pl/sql.

## estrutura de uma procedure

é bem parecido com um bloco pl/sql anônimo.

a diferença é o **IS** → que tem a mesma função do **DECLARE** em blocos anônimos do pl/sql.

```sql
CREATE OR REPLACE PROCEDURE nome_da_procedure (
    parametro1 IN  Tipo_Dado,
    parametro2 OUT Tipo_Dado,
    parametro3 IN OUT Tipo_Dado
) 
IS
v_atributo Tipo_Dado;
BEGIN
    -- Corpo da procedure
    EXCEPTION
    --exceptions lançadas
END nome_da_procedure;
```

### exemplo de procedure

- note que podemos ter uma variável que é do tipo de um cursor, ela precisará ser ROWTYPE.

```sql
CREATE OR REPLACE
PROCEDURE PROC_DET_FUNC
IS
	--declaração de cursores e variáveis
  CURSOR emp_cur
  IS
  SELECT first_name, last_name, salary FROM HR.EMPLOYEES;
  
  --podemos criar um atributo do tipo CURSOR
  --ele precisará ser rowtype.
  --porém, é opcional, pois se nós cometarmos
  --a var emp_rect aqui e declarar ela direto no for
  --o próprio oracle já cria ela implicitamente
  emp_rec emp_cur%rowtype;
BEGIN

  FOR emp_rec IN emp_cur
  LOOP
    dbms_output.put_line('Nome do funcionario: ' || emp_rec.first_name);
    dbms_output.put_line('Sobrenome do funcionario: ' ||emp_rec.last_name);
    dbms_output.put_line('Salário do funcionario: ' ||emp_rec.salary);
    dbms_output.put_line('---------------------------------------------');
  END LOOP;
END;
```

- o trecho FOR emp_rec IN emp_cur → está fazendo o seguinte:
    - para cada linha dentro do **cursor emp_cur**, essa linha está sendo **atribuida a emp_rec naquela rodada do for loop**.

<aside>
💡
o for no código acima não é de um cursor implicito, pois cursor implicito é apenas quando fazemos select após o in.
</aside>