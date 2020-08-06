SELECT driver_license, MAX(id_violation)
FROM fine
	GROUP BY driver_license
LIMIT 10;