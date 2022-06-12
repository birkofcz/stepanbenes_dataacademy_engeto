
-- SQL SADA PRO VÝZKUMNÉ OTÁZKY --

-- 1. rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
SELECT *,
CAST(prumerna_mzda_nebo_cena as INT) as mzda_INT 
FROM t_stepan_benes_project_SQL_primary_final tsbpspf 
WHERE kod_odvetvi = 'S' -- vyměn si kód odvětví (mzdy)
-- ORDER by mzda ASC -- kontrolní. Nejdou-li roky po sobě, mzdy pokaždé nestoupaly
;


-- 2. Kolik je možné koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
-- mléko 114201 (po litrech)
-- chléb 113301 (po kilech)
-- první a pislední srovnatelní období - 2006 a 2018


	SELECT *
	FROM t_stepan_benes_project_SQL_primary_final
	WHERE kod_odvetvi = '114201'
	;
	-- = 14 Kč / litr mléka v roce 2006
	-- = 20 Kč / litr mléka v roce 2018
	
	SELECT *
	FROM t_stepan_benes_project_SQL_primary_final
	WHERE kod_odvetvi = '111301'
	;
	-- = 16 Kč / kilo chleba v roce 2006
	-- = 24 Kč / kilo chleba v roce 2018
	
SELECT *
FROM t_stepan_benes_project_SQL_primary_final
WHERE kod_odvetvi = 'S'-- vyměň si kod odvětví (mzdy)
;

-- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší meziroční procentuálnbí nárůst)?
SELECT *,
CAST(prumerna_mzda_nebo_cena as INT) as cena_INT
FROM t_stepan_benes_project_SQL_primary_final tsbpspf 
WHERE kod_odvetvi = '2000001' -- vyměn si kód odvětví (potraviny)
;

-- 4. Existuje rok, ve kterém byl meziroční nárust cen potravin výrazně vyšší než růst mezd (více než 10 procent?)
-- vyřešeno z již záskaných dat v podkladovém excelu

-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednim roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
SELECT *,
cast (HDP as INT)
FROM t_stepan_benes_project_SQL_secondary_final
where stat = 'Czech Republic'
;



