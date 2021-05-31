--BANCO DE DADOS I - ROTEIRO 9
--ALUNO: Kássio Augusto de Moura Silva - MATRICULA: 119210551


-- Questao 1 --
-- A
CREATE VIEW vw_dptmgr AS SELECT dnumber AS num_department, fname AS manager FROM department, employee WHERE ssn = mgrssn;

-- B
CREATE VIEW vw_empl_houston AS SELECT ssn, fname FROM employee WHERE address LIKE '%Houston%';

-- C
CREATE VIEW vw_deptstats AS SELECT d.dnumber AS num_department, d.dname AS name_department, COUNT (e.dno) AS num_employees FROM department AS d, employee AS e WHERE d.dnumber = e.dno GROUP BY d.dnumber;

-- D
CREATE VIEW vw_projstats AS SELECT p.pnumber AS project_id, COUNT (w.pno) AS num_employees FROM project AS p, works_on AS w WHERE p.pnumber = w.pno GROUP BY p.pnumber;

-- Questao 2 --
SELECT * FROM vw_dptmgr;
SELECT * FROM vw_empl_houston;
SELECT * FROM vw_deptstats;
SELECT * FROM vw_projstats;

-- Questao 3 --
DROP VIEW vw_dptmgr;
DROP VIEW vw_empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;

-- Questao 4 --
CREATE FUNCTION check_age(essn CHAR(9)) RETURNS text AS $$ DECLARE birth_date DATE;

BEGIN
  SELECT bdate INTO birth_date FROM employee WHERE ssn = essn;
  IF birth_date IS NULL THEN
    RETURN 'UNKNOWN';
  ELSIF birth_date > now() THEN
    RETURN 'INVALID';
  ELSIF EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date)) >= 50 THEN
    RETURN 'SENIOR';
  ELSIF EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date)) < 50 THEN
    RETURN 'YOUNG';
  END IF;
END;
$$  LANGUAGE plpgsql;

-- Questao 5 --
CREATE FUNCTION check_mgr() RETURNS TRIGGER AS $check_mgr$
  BEGIN
    IF NOT EXISTS (SELECT ssn FROM employee WHERE ssn = NEW.mgrssn AND dno = NEW.dnumber) THEN
      RAISE EXCEPTION 'manager must be a department''s employee';
    END IF;
    IF NOT EXISTS (SELECT ssn FROM employee WHERE superssn = NEW.mgrssn) THEN
      RAISE EXCEPTION 'manager must have supevisees';
    END IF;
    IF check_age(NEW.mgrssn) != 'SENIOR' THEN
      RAISE EXCEPTION 'manager must be a SENIOR employee';
    END IF;
  RETURN NEW;
  END;
  $check_mgr$ LANGUAGE plpgsql;

CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department FOR EACH ROW EXECUTE PROCEDURE check_mgr();



