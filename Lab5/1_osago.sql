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