-- INDEX 확인
SHOW INDEX FROM employees;

-- 0.031초
SELECT * FROM employees WHERE `name` = '주정웅';

-- INDEX 생성
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`)
;

-- 0.000초
SELECT * FROM employees WHERE `name` = '주정웅';

-- INDEX 삭제
ALTER TABLE employees
DROP INDEX idx_employees_name