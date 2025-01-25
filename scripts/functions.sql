SELECT
	tp.NM_PRODUCT,
	SUM(QT_ITEM) AS QT_ITEM
FROM
	TB_NF_ITEM tni
INNER JOIN TB_PRODUCT tp ON
	TNI.CD_PRODUCT = tp.CD_PRODUCT
GROUP BY
	tni.CD_NF,
	tp.NM_PRODUCT
ORDER BY
	tp.NM_PRODUCT;

SELECT
	TRUNC(TN.DT_EMISSION) AS DATA,
	SUM(tn.NR_ITEM) QT_ITEM
FROM
	TB_NF TN
GROUP BY
	TRUNC(TN.DT_EMISSION)
ORDER BY
	TRUNC(TN.DT_EMISSION) ;

SELECT
	tni.CD_PRODUCT,
	sum(tni.QT_ITEM * tni.VL_PRODUCT)
FROM
	TB_NF_ITEM tni
GROUP BY
	tni.CD_PRODUCT;

SELECT
	tni.CD_PRODUCT,
	MIN(tni.VL_PRODUCT) VL_PRODUCT_MIN
FROM
	TB_NF_ITEM tni
GROUP BY
	tni.CD_PRODUCT;

SELECT
	TRUNC(TNI.DT_EMISSAO),
	MIN(tni.VL_PRODUCT)
FROM
	TB_NF_ITEM tni;

SELECT
	TRUNC(TNI.DT_EMISSAO),
	tni.CD_PRODUCT,
	MIN(tni.VL_PRODUCT) VL_PRODUCT_MIN
FROM
	TB_NF_ITEM tni
GROUP BY
	TRUNC(TNI.DT_EMISSAO),
	tni.CD_PRODUCT
ORDER BY
	TRUNC(TNI.DT_EMISSAO),
	TNI.CD_PRODUCT ;

SELECT
	TRUNC(TNI.DT_EMISSAO),
	tni.CD_PRODUCT,
	MAX(tni.VL_PRODUCT) VL_PRODUCT_MIN
FROM
	TB_NF_ITEM tni
GROUP BY
	TRUNC(TNI.DT_EMISSAO),
	tni.CD_PRODUCT
ORDER BY
	TRUNC(TNI.DT_EMISSAO),
	TNI.CD_PRODUCT ;

SELECT
	TNI.CD_PRODUCT,
	SUM(tni.QT_ITEM)
FROM
	TB_NF_ITEM tni
GROUP BY
	TNI.CD_PRODUCT
ORDER BY
	MAX(tni.VL_PRODUCT) DESC;

SELECT
	TC."ano",
	TC."nome_uf"
FROM
	TB_CENSO tc
GROUP BY
	TC."ano",
	TC."nome_uf";

SELECT
	MAX(TB_CENSO_UF_SP."pib_per_cap")
FROM
	(
	SELECT
		*
	FROM
		TB_CENSO tc
	WHERE
		tc."nome_uf" 
			   LIKE '%Paulo') TB_CENSO_UF_SP;

SELECT
	tc."ano",
	TC."nome_uf",
	tc."pib_per_cap"
FROM
	TB_CENSO tc
WHERE
	tc."pib_per_cap" >= (
	SELECT
		AVG(tc2."pib_per_cap")
	FROM
		TB_CENSO tc2);

SELECT
	tc."ano",
	TC."nome_uf",
	tc."pib_per_cap"
FROM
	TB_CENSO tc
WHERE
	tc."pib_per_cap" <= (
	SELECT
		AVG(tc2."pib_per_cap")
	FROM
		TB_CENSO tc2);

SELECT
	tc."nome_uf",
	MAX(tc."pib_per_cap")
FROM
	TB_CENSO tc
GROUP BY
	tc."nome_uf",
	tc."uf" ;

SELECT
	tni.CD_PRODUCT,
	SUM(tni.VL_PRODUCT) VL_TOTAL_PROD
FROM
	TB_NF_ITEM tni
WHERE
	tni.CD_PRODUCT IN (2, 4)
GROUP BY
	tni.CD_PRODUCT;

INSERT
	INTO
	TB_GERENTE(CD_GERENTE,
	NM_GERENTE,
	DS_AREA)
(
	SELECT
		CONCAT(tg.cd_gerente, 0), 
		CONCAT(tg.nm_gerente, tg.ds_area),
		CONCAT(tg.ds_area, '---')
	FROM
		TB_GERENTE tg);

SELECT
	CONCAT(CONCAT(TC."nome_mun", ' - '), CONCAT(TC."nome_uf", CONCAT(' - ', TC."nome_meso_reg")) )
FROM
	TB_CENSO TC;

SELECT
	'idNF= ' || LPAD(tn.ID_NF, 5, '0'), 
	'dataEmissao= ' || tn.DT_EMISSION,
	'nrItem = ' || RPAD(NR_ITEM, 1, 0)
FROM
	TB_NF tn;

SELECT
	SUBSTR(tg.NM_GERENTE, 1, 2)
FROM
	TB_GERENTE tg
WHERE
	tg.CD_GERENTE = 50;

SELECT
	DS_AREA,
	DECODE(DS_AREA, 'MARKETING', 'Trade Marketing',
					  'TI', 'Back-End Developer',
					  'DS', 'Data Analytics', 
					  --VALOR PADRÃO
					  'Null')
FROM
	TB_GERENTE tg;

SELECT
	tni.CD_PRODUCT, 
	SUM(CASE WHEN TNI.CD_PRODUCT IN (2, 4) 
				 THEN tni.VL_PRODUCT 
				 ELSE 0
				 END) VL_TOTAL_PROD
FROM
	TB_NF_ITEM tni
GROUP BY
	tni.CD_PRODUCT;

SELECT
	tc."nome_uf",
	tc."nome_mun",
	tc.populacao, 
	   tc."pib_per_cap",
	TC."pib",
		CASE
		WHEN TC.POPULACAO <= 15
		AND tc."pib_per_cap" IN (11, 13)
			 THEN 'Baixo'
		WHEN TC.POPULACAO <= 20
		AND tc."pib_per_cap" IN (11, 13)
			 THEN 'Médio'
		ELSE 'Alto'
	END DS_CLASSIFICACAO,
		CASE
		WHEN tc."pib" >= 100000	
			 THEN 'Desenvolvido'
		WHEN tc."pib" <= 60000
			 THEN 'Subdesenvolvido'
		ELSE '-'
	END DS_STATUS_PIB
FROM
	TB_CENSO tc ;

SELECT
	*
FROM
	TB_CENSO tc ;

SELECT
	tc."nome_uf",
	tc."nome_mun",
	tc.populacao,
	tc."pib_per_cap",
	CASE
		WHEN TC.POPULACAO <= 15
		AND tc."pib_per_cap" IN (11, 13) THEN 'Baixo'
		ELSE 'teste'
	END AS CLASSIFICACAO_1,
	CASE
		WHEN TC.POPULACAO <= 20
		AND tc."pib_per_cap" IN (11, 13) THEN 'Médio'
		ELSE 'teste'
	END AS CLASSIFICACAO_2
FROM
	TB_CENSO tc;

SELECT
	UNIQUE l.COUNTRY_ID ID,
		CASE
		l.COUNTRY_ID 
			WHEN 'CH' THEN 'china'
		ELSE '-'
	END
FROM
	hr.LOCATIONS l;

SELECT
	ROUND(AVG(tni.VL_PRODUCT), 2)
FROM
	TB_NF_ITEM tni
GROUP BY
	CD_PRODUCT;

--não arredonda, apenas deixa a quantidade de casas decimais
--do 2º param
SELECT
	TRUNC(AVG(tni.VL_PRODUCT), 2)
FROM
	TB_NF_ITEM tni
GROUP BY
	CD_PRODUCT;

SELECT
	INITCAP('gabriela xavier')
FROM
	dual;

SELECT
	TO_DATE(TO_CHAR(SYSDATE, 'dd/mm') || TO_CHAR(SYSDATE, 'yyyy'))
FROM
	dual;

SELECT
	TO_DATE(TO_CHAR(SYSDATE, 'dd/mm'), 'dd/mm')
FROM
	dual;

SELECT
	TO_DATE('12/12', 'dd/mm')
FROM
	dual;

--do dia 16 em diante, arredonda para o próximo mês
SELECT
	ROUND(SYSDATE + 1, 'mm')
FROM
	dual;

--do mês 7 em diante, arredonda para o próximo ano
SELECT
	ROUND(SYSDATE + 167, 'yyyy')
FROM
	dual;

SELECT
	TO_DATE(TO_CHAR(SYSDATE, 'dd/mm'))
FROM
	dual;

SELECT
	to_date('15012025', 'ddmmyyyy')
FROM
	dual;

SELECT
	INITCAP(TO_CHAR(SYSDATE, 'day, dd "de" month "de" yyyy'))
FROM
	dual; 

SELECT
	ABS(TRUNC(MONTHS_BETWEEN(TO_DATE('14/01/2020', 'dd/mm/yyyy'), 
		   TRUNC(SYSDATE)) / 12)) years
FROM
	dual;

SELECT LEAST(23456.67, 23456.68, 23456.69) FROM dual;

SELECT GREATEST(23456.67, 23456.68, 23456.69) FROM dual;

SELECT COALESCE('0', 'gabi', '26') FROM dual;

SELECT NVL2(TNI.VL_PRODUCT, tni.VL_PRODUCt, 0) FROM TB_NF_ITEM tni; 

SELECT NVL(TNI.VL_PRODUCT, 0) FROM TB_NF_ITEM tni; 