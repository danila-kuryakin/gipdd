/*
 При включении категории в водительское удостоверение проверять наличие.
 Если уже есть - выбрасывать исключение и не добавлять дубль.
 */

CREATE OR REPLACE FUNCTION unique_category() RETURNS trigger AS $unique_category$
    DECLARE
        tmp integer;
    BEGIN
        SELECT categories.id_categories
        INTO tmp
        FROM categories
        where categories.categories = NEW.categories and categories.id_categories = NEW.id_categories;

        IF (tmp IS NULL ) THEN
                RETURN NEW;
            ELSE
                RAISE EXCEPTION 'Category not unique.';
            END IF;
    END;
    $unique_category$ LANGUAGE plpgsql;

CREATE TRIGGER unique_category_trigger
     BEFORE INSERT OR UPDATE ON categories
     FOR EACH ROW
     EXECUTE PROCEDURE unique_category();