SELECT COUNT(*) AS count,
	AVG(driver_license) AS driver_license_max,
	MAX(police_certificate) AS police_certificate_max,
	MAX(data_and_time) AS data_and_time_max,
	MIN(data_and_time) AS data_and_time_min
FROM fine;