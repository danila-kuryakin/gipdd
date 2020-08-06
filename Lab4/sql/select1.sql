WITH dtp_new AS (SELECT car.people_id AS people, count(car.people_id) AS count_guilty
            FROM guilty
            JOIN dtp ON guilty.guilty = dtp.guilty
            JOIN car ON guilty.guilty_id = car.id
            GROUP BY car.people_id),
      fine_new AS (SELECT driver_license.people_id as people_id_fine, count(fine.driver_license) AS count_fine
            FROM fine
            JOIN driver_license ON fine.driver_license = driver_license.id
            GROUP BY driver_license.people_id)
SELECT dtp_new.people, fine_new.count_fine/dtp_new.count_guilty AS attitude,
       fine_new.count_fine, dtp_new.count_guilty
FROM dtp_new
JOIN fine_new ON dtp_new.people = fine_new.people_id_fine
ORDER BY attitude DESC
LIMIT 10
