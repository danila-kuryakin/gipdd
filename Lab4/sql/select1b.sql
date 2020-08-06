SELECT driver_license.people_id as people_id_fine, count(fine.driver_license) AS count_fine
FROM fine
JOIN driver_license ON fine.driver_license = driver_license.id
GROUP BY driver_license.people_id
ORDER BY driver_license.people_id ASC