SELECT tp.NM_PRODUCT, SUM(QT_ITEM) AS QT_ITEM FROM TB_NF_ITEM tni 
INNER JOIN TB_PRODUCT tp ON TNI.CD_PRODUCT = tp.CD_PRODUCT
GROUP BY tni.CD_NF, tp.NM_PRODUCT
ORDER BY tp.NM_PRODUCT; 

SELECT TRUNC(TN.DT_EMISSION) AS DATA, SUM(tn.NR_ITEM) QT_ITEM FROM TB_NF TN
GROUP BY TRUNC(TN.DT_EMISSION)
ORDER BY TRUNC(TN.DT_EMISSION) ;

SELECT tni.CD_PRODUCT, sum(tni.QT_ITEM * tni.VL_PRODUCT) 
FROM TB_NF_ITEM tni
GROUP BY tni.CD_PRODUCT;

SELECT tni.CD_PRODUCT, MIN(tni.VL_PRODUCT) VL_PRODUCT_MIN FROM TB_NF_ITEM tni
GROUP BY tni.CD_PRODUCT;

SELECT TRUNC(TNI.DT_EMISSAO), MIN(tni.VL_PRODUCT) FROM TB_NF_ITEM tni;

SELECT TRUNC(TNI.DT_EMISSAO), tni.CD_PRODUCT, MIN(tni.VL_PRODUCT) VL_PRODUCT_MIN FROM TB_NF_ITEM tni
GROUP BY TRUNC(TNI.DT_EMISSAO), tni.CD_PRODUCT
ORDER BY TRUNC(TNI.DT_EMISSAO), TNI.CD_PRODUCT ;

SELECT TRUNC(TNI.DT_EMISSAO), tni.CD_PRODUCT, MAX(tni.VL_PRODUCT) VL_PRODUCT_MIN FROM TB_NF_ITEM tni
GROUP BY TRUNC(TNI.DT_EMISSAO), tni.CD_PRODUCT
ORDER BY TRUNC(TNI.DT_EMISSAO), TNI.CD_PRODUCT ;

SELECT TNI.CD_PRODUCT, SUM(tni.QT_ITEM) 
FROM TB_NF_ITEM tni 
GROUP BY TNI.CD_PRODUCT
ORDER BY MAX(tni.VL_PRODUCT) desc;

SELECT TC."ano", TC."nome_uf" 
FROM TB_CENSO tc
GROUP BY TC."ano", TC."nome_uf";

SELECT MAX(TB_CENSO_UF_SP."pib_per_cap") 
FROM (SELECT * FROM TB_CENSO tc 
			   WHERE tc."nome_uf" 
			   LIKE '%Paulo') TB_CENSO_UF_SP;

SELECT tc."ano", TC."nome_uf", tc."pib_per_cap" FROM TB_CENSO tc 
WHERE tc."pib_per_cap" >= (SELECT AVG(tc2."pib_per_cap") 
							FROM TB_CENSO tc2);

SELECT tc."ano", TC."nome_uf", tc."pib_per_cap" FROM TB_CENSO tc 
WHERE tc."pib_per_cap" <= (SELECT AVG(tc2."pib_per_cap") 
							FROM TB_CENSO tc2);
					
SELECT tc."nome_uf", MAX(tc."pib_per_cap")  FROM TB_CENSO tc 
GROUP BY tc."nome_uf", tc."uf" ;

SELECT tni.CD_PRODUCT, SUM(tni.VL_PRODUCT) VL_TOTAL_PROD
FROM TB_NF_ITEM tni 
WHERE tni.CD_PRODUCT IN (2, 4)
GROUP BY tni.CD_PRODUCT;

INSERT INTO TB_GERENTE(CD_GERENTE, NM_GERENTE, DS_AREA)
(SELECT CONCAT(tg.cd_gerente, 0), 
		CONCAT(tg.nm_gerente, tg.ds_area),
		CONCAT(tg.ds_area, '---')
		FROM TB_GERENTE tg);

SELECT CONCAT(CONCAT(TC."nome_mun", ' - '), CONCAT(TC."nome_uf", CONCAT(' - ', TC."nome_meso_reg")) )  
FROM TB_CENSO TC;

SELECT 'idNF= ' || LPAD(tn.ID_NF, 5, '0'), 
	'dataEmissao= ' || tn.DT_EMISSION,
	'nrItem = ' || RPAD(NR_ITEM, 1, 0)
FROM TB_NF tn; 


SELECT SUBSTR(tg.NM_GERENTE, 1, 2) FROM TB_GERENTE tg
WHERE tg.CD_GERENTE = 50;


SELECT DS_AREA, DECODE(DS_AREA, 'MARKETING', 'Trade Marketing',
					  'TI', 'Back-End Developer',
					  'DS', 'Data Analytics', 
					  --VALOR PADRÃO
					  'Null')
FROM TB_GERENTE tg;

SELECT tni.CD_PRODUCT, 
	SUM(CASE WHEN TNI.CD_PRODUCT IN (2, 4) 
				 THEN tni.VL_PRODUCT 
				 ELSE 0
				 END) VL_TOTAL_PROD
FROM TB_NF_ITEM tni	
GROUP BY tni.CD_PRODUCT;

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

SELECT * FROM TB_CENSO tc ;
SELECT * FROM TB_CENSO tc ;
SELECT tc."nome_uf", 
       tc."nome_mun", 
       tc.populacao, 
       tc."pib_per_cap",
       CASE 
           WHEN TC.POPULACAO <= 15 AND tc."pib_per_cap" IN (11, 13) THEN 'Baixo'  
           ELSE 'teste'
       END AS CLASSIFICACAO_1,
       CASE 
           WHEN TC.POPULACAO <= 20 AND tc."pib_per_cap" IN (11, 13) THEN 'Médio'
           ELSE 'teste'
       END AS CLASSIFICACAO_2
FROM TB_CENSO tc;

