SELECT fine.id, driver_license, driver_license.categories
FROM fine
	JOIN driver_license ON fine.id = driver_license.id
LIMIT 10;