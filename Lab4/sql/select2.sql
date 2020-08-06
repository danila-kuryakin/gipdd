SELECT EXTRACT(YEAR FROM data_and_time) as year,violation.title as title, violation.punishment as description, count(EXTRACT(YEAR FROM data_and_time))
FROM fine
JOIN violation ON fine.id_violation = violation.id
GROUP BY id_violation, title, punishment,  year
ORDER BY id_violation ASC, year