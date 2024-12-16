## operadores comparação

- maior >
- menor <
- maior igual >=
- menor igual <=
- diferente <>  

### usando operadores de comparação com datas

```sql
SELECT * FROM HR.EMPLOYEES a
WHERE a.HIRE_DATE > '03/02/06'
AND a.HIRE_DATE <= '12-02-06'
order by  a.HIRE_DATE asc;
```

- podemos escrever as datas tanto com barra / ou com -.

## operadores matemáticos

- no próprio select podemos fazer operações matemáticas com um dado de uma coluna

```sql
SELECT E.SALARY "SALARIO ATUAL", 
e.SALARY + 1000 "SALARIO AJUSTADO"
FROM HR.EMPLOYEES e 
WHERE E.HIRE_DATE <= '01/01/2004'
ORDER BY e.HIRE_DATE ASC;
```

- aqui, estamos pegando a coluna SALARY e somando a 1000

### operador de resto no Oracle SQL é uma função, a função MOD

```sql
SELECT * FROM HR.EMPLOYEES e
WHERE MOD(e.SALARY, 3) = 0; 

SELECT * FROM TB_NF tn 
WHERE MOD(tn.NR_ITEM, 2) <> 0;
```

## utilizando a tabela dual para poder fazer cálculos no oracle SQL

### mas o que é a tabela dual

a tabela **DUAL** é uma tabela **dummy** (fictícia) é usados em bancos de dados para executar operações que não requerem ou não se relacionam diretamente com os dados de uma tabela convencional. 

### utilizando tabela dual para fazer cálculos

```sql
SELECT 2000 / 10 AS divisao, 
2000 * 10 AS multiplicacao, 
2000 - 1000 AS subtracao
FROM dual;
```

podemos fazer expressões matemáticas também:

```sql
SELECT 2000 / 2 * 3 FROM dual;
```

## operadores lógicos

### WHERE

o where em um consulta faz com que só sejam trazidos os dados que atendam a condição definida por ele.

- e também é utilizado para fazer join.
- posso entender a consulta abaixo como: traga os registros da tb_nf que estejam também na tb_nf_authorized.

```sql
SELECT * FROM TB_NF tn, TB_NF_AUTHORIZED tna 
WHERE TN.ID_NF = TNA.ID_NF; 
```

- nessa caso serão selecionados apenas os dados da TB_NF que o ID_NF seja igual ao ID_NF de um registro da TB_NF_AUTHORIZED.
- só serão selecionados os dados que tenham o ID_NF em comum.

### AND

```sql
SELECT * FROM TB_NF tn 
WHERE (tn.NR_ITEM <= 10 AND MOD(TN.NR_ITEM, 2) = 0) ;

```

- o AND retorna true se as duas (ou mais)condições forem atendidas
- então vai retornar os registros da TB_NF que atendam as duas condições.

### BETWEEN

aceita valores numéricos e datas.

```sql
SELECT * FROM TB_NF tn WHERE TRUNC(tn.DT_EMISSION) 
BETWEEN '07/12/2024' AND'13/12/2024'; 
```

```sql
SELECT * FROM TB_NF tn WHERE tn.DT_EMISSION 
BETWEEN TO_DATE('07/12/2024 11:42:40', 'DD/MM/YYYY HH:MI:SS') 
AND TO_DATE('13/12/2024 11:40:00', 'DD/MM/YYYY HH:MI:SS'); 
```

mais um exemplo usando números em vez de datas:

```sql
SELECT * FROM TB_NF tn 
WHERE NR_ITEM BETWEEN 10 AND 25;
```

### IN

seleciona todos os dados em que o **valor da coluna especificada** esteja dentro dos valores do IN.

```sql
SELECT * FROM HR.COUNTRIES c 
--c.REGION_ID = coluna especificada
HERE c.REGION_ID IN (1, 2);
```
- os registros em que c.REGION_ID tiver valor 1 e 2, serão trazidos.

### LIKE ‘% ’ ‘_’

- operador LIKE pode ser utilizado com o caracter curinga % e também com _
- ele funciona com textos.

exemplos:

- coluna LIKE ‘a%’; → aqui são palavras que começam com a.
- coluna LIKE ‘_a%’; → aqui são palavras que a **segunda** posição é a letra a. pois o _ representa a posição 1 aqui.
- coluna **LIKE** '______u%' → aqui são palavra que a sexta posição comece com u.
- coluna LIKE ‘%a’; → aqui são palavras que terminem com a.
- coluna LIKE ‘%a%’; - aqui são palavras que contenham o a.
- também pode ser mais que uma letra, pode ser LIKE ‘%bra%’, serão retornadas palavras que contenham exatamente essa sequência de letras.

### e quando queremos palavras que comecem com determinada letra e termine com outra determinada letra?

```sql
SELECT * FROM BASE_DE_DADOS bdd 
WHERE "nome_mun" LIKE 'A%' AND "nome_mun" LIKE '%o';
```

podemos fazer dessa forma, mas também podemos simplificar a query fazendo da forma abaixo.

```sql
SELECT * FROM BASE_DE_DADOS bdd 
WHERE "nome_mun" LIKE 'A%o';

SELECT * FROM BASE_DE_DADOS bdd 
WHERE "nome_mun" LIKE 'A%o' OR "nome_mun" LIKE 'C%a';
```

pois a letra estando antes do %, é para INICIAR.

estando após, é para finalizar.

### NOT

esse operador inverte o valor de todos os outros operadores booleanos acima.

então ele trará os resultados cujo o valor passado como referência para validação, não esteja entre os dados.

- NOT BETEWEEN

```sql
SELECT * FROM HR.EMPLOYEES e 
WHERE TRUNC(e.HIRE_DATE, 'yyyy') 
NOT BETWEEN to_date('2002', 'yyyy') 
AND to_date('2007', 'yyyy');
```

- NOT IN

```sql
SELECT * FROM HR.EMPLOYEES e;
SELECT * FROM HR.EMPLOYEES e 
WHERE e.DEPARTMENT_ID NOT IN (80, 50, 110, 100)
ORDER BY DEPARTMENT_ID; 
```

- NOT LIKE

```sql
SELECT * FROM hr.EMPLOYEES e 
WHERE e.JOB_ID NOT LIKE UPPER('sa%')
AND e.JOB_ID NOT LIKE UPPER('it%');
```

### OR

ele retorna true se qualquer uma das condições dentro do WHERE forem true.

```sql
SELECT * FROM HR.EMPLOYEES e 
WHERE e.JOB_ID LIKE 'IT%' OR e.JOB_ID LIKE '%REP';
```
### IS NULL e IS NOT NULL

é usado para validar as colunas com valores null, pois o oracle sql não aceita validar os valores com

- coluna <> null ou coluna = null, irá dar erro.

### HAVING

HAVING substitui o clausula WHERE quando estamos utilizando **funções de agregação**, pois não podemos utilizar o WHERE com as funções de agregação.

ex de uso do having →

```sql
SELECT "uf", "nome_uf", COUNT(*) AS qtd 
FROM BASE_DE_DADOS bdd 
WHERE "ano" = 2014
group BY "uf", "nome_uf" 
HAVING count("cod_mun") >500;
```

aqui é como se o HAVING fosse um WHERE. 

## precedência de operadores lógicos

### AND e OR

```sql
SELECT * FROM HR.EMPLOYEES e 
WHERE (e.JOB_ID LIKE 'IT%' OR e.JOB_ID LIKE '%REP') 
AND e.SALARY >= 10000;
```

- o AND tem maior precedencia que o OR, então ele é validado antes.

https://docs.oracle.com/cd/E49933_01/server.770/es_eql/src/ceql_expr_precedence_rules.html