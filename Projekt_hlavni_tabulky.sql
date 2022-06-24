
-- PROJEKT SQL - tvorba hlavních tabulek --

-- porovnatelné období je 2006 - 2018 (data o cenách), data o výplatách jsou od 2001 do 2021

-- P O Z O R -- 
-- 
-- BLOK ÚKLIDU - kontrolní selecty a dropy pomocných i finálních tabulek -----------------------------
 -- SCRIPT NA TVORBU NÍŽE
-- 
-- A -- HLAVNÍ TABULKA PRIMARY -- 

-- I. POMOCNÁ TABULKA - t_stepanb_price_edited
SELECT *
FROM t_stepanb_price_edited
;
DROP TABLE t_stepanb_price_edited
;

-- II. POMOCNÁ TABULKA - t_stepanb_payroll_edited
SELECT *
FROM t_stepanb_payroll_edited 
;
DROP TABLE t_stepanb_payroll_edited
;

-- III. POMOCNÁ TABULKA - t_stepanb_payroll_avg
SELECT  *
FROM t_stepanb_payroll_avg
;
DROP TABLE t_stepanb_payroll_avg
;

-- IV. POMOCNÁ TABULKA - t_stepanb_price_avg
SELECT *
FROM t_stepanb_price_avg
;
DROP TABLE t_stepanb_price_avg
;
-- HLAVNÍ TABULKA PRIMARY - t_stepan_benes_project_SQL_primary_final 
SELECT *
FROM t_stepan_benes_project_SQL_primary_final
;
DROP TABLE t_stepan_benes_project_SQL_primary_final 
;

-- B - HLAVNÍ TABULKA SECONDARY -- 

-- I. POMOCNÁ TABULKA - t_stepanb_countries_edit
SELECT *
FROM t_stepanb_countries_edit
;
DROP TABLE t_stepanb_countries_edit 
;

-- II. POMOCNÁ TABULKA - t_stepanb_economies_edit
SELECT *
FROM t_stepanb_economies_edit
;
DROP TABLE t_stepanb_economies_edit 
;

-- HLAVNÍ TABULKA SECONDARY - t_stepan_benes_project_SQL_secondary_final 
SELECT *
FROM t_stepan_benes_project_SQL_secondary_final 
;
DROP TABLE t_stepan_benes_project_SQL_secondary_final
;



-- TVORBA -- 
-- 
-- RUN FROM HERE ! -------------------------------------------------------------------------------
-- 

-- A -- HLAVNÍ TABULKA PRIMARY 

-- I. POMOCNÁ TABULKA - PRICE EDITED -- Join select czechia_price a czechia_price_category, pouze relevantní údaje, seřazené pro lepší orientaci (108 249 záznamů)

CREATE OR REPLACE TABLE  t_stepanb_price_edited AS ( 
	SELECT 
		cpr.value,
		cpr.category_code,
		cpc.name,
		cpc.price_value,
		cpc.price_unit, 
		date_from,
		date_to,
		region_code
	FROM czechia_price cpr 
	CROSS JOIN czechia_price_category cpc 
		ON cpr.category_code = cpc.code
	)
	;


-- II. POMOCNÁ TABULKA - PAYROLL EDITED -- join select czechia_payroll a czechia_payroll_industry_branch, pouze relevantní údaje, pouze roky 2006 - 2018 (řídí se daty czechia price) seřazené pro lepší orientaci (988 záznamů)
CREATE OR REPLACE TABLE t_stepanb_payroll_edited AS ( 
SELECT
	cp.payroll_year,
	cp.payroll_quarter,
	cp.value,
	cp.industry_branch_code,
	cpib.name
FROM czechia_payroll cp 
CROSS JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code = cpib.code
WHERE payroll_year BETWEEN 2006 AND 2018
		AND value_type_code  = 5958
		AND calculation_code = 100
		AND industry_branch_code IS NOT NULL
		AND value IS NOT NULL
)
;

-- III. POMOCNÁ TABULKA - PAYROLL AVG -- - průmerné výplaty podle odvětví za jednotlivé roky

CREATE OR REPLACE TABLE t_stepanb_payroll_avg AS (
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'A' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'B' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'C' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'D' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'E' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'F' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'G' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'H' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'I' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'J' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'K' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'L' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'M' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'N' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'O' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'P' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'Q' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'R' -- definice odvětví
GROUP by payroll_year 
UNION 
SELECT
	payroll_year as rok,
	Round(AVG(value)) as prumerna_mzda_nebo_cena,
	industry_branch_code as kod_odvetvi,
	name as nazev_odvetvi
from t_stepanb_payroll_edited
WHERE industry_branch_code = 'S' -- definice odvětví
GROUP by payroll_year 
)
;



-- IV. POMOCNÁ TABULKA - PRICE AVG -- - průměrné ceny podle odvětví za jednotlivé roky

CREATE OR REPLACE TABLE t_stepanb_price_avg AS ( 
SELECT
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 111101 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 111201 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 111301 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 111303 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 111602 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 112101 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 112201 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 112401-- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 112704 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 114201 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 114401 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 114501 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 114701 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 115101 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 115201 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 116101 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 116103 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 116104 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 117101 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 117103 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 117106 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 117401 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 118101 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 122102 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 212101 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 213201 -- kod odvetvi
GROUP BY year(date_to)
UNION 
SELECT  	
	year(date_to) as rok,
	ROUND(AVG(value)) as prumerna_mzda_nebo_cena,	
	category_code as kod_odvetvi,
	name as nazev_odvetvi	
FROM t_stepanb_price_edited 
WHERE category_code = 2000001 -- kod odvetvi
GROUP BY year(date_to)
)
;

-- HLAVNÍ TABULKA PRIMARY - t_stepan_benes_project_SQL_primary_final

CREATE OR REPLACE TABLE t_stepan_benes_project_SQL_primary_final AS ( 
SELECT *
FROM t_stepanb_price_avg tspa 
UNION
SELECT *
FROM t_stepanb_payroll_avg tspa2 
)
;

-- B -- HLAVNÍ TABULKA SECONDARY - HDP, GINI A POPULACE ČR + DALŠÍCH EVROPSKÝCH STÁTŮ - za roky 2006 - 2018

-- I. POMOCNÁ TABULKA - pouze relevantní údaje a evropské státy

CREATE OR REPLACE TABLE t_stepanb_countries_edit AS ( 
SELECT 
	country,
	continent,
	population
FROM countries c 
WHERE continent = 'Europe'
)
;

-- II. POMOCNÁ TABULKA - pouze relevantní údaje a roky

CREATE OR REPLACE TABLE t_stepanb_economies_edit AS ( 
SELECT
	country as zeme,
	`year` as rok,
	GDP as HDP,
	population as populace,
	gini
FROM economies e 
WHERE `year` BETWEEN 2006 AND 2018
ORDER BY `year` ASC
);

-- -- HLAVNÍ TABULKA SECONDARY - t_stepan_benes_project_SQL_secondary_final
CREATE OR REPLACE TABLE t_stepan_benes_project_SQL_secondary_final AS (
select 
tsce.country as stat,
tsce.continent as kontinent,
tsee.populace as populace,
tsee.HDP,
tsee.gini as gini,
tsee.rok as rok
FROM t_stepanb_countries_edit tsce 
CROSS JOIN t_stepanb_economies_edit tsee 
	ON tsce.country = tsee.zeme
)
;











	
