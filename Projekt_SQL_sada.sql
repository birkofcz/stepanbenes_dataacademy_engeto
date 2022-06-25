
-- SQL SADA PRO VÝZKUMNÉ OTÁZKY --

-- 1. rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SELECT 
	rok,
	ROUND(AVG(cena_nebo_mzda)) as prumerna_mzda_nebo_cena,
	kod_odvetvi,
	nazev_odvetvi
FROM t_stepan_benes_project_SQL_primary_final
WHERE kod_odvetvi  ='A' -- vyměň si kód (mzdy)
GROUP BY rok 
-- ORDER by prumerna_mzda_nebo_cena ASC -- kontrolní. Nejdou-li roky po sobě, mzdy pokaždé nestoupaly
;


-- 2. Kolik je možné koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
-- mléko 114201 (po litrech)
-- chléb 111301 (po kilech)
-- první a poslední srovnatelní období - 2006 a 2018

	SELECT 
		rok,
		kod_odvetvi,
		nazev_odvetvi,
		ROUND(AVG(cena_nebo_mzda)) as prumerna_cena
	FROM t_stepan_benes_project_SQL_primary_final
	WHERE kod_odvetvi = 114201
		AND rok = 2006 -- vymen si rok
	;
	-- = 14 Kč / litr mléka v roce 2006
	-- = 20 Kč / litr mléka v roce 2018
	
	SELECT 
		rok,
		kod_odvetvi,
		nazev_odvetvi,
		ROUND(AVG(cena_nebo_mzda)) as prumerna_cena
	FROM t_stepan_benes_project_SQL_primary_final
	WHERE kod_odvetvi = 111301
		AND rok = 2006 -- vymen si rok
	;
	-- = 16 Kč / kilo chleba v roce 2006
	-- = 24 Kč / kilo chleba v roce 2018
	
-- MZDY - dotaz prvni otazky


-- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší meziroční procentuálnbí nárůst)?
 SELECT 
	rok,
	ROUND(AVG(cena_nebo_mzda)) as prumerna_mzda_nebo_cena,
	kod_odvetvi,
	nazev_odvetvi
FROM t_stepan_benes_project_SQL_primary_final
WHERE kod_odvetvi  = 111101 -- vyměň si kód (potraviny)
GROUP BY rok 
;

-- 4. Existuje rok, ve kterém byl meziroční nárust cen potravin výrazně vyšší než růst mezd (více než 10 procent?)
-- vyřešeno z již záskaných dat v podkladovém excelu

-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednim roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
SELECT *,
CAST (HDP AS INT)
FROM t_stepan_benes_project_SQL_secondary_final
WHERE stat = 'Czech Republic'
;



