/*
 Тригер который добавляет к максимальному id две единцы.
 */

CREATE OR REPLACE FUNCTION violation_auto_key() RETURNS trigger AS $violation_auto_key$
    BEGIN
        new.id = (SELECT max(id) FROM violation) + 2;
        RETURN new;
    END;
    $violation_auto_key$ LANGUAGE plpgsql;

CREATE TRIGGER violation_auto_key_trigger
     BEFORE INSERT OR UPDATE ON violation
     FOR EACH ROW
     EXECUTE PROCEDURE violation_auto_key();

SELECT max(id) FROM violation;

insert into violation (title, punishment)
VALUES (1.1,'Test1')
