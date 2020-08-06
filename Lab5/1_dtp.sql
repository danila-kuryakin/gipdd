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

select * from get_driver_data_dtp_guilty(1);

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

select * from get_driver_data_dtp_injured(1);