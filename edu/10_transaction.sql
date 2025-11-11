-- TRANSACTION

-- 트랜잭션 시작
START TRANSACTION;

-- insert
INSERT INTO employees (`name`, birth, gender, hire_at)
VALUES ('미어캣', '2000-01-01', 'M', DATE(NOW()));

-- UPDATE employees SET birth = NOW() WHERE emp_id = 100008;

-- select
SELECT * FROM employees WHERE `name` = '미어캣';

-- rollback
ROLLBACK;

-- commit
COMMIT;