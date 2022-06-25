# stepanbenes_dataacademy_engeto

README PRO PROJEKT SQL - STEPAN BENES ------------------------



2022_06_25: POPIS ZMĚN V REAKCI NA ZPĚTNOU VAZBU

-----
1. Průvodní listina obsahuje základní strukturu a popisuje postup. To zlepšuje přehlednost projektu. Nicméně jsem v ní našel trošičku překlepů a možná by zasloužila trošku učesat z pohledu markdownu. GitHub to renderuje tak nějak zvláštně.
-----
- Nové README jsem se snažil napsat bez chyb a lépe zalamovat. Na GitHubu se mi to renderuje dobře.

-----
2. Repozitář by nemusel obsahovat tento soubor https://github.com/birkofcz/stepanbenes_dataacademy_engeto/blob/main/.project, který je čistě pracovní. Bylo by vhodné jej zahrnout do .gitignore.
-----
- OPRAVENO. Naučil jsem se vytvořit .gitignore a soubor do něj přidal. Repozitář mi obecně občas vracel chyby, proto jsem jej celý obnovil do čisté podoby. Nyní již fungují commity a pully bez problémů.

-----
3. SQL jsou dobře strukturované a to zlepšuje jejich čitelnost. Občas nemáš sjednocena rezervovaná slova na kapitálky - to by se ještě hodilo sjednotit.
-----
- OPRAVENO - v upravených skriptech sjednoceno

-----
4. Nějak necháput takovou extrémní složitost https://github.com/birkofcz/stepanbenes_dataacademy_engeto/blob/main/Projekt_hlavni_tabulky.sql - proč děláš tolik UNION. Nakonec přece vybereš všechny kategorie. Nešlo by jedním dotazem bez konkrétních WHERE a poté nutnosti UNIONs? 
-----
- Zkoušel jsem varianty bez WHERE, selecty mi ale vrací divné výstupy, které si mi nedařilo opravit. V této podobě to dobře fungovalo jen přes ty UNIONy. Fakticky to tolik práce nebylo, jen CTRL+C a CTRL+V. Nicméně jednoduchý a čistý kód to není, uznávám. Vrátil jsem se proto o krok zpět a úplně vynechal pomocné tabulky. Primární tabulku jsem vyřešil pro jeden CREATE TABLE. Celé je to teď čistší. Průměrné ceny a mzdy si pak SELECTuji až v dotazech nad primární tabulkou. 

-----
5. Proč je zde blok úklidu? https://github.com/birkofcz/stepanbenes_dataacademy_engeto/blob/main/Projekt_hlavni_tabulky.sql#L6 Proč se nemá pouštět? Není tedy lepší odstranit, nebo upravit dotazy s IF EXISTS přepínači, aby SQL nespadly, když objekty neexistují?
-----
- Pravda, používal jsem to při tvorbě, abych si ulehčil psaní, ve finálním skriptu je to ale zbytečné a odstranil jsem to. Teď je to mnohem kratší a přehlednější.
 
-----
6. Opět problém s UNIONs v https://github.com/birkofcz/stepanbenes_dataacademy_engeto/blob/main/Projekt_hlavni_tabulky.sql a jak se tento soubor liší od předchozího SQL scriptu?
-----
- Tady tomu moc nerozumím. Vypadá to, jako by tam snad byl ten soubor zdvojený na nějakých konfliktních změnách. Má tam být pouze jednou. Jak jsem psal v prvním bodě, práce s gitem mi občas vracela chyby, zřejmě na nějakém konfliktu, kdy jsem se o commity a pully snažil střídavě z BASHe a z Dbeaveru, kde to není úplně optimální. Repozitář jsem nicméně vyčistil a pak už commitoval jen úpravy ze zpětné vazby - a čistě z terminálu.

------
7. Analýzu pro odpovězení na výzkumné otázky https://github.com/birkofcz/stepanbenes_dataacademy_engeto/blob/main/VO_podklady%20a%20analy%CC%81za.xlsx jsi udělal moc pěkně. Díky za to :) K tomu nemám připomínky ;)
------
- Děkuji!

-----
8. Ještě poznámka ke commitům. Je super, že jsi postupně commitoval a je vidět postup. Nicméně bych volil spíše angličtinu. Doporučuji pohledat "how to write commit message"
-----
- Rozumím. Nové commity už mají anglické popisy, podle pravidla KISS - Keep it short and simple. 


Přehled souborů:
----------------
Projekt_hlavni_tabulky.sql - skript pro vytvoření PRIMARY a SECONDARY tabulek 
Projekt_SQL_sada.sql - skript s dotazy nad PRIMARY a SECONDARY tabulkami
VO_podklady a analýza.xlsx - EXCEL s podkladovými tabulkami k výzkumným otázkám a odpovědmi na výzkumné otázky
README.txt - průvodní dokumentace k projektu







2022_06_12: ODEVZDÁNÍ PROJEKTU


Jak jsem postupoval:
--------------------

1) Nejdříve jsem si prohlédl relevantní tabulky, jejich strukturu a přemýšlel, jak z nich dostat co nejlepší podklady

2) Jako relevantní společný údaj jsem identifikoval roky - pouze rozsah 2006 až 2018 - podle dat dostupných pro ceny potravin

3) S přihlédnutím k výzkumným otázkám jsem se rozhodl pro optiku jednotlivých let - údaje o cenách a výplatách jsem se rozhodl zprůměrovat na úrovni jednotlivých let, bez přihlédnutí k regionům, týdnům či čtvrtletím. I kdyby někde data scházela, skoky to nebudou nijak vysoké a zprůměrování bude dostatečně vypovídající údaj.

4) Rozdílný počet odvětví pro profese a pro potraviny mi zamotal hlavu při pokusu o rozumné spojení v jednu tabulku - na společných letech. Malé zkušenosti. Konám různé experimenty, žádný mi nepřináší uspokojivý výsledek. Bojím se nekonzistentnosti dat a nesmyslných propojení. Rozhoduji se pro amatérštější, transparentnější ... i když možné méně elegantní postup. 
   
5) Rozhoduji se pro tvorbu 4 pomocných tabulek pro primární tabulku a 2 pomocných tabulek pro sekundární tabulku. Využiji je pro přehledné očištění dat a postupné výpočty průměrů. 
	-- Primarni tabulka -- 
	I. t_stepanb_price_edited - selekce relevantních dat
	II. t_stepanb_payroll_edited - selekce relevantních dat
	III. t_stepan_price_avg - tvorba průměrných cen napříč republikou za jednotlivé roky - po jednotlivých odvětvích 
	IV. t_stepan_payroll_edited - počítání průměrných výplat za jednotlivé roky - po jednotlivých odvětvích
	--Sekundarni tabulka --
	I. t_stepanb_countries_edit - selekce relevantních dat
	II. t_stepanb_economies_edit - selekce relevantních dat

6) Pomocí JOINů si spojuji data z pomocných tabulek ve finální tabulky.

7) Tvořím skript pro dotazy nad finálními tabulkami. Jde už o velice jednoduché dotazy. Pro lepší formát dat pro následný přesun do Excelu využívám CAST a měním si číselné hodnoty na celá čísla. Jedná se v této chvíli už jen o korekci formátu, za desetinou tečkou jsou jen nuly. 

8) K podkladovým tabulkám a odpovědím na jednotlivé výzkumné otázky využívám EXCEL - "VO_podklady a analýza". Tvořím si zde potřebné přehledy a výpočty. Odpovídám na výzkumné otázky.


POznámky:
----------

- Skript s hlavními a pomocnými tabulkami začíná úklidovou sekcí - kontrolními selecty a dropy jednotlivých tabulek, aby bylo možné po sobě efektivně uklidit. Tvorba samotných tabulek je níže a lze ji spustit jako celek. 


