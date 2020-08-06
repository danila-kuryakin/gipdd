/*
 По имеющемуся водительскому удостоверению добавить его копию с переченм категорий,
 если срок действия уже истек на данный момент.
 */

drop procedure if exists driver_copy;
create procedure driver_copy(id_driver_ integer)
as $$
    DECLARE  rand_categ bigint;
        newdate timestamp;
        i bigint;
        max_rand integer;
        min_rand integer;
begin

    max_rand = 100000000;
    min_rand = 1000000;
    drop table if exists tmp;

    create temporary table tmp
    (
        "id" serial,
        "number" integer,
        "categories" integer,
        "data_and_time_of_issue" TIMESTAMP,
        "end_date_and_time" TIMESTAMP,
        "unit_gipdd" varchar(128),
        "people_id" integer
    );
    INSERT INTO tmp (select * from driver_license);

    newdate = statement_timestamp();
    if exists(select * from tmp where tmp.id = id_driver_ and tmp.end_date_and_time < newdate) then
        i = min_rand;
        loop
            rand_categ = (SELECT floor(random() * max_rand + min_rand));
            if not exists(select * from tmp where categories = rand_categ) then
                INSERT INTO driver_license (number, categories, data_and_time_of_issue, end_date_and_time, unit_gipdd, people_id)
                    select tmp.number, rand_categ, newdate, newdate + '10 YEAR', tmp.unit_gipdd, tmp.people_id
                    from tmp where id = id_driver_
                    limit 1;
                INSERT INTO categories(categories, id_categories)
                    select rand_categ, categories.id_categories from categories where categories.categories = (
                        select categories
                        from tmp where id = id_driver_
                        limit 1
                    );
                exit;
            end if;
            i = i + 1;
            if i > max_rand then
                exit;
            end if;
        end loop;
    end if;
end;
$$
    language plpgsql;

call driver_copy(1)