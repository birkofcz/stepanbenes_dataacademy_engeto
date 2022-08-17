# Skript pro kola Edinburgh

SELECT * FROM edinburgh_bikes
	
# Stanice a jejich cetnost v modu startovnich a koncovych
	
	SELECT t1.station_name, count_start, count_end, s_lat, s_long
	FROM
		(SELECT 
		start_station_name AS station_name,
		COUNT(start_station_name) as count_start,
		start_station_latitude as s_lat,
		start_station_longitude as s_long
		FROM edinburgh_bikes
		group by start_station_name 
		order by station_name ASC) t1 
	INNER JOIN
		(SELECT 
		end_station_name AS station_name,
		COUNT(end_station_name) as count_end
		FROM edinburgh_bikes
		group by end_station_name 
		order by station_name ASC)t2
	ON t1.station_name = t2.station_name
	
	# rozsirene o pocitani prumerne obratky kol za den
	
	SELECT t1.station_name, count_start, ROUND(count_start/1019) as avg_start_day, count_end, ROUND(count_end/1019) as avg_end_day, s_lat, s_long
	FROM
		(SELECT 
		start_station_name AS station_name,
		COUNT(start_station_name) as count_start,
		start_station_latitude as s_lat,
		start_station_longitude as s_long
		FROM edinburgh_bikes
		group by start_station_name 
		order by station_name ASC) t1 
	INNER JOIN
		(SELECT 
		end_station_name AS station_name,
		COUNT(end_station_name) as count_end
		FROM edinburgh_bikes
		group by end_station_name 
		order by station_name ASC)t2
	ON t1.station_name = t2.station_name
	
	# rozsireny query o pocitani, kde kola chybi a kde prebyvaji. Je 1019 sledovaných dní a 33 sledovaných měsíců
	
	SELECT 
		t1.station_name, 
		count_start,
		count_end,
		t1.s_lat,
		t1.s_long,
		((count_end - count_start) < 0) as is_lacking_bikes,
		(ROUND((count_end - count_start) / 1019)) as lack_or_over_daily_avg
		#(((count_end - count_start) / 1019) > 2 or ((count_end - count_start) / 1019) < -2) as does_need_adjust
	FROM
		(SELECT 
		start_station_name AS station_name,
		COUNT(start_station_name) as count_start,
		start_station_latitude as s_lat,
		start_station_longitude as s_long
		FROM edinburgh_bikes
		group by start_station_name 
		order by station_name ASC) t1 
	INNER JOIN
		(SELECT 
		end_station_name AS station_name,
		COUNT(end_station_name) as count_end,
		end_station_latitude as s_lat,
		end_station_longitude as s_long
		FROM edinburgh_bikes
		group by end_station_name 
		order by station_name ASC)t2
	ON t1.station_name = t2.station_name
	
	# edinburgh weather
	
	SELECT * FROM edinburgh_weather 
	
	SELECT * 
	FROM edinburgh_weather 
	WHERE date >= "2018-09-15" and date <= "2020-06-30"
	
	
		
	
	




