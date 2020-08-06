drop procedure if exists procedureDelete;
create procedure procedureDelete()
as $$
    begin
        DELETE
        FROM fine
        WHERE driver_license = 72850;
    end
$$
    language plpgsql;