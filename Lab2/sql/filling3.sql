INSERT INTO people (first_name, last_name, middle_name)
VALUES ('Александр', 'Сидоров', 'Александрович'),
('Иван', 'Иванов', 'Иванович'),
('Петров', 'Григорий', 'Антонович');

INSERT INTO driver_license (number, categories, data_and_time_of_issue,
							end_date_and_time, unit_gipdd, people_id)
VALUES (782212, 1, '2010-05-01', '2020-05-01', 'ГИБДД 7816', 1),
(782245, 2, '2012-08-01', '2022-08-01', 'ГИБДД 7816', 2);

INSERT INTO inspector (police_certificate, rank, people_id)
VALUES (12345, 'Лейтенант', 1),
(45678,'Лейтенант', 2);

INSERT INTO machine_directory (brand, model)
VALUES ('LADA', 'Vesta'),
('LADA', 'Xray'),
('Reno', 'Lagan');

INSERT INTO violation (title, punishment)
VALUES (1000, 'Превышение скорости'),
( 500, 'Неправильная парковка');

INSERT INTO dir_categories (name)
VALUES ('A'),
('B'),
('C'),
('D');

INSERT INTO categories (id_categories)
VALUES (1),
(1);

INSERT INTO car (registration_plate, brand_and_monel, categories, people_id)
VALUES ('B123KX178', 1, 2, 1),
('А777AA64', 2, 2, 2);

INSERT INTO fine (driver_license, police_certificate, data_and_time, id_violation)
VALUES (1, 2, '2018-12-10', 1);

INSERT INTO dtp ( injured, guilty, damage_car)
VALUES (1, 1, 1),
(2, 2, 2);

INSERT INTO details (name)
VALUES ('Левое крыло'),
('Правое крыло'),
('Передний бампер');

INSERT INTO damage_car (damage_car)
VALUES (1),
(2);

INSERT INTO damage (damage_id)
VALUES (1),
(2);

INSERT INTO injured ( injured_id)
VALUES (1),
(2);

INSERT INTO guilty (guilty_id)
VALUES (1),
(2);

INSERT INTO osago (data_and_time_of_issue, end_date_and_time, drivers)
VALUES ('2018-05-01', '2019-05-01', 1),
VALUES ('2017-12-05', '2019-12-05', 2);

INSERT INTO drivers (drivers, drivers_id)
VALUES (1),
VALUES (2);











