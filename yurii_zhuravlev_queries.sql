# Query #1: get a list of all employees, ordered by last name
SELECT *
FROM yurii_zhuravlev_cherkasy_electro_trans.employe AS t_employe
ORDER BY t_employe.lastname;

# Query #2: get average salary by employee
SELECT t_employe.id,
       t_employe.firstname,
       t_employe.lastname,
       AVG(t_salary.amount) as average_salary
FROM yurii_zhuravlev_cherkasy_electro_trans.salary AS t_salary
JOIN yurii_zhuravlev_cherkasy_electro_trans.employe AS t_employe
    ON t_salary.employe_id = t_employe.id
GROUP BY t_salary.employe_id;

# Query #3: get average and highest current salary by position (store current salary in the employees table)
SELECT t_position.id,
       t_position.title,
       AVG(t_salary.amount) AS average_salary,
       MAX(t_employe.monthly_salary) AS highest_current_salary
FROM yurii_zhuravlev_cherkasy_electro_trans.position AS t_position
JOIN yurii_zhuravlev_cherkasy_electro_trans.employe AS t_employe
    ON t_position.id = t_employe.position_id
JOIN yurii_zhuravlev_cherkasy_electro_trans.salary AS t_salary
    ON t_position.id = t_salary.position_id
GROUP BY t_position.id;

# Query #4: get total number of days every person worked and total income
SELECT t_employe.id,
       t_employe.firstname,
       t_employe.lastname,
       COUNT(*) AS total_days,
       SUM(t_race.tickets_sold * t_route.price) AS total_income
FROM yurii_zhuravlev_cherkasy_electro_trans.race AS t_race
JOIN yurii_zhuravlev_cherkasy_electro_trans.employe AS t_employe
    ON t_race.employe_id = t_employe.id
JOIN yurii_zhuravlev_cherkasy_electro_trans.route AS t_route
    ON t_race.route_id = t_route.id
GROUP BY t_employe.id;

# Query #5: get overall (total) income by transport, average income and a number of working days in the descending order
SELECT t_transport.id,
       t_transport.model,
       t_transport.number,
       SUM(t_race.tickets_sold * t_route.price) AS total_income,
       AVG(t_race.tickets_sold * t_route.price) AS average_income,
       COUNT(t_transport.id) as working_days
FROM yurii_zhuravlev_cherkasy_electro_trans.transport AS t_transport
JOIN yurii_zhuravlev_cherkasy_electro_trans.race AS t_race
    ON t_transport.id = t_race.transport_id
JOIN yurii_zhuravlev_cherkasy_electro_trans.route AS t_route
    ON t_race.route_id = t_route.id
GROUP BY t_transport.id
ORDER BY working_days DESC;

# Query #6: get people who have birthday in May
SELECT t_employe.id,
       t_employe.firstname,
       t_employe.lastname,
       t_employe.dob,
       monthname(t_employe.dob)
FROM yurii_zhuravlev_cherkasy_electro_trans.employe AS t_employe
WHERE monthname(dob) = 'May';

# get a number of years every person works in `CherkasyElektroTrans`
SELECT t_employe.id,
       t_employe.firstname,
       t_employe.lastname,
       t_employe.hired,
       DATEDIFF(CURDATE(), t_employe.hired) DIV 365.25 AS years_works
FROM yurii_zhuravlev_cherkasy_electro_trans.employe AS t_employe;
