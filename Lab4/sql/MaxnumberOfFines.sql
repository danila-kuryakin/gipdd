SELECT MAX(c.cnt) AS maxFine
FROM(SELECT COUNT(driver_license) AS cnt 
	 FROM fine 
	 GROUP BY driver_license) c
