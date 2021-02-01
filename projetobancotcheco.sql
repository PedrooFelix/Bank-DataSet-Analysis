select * from account

--analise das contas
--sabendo as 3 formas de taxas do banco

--poplatek po obratu = taxa de rotatividade = 93 = 2%
--poplatek tydne = taxa por semana = 240 = 5%
--poplatek mesicne = taxa mensal = 4167 = 93%
select count(*) from account
SELECT frequency,count(*) as total from account group by frequency
SELECT distinct(frequency) from account


-- análise dos cartoes
--3 tipos de cartoes: classico, junior e gold.
--classic = 659 = 14% do total = 892 = 73%
--junior = 145 = 3% do total = 16%
--gold = 88 = 1% do total = 11%
select * from card
select type,count(*) from card group by type

--analise dos clientes 
-- possuimos 77 distritos
--distrito 1 = 663 clientes
--distrito 74 = 180 clientes
--distrito 70 = 169 clientes
--distrito 54 = 155 clientes
--distrito 64 = 109 clientes
select distinct(district_id) from client order by district_id
select district_id, count(*) from client group by district_id order by count DESC
select count(*) from client
select * from client
--analise do disp
--proprietário e gerente
--gerente = 869
--proprietarios = 4500

select * from disp
select type,count(*) from disp group by type

--all dos distritos

select * from district order by "A4" DESC
--DA PARA TRATAR O NOME DA CIDADE - PRAHA 
SELECT CASE WHEN(~ '')

CREATE TEMPORARY TABLE TBREGIAO_A AS 
(SELECT DISTINCT("A3"),COUNT(*),
SUM("A4") AS POPULACAO,
ROUND(AVG("A11"),2) AS MEDIA_SALARIO ,
ROUND(AVG("A13")) AS TX_DESEMPREGO,
ROUND(AVG("A14"),2) AS MEDIA_EMPREENDEDOR,
ROUND(AVG("A16"),2) AS MEDIA_CRIME
FROM DISTRICT where "A3" ~'B' GROUP BY "A3" ORDER BY POPULACAO DESC
)
SELECT * FROM TBREGIAO_A

DROP TABLE IF EXISTS REGIAO_A;
CREATE TEMPORARY TABLE REGIAO_BOHEMIAN AS
(SELECT COUNT(*) AS QTD_REGIAO,
 ROUND(AVG(MEDIA_SALARIO)) AS MEDIA_SALARIO,
 SUM(POPULACAO) AS POPULACAO,
ROUND(AVG(TX_DESEMPREGO)) AS TX_DESEMPREGO,
ROUND(AVG(MEDIA_EMPREENDEDOR),2) AS MEDIA_EMPREENDEDOR,
ROUND(AVG(MEDIA_CRIME),2) AS MEDIA_CRIME
 FROM TBREGIAO_A WHERE "A3" ~'B')

SELECT * FROM REGIAO_BOHEMIAN
--SEPARANDO
SELECT DISTINCT("A3") FROM DISTRICT GROUP BY "A3"
--FAZENDO AGORA DE MORAVIA
CREATE TEMPORARY TABLE TBREGIAO_B AS 
(SELECT DISTINCT("A3"),COUNT(*),
SUM("A4") AS POPULACAO,
ROUND(AVG("A11"),2) AS MEDIA_SALARIO ,
ROUND(AVG("A13")) AS TX_DESEMPREGO,
ROUND(AVG("A14"),2) AS MEDIA_EMPREENDEDOR,
ROUND(AVG("A16"),2) AS MEDIA_CRIME
FROM DISTRICT where "A3" ~'Moravia' GROUP BY "A3" ORDER BY POPULACAO DESC
)

SELECT * FROM TBREGIAO_B


--AGORA FAZENDO ELA EM UMA LINHA
DROP TABLE IF EXISTS REGIAO_MORAVIA;
CREATE TEMPORARY TABLE REGIAO_MORAVIA AS
(SELECT COUNT(*) AS QTD_REGIAO,
 ROUND(AVG(MEDIA_SALARIO)) AS MEDIA_SALARIO,
 SUM(POPULACAO) AS POPULACAO,
ROUND(AVG(TX_DESEMPREGO)) AS TX_DESEMPREGO,
ROUND(AVG(MEDIA_EMPREENDEDOR),2) AS MEDIA_EMPREENDEDOR,
ROUND(AVG(MEDIA_CRIME),2) AS MEDIA_CRIME
 FROM TBREGIAO_B WHERE "A3" ~'Moravia')
 
 SELECT * FROM REGIAO_MORAVIA
 
 -- fazendo com prague
CREATE TEMPORARY TABLE TBREGIAO_C AS 
(SELECT DISTINCT("A3"),COUNT(*),
SUM("A4") AS POPULACAO,
ROUND(AVG("A11"),2) AS MEDIA_SALARIO ,
ROUND(AVG("A13")) AS TX_DESEMPREGO,
ROUND(AVG("A14"),2) AS MEDIA_EMPREENDEDOR,
ROUND(AVG("A16"),2) AS MEDIA_CRIME
FROM DISTRICT where "A3" ~'Prague' GROUP BY "A3" ORDER BY POPULACAO DESC
);

SELECT * FROM TBREGIAO_C


--AGORA FAZENDO ELA EM UMA LINHA
CREATE TEMPORARY TABLE REGIAO_PRAGUE AS
(SELECT COUNT(*) AS QTD_REGIAO,
 ROUND(AVG(MEDIA_SALARIO)) AS MEDIA_SALARIO,
 SUM(POPULACAO) AS POPULACAO,
ROUND(AVG(TX_DESEMPREGO)) AS TX_DESEMPREGO,
ROUND(AVG(MEDIA_EMPREENDEDOR),2) AS MEDIA_EMPREENDEDOR,
ROUND(AVG(MEDIA_CRIME),2) AS MEDIA_CRIME
 FROM TBREGIAO_C WHERE "A3" ~'Prague')
 
-- JOIN COM AS 3 TABELAS
--REGIAO_MORAVIA,REGIAO_PRAGUE,REGIAO_BOHEMIAN
 -- agora fazendo join com as 3 regioes
 DROP TABLE IF EXISTS DISTRITOS;

 CREATE TEMPORARY TABLE DISTRITOS AS 
 (SELECT 'BOHEMIAN' AS PRAGUE,* FROM REGIAO_BOHEMIAN
UNION ALL
SELECT 'PRAGUE' AS PRAGUE,* FROM REGIAO_PRAGUE
UNION ALL
 SELECT 'MORAVIA' AS REGIAO_MORAVIA,* FROM REGIAO_MORAVIA

 )
 --
 select * from DISTRITOS ORDER BY POPULACAO DESC
--TAXA DE AUMENTO 
--DIFERENCA DAS 2 
-- DIVIDIDO PELO VALOR INICIAL

SELECT DISTINCT("A3"),COUNT(*),
SUM("A4") AS POPULACAO,
ROUND(AVG("A11"),2) AS MEDIA_SALARIO ,
ROUND(AVG("A13")) AS TX_DESEMPREGO,
ROUND(AVG("A14"),2) AS MEDIA_EMPREENDEDOR,
ROUND(AVG("A16"),2) AS MEDIA_CRIME
FROM DISTRICT GROUP BY "A3" ORDER BY POPULACAO DESC

SELECT * FROM DISTRICT
--numero de habitantes = a4 
-- no. of municipalities with inhabitants >10000 = a8
--ratio of urban inhabitants = a10
--average salary = a11 
-- unemploymant rate '96 = a13
-- no. of enterpreneurs per 1000 inhabitants = a14
-- no. of commited crimes '96 = a16 

-- da para fazer taxa de aumento de crimes de 95 para 96
-- da para fazer taxa de aumento de desemprego de 95 para 96


--select do loan = tanto de emprestimo
--682 emprestimos
--status = 4 status
--each record describes a loan granted for agiven account
-- A - contratos acabados sem problemas = 203 -- DESCOBRIR DE QUAIS DISTRITOS ESSAS PESSOAS SAO

-- contratos concluído - emprestimo nao pago B = 31

-- C = -- contratos em andamento, ok pelo menos 403 -- DESCOBRIR DE QUAIS DISTRITOS ESSAS PESSOAS SAO
-- D = -- contratos em andamento, clientes em débito =  devendo 45
/**
'A' stands for contract finished, no
problems,
'B' stands for contract finished, loan not
payed,
'C' stands for running contract, OK so far,
'D' stands for running contract, client in
debt
**/
select * from loan
select distinct(status) from loan
select count(status) from loan
select count(*),status from loan group by status

-- SELECT order 
--6471 ordens
-- uver = crédito = 717 = pagamentos de emprestimo
-- sipo = ? = 3502 = pagamentos domésticos
-- vazio = 1379 
-- leasing = locação = 341 = pagamento de 
-- pojistine = seguro = 532 = pagamentos de seguro
/**
"POJISTNE" stands for insurrance
payment
"SIPO" stands for household payment
"LEASING" stands for leasing
"UVER" stands for loan payment - 
**/
select * from "order"

select count(*),k_symbol as contador from "order" group by k_symbol

--select de transactions

select * from trans
select distinct(type) from trans
select count(type),type from trans group by "type"
/**
"PRIJEM" stands for credit
"VYDAJ" stands for withdrawal

"VYBER KARTOU" credit card withdrawal
"VKLAD" credit in cash
"PREVOD Z UCTU" collection from another bank
"VYBER" withdrawal in cash
"PREVOD NA UCET" remittance to another bank

**/

select * from trans where type = 'PRIJEM'

SELECT COUNT(*) FROM DISTRICT  group by "A3"

--meta é descobrir quem sao os melhores clientes
-- quais os seus distritos
-- fazer um join para ver onde estao os clientes nota A 
select case when district_id between 2 and 52 then 'BOHEMIA'
END REGIAO from DISTRICT

select district.district_id,loan.status,count(*) AS QTD_DISTRICT from loan
inner join account on loan.account_id = account.account_id
inner join district on account.district_id = district.district_id
group by loan.status, district.district_id ORDER BY QTD_DISTRICT DESC

select district.district_id,loan.status,count(*) AS QTD_DISTRICT from loan
inner join account on loan.account_id = account.account_id
inner join district on account.district_id = district.district_id
WHERE STATUS ='A'
group by loan.status, district.district_id ORDER BY QTD_DISTRICT DESC 
-- DISTRITO 1 POSSUI 34 CLIENTES A
-- DISTRITO 1 POSSUI 43 CLIENTES NOTA C
-- REGIAO DE MORAVIA POSSUI 142 CLIENTES NOTAS C
SELECT * FROM DISTRICT
select district.district_id,loan.status,count(*) AS QTD_DISTRICT from loan
inner join account on loan.account_id = account.account_id
inner join district on account.district_id = district.district_id
WHERE STATUS ='C'
group by loan.status, district.district_id,STATUS ='C'
ORDER BY QTD_DISTRICT DESC 




ALTER TABLE district 
RENAME COLUMN "A1" TO district_id;
--
SELECT * FROM DISTRICT

-- INCENTIVO AO EMPRESTIMO  PARA EMPREENDEDORES EM PRAGUE
-- INCENTIVO A EXPANSAO DO SETOR AUTOMOBILISTICO NAS AREAS MAIS AFASTADAS
-- INCENTIVO A EXPANSAO DO SETOR DE CERVEJA 
-- POR TER UM SALARIO MUITO MENOR SE TORNA MAIS LUCRATIVO UMA MAO DE OBRA MAIS BARATA
-- INCENTIVO EM MORAVIA
SELECT * FROM DISTRITOS ORDER BY POPULACAO DESC


