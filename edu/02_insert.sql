-- INSERT 문
-- 신규 데이터를 저장하기위해 사용하는 문
INSERT INTO employees (
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
	,deleted_at
)
VALUES (
	'박병주'
	,'2000-01-01'
	,'M'
	,'2025-10-31'
	,NULL
	,NULL
	,NOW()
	,NOW()
	,NULL
);

-- 생성일이 가장 최근인 것
-- 그냥 내이름으로 찾기
-- 입사일이 오늘 기준
-- 생일로 찾기
-- 가장 큰 PK로 찾기
SELECT *
FROM employees
WHERE
	`name` = '박병주'
	AND birth = '2000-01-01'
	AND hire_at = '2025-10-31'
;

-- 자신의 연봉 데이터를 넣어 주세요.
INSERT INTO salaries (
	emp_id
	,salary
	,start_at
)
VALUES 
(100005,30000000,NOW()),
(100005,30000000,NOW())
;

-- SELECT INSERT
INSERT INTO salaries (
	emp_id
	,salary
	,start_at
)
SELECT
	emp_id
	,300000000
	,created_at
FROM employees
WHERE
	`name` = '박병주'
	AND birth = '2000-01-01'
	AND hire_at = '2025-10-31'
;