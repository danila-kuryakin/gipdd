/*
 По заданному водителю вывести всю информацию:
 нарушения
 полисы
 ДТП
 */

CREATE OR REPLACE FUNCTION get_driver_data_dtp_guilty(id_driver_ integer)
RETURNS table(id_driver integer, dtp_id integer, car integer, car_injured integer, details_name varchar)
AS $$
    SELECT driver_license.id as id_driver, dtp.id AS dtp_id, c1.id AS car, c2.id AS car_injured, det.name AS details_name
    FROM driver_license
    JOIN people ON driver_license.people_id = people.id
    JOIN car c1 ON people.id = c1.people_id
    JOIN guilty ON c1.id = guilty.guilty_id
    JOIN dtp ON guilty.guilty = dtp.guilty
    JOIN injured ON dtp.injured = injured.injured
    JOIN car c2 ON injured.injured_id = c2.id
    JOIN damage_car dc on dtp.damage_car = dc.damage_car
    JOIN damage dam on dc.damage = dam.damage
    JOIN details det on dam.damage_id = det.id
    WHERE driver_license.id = id_driver_

$$
LANGUAGE sql;

select * from get_driver_data_dtp_guilty(5);

CREATE OR REPLACE FUNCTION get_driver_data_dtp_injured(id_driver_ integer)
RETURNS table(id_driver integer, dtp_id integer, car integer, car_guilty integer, details_name varchar)
AS $$
    SELECT driver_license.id as id_driver, dtp.id AS dtp_id, c1.id AS car, c2.id AS car_guilty, det.name AS details_name
    FROM driver_license
    JOIN people ON driver_license.people_id = people.id
    JOIN car c1 ON people.id = c1.people_id
    JOIN injured ON c1.id = injured.injured_id
    JOIN dtp ON injured.injured = dtp.injured
    JOIN guilty ON dtp.guilty = guilty.guilty
    JOIN car c2 ON guilty.guilty_id = c2.id
    JOIN damage_car dc on dtp.damage_car = dc.damage_car
    JOIN damage dam on dc.damage = dam.damage
    JOIN details det on dam.damage_id = det.id
    WHERE driver_license.id = id_driver_
$$
LANGUAGE sql;

select * from get_driver_data_dtp_injured(5);

CREATE OR REPLACE FUNCTION get_driver_data_fine(id_driver_ integer)
RETURNS table(id_driver integer, fine_id integer, fine_police_certificate integer, fine_data_and_time TIMESTAMP, fine_id_violation integer, violation_title text, violation_punishment text)
AS $$
    SELECT driver_license.id as id_driver, fine.id AS fine_id,
           fine.police_certificate AS fine_police_certificate, fine.data_and_time AS fine_data_and_time, fine.id_violation AS fine_id_violation, violation.title AS violation_title, violation.punishment AS violation_punishment
    FROM driver_license
    JOIN fine ON driver_license.id = fine.driver_license
    JOIN violation ON fine.id_violation = violation.id
    WHERE driver_license.id = id_driver_

$$
LANGUAGE sql;

select * from get_driver_data_fine(5);

CREATE OR REPLACE FUNCTION get_driver_data_osago(id_driver_ integer)
RETURNS table(id_driver integer,
                osago_id integer,
                osago_data_and_time_of_issue TIMESTAMP,
                osago_end_date_and_time TIMESTAMP,
                osago_car varchar(12)
             )
AS $$
    SELECT driver_license.id as id_driver,
           osago.id AS osago_id,
           osago.data_and_time_of_issue AS osago_data_and_time_of_issue,
           osago.end_date_and_time AS osago_end_date_and_time,
           osago.car AS osago_car
    FROM driver_license
    JOIN people ON driver_license.people_id = people.id
    JOIN car ON people.id = car.people_id
    JOIN osago ON car.registration_plate = osago.car
    WHERE driver_license.id = id_driver_

$$
LANGUAGE sql;

select * from get_driver_data_osago(5);