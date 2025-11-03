-- SubQuery

-- WHERE절에서 사용
-- 단일 행 서브쿼리
-- D001 부서장의 사번과 이름을 출력
SELECT
	-- 별칭을 주거나 테이블명을 사용해 어느 테이블의 컬럼인지 활실히 지정해 구분해야 한다
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	-- 단일 행  비교 연산자(=, <, <=, >, >=, <>)를 사용할 경우 결과값은 반드시  하나여야 한다
	emp.emp_id = (
		SELECT depm.emp_id
		FROM department_managers depm
		where
			depm.dept_code = 'D001'
			AND depm.end_at IS NULL
	)
;

-- 다중 행 서브쿼리
-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	-- 서브쿼리가 2건 이상 반활 될 경우에는 반드시 다중 행 비교연산자(IN, ALL, ANY, SOME, EXISTS 등)을 사용
	emp.emp_id IN (
		SELECT depm.emp_id
		FROM department_managers depm
		where
			depm.end_at IS NULL
	)
;

-- 다중 열 서브쿼리
-- 서브쿼리의 결과가 복수의 컬럼을 반환할 경우, 메인 쿼리의 조건과 동시 비교
-- 현재 D002의 부서장이 해당 부서에 소속된 날짜 출력
SELECT
	department_emps.*
FROM department_emps
WHERE
	(department_emps.emp_id, department_emps.dept_code) IN (
		select
			department_managers.emp_id
			,department_managers.dept_code
		FROM department_managers
		where
			department_managers.dept_code = 'D002'
			AND department_managers.end_at IS NULL
	)
;

-- 연관 서브쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- 부서장 직을 지냈던 경력이 있는 사원의 정보 출력
SELECT
	employees.*
FROM employees
WHERE
	employees.emp_id IN (
		SELECT department_managers.emp_id
		FROM department_managers
		where
			department_managers.emp_id = employees.emp_id
	)
;