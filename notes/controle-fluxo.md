# CONTROLE DE FLUXO

## CASE

case é uma função que tem a mesma funcionalidade do IF/ELSE nas linguagens de programação.

### WHEN, THEN e ELSE

o when avalia uma condição booleana. quando verdadeira, o THEN retorna um valor, quando falsa, o ELSE retorna um valor.

### END

o END serve para finalizar a estrutura CASE WHEN e sempre deve ser adicionado.

```sql
SELECT tni.CD_PRODUCT, 
			 SUM(CASE WHEN TNI.CD_PRODUCT IN (2, 4) 
				   THEN tni.VL_PRODUCT 
				   ELSE 0
				   END) VL_TOTAL_PROD
FROM TB_NF_ITEM tni	
GROUP BY tni.CD_PRODUCT;
```

### quando uma condição WHEN retorna TRUE, as outras não são validadas

```sql
SELECT tc."nome_uf", tc."nome_mun", tc.populacao, tc."pib_per_cap",
		CASE WHEN TC.POPULACAO <= 15 AND tc."pib_per_cap" IN (11, 13)
			 THEN 'Baixo'  
			 WHEN TC.POPULACAO <= 20 AND tc."pib_per_cap" IN (11, 13)
			 THEN 'Médio'
			 ELSE 'Alto'
			 END DS_CLASSIFICACAO
FROM TB_CENSO tc ;
```

se a primeira condição ->
- WHEN (TC.POPULACAO <= 15 AND tc."pib_per_cap" IN (11, 13)) 

retornar TRUE, as outras não serão analisadas pela engine do banco.

### podemos ter vários CASE WHEN em uma mesma query

```sql
SELECT tc."nome_uf", tc."nome_mun", tc.populacao, 
	   tc."pib_per_cap", TC."pib",
		CASE WHEN TC.POPULACAO <= 15 AND tc."pib_per_cap" IN (11, 13)
			 THEN 'Baixo'  
			 WHEN TC.POPULACAO <= 20 AND tc."pib_per_cap" IN (11, 13)
			 THEN 'Médio'
			 ELSE 'Alto'
			 END DS_CLASSIFICACAO,
		CASE WHEN tc."pib" >= 100000	
			 THEN 'Desenvolvido'
			 WHEN tc."pib" <= 60000
			 THEN 'Subdesenvolvido'
			 ELSE '-'
			 END DS_STATUS_PIB
FROM TB_CENSO tc ;
```

### THEN e ELSE devem retornar valores de um mesmo tipo

caso no THEN seja retornado uma dado de texto e no ELSE um dado numérico, é lançado o erro abaixo.

```sql
Erro SQL [932] [42000]: ORA-00932: tipos de dados 
inconsistentes: esperava CHAR obteve NUMBER

```

### doc Oracle - CASE WHEN

- https://docs.oracle.com/cd/B28359_01/server.111/b28286/expressions004.htm#SQLRF20037