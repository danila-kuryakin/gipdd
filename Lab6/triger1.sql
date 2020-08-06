/*
 При фиксации нарушения проверять наличие действующего водительского удостоверения
 на момент нарушения. Если нет - выбрасывать исключение и не добавлять.
 */

CREATE OR REPLACE FUNCTION valid_dl() RETURNS trigger AS $valid_dl$
    DECLARE
        today_date timestamp;
        tmp timestamp;
    BEGIN

        today_date = statement_timestamp();
        SELECT driver_license.end_date_and_time
        INTO tmp
        FROM driver_license
        WHERE NEW.driver_license = driver_license.id;

        IF (today_date < tmp) THEN
                RETURN NEW;
            ELSE
                RAISE EXCEPTION 'Driver license expired.';
        END IF;
    END;
    $valid_dl$ LANGUAGE plpgsql;

CREATE TRIGGER valid_dl_trigger
     BEFORE INSERT OR UPDATE ON fine
     FOR EACH ROW
     EXECUTE PROCEDURE valid_dl();