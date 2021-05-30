--BANCO DE DADOS I - ROTEIRO 5
--ALUNO: Kássio Augusto de Moura Silva - MATRICULA: 119210551

-- Q1
SELECT COUNT(*) FROM employee WHERE sex = 'F';

-- Q2
SELECT AVG(salary) FROM employee WHERE sex = 'M' AND address LIKE '%, TX';

-- Q3
SELECT superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados FROM employee GROUP BY superssn ORDER BY COUNT(*);

-- Q4
SELECT n.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM (employee AS n JOIN employee AS e ON n.ssn = e.superssn) GROUP BY n.ssn ORDER BY COUNT(*) ASC;

-- Q5
SELECT n.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM (employee AS n RIGHT OUTER JOIN employee AS e ON n.ssn = e.superssn) GROUP BY n.ssn ORDER BY COUNT(*) ASC;

-- Q6
SELECT MIN(COUNT) AS qtd FROM(SELECT COUNT(*) FROM works_on GROUP BY pno) AS q;

-- Q7
SELECT pno AS num_projeto, COUNT(essn) AS qtd_func FROM works_on GROUP BY pno HAVING COUNT(essn) = (SELECT MIN(qtd) AS qtd_empregados FROM (SELECT COUNT(essn) AS qtd FROM works_on GROUP BY pno) as qtds);

-- Q8
SELECT w.pno AS num_proj, AVG(e.salary) AS media_sal FROM employee AS e JOIN works_on AS w ON e.ssn = w.essn GROUP BY w.pno;

-- Q9
SELECT w.pno AS proj_num, p.pname AS proj_nome, AVG(e.salary) AS media_sal FROM employee AS e JOIN works_on AS w ON e.ssn = w.essn JOIN project AS p ON p.pnumber = w.pno GROUP BY w.pno, p.pnumber;

-- Q10
SELECT f.fname, f.salary FROM employee AS f WHERE f.salary > ALL(SELECT salary FROM works_on AS p JOIN employee AS f ON (p.essn = f.ssn AND p.pno = 92));

-- Q11
SELECT e.ssn, COUNT(w.essn) AS qtd_proj FROM employee as e LEFT JOIN works_on AS w on e.ssn = w.essn GROUP BY e.ssn ORDER BY COUNT(w.essn);

-- Q12
SELECT pno AS num_proj, COUNT AS qtd_func FROM (SELECT pno, COUNT(*) FROM employee AS func LEFT OUTER JOIN works_on AS proj ON (func.ssn = proj.essn) GROUP BY pno) AS qtd WHERE qtd.count < 5 ORDER BY qtd_func;

-- Q13      
SELECT DISTINCT s.fname AS fname FROM employee AS s, dependent AS d, works_on AS w, project AS p WHERE (p.plocation LIKE '%Sugarland%' AND p.pnumber = w.pno AND w.essn = s.ssn AND s.ssn = d.essn);

-- Q14
SELECT dname FROM department WHERE NOT EXISTS (SELECT dnum FROM project WHERE dnumber = dnum);

-- Q15
SELECT DISTINCT fname, lname FROM employee AS e, works_on WHERE essn = ssn AND ssn <> '123456789' AND NOT EXISTS ((SELECT pno FROM works_on WHERE essn = '123456789') EXCEPT(SELECT pno FROM works_on WHERE essn = e.ssn));

