CREATE TABLE "people" (
	"id" integer PRIMARY KEY,
	"first_name" varchar(128) NOT NULL,
	"last_name" varchar(128) NOT NULL,
	"middle_name" varchar(128)
);

CREATE TABLE "driver_license" (
	"id" integer PRIMARY KEY,
	"number" integer NOT NULL,
	"categories" integer UNIQUE,
	"data_and_time_of_issue" TIMESTAMP NOT NULL,
	"end_date_and_time" TIMESTAMP NOT NULL,
	"unit_gipdd" varchar(128) NOT NULL,
	"people_id" integer REFERENCES people (Id) NOT NULL
);

CREATE TABLE "inspector" (
	"id" integer PRIMARY KEY,
	"police_certificate" integer NOT NULL,
	"rank" varchar(128) NOT NULL,
	"people_id" integer REFERENCES people (Id) NOT NULL
);

CREATE TABLE "machine_directory" (
	"id" integer PRIMARY KEY,
	"brand" varchar(128) NOT NULL,
	"model" varchar(128)
);

CREATE TABLE "violation" (
	"id" integer PRIMARY KEY,
	"title" integer NOT NULL,
	"punishment" varchar(128) NOT NULL
);

CREATE TABLE "dir_categories" (
	"id" integer PRIMARY KEY,
	"name" varchar(2) NOT NULL
);

CREATE TABLE "categories" (
	"categories" integer REFERENCES driver_license (categories) NOT NULL,
	"id_categories" integer REFERENCES dir_categories (id) NOT NULL
);

CREATE TABLE "car" (
	"id" integer PRIMARY KEY,
	"registration_plate" varchar(12) NOT NULL UNIQUE,
	"brand_and_monel" integer NOT NULL,
	"categories" integer REFERENCES dir_categories (id) NOT NULL,
	"people_id" integer REFERENCES people (Id) NOT NULL
);

CREATE TABLE "fine" (
	"id" integer PRIMARY KEY,
	"driver_license" integer REFERENCES driver_license (Id) NOT NULL,
	"police_certificate" integer REFERENCES inspector (Id) NOT NULL,
	"data_and_time" TIMESTAMP NOT NULL,
	"id_violation" integer NOT NULL,
	"people_id" integer REFERENCES people (Id) NOT NULL
);

CREATE TABLE "dtp" (
	"id" integer PRIMARY KEY,
	"injured" integer UNIQUE,
	"guilty" integer UNIQUE,
	"damage_car" integer UNIQUE
);

CREATE TABLE "details" (
	"id" integer PRIMARY KEY,
	"name" varchar(128) NOT NULL
);

CREATE TABLE "damage_car" (
	"damage_car" integer REFERENCES dtp (damage_car) NOT NULL,
	"damage" integer UNIQUE
);

CREATE TABLE "damage" (
	"damage_id" integer REFERENCES details (id) NOT NULL,
	"damage" integer REFERENCES damage_car (damage)  NOT NULL
);

CREATE TABLE "injured" (
	"injured" integer REFERENCES dtp (injured) NOT NULL,
	"injured_id" integer REFERENCES car (id) NOT NULL
);

CREATE TABLE "guilty" (
	"guilty" integer REFERENCES dtp (guilty) NOT NULL,
	"guilty_id" integer REFERENCES car (id) NOT NULL
);

CREATE TABLE "osago" (
	"id" integer PRIMARY KEY,
	"data_and_time_of_issue" TIMESTAMP NOT NULL,
	"end_date_and_time" TIMESTAMP NOT NULL,
	"car" integer REFERENCES car (id) NOT NULL
);








