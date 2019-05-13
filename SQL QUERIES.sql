--1. מחזיר כמה סוגים של ציוד יש בסניפים שיש בהם יותר מחמש תקלות

select branchId, count(equipmentName)
from malfunction natural join equipment
group by branchId
having count(*)>5
-------------------------------------------------------------
--2.מחזיר מספרי זיהוי של עובדים שיש להם יותר מתקלה אחת שלא טיפלו בה עדיין
--return id of employees that have more than 1 malfuntions that they didn't fix yet

select distinct employeeId
from (select * from malfunction natural join employee) l
where 1< (select count(*)
          from malfunction m
          where m.employeeid=l.employeeId and isFixed='NO')
-------------------------------------------------------------
--3.return how many malfunctions the employee with the id 57725998 has fixed
-- מחזיר כמה תקלות תיקן העובד שהמספר זיהוי שלו הוא 57725998

select count(*)
from malfunction m
where m.employeeid=57725998 and isFixed='YES'
-------------------------------------------------------------
--4.return id of all employees that filled a miantenance report and how many maintenance reports they filled
-- מחזיר מספרי זיהוי של עובדים שמילאו דוחות תחזוקה וכמה הם מילאו

select employeeId, count (*)
from maintenancereport natural join employee
group by employeeId  
-------------------------------------------------------------
--5.return how many maintenance reports the employee with the id 76452032 has filled
-- מחזיר כמה דוחות תחזוקה מילא העובד שמספר הזיהוי שלו הוא 76452032

select count(*)
from maintenancereport
where employeeId=76452032
-------------------------------------------------------------
--6.return the id and the count of malfunctios in branches that have at least one malfunction 
-- מחזיר את מספרי הזיהוי ואת כמות התקלות של סניפים שיש בהם לפחות תקלה אחת

select branchId, count(*)
from malfunction natural join branch
group by branchId
-------------------------------------------------------------
--7.return the id and the count of malfunctios in branches that have more than 5 pieces of equipment and at least one malfunction 
--מחזיר את מספרי הזיהוי ואת כמות התקלות של סניפים שיש להם יותר מחמש יחידות של ציוד וגם שיש בהם לפחות תקלה אחת
select branchId, count(*)
from (select * from malfunction natural join branch) m
group by branchId
having 5 < (select count(*) 
             from equipment e
             where m.branchid=e.branchid)
-------------------------------------------------------------
--8.return the number of malfunctions and the number of maintenance reports of every branch
-- מחזיר את מספר התקלות ואת מספר דוחות התחזוקה של כל סניף

select b.branchId, 
       (select count(*) from malfunction m where m.branchid=b.branchid) as nunOfMalfunctions,
       (select count(*) from maintenancereport m where m.branchid=b.branchid) as numOfMaintenanceReports
from branch b
--------------------------------------------------------------
--9. return the id od employees that handled more than 5 maintenance reports and malfunctions in total, and the number of reports and malfunctions they have handled
-- מחזיר את מספר הזיהוי של עובדים שטיפלו ביותר מחמש תקלות ודוחות תחזוקה ביחד, ומחזיר בכמה תקלות ובכמה דוחות תחזוקה הם טיפלו

select distinct employeeId, 
       (select count(*) from Maintenancereport m1 where e.employeeId=m1.employeeId) as numOfReports,
       (select count(*) from malfunction m2 where e.employeeId=m2.employeeId) as numOfMalfunctions
from employee e
where ((select count(*) from Maintenancereport m1 where e.employeeId=m1.employeeId)+
      (select count(*) from malfunction m2 where e.employeeId=m2.employeeId)) > 5  
---------------------------------------------------------------
--10.return the id of branches that have more 10 pieces of equipment or that had more than 5 malfunctions
-- מחזיר את מספרי הזיהוי של סניפים שיש להם יותר מעשר יחידות ציוד או שהיו להם יותר מחמש תקלות

select branchId
from Branch b1
where 10 < (select count(*) from equipment e2 where b1.branchId=e2.branchId)
union 
select branchId
from Branch b2
where 5 < (select count(*) from malfunction e2 where b2.branchId=e2.branchId)
