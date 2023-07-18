-- 1일차 : 전날 설치
/*
 * SELECT * FROM 테이블명;
 * SELECT 컬럼1, 컬럼2... FROM 테이블명
 * WHERE 조건절
 * ORDER BY : 정렬 , ASC(오름차순 생략가능), DESC(내림차순) => 정렬문법이며 가장 마지막 절에 온다.
 */
SELECT * FROM employees; 	-- 사원 테이블
SELECT * FROM departments; 	-- 부서 테이블
SELECT * FROM jobs;			-- 직무테이블
SELECT * FROM job_history;	-- 직무 히스토리 테이블
SELECT * FROM countries;	-- 국가 테이블
SELECT * FROM locations;	-- 위치 테이블
SELECT * FROM regions;		-- 지역 테이블

--[테이블의 구조 : DESC(DESCRIBE) 테이블명]
--DESC employees;
--DESCRIBE employees;

-- 실습 4-4 사원정보를 조회한다.
SELECT * 
FROM employees; 
-- 실습 4-5 사번, 이메일, 직무, 부서번호
SELECT employee_id 
	 , last_name
	 , email 
	 , job_id
	 , salary
	 , hire_date
	 , department_id
  FROM employees
 WHERE department_id = 60 
	OR employee_id = 100;
	
-- 습 4-5, 사원테이블에서 사번, last_name, email, salary(단 salary가 10000이상, 사번이 150 이상, last name이 Ozer)조회하라
SELECT employee_id
	 , last_name
	 , email
	 , salary
  FROM employees -- 스키마(hr.)이 생략되어 있음
  
 WHERE salary > 10000
   AND employee_id > 150
   AND last_name = 'Ozer'; -- '문자', 대소문자를 구분함, 같다(=)
--168	Ozer	LOZER	11500

-- jobs 테이블에서 job_id, job_title 조회
SELECT job_id
     , job_title
  FROM jobs;
 
-- 실습4-6. DISTINCT : 열 중복 데이터를 삭제
 -- 사원테이블에서 부서번호를 조회(중복없이)
SELECT DISTINCT department_id
FROM employees
ORDER BY department_id ASC;

-- 실습4-7. 별칭
-- 한칸 띄우고 별칭, 한칸 띄우고 "별칭", 한칸띄우고 AS 별칭, 한칸띄우고 AS "별칭"
-- 사원 테이블에서 사번, Last_Name salary , 연봉 salary *12 + comm ), 단 급여가 만원 이상
SELECT employee_id
	 , last_name
	 , salary
	 , commission_pct AS "수당"
	 , salary * 12 + commission_pct AS "연봉" -- null 은 비교, 연산, 할당이 불가하다.
FROM employees
WHERE salary >= 10000 
--AND commission_pct is NOT NULL
ORDER BY employee_id ASC;

-- commission_pct 가 null 이라 할지라도 연봉을 출력 => NVL(컬럼명, 0)
SELECT employee_id
	 , last_name
	 , salary
	 , commission_pct AS "수당"
	 , salary * 12 + NVL(commission_pct, 0) AS "연봉"
FROM employees
WHERE salary >= 10000 
ORDER BY employee_id ASC;

/*
 * 정렬 ORDER BY 컬럼명 ASC;
 * ASC(오름차순) DESC(내림차순)
 * SELECT 문 마지막에 온다
 */

-- 사원 테이블에서 사번이 150번 미만인 사원의 사번 last_name, salary, 부서ID 검색
-- 단 부서 ID는 오름차순으로 정렬하고 급여도 오름차순 사번은 내림차순
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
WHERE employee_id < 110
ORDER BY department_id ASC
	 , salary ASC
	 , employee_id ASC;
	 
-- 부서테이블에서 부서id가 50번 미만일때 부서id, 부서명, 매니져 id
SELECT department_id
	 , department_name
	 , manager_id 
FROM departMents
WHERE department_id < 50;

