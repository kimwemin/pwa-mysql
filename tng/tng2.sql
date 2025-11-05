-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,tite.title_code
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
			AND tite.end_at IS NULL
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
-- tip. 해당 정보의 경우 요청하지 않더라도 과거부터 현재까지 순서대로 나열해 출력하는 것이 좋다
SELECT
	emp.`name`
	,sal.start_at
	,sal.end_at
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = '10010'
ORDER BY sal.start_at ASC
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dept.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND depe.end_at IS NULL
			-- AND emp.fire_at IS NULL  굳이? 문제에서 명확히 적지 않아 불필요함
	JOIN departments dept
		ON depe.dept_code = dept.dept_code
ORDER BY emp.emp_id ASC
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,sal_rank.salary
FROM (
	SELECT
		sal.emp_id
		,sal.salary
		,RANK() OVER(ORDER BY sal.salary DESC) AS sal_rank
	FROM salaries sal
	WHERE
		sal.end_at IS NULL
	LIMIT 10
) sal_rank
	JOIN employees emp
		ON sal_rank.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dept.dept_name
	,emp.`name`
	,emp.hire_at
FROM department_managers depm
	JOIN departments dept
		ON depm.dept_code = dept.dept_code
			AND depm.end_at IS NULL
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
			AND emp.fire_at IS NULL -- 부서장 중 한명이 퇴사자임
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	AVG(sal.salary)
FROM titles tit
	JOIN title_emps tite
		ON tit.title_code = tite.title_code
			AND tit.title = '부장'
			AND tite.end_at IS NULL
	JOIN salaries sal
		ON tite.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;

-- 현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	,AVG(sal.salary)
FROM title_emps tite
	JOIN employees emp
		ON tite.emp_id = emp.emp_id
			AND tite.title_code = 'T005'
			AND tite.end_at IS NULL
			AND emp.fire_at IS NULL
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
GROUP BY emp.`name`
;

-- T.ver 코드
SELECT
	emp.`name`
	,AVG(sal.salary)
FROM titles tit
	JOIN title_emps tite
		ON tit.title_code = tite.title_code
			AND tit.title = '부장'
			AND tite.end_at IS NULL
	JOIN employees emp
		ON emp.emp_id = tite.emp_id
			AND emp.fire_at IS NULL
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
GROUP BY sal.emp_id, emp.`name`
;

-- 서브쿼리 사용 시 코드
-- 위 코드는 테이블에 데이터가 추가나 수정된다면 오류를 일으킬 확률이 있다

SELECT
	emp.`name`
	,sub_salaries.avg_sal
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			,AVG(sal.salary) avg_sal
		FROM title_emps tite
			JOIN titles tit
				ON tite.title_code = tit.title_code
					AND tit.title = '부장'
					AND tite.end_at IS NULL
			JOIN salaries sal
				ON sal.emp_id = tite.emp_id
		GROUP BY sal.emp_id
	) sub_salaries
		ON emp.emp_id = sub_salaries.emp_id
			AND emp.fire_at IS NULL
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
-- 같은 사원이 부서이동을 통해 부서장직을 2번 역임한 경우 등 중복된 사원이 나올 가능성이 있다
-- 위와 같은 경우 서브쿼리를 활용해 EXIST로 있는지 없는지 체크 후 처리
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,depm.dept_code
FROM department_managers depm
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
SELECT
	tit.title
	,CEILING(AVG(sal.salary)) avg_sal
FROM titles tit
	LEFT JOIN title_emps tite
		ON tit.title_code = tite.title_code
			AND tite.end_at IS NULL
	JOIN salaries sal
		ON tite.emp_id = sal.emp_id
			AND sal.end_at IS NULL
GROUP BY tit.title
	HAVING avg_sal >= 60000000
ORDER BY avg_sal DESC
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tit.title_code
	,tit.title
	,COUNT(emp.gender) AS count_emp
FROM titles tit
	JOIN title_emps tite
		ON tit.title_code = tite.title_code
			AND tite.end_at IS NULL
	JOIN employees emp
		ON tite.emp_id = emp.emp_id
			AND emp.gender = 'F'
GROUP BY tit.title, tit.title_code
ORDER BY count_emp DESC
;