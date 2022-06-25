
-- PROJEKT SQL - tvorba hlavních tabulek --

-- porovnatelné období je 2006 - 2018 (data o cenách), data o výplatách jsou od 2001 do 2021



-- A -- HLAVNÍ TABULKA PRIMARY 
-- Vybírá pouze relevantní data z různých tabulek. Přehled obsahuje všechna data (čtvrtletí i týdny,) průměry až dotazem nad touto tabulkou při hledání odpovědí na výzkumné otázky

CREATE OR REPLACE TABLE t_stepan_benes_project_SQL_primary_final AS ( 
	SELECT 
		year(date_to) AS rok,
		cpr.value AS cena_nebo_mzda,
		cpr.category_code AS kod_odvetvi,
		cpc.name AS nazev_odvetvi
	FROM czechia_price cpr 
	CROSS JOIN czechia_price_category cpc 
		ON cpr.category_code = cpc.code
UNION 	
	SELECT
		cp.payroll_year AS rok,
		cp.value AS cena_nebo_mzda,
		cp.industry_branch_code AS kod_odvetvi,
		cpib.name AS nazev_odvetvi
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
		country AS zeme,
		`year` AS rok,
		GDP AS HDP,
		population AS populace,
		gini
	FROM economies e 
	WHERE `year` BETWEEN 2006 AND 2018
	ORDER BY `year` ASC
);

-- -- HLAVNÍ TABULKA SECONDARY - t_stepan_benes_project_SQL_secondary_final -- CROSS JOIN relevantních dat z pomocných tabulek

CREATE OR REPLACE TABLE t_stepan_benes_project_SQL_secondary_final AS (
	SELECT 
		tsce.country AS stat,
		tsce.continent AS kontinent,
		tsee.populace AS populace,
		tsee.HDP,
		tsee.gini AS gini,
		tsee.rok AS rok
	FROM t_stepanb_countries_edit tsce 
	CROSS JOIN t_stepanb_economies_edit tsee 
		ON tsce.country = tsee.zeme
)
;








	
