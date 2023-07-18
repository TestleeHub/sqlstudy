/*
 * 7. 그룹함수
 * 7-1. 그룹함수
 * 7-2. GROUP BY
 * 7-3. HAVING
 */
-- 그룹함수 : 테이블의 전체데이터중에서 통계적인 결과를 구하기 위해서, 하나 이상의 행을 그룹으로 묶어 연상하여
-- 하나의 결과를 구한다.
-- 1. SUM : 합계 그룹함수
-- 급여 총액
SELECT SUM(SALARY) AS 급여총액
FROM employees;

--2. AVG 평균 그룹함수
--급여 평균 : 소수점 3째 자리에서 반올림
SELECT ROUND(AVG(SALARY), 2) AS 급여평균
FROM employees;

SELECT ROUND(AVG(SALARY),-3) AS 급여평균
FROM employees;

-- 3. MAX, MIN : 최대값, 최소값 그룹함수
-- 최대급여, 최소급여
SELECT MAX(SALARY) AS 최대급여
	 , MIN(SALARY) AS 최소급여
FROM employees;

-- 최근 입사일, 가장 오래된 입사일
SELECT MAX(hire_date) AS 최근입사일
	 , MIN(hire_date) AS 오래된입사일
FROM employees;

--4. COUNT(*) : 전체 행(row)갯수를 구하는 그룹함수
-- COUNT(*) : NULL값으로 된 행, 중복된 행을 비롯하여 선택된 모든행을 카운트한 갯수
-- COUNT(컬럼명) : 컬럼명의 값이 NULL이 아닌 갯수, 중복된 행포함
--사원수
SELECT COUNT(employee_id)
FROM employees;

--커미션을 받은 사원수
SELECT COUNT(COMMISSION_PCT)
FROM employees;

SELECT COMMISSION_PCT , COUNT(*)
FROM employees
WHERE commission_pct is not null
GROUP BY commission_pct;

--부서테이블의 부서 갯수
SELECT COUNT(*)
FROM departments;

--사원테이블의 부서 갯수
SELECT COUNT(DISTINCT department_id)
FROM employees;

--사원테이블의 최대급여, 최소급여, 급여총액, 급여 평균(둘때자리), 사원수
SELECT MAX(salary) AS "최대급여"
	 , MIN(salary) AS "최소급여"
	 , SUM(salary) AS "급여총액"
	 , ROUND(AVG(salary),2) AS "급여평균"
	 , COUNT(*) AS "사원수"
FROM employees;

/*
 * 7-2. GRUOP BY
 * - 특정 컬럼을 기준으로 그룹별로 나눌때 사용
 * - 형식 
 * SELECT 컬럼1, 컬럼2, ....그룹함수
 * FROM Table 명
 * WHERE 조건
 * GROUB BY 컬럼1, 컬럼2, ...
 * ORDER BY 컬럼명 ASC(DESC);
 * 
 * --  GROUP BY 절 다음에 컬럼의 별칭은 사용할 수 없다.
 * -- 그룹함수가 아닌 SELECT 리스트의 모든 일반 컬럼은 GROUP BY 절에 반드시 기술해야 한다.(중요)
 * -- 그러나 반대로 GROUP BY 절에 기술된 컬럼이 반드스 SELECT 절에 있어야 하는 것은 아니다. 단지 결과가 무의미하다.
 * 
 */
-- 사원테이블의 평균 급여

SELECT department_id, ROUND(AVG(salary), 2), COUNT(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY COUNT(*) DESC;

--부서별 직무별 최대급여 구하기, 부서정렬
SELECT department_id, job_id, ROUND(MAX(SALARY),2), COUNT(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id
ORDER BY department_id;

--사원테이블에서 직무 별로 총급여, 최대급여 구하기, 직무 정렬
SELECT job_id, SUM(salary), MAX(SALARY), COUNT(*)
FROM employees
GROUP BY job_id
ORDER BY job_id;

-- 부서별, 직무별, 인원수, 급여평균, 최대급여 구하기(소수점 두째자리)
-- 부서, 직무, 오름차순 정렬(단 부서는 NOT NULL)
SELECT department_id
	 , job_id
	 , COUNT(*) AS "인원수"
	 , ROUND(AVG(SALARY), 2) AS "급여 평균"
	 , MAX(SALARY) AS "최대 급여"
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id
ORDER BY department_id ASC, job_id ASC;

/*
 * 7-3. 그룹함수 제한 : HAVING절 => 중요
 * - 표시할 그룹을 지정하여 집계정보를 기준으로 Filtering
 * - HAVING + 그룹함수 조건절
 * - 형식
 * SELECT 컬럼1, 컬럼2, ....그룹함수
 * FROM Table 명
 * WHERE 조건
 * GROUB BY 컬럼1, 컬럼2, ...
 * HAVING + 그룹함수 조건절
 * ORDER BY 컬럼명 ASC(DESC);
 */

-- 부서별 최대급여, 총급여(단 총급여가 15000 이상), 부서코드 오름차순 정렬
-- 부서코드가 없으면 제외

SELECT department_id
	 , MAX(salary) AS "최대 급여"
	 , SUM(salary) AS "총 급여"
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING SUM(salary) >= 15000
ORDER BY department_id ASC;

--직무별 평균급여, 총급여(단, 평균급여가 5000 이상)
-- 소수점 이하는 무조건 절삭, 직무 오름차순, (단 job_id가 it를 포함할 때 조회 안되도록)
SELECT job_id
	 , TRUNC(AVG(salary), 0) AS "평균 급여"
	 , SUM(salary) AS "총 급여"
FROM employees
WHERE job_id NOT LIKE('%IT%')
GROUP BY job_id
HAVING ROUND(AVG(salary)) >= 5000
ORDER BY job_id ASC;

/*
 * 중첩 그룹함수
 * - 그룹함수는 두번까지 중첩 사용사능하다. 예) MAX(AVG(salary))
 * - 중첩 그룹함수는 select list에 일반 컬럼 사용불가
 */

SELECT MAX(TRUNC(AVG(salary), 0)) AS "평균 급여" -- 중첩 그룹함수는 일반컬럼 사용불가
FROM employees
WHERE job_id NOT LIKE('%IT%')
GROUP BY job_id
HAVING SUM(salary) >= 5000
ORDER BY job_id ASC;
