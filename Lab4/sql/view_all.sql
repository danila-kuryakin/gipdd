CREATE OR REPLACE VIEW select_categories AS
    SELECT *
    FROM car
    WHERE id IN (31, 32, 33, 34)
    AND categories = 1;

CREATE OR REPLACE VIEW select_Between AS
    SELECT *
    FROM inspector
    WHERE id BETWEEN 0 AND 20
    AND people_id < 10;

CREATE OR REPLACE VIEW select_Like AS
    SELECT *
    FROM people
    WHERE first_name LIKE 'e%';

CREATE OR REPLACE VIEW select_Сalculate AS
    SELECT id, driver_license + 100000 AS driver_license2,
    police_certificate - 100000 AS police_certificate2
    FROM fine
    LIMIT 10;

CREATE OR REPLACE VIEW select_OrderBy AS
    SELECT *
    FROM people
    ORDER BY last_name ASC, first_name ASC
    LIMIT 10;

CREATE OR REPLACE VIEW select_aggregate AS
SELECT COUNT(*) AS count,
	AVG(driver_license) AS driver_license_max,
	MAX(police_certificate) AS police_certificate_max,
	MAX(data_and_time) AS data_and_time_max,
	MIN(data_and_time) AS data_and_time_min
FROM fine;

CREATE OR REPLACE VIEW select_Join1 AS
    SELECT fine.id, driver_license, driver_license.categories
    FROM fine
    JOIN driver_license ON fine.id = driver_license.id
    LIMIT 10;

CREATE OR REPLACE VIEW select_group AS
    SELECT driver_license, MAX(id_violation)
    FROM fine
    GROUP BY driver_license
    LIMIT 10;

CREATE OR REPLACE VIEW select_maxNumberOfFines AS
    SELECT MAX(c.cnt) AS maxFine
    FROM(SELECT COUNT(driver_license) AS cnt
         FROM fine
         GROUP BY driver_license) c;

CREATE OR REPLACE VIEW select1_attitude AS
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
    LIMIT 10;

CREATE OR REPLACE VIEW select2_CountFineInYear AS
    SELECT EXTRACT(YEAR FROM data_and_time) as year,violation.title as title, violation.punishment as description, count(EXTRACT(YEAR FROM data_and_time))
    FROM fine
    JOIN violation ON fine.id_violation = violation.id
    GROUP BY id_violation, title, punishment,  year
    ORDER BY id_violation ASC, year;

CREATE OR REPLACE VIEW select3_CarInMaxDTP AS
    SELECT car.people_id AS car_people_id, count(car.people_id) AS count_guilty
    FROM guilty
    JOIN dtp ON guilty.guilty = dtp.guilty
    JOIN car ON guilty.guilty_id = car.id
    GROUP BY car.id
    ORDER BY count_guilty DESC
    limit 10;








