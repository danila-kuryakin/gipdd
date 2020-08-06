SELECT car.people_id AS car_people_id, count(car.people_id) AS count_guilty
FROM guilty
JOIN dtp ON guilty.guilty = dtp.guilty
JOIN car ON guilty.guilty_id = car.id
GROUP BY car.id
ORDER BY count_guilty DESC
limit 10
