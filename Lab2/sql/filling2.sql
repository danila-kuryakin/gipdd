INSERT INTO people ( id, first_name, last_name, middle_name) 
VALUES (1, 'Александр', 'Сидоров', 'Александрович'),
(2, 'Иван', 'Иванов', 'Иванович'),
(3, 'Петров', 'Григорий', 'Антонович');

INSERT INTO driver_license ( id, numer, categories, data_and_time_of_issue, 
							end_date_and_time, unit_gipdd, people_id) 
VALUES (1, 782212, 1, '2010-05-01', '2020-05-01', 'ГИБДД 7816', 1),
(2, 782245, 2, '2012-08-01', '2022-08-01', 'ГИБДД 7816', 2);

INSERT INTO inspector ( id, police_certificate, rank, people_id) 
VALUES (1, 12345, 'Лейтенант', 1),
(2, 45678,'Лейтенант', 2);

INSERT INTO machine_directory ( id, brand, model) 
VALUES (1, 'LADA', 'Vesta'),
(2, 'LADA', 'Xray'),
(3, 'Reno', 'Lagan');

INSERT INTO violation ( id, title, punishment) 
VALUES (1, 1000, 'Превышение скорости'),
(2, 500, 'Неправильная парковка');

INSERT INTO dir_categories ( id, name) 
VALUES (1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D');

INSERT INTO categories ( categories, id_categories) 
VALUES (1, 1), 
(1, 1);

INSERT INTO car ( id, registration_plate, brand_and_monel, categories, people_id) 
VALUES (1, 'B123KX178', 1, 2, 1), 
(2, 'А777AA64', 2, 2, 2);

INSERT INTO fine ( id, driver_license, police_certificate, data_and_time, id_violation, people_id) 
VALUES (1, 1, 2, '2018-12-10', 1, 1);

INSERT INTO dtp ( id, injured, guilty, damage_car) 
VALUES (1, 1, 1, 1),
(2, 2, 2, 2);

INSERT INTO details ( id, name) 
VALUES (1, 'Левое крыло'),
(2, 'Правое крыло'),
(3, 'Передний бампер');

INSERT INTO damage_car (damage_car, damage) 
VALUES (1, 1),
(2, 2);

INSERT INTO damage (damage_id, damage) 
VALUES (1, 1),
(2, 2);

INSERT INTO injured (injured, injured_id) 
VALUES (1, 1),
(2, 2);

INSERT INTO guilty (guilty, guilty_id) 
VALUES (2, 1),
(1, 2);

INSERT INTO osago (id, data_and_time_of_issue, end_date_and_time, drivers) 
VALUES (1, '2018-05-01', '2019-05-01', 1),
VALUES (2, '2017-12-05', '2019-12-05', 2);

INSERT INTO drivers (drivers, drivers_id) 
VALUES (1, 1),
VALUES (2, 2);











