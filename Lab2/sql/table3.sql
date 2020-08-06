CREATE TABLE "people" (
	"id" serial PRIMARY KEY,
	"first_name" varchar(128) NOT NULL,
	"last_name" varchar(128) NOT NULL,
	"middle_name" varchar(128)
);

CREATE TABLE "driver_license" (
	"id" serial PRIMARY KEY,
	"number" integer NOT NULL,
	"categories" serial UNIQUE,
	"data_and_time_of_issue" TIMESTAMP NOT NULL,
	"end_date_and_time" TIMESTAMP NOT NULL,
	"unit_gipdd" varchar(128) NOT NULL,
	"people_id" integer REFERENCES people (Id) NOT NULL
);

CREATE TABLE "inspector" (
	"id" serial PRIMARY KEY,
	"police_certificate" integer NOT NULL,
	"rank" varchar(128) NOT NULL,
	"people_id" integer REFERENCES people (Id) NOT NULL
);

CREATE TABLE "machine_directory" (
	"id" serial PRIMARY KEY,
	"brand" varchar(128) NOT NULL,
	"model" varchar(128)
);

CREATE TABLE "violation" (
	"id" serial PRIMARY KEY,
	"title" varchar(128) NOT NULL,
	"punishment" varchar(128) NOT NULL
);

CREATE TABLE "dir_categories" (
	"id" serial PRIMARY KEY,
	"name" varchar(2) NOT NULL
);

CREATE TABLE "categories" (
	"categories" integer REFERENCES driver_license (categories) NOT NULL,
	"id_categories" integer REFERENCES dir_categories (id) NOT NULL
);

CREATE TABLE "car" (
	"id" serial PRIMARY KEY,
	"registration_plate" varchar(12) NOT NULL UNIQUE,
	"brand_and_monel" integer NOT NULL,
	"categories" integer REFERENCES dir_categories (id) NOT NULL,
	"people_id" integer REFERENCES people (Id) NOT NULL
);

CREATE TABLE "fine" (
	"id" serial PRIMARY KEY,
	"driver_license" integer REFERENCES driver_license (Id) NOT NULL,
	"police_certificate" integer REFERENCES inspector (Id) NOT NULL,
	"data_and_time" TIMESTAMP NOT NULL,
	"id_violation" integer NOT NULL
);

CREATE TABLE "dtp" (
	"id" serial PRIMARY KEY,
	"injured" integer UNIQUE,
	"guilty" integer UNIQUE,
	"damage_car" integer UNIQUE
);

CREATE TABLE "details" (
	"id" serial PRIMARY KEY,
	"name" varchar(128) NOT NULL
);

CREATE TABLE "damage_car" (
	"damage_car" integer REFERENCES dtp (damage_car) NOT NULL,
	"damage" integer NOT NULL UNIQUE
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
	"id" serial PRIMARY KEY,
	"data_and_time_of_issue" TIMESTAMP NOT NULL,
	"end_date_and_time" TIMESTAMP NOT NULL,
	"car" varchar(12) REFERENCES car (registration_plate) NOT NULL
);








