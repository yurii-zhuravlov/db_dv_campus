# Query #1: get a list of all employees, ordered by last name
SELECT *
FROM yurii_zhuravlev_cherkasy_electro_trans.employee AS t_employee
ORDER BY t_employee.lastname;

# Query #2: get average salary by employee
SELECT t_employee.id,
       t_employee.firstname,
       t_employee.lastname,
       AVG(t_salary.amount) as average_salary
FROM yurii_zhuravlev_cherkasy_electro_trans.salary AS t_salary
JOIN yurii_zhuravlev_cherkasy_electro_trans.employee AS t_employee
    ON t_salary.employee_id = t_employee.id
GROUP BY t_salary.employee_id;

# Query #3: get average and highest current salary by position (store current salary in the employees table)
SELECT t_position.id,
       t_position.title,
       AVG(t_salary.amount) AS average_salary,
       MAX(t_employee.monthly_salary) AS highest_current_salary
FROM yurii_zhuravlev_cherkasy_electro_trans.position AS t_position
JOIN yurii_zhuravlev_cherkasy_electro_trans.employee AS t_employee
    ON t_position.id = t_employee.position_id
JOIN yurii_zhuravlev_cherkasy_electro_trans.salary AS t_salary
    ON t_position.id = t_salary.position_id
GROUP BY t_position.id;

# Query #4: get total number of days every person worked and total income
SELECT t_employee.id,
       t_employee.firstname,
       t_employee.lastname,
       COUNT(*) AS total_days,
       SUM(t_race.tickets_sold * t_route.price) AS total_income
FROM yurii_zhuravlev_cherkasy_electro_trans.race AS t_race
JOIN yurii_zhuravlev_cherkasy_electro_trans.employee AS t_employee
    ON t_race.employee_id = t_employee.id
JOIN yurii_zhuravlev_cherkasy_electro_trans.route AS t_route
    ON t_race.route_id = t_route.id
GROUP BY t_employee.id;

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
SELECT t_employee.id,
       t_employee.firstname,
       t_employee.lastname,
       t_employee.dob,
       monthname(t_employee.dob)
FROM yurii_zhuravlev_cherkasy_electro_trans.employee AS t_employee
WHERE monthname(dob) = 'May';

# Query #7: get a number of years every person works in `CherkasyElektroTrans`
SELECT t_employee.id,
       t_employee.firstname,
       t_employee.lastname,
       t_employee.hired,
       DATEDIFF(CURDATE(), t_employee.hired) DIV 365.25 AS years_works
FROM yurii_zhuravlev_cherkasy_electro_trans.employee AS t_employee;
