SELECT id, driver_license + 100000 AS driver_license2,
police_certificate - 100000 AS police_certificate2
FROM fine
LIMIT 10;