-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT *
FROM titles
;
-- 2. 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
-- 인덱스가 있다면 인덱스로 먼저 필터링 이후 많이 걸러낼 수 있는 것 우선으로 필터링
SELECT
	emp_id
FROM salaries
WHERE
	end_at IS null
	AND salary <= 60000000
;
-- 3. 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
-- BETWEEN 우선 작성 후 성능 문제가 일어날 경우 AND로 풀어서 작성해 비교해본다
SELECT
	emp_id
FROM salaries
WHERE
	end_at IS null
	AND salary BETWEEN 60000000 AND 70000000
;
-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT *
FROM employees
WHERE
	emp_id IN(10001, 10005)
;
-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT
	title_code
	,title
FROM titles
WHERE
	title LIKE '%사%'
;
-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
-- ORDER BY의 경우 정렬 조건이 더 필요할 시 ,로 구분한 뒤 나열한다
SELECT *
FROM employees
ORDER BY `name` ASC
;
-- 7. 사원별 전체 급여의 평균을 조회해 주세요.
SELECT
	emp_id
	,AVG(salary) avg_sal
FROM salaries
GROUP BY emp_id
;
-- 8. 사원별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
-- 사원번호와 평균급여를 조회해 주세요.
SELECT
	emp_id
	,AVG(salary) avg_sal
FROM salaries
GROUP BY emp_id
	HAVING avg_sal BETWEEN 30000000 AND 50000000
;
-- 9. 사원별 전체 급여 평균이 70,000,000이상인,
-- 사원의 사번, 이름, 성별을 조회해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,emp.gender
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT
			sal.emp_id
		FROM salaries sal
		GROUP BY sal.emp_id
			HAVING AVG(sal.salary) >= 70000000
	)
;
-- 10. 현재 직급이 'T005'인,
-- 사원의 사원번호와 이름을 조회해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT
			tite.emp_id
		FROM title_emps tite
		WHERE
			tite.end_at IS NULL
			AND tite.title_code = 'T005'
	)
;