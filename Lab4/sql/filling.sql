INSERT INTO people (id,first_name, last_name, middle_name)
VALUES ( 100000,'Александр', 'Сидоров', 'Александрович');

INSERT INTO driver_license ( number, categories, data_and_time_of_issue,
							end_date_and_time, unit_gipdd, people_id) 
VALUES (782212, 1, '2010-05-01', '2020-05-01', 'ГИБДД 7816', 100000);

INSERT INTO inspector (police_certificate, rank, people_id)
VALUES (12345, 'Лейтенант', 100000);

INSERT INTO machine_directory (brand, model)
VALUES ('LADA', 'Vesta');

INSERT INTO violation (id, title, punishment)
VALUES (100000, 1.1, 'Превышение скорости');

INSERT INTO dir_categories ( name)
VALUES ('BE');

INSERT INTO car (registration_plate, brand_and_monel, categories, people_id)
VALUES ('B123KX178', 1, 100000, 100000);

INSERT INTO osago (data_and_time_of_issue, end_date_and_time, car)
VALUES ('2018-05-01', '2019-05-01', 100000);

INSERT INTO categories ( categories, id_categories)
VALUES (100000, 1);

INSERT INTO fine ( driver_license, police_certificate, data_and_time, id_violation)
VALUES (100000, 100000, '2018-12-10', 100000);

INSERT INTO dtp ( injured, guilty, damage_car)
VALUES (100000, 100000, 100000);

INSERT INTO details (name)
VALUES ('Левое крыло');

INSERT INTO damage_car (damage_car, damage) 
VALUES (100000, 1);

INSERT INTO damage (damage_id, damage) 
VALUES (1, 1);

INSERT INTO injured (injured, injured_id) 
VALUES (1, 1);

INSERT INTO guilty (guilty, guilty_id) 
VALUES (2, 1);











