SELECT osago.id, osago.data_and_time_of_issue, osago.end_date_and_time, car.registration_plate, car.categories
FROM osago
	JOIN car ON osago.car = car.id
LIMIT 10;