SELECT car.people_id AS people, count(car.people_id) AS count_guilty
FROM guilty
JOIN dtp ON guilty.guilty = dtp.guilty
JOIN car ON guilty.guilty_id = car.id
GROUP BY car.people_id