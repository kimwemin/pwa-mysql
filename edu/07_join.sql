-- JOIN문
-- 두개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력

-- INNER JOIN
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- JOIN만 쓸 경우 INNER가 생략된 INNER JOIN으로 자동인식한다
-- 조건문은 WHERE절이나 ON절 중 편한 곳에 작성
-- ON절에 적을 경우 AND로 잇고 조건문을 작성한다

-- 전 사원의 사번, 이름, 현재 급여를 출력해주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
ORDER BY emp.emp_id ASC
;

-- 재직 중인 사원의 사번, 이름, 생일, 부서명
SELECT
	emp.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND depe.end_at IS NULL
	JOIN departments dept
		ON depe.dept_code = dept.dept_code
WHERE
	emp.fire_at IS NULL
;


-- LEFT JOIN
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	LEFT JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;


-- SELF JOIN
-- 같은 테이블끼리 JOIN
SELECT
	emp.emp_id AS junior_id
	,emp.`name` AS junior_name
	,sup_emp.emp_id AS supervisor_id
	,sup_emp.`name` AS supervisor_name
FROM employees emp
	JOIN employees sup_emp
		ON	emp.sup_id = sup_emp.emp_id
			AND emp.sup_id IS NOT NULL
;