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

select * from get_driver_data_fine(1);