/*
 * 5장
 * [비교연산자]
 * - 같다 : =
 * - 같지 않다 : <>, !=, ^=
 * - >, <, >= , <= 
 */
-- 날짜 / 문자 데이터 조회
-- 사원 테이블에서 last_name 이 King이거나 입사일이 05/07/16인 사원의 사번, last name, 입사일 검색
SELECT employee_id
	 , last_name
	 , hire_date
  FROM employees
 WHERE last_name = 'King'	--대소문자 구분
    OR hire_date = '05/07/16';

/*
 * [IN연산자] : 특정 칼럼의 값이 A,B,C 중에 하나라도 일치하면 참이되는 연산자
 *  - 형식 : 컬럼값 IN (A,B,C) 
 * 			컬럼값 NOT IN(A,B,C)
 */
   
-- salary가 3000이상 5000이하인 사원의 사번, salary검색(정렬)
SELECT employee_id
	 , salary
  FROM employees
 WHERE salary >= 3000
   AND salary <= 5000
ORDER BY salary ASC;

SELECT employee_id
	 , salary
  FROM employees
 WHERE salary IN (3000,4000,5000)
ORDER BY salary ASC;

--사원 테이블에서 부서ID가 70,80,90,100인 사원의 
--사번, last_name, 부서ID로 조회(단 부서ID는 오름차수)
SELECT employee_id
	 , last_name
	 , department_id
  FROM employees
 WHERE department_id IN (70, 80, 90, 100)
ORDER BY department_id ASC;

--사원테이블에서 email이 SBELL, ABULL일때의 사번, last_name, email 조회
SELECT employee_id
	 , last_name
	 , email
FROM employees
WHERE email IN ('SBELL', 'ABULL')
ORDER BY employee_id;

/*
 *	WHERE 컬럼명 BETWEEN A AND B 연산자 => 중요
 */
--salary 가 3000이상 4000이하인 사원의 사번, salary 검색(정렬)
SELECT employee_id
	 , last_name
	 , salary
FROM employees
WHERE salary BETWEEN 3000 AND 4000
ORDER BY salary;

--사원 테이블에서 사번, 입사일 조회 (단 입사일은 04/01/01 ~ 05/12/31), 단 입사일 오름차순
SELECT employee_id
	 , hire_date
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31'
ORDER BY hire_date ASC;

/*[ 2일차 ]
 * 5-3
 * LIKE 연산자와 와일드 카드 
 * - 컬럼명 LIKE Pattern
 * - 와일드 카드 :
 * % => 길이와 상관없이 모든 문자 데이터를 의미
 * _ => 어떤 값이든 상관 없으 한개의 문자데이터를 의미
 */
-- 사원테이블의 last_name 의 3번째 ,4번째 단어가 tt인 사원의 사번 last name 조회 사번은 오름자순
SELECT employee_id
	 , last_name
FROM employees
WHERE last_name LIKE '__tt%'
ORDER BY employee_id ASC;

--사원테이블에서 'JONES'가 포함된 email 조회 사번 오름차순
SELECT employee_id
	 , email
FROM employees
WHERE email LIKE '%JONES%'
ORDER BY employee_id ASC;

--JOBS 테이블에서 'REP'가 포함된 JOB_ID조회
SELECT job_id
FROM jobs
WHERE job_id LIKE '%REP%'
ORDER BY job_id ASC;

--사원 테이블에서 ul이 포함되지 않은 last name 조회 사번 오름차순
SELECT employee_id
	 , last_name
FROM employees
WHERE last_name NOT LIKE '%ul%'
ORDER BY employee_id ASC;

/*
 * 5-3
 * NULL : 미확정, 값이 정해져 있지 않아 알수 없는 값을 의미하며, 연산불가, 대입 불가, 비교 불가
 * 	연산시 관계 컬럼값도 NULL로 바뀐다. 예 ) 커미션이 NULL이면 연봉도 NULL
 * 	- IS NULL, IS NOT NULL
 */

--사원테이블에서 부서 ID가 NULL 이 아닌 모든 행 조회 부서ID 정렬
SELECT *
FROM employees
WHERE department_id IS NOT NULL
ORDER BY employee_id ASC;

-- 사원 테이블의 last_name , salary. salary * 12 + commission_pct AS 연봉, commission_pct 검색
-- salary >= 10000

SELECT employee_id
	 , last_name
	 , salary
	 , salary * 12 + NVL(commission_pct,0) AS "연봉"
	 , commission_pct
FROM employees
WHERE salary >= 10000
ORDER BY employee_id ASC;

/*
 * 5-3. 합집합
 * - UNION : 중복제거 / UNION ALL 중복 허영
 * - ORDER BY는 문장의 맨끝
 * - 합집합, 교집합, 차집합은 테이블간에 갯수와 재료형이 일치해야 한다. 테이블은 달라도 무관
 * 
 */
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
WHERE department_id = 20
UNION ALL
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
WHERE department_id = 20;

SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
WHERE department_id = 10
UNION
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
WHERE department_id = 20;

--차집합
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
MINUS
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
WHERE department_id = 10
ORDER BY department_id ASC;

--교집합
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
INTERSECT
SELECT employee_id
	 , last_name
	 , salary
	 , department_id
FROM employees
WHERE department_id = 10
ORDER BY department_id ASC;

