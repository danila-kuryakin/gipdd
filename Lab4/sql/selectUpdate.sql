UPDATE fine
SET driver_license = 72850
WHERE driver_license = 72849;

SELECT *
FROM fine
WHERE driver_license = 72849 or driver_license = 72850;

