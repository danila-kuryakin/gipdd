SELECT driver_license, count(driver_license)
FROM fine
GROUP BY driver_license