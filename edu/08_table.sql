-- DB 생성
CREATE DATABASE mydb;

-- DB 선택
USE mydb;

-- DB 삭제
DROP DATABASE mydb;

-- 스키마 : CREATE, ALTER, DROP

-- ----------------
-- 테이블 생성
-- ----------------
CREATE TABLE users(
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,`name` VARCHAR(50) NOT NULL COMMENT '이름'
	,gender CHAR(1) NOT NULL COMMENT 'F=여자, M=남자, N=선택안함'
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
);

-- 게시글 테이블
-- pk, 유저번호, 제목, 내용, 작성일, 수정일, 삭제일
CREATE TABLE posts(
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,user_id BIGINT UNSIGNED NOT NULL
	,title VARCHAR(50) NOT NULL
	,content VARCHAR(1000) NOT NULL
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
);

-- -------------
-- 테이블 수정
-- -------------
-- FK 추가방법
-- ALTER TABLE [테이블명]
-- ADD CONSTRAINT [Constraint명]
-- FOREIGN KEY (Constraint 부여 컬럼명) 
-- REFERENCES 참조테이블명(참조테이블 컬럼명) 
-- [ON DELETE 동작 / ON UPDATE 동작];
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id)
REFERENCES users(id)
;
-- FK 삭제
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id
;

-- ----------
-- 컬럼 추가
-- ----------
ALTER TABLE posts
ADD COLUMN image VARCHAR(100)
;

-- ----------
-- 컬럼 제거
-- ----------
ALTER TABLE posts
DROP COLUMN image
;

-- ----------
-- 컬럼 수정
-- ----------
ALTER TABLE users
MODIFY COLUMN gender VARCHAR(10) NOT NULL COMMENT '남자, 여자, 미선택'
;

-- ----------------------
-- AUTO_INCREMENT 값 변경
-- ----------------------
ALTER TABLE users AUTO_INCREMENT = 1;


-- ------------
-- 테이블 삭제
-- ------------
DROP TABLE posts;
DROP TABLE users;

-- -------------------------
-- 테이블의 모든 데이터 삭제
-- -------------------------
TRUNCATE TABLE salaries;