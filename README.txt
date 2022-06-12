# stepanbenes_dataacademy_engeto

README PRO PROJEKT SQL - STEPAN BENES ------------------------

Přehled souborů:
----------------
Projekt_hlavni_tabulky.sql - skript pro vytvoření PRIMARY a SECONDARY tabulek + pomocných tabulek
Projekt_SQL_sada.sql - skript s dotazy nad PRIMARY a SECONDARY tabulkami
VO_podklady a analýza.xlsx - EXCEL s podkladovými tabulkami k výzkumným otázkám a odpovědmi na výzkumné otázky
README.md - průvodbí dokumentace k projektu

Jak jsem postupoval:
--------------------

1) Nejdříve jsem si prohlédl relevantní tabulky, jejich strukturu a přemýšlel, jak z nich dostat co nejlepší podklady

2) Jako relevantní společný údaj jsem identifikoval roky - pouze rozsah 2006 až 2018 - podle dat dostupných pro ceny potravin

3) S přihlédnutím k výzkumným otázkám jsem se rozhodl pro optiku jednotlivých let - údaje o cenách a výplatách jsem se rozhodl zprůměrovat na úrovni jednotlivých let, bez přihlédnutí k regionům, týdnům či čtvrtletím. I kdyby někde data scházela, skoky to nebudou nijak vysoké a zprůměrování bude dostatečně vypovídající údaj.

4) Rozdílný počet odvětví pro profese a pro potraviny mi zamotal hlavu při pokusu o rozumné spojení v jednu tabulku - na společných letech. Malé zkušenosti. Konám různé experimenty, žádný mi nepřináší uspokojivý výsledek. Bojím se nekonzistentnosti dat a nesmyslných propojení. Rozhoduji se pro amatérštější, transparentnější ... i když možné méně elegantní postup. 
   
5) Rozhoduji se pro tvorbu 4 pomocných tabulek pro primární tabulku a 2 pomocných tabulek pro sekundární tabulku. Využiji je pro přehledné očištění dat a postupné výpočty průměrů. 
	-- Primarni tabulka -- 
	I. t_stepanb_price_edited - selekce relevatních dat
	II. t_stepanb_payroll_edited - selekce relevantních dat
	III. t_stepan_price_avg - tvorba průměrných cen napříč republikou za jednotlivé roky - po jednotlivých odvětvích 
	IV. t_stepan_payroll_edited - počítání průměrných výplat za jednotlivé roky - po jednotlivých odvětvích
	--Sekundarni tabulka --
	I. t_stepanb_countries_edit - selekce relevantních dat
	II. t_stepanb_economies_edit - selekce relevantních dat

6) Pomocí JOINů si spojuji data z pomocných tabulek ve finální tabulky.

7) Tvořím skript pro dotazy nad finálními tabulkami. Jde už o velice jednoduché dotazy. Pro lepší formát dat pro následný přesun do Excelu využívám CAST a měním si číselné hodnoty na celá čísla. Jedná se v této chvíli už jen o korekci formátu, za desetinou tečkou jsou jen nuly. 

8) K podkladovým tabulkám a odpovědím na jednotlivé výzkumné otázky využívám EXCEL - "VO_podklady a analýza". Tvořím si zde potřebné přehledy a výpočty. Odpovídám na výzkumné otázky - k nalazení pod jednotlivými listy.


POznámky:
----------

- Skript s hlavními a pomocnými tabulkami začíná úklidovou sekcí - kontrolními selecty a dropy jednotlivých tabulek, aby bylo možné po sobě efektivně uklidit. Tvorba samotných tabulek je níže a lze ji spustit jako celek. 


