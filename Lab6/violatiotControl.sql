/*
    При удаление violation все штрафы принимают другое violation.
*/

CREATE OR REPLACE FUNCTION violation_control() RETURNS trigger AS $violation_control$
    DECLARE
        i BIGINT;
    BEGIN
        i = 1;
        IF (SELECT id FROM violation WHERE (SELECT COUNT(*) FROM violation) = 1) IS NOT NULL and (SELECT id FROM fine) IS NOT NULL THEN
            RAISE EXCEPTION 'First remove all the fines';
        end if;
        FOR i IN (SELECT id FROM violation)
        LOOP
            IF(SELECT id FROM violation WHERE id = i and id != old.id) IS NOT NULL THEN
                UPDATE fine SET id_violation = i where id_violation = old.id;
                RETURN old;
            ELSE
                i = i + 1;
            END IF;
        end loop;
    END;
$violation_control$ LANGUAGE plpgsql;

CREATE TRIGGER violation_control_trigger
     BEFORE DELETE ON violation
     FOR EACH ROW
     EXECUTE PROCEDURE violation_control();
