

-- Průměrné mzdy fytických osob podle odvětví - v letech
SELECT *
FROM czechia_payroll cp 
where 1=1
	and payroll_year = 2000 -- pracovní 
	and value_type_code = 5958 -- 5958 - průměrná hrubá mzda zaměstnance
	and calculation_code = 100 -- 100 - fyzické osoby
	and industry_branch_code is not NULL 
	and value is not null
	and industry_branch_code = 'A'
	

;

--  Vypočítá průměrnou mzdu za udaný rok, ve všech odvětvích --
SELECT 
	industry_branch_code as kod_odvetvi,
	payroll_year as rok,
	AVG(value) as prumerna_mzda
from czechia_payroll cp 
WHERE 1=1
	and payroll_year = 2000 -- definice roku
	and value_type_code  = 5958
	and calculation_code = 100
	AND industry_branch_code is not null
	and value is not null
group by industry_branch_code
;

-- Vypočítá průměrnou mzdu za jednotlivé roky podle zadaného odvětví -- 
SELECT 
	payroll_year as rok,
	AVG(value) as prumerna_mzda,
	industry_branch_code as kod_odvetvi
from czechia_payroll cp 
WHERE 1=1
	and industry_branch_code = 'A' -- definice odvětví
	and value_type_code  = 5958
	and calculation_code = 100
	AND industry_branch_code is not null
	and value is not null
group by payroll_year 
;

