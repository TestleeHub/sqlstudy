/*
 * ch6. 오라클 함수
 * 6-2 대소문자를 바꿔주는 UPPER, LOWER, INITCAP
 * -- UPPER : 대문자로 변환
 * -- LOWER : 소문자로 변환
 * -- INITCAP : 첫글자만 대문자, 나머지는 소문자로 변환
 */

-- 사원 테이블의 last_name 이 'King'일 경우 employee_id , last_naem 조회
SELECT employee_id
	 , last_name
  FROM employees
 WHERE last_name = 'King';

SELECT employee_id
	 , last_name
  FROM employees
 WHERE last_name = INITCAP('KING'); -- INITCAP : 첫글자만 대문자, 나머지는 소문자로 변환
 
-- 사원 테이블의 email 이 'TFOX'일 경우 email 조회
SELECT employee_id
	 , email
FROM employees
WHERE email = UPPER('tfox');

/*
 * 문자열 길이를 구하는 LENGTH 함수 : 한글 한문자당 1byte
 * 문자열 길이를 구하는 LENGTHB 함수 : 한글 한문자당 3byte
 */
-- Dual 테이블 : SYS소유의 테이블로, 오라클에서 제공하는 더미 테이블, 하나의 행으로 결과를 출력함
-- DUMMY VARCHAR2(1) 이라는 하나의 컬럼으로 구성괴어 있고, 데이터는 'X'값

SELECT * FROM dual;

SELECT sysdate
FROM dual;

SELECT LENGTH('안녕')
FROM dual;

SELECT LENGTHB('oracle')
FROM dual;

SELECT sysdate -- 오늘
	 , sysdate + 1 -- 내일
	 , sysdate + 2 -- 모레
	 , sysdate - 1 -- 어제
FROM dual;

/*
 * 문자열 일부를 추출하는 SUBSTR 함수.. 인덱스는 1부터 시작
 * - SUBSTR(문자열데이터, 시작위치, 추출개수) : 시작위치부터 추출갯수만큼 추출한다.
 * - 시작 위치가 양수인 경우 1부터 시작 , 음수인 경우 뒤쪽부터 시작
 * - 추출갯수 생략시 데이터 끝까지 추출
 */

SELECT job_id 
	 , SUBSTR(job_id, 1,2)
	 , SUBSTR(job_id, -5)
FROM employees;

/*
 * INSTR - 문자열내에 특정 문자 위치를 찾아주는 함수
 * 형식 - INSTR(대상, 찾을 글자, 시작위치, 몇번째 발견)
 *  - 시작위치 , 몇번쨰 발션 모두 생략시 모두 1로 간주
 */

SELECT INSTR('HELLO, ORACLE!', 'L') AS "TEST1"
 	 , INSTR('HELLO, ORACLE!', 'L', 5) AS "TEST2"
 	 , INSTR('HELLO, ORACLE!', 'L', 2, 2) AS "TEST2"
FROM dual;

/*
 * REPLACE - 특정 문자를 다른 문자로 바꾸는 Replace 함수
 * 형식 - REPLACE(문자열 또는 열이름(필수), [찾는 문자(필수)], [대체할 문자(선택)]
 */

SELECT '010-1111-2222' AS REPLACE_BEFORE
	 , REPLACE('010-1111-2222', '-', '/') AS REPLACE_AFTER
FROM dual;

/*
 * 데이터의 빈공간을 특정 문자로 채우는 LPAD, RPAD 함수
 * 
 */

SELECT RPAD('880516-1', 14, '*') AS RPAD_1
FROM dual;

SELECT RPAD(SUBSTR('010-1234-4567', 1, 9), 13, '*') AS RPAD_1
FROM dual;

/*
 * CONCAT - 문자의 값을 연결한다.('||'와 동일하다)
 */
-- 사원테이블에서 사번, 입사일, 이름(first_name-last_name)
SELECT employee_id
	 , hire_date
	 , first_name || '-' ||last_name AS fullname
FROM employees;

--입사년도가 04 이거나 06인 사원의 사번 입사일(----년 --월 -- 일), 이름(first_name-last_name)
--입사일 순서로 정렬
SELECT employee_id
	 ,'20' || SUBSTR(hire_date, 1, 2) || '년' || SUBSTR(hire_date, 4, 2) || '월' || SUBSTR(hire_date, 7, 2) || '일' AS 입사일
	 , first_name || '-' ||last_name AS 이름
FROM employees
--WHERE SUBSTR(hire_date, 1, 2) IN ('04', '06')
WHERE SUBSTR(hire_date, 1, 2) IN ('04', '06')
ORDER BY hire_date ASC;

SELECT employee_id
	 ,TO_CHAR(hire_date, 'yyyy"년"mm"월"dd"일"') AS 입사일
	 , first_name || '-' ||last_name AS 이름
FROM employees
WHERE TO_CHAR(hire_date, 'yy') IN ('04', '06')
ORDER BY hire_date ASC;

/*
 * TRIM : 불필요한 공백 제거
 * LTRIM : 왼쪽 공백 지우기
 * RTRIM : 오른쪽 공백 지우기
 */

SELECT '    Oracle mania    '
	 , TRIM('    Oracle mania    ') AS trim
	 , LTRIM('    Oracle mania    ') AS ltrim
	 , RTRIM('    Oracle mania    ') AS rtrim
FROM dual;

/*
 * 6-3. 숫자함수 => 중요
 * ROUND : 지정한 숫자의 특정 위치에서 반올림한 값을 반환
 * TRUNC : 지정한 숫자의 특정 위치에서 버림한 값을 반환
 * CEIL : 지정한 숫자와 가까운 큰 정수 반환
 * FLOOR : 지정한 숫자와 가까운 작은 정수 반환
 * MOD : 숫자를 나눈 나머지 값을 구하는 MOD 함수
 */
--ROUND(숫자, 반올림 위치)
SELECT ROUND(1234.5678) 	AS ROUND_
	 , ROUND(1234.5678, 0) 	AS ROUND_0
	 , ROUND(1234.5678, 1) 	AS ROUND_1
	 , ROUND(1234.5678, 2) 	AS ROUND_2
	 , ROUND(1234.5678, -1) AS ROUND_M1
	 , ROUND(1234.5678, -2) AS ROUND_M2
FROM dual

--TRUNC(숫자, 반올림 위치)
SELECT TRUNC(1234.5678) 	AS TRUNC_
	 , TRUNC(1234.5678, 0) 	AS TRUNC_0
	 , TRUNC(1234.5678, 1) 	AS TRUNC_1
	 , TRUNC(1234.5678, 2) 	AS TRUNC_2
	 , TRUNC(1234.5678, -1) AS TRUNC_M1
	 , TRUNC(1234.5678, -2) AS TRUNC_M2
FROM dual

--CEIL : 지정한 숫자와 가까운 큰 정수 반환
SELECT CEIL(3.14) --4
FROM dual;

--FLOOR : 지정한 숫자와 가까운 작은 정수 반환
SELECT FLOOR(3.14) --4
FROM dual;

--MOD : 지정한 숫자와 가까운 작은 정수 반환
SELECT MOD(15,6) --4
FROM dual;

/*
 * 6-4. 날짜함수
 * - 몇개월 이후 날짜를 구하는 ADD_MONTHS 함수
 * - ADD_MONTHS(날짜, 더할 개월수)
 */
SELECT SYSDATE AS "오늘"
	 , ADD_MONTHS(SYSDATE, 3) AS "3개월 후"
  FROM dual;
 
/*
 * 6-4. 날짜함수
 * - 두날짜간의 개월수 차이를 구하는 MONTH_BETWEEN 함수
 * - MONTHS_BETWEEN(날짜, 날짜)
 */
SELECT SYSDATE AS "오늘"
	 , ROUND(MONTHS_BETWEEN(sysdate, '2023-06-07')) AS "개강후 몇개월"
	 , ROUND(sysdate - TO_DATE('2023-06-07')) AS "개강후 몇일"
  FROM dual;
 
 --사원테이블에서 사번, 입사일, T_입사일, R_입사일, 근무개월수 T_근무개월수 R_근무개월수
 SELECT employee_id
 	  , hire_date
 	  , TRUNC(hire_date, 'mm') AS "T_입사일"
 	  , ROUND(hire_date, 'mm') AS "R_입사일"
 	  , MONTHS_BETWEEN(SYSDATE, hire_date) AS "근무개월수"
 	  , TRUNC(MONTHS_BET
 	  WEEN(SYSDATE, hire_date)) AS "T_근무개월수"
 	  , ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "R_근무개월수"
 FROM employees
 /*
  * [3일차]
  * 날짜 Round 함수, TRUNC 버림함수
  * 형식 : TRUNC(date, format)
  * TRUNC => format이 'MONTH'인 경우, 달을 기준으로 자른다. 이번달 1일
  * ROUND => format이 'MONTH'인 경우, 일을 기준으로 16보다 작으면 이번달 1일, 16이상이면 다음달 1일
  */
--사원테이블에서 사번, 입사일, T_입사일, R_입사일, 근무일수 T_근무일수 R_근무일수
 
 SELECT employee_id
 	  , hire_date
 	  , TRUNC(hire_date, 'mm') AS "T_입사일"
 	  , ROUND(hire_date, 'mm') AS "R_입사일"
 	  , (SYSDATE - hire_date) AS "근무일수"
 	  , TRUNC((SYSDATE - hire_date)) AS "T_근무일수"
 	  , ROUND((SYSDATE - hire_date)) AS "R_근무일수"
 FROM employees;
 
/*
 * NEXT_DAY : 돌아오는 요일의 날짜 반환 => NEXT_DAY([날짜데이터], [요일문자])
 * 				요일 대신 숫자가 올수 있다. 1:일요일 ...
 * LAST_DAY : 달의 마지막 날짜를 반환 => LAST_DAY([날짜 데이터])
 */

SELECT SYSDATE
	 , NEXT_DAY(SYSDATE, 1)
	 , NEXT_DAY(SYSDATE, '월요일')
	 , NEXT_DAY(SYSDATE, 3)
	 , NEXT_DAY(SYSDATE, '수요일')
	 , NEXT_DAY(SYSDATE, '목요일')
	 , NEXT_DAY(SYSDATE, '금요일')
	 , NEXT_DAY(SYSDATE, '토요일')
FROM dual;

SELECT employee_id AS "사번"
	 , hire_date AS "입사일"
	 , LAST_DAY(hire_date) AS "입사한 달의 마지막 날"
FROM employees
ORDER BY hire_date;

/*
* TO_CHAR : 숫자 또는 날짜 -> 문자 데이터로 변환
 * TO_NUMBER : 문자 -> 숫자 데이터로 변환
 * TO_DATE : 문자 -> 날짜 데이터로 변환
 */

/*
1. TO_CHAR
- 날짜형 혹은 숫자형을 문자형으로 변환한다. 
- 형식 : TO_CHAR(날짜데이터, '출력형식')
- 날짜 출력 형식
  종류    의미
  YYYY   년도표현(4자리)
  YY     년도표현(2자리)
  MM     월을 숫자로 표현       
  MON    월을 알파벳으로 표현
  DD     일을 숫자로 표현
  DAY    요일 표현
  DY     요일을 약어로 표현
  W      몇 번째 주
  CC     세기
*/
--1. TO_CHAR
-- 날짜형 혹은 숫자형을 문자형으로 변환한다. 
-- 형식 : TO_CHAR(날짜데이터, '출력형식')

SELECT SYSDATE
	 , TO_CHAR(SYSDATE, 'yy/mm/dd hh mi ss')
	 , TO_CHAR(SYSDATE, 'yy/mm/dd dy')
FROM dual;

-- 시간 표현
-- 오전 -> AM | 오후 -> PM
-- 12시간 - HH:MI:SS | 24시간 - HH24 : MI : SS
SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd(dy) AM hh:mi:ss') AS "날짜"
FROM dual;

/*  
-- 1-2. TO_CHAR(숫자형) -> 문자형으로 변환한다.  
-- 형식 : TO_CHAR(숫자, '출력형식')  
- L : 각 지역별 통화기호를 앞에 표시 예)한국: ￦   -- 도구-환경설정 -> 검색(돋보기) -> NLS 창에 통화 : ￦으로 설정되어 있음
-  특수문자 : ㄹ+한자키 
- , : 천단위 자리 구분을 표시
- . : 소수점을 표시
- 9 : 자리수를 나타내며, 자리수가 맞지 않아도 0으로 채우지 않는다.
- 0 : 자리수를 나타내며, 자리수가 맞지 않을 경우 0으로 채운다.
*/ 

SELECT employee_id AS "사번"
	 , salary
	 , TO_CHAR(salary, 'L999,999') AS "L"
	 , TO_CHAR(salary, '$999,999') AS "$"
FROM employees;

/*
 * TO_DATE : 문자 -> 날짜 데이터로 변환
 * - 형식 : TO_DATE('문자', '날짜 format')
 */
--입사일이 03/06/17인 사원의 사번, 입사일, 조회
SELECT employee_id AS "사번"
	 , hire_date AS "입사일"
	 , TO_CHAR(hire_date, 'yyyy-mm-dd (dy) AM hh24 : mi : ss') AS "to_char입사일"
FROM employees
WHERE HIRE_DATE = TO_DATE('030617', 'yy-mm-dd');

/*
 * TO_NUMBER
 * - 문자형을 숫자형으로 바꾼다.
 */

SELECT '10,000' - '50,000'
FROM dual;

SELECT TO_NUMBER('100,000', '999,999') - TO_NUMBER('50,000', '999,999')
FROM dual;

/*
 * 1.NVL 함수 => 매우 중요
 * - NULL : 미확정, 값이 정해져 있지 않아 알수없는 값을 의미하며, 연산, 대입, 비교가 불가능하다.
 * 			연산시 관계 컬럼값도 null로 바뀐다.
 * - NVL : 값이 NULL일경우에  연산, 대입, 비교가 불가능 하므로 NVL을 이용하여 대체
 * 			NULL을 주로 0또는 다른값으로 반환한다.
 * 문법 : NVL(컬럼값, 초기값)
 * 		단, 두개의 값은 반드시 데이터 타입이 일치해야 한다.
 */
--사원테이블의 last_name , salary , salary * 12 + commision_pct 연봉
SELECT employee_id AS "사번"
	 , salary AS "급여"
	 , commission_pct AS "수당"
	 , SALARY * 12 + NVL(commission_pct, 0) AS "연봉"
FROM employees
WHERE salary >= 10000

--LOCATIONS 테이블에서 location_id, city, state_province 조회
--(단 state_province가 null 일 경우 '미정 주'로 출력)
SELECT location_id
	 , city
	 , NVL2(state_province, '확정주','미정 주')
FROM locations;

--LOCATIONS 테이블에서 location_id, city, state_province 조회
--(단 state_province가 null 이 아닌경우만 조회)
SELECT location_id
	 , city
	 , state_province
FROM locations
WHERE state_province IS NOT NULL;

SELECT location_id
	 , city
	 , state_province
FROM locations
WHERE state_province IS NULL;

/*
 * NVL2 함수
 * 형식 : NVL2(expr1, expr2, expr3)
 *  - expr1이 null이면 expr3를 반환,
 *  - expr1이 null이 아니면 expr2을 반환
 */

SELECT employee_id AS "사번"
	 , salary AS "급여"
	 , commission_pct AS "수당"
	 , SALARY * 12 + NVL(commission_pct, 0) AS "NVL연봉"
	 , NVL2(commission_pct, SALARY * 12 + commission_pct, SALARY * 12) AS "NVL2연봉"
FROM employees
WHERE salary >= 10000;


/*
 * 3. NULLIF 함수
 *  - 형식 : NULLIF(expr1, expr2)
 *  - 두 표현식을 비교해서 동일하면 null을 반환하고, 동일하지 않으면 첫번째 표현식을 반환
 */
SELECT NULLIF('A','A')
FROM dual;

/*
 * 4. COALESCE
 *  - 형식 : COALESCE(expr1, expr2....n)
 *  - 인수중에서 NULL이 아닌 첫번째 인수를 반환
 */

SELECT employee_id AS "사번"
	 , salary AS "급여"
	 , commission_pct AS "수당"
	 , SALARY * 12 + NVL(commission_pct, 0) AS "NVL연봉"
	 , NVL2(commission_pct, SALARY * 12 + commission_pct, SALARY * 12) AS "NVL2연봉"
	 , SALARY * 12 + COALESCE(commission_pct, NULL, 123) AS "COR 연봉"
FROM employees
WHERE salary >= 10000;

/*
 * DECODE 함수 : 자바의 SWITCH CASE 문과 동일하다
 *  - 조건에 따라 다양한 선택이 가능
 *  - 형식 : DECODE(표현식,
 * 					조건1, 결과1,
 * 					조건2, 결과2,
 * 					조건3, 결과3,...
 * 					기본결과);
 *
 */
-- 사번, 이름 , job_id, salary, 수당 출력(단, decode를 이용하여 수당 출력)
--  표현식   조건        결과
-- job_id : AD_PRES  salary*1.1
--        AD_VP    salary*1.2
--        IT_PROG   salary*1.3
--        FI_MGR    salary*1.4
--        그 외      salary*1.5  AS 수당
SELECT employee_id AS "사번"
	 , first_name || ' ' || last_name AS "이름"
	 , salary AS "급여"
	 , DECODE(job_id 
	 		,'AD_PRES', salary*1.1
	 		,'AD_VP', salary*1.2
	 		,'IT_PROG', salary*1.3
	 		,'FI_MGR', salary*1.4
	 		, salary*1.5) AS "수당"
FROM employees
ORDER BY "수당";

/*
 * CASE : 자바의 if else문과 동일
 *  - 형식 : CASE(표현식,
 * 					WHEN 조건1 THEN 결과1,
 * 					WHEN 조건2 THEN 결과2,
 * 					WHEN 조건3 THEN 결과3,..
 * 					ELSE 디폴트결과
 * 			END;)
 */

-- 사번, 이름 , job_id, salary, commossion_pct
-- comm_text : commossion_pct 가 없으면 '해당사항 없음'
--				commossion_pct 가 0이면 '수당 없음'
--				0보다 크면 '수당 : '
SELECT employee_id AS "사번"
	 , first_name || ' ' || last_name AS "이름"
	 , job_id
	 , salary AS "급여"
	 , commission_pct
	 , CASE 
	 		WHEN commission_pct IS NULL THEN '해당사항 없음'
	 		WHEN commission_pct = 0 THEN '수당 없음'
	 		WHEN commission_pct > 0 THEN '연봉 :' || TO_CHAR(salary * 12 + commission_pct)
	 		ELSE '수당 이 마이너스임'
	   END AS "comm_text"
FROM employees;

SELECT employee_id AS "사번"
	 , first_name || ' ' || last_name AS "이름"
	 , salary AS "급여"
	 , CASE job_id
	 		WHEN 'AD_PRES'	THEN salary*1.1
	 		WHEN 'AD_VP'	THEN salary*1.2
	 		WHEN 'IT_PROG'	THEN salary*1.3
	 		WHEN 'FI_MGR'	THEN salary*1.4
	 		ELSE salary*1.5 
	 	END AS "수당"
FROM employees
ORDER BY "수당";

 /* DECODE함수, CASE문
사원테이블의 부서ID가 10~60인 경우 부서ID와 '부서명' 출력
    그 외는 '부서미정'으로 출력
    부서ID로 정렬한다.
    단 부서ID는 중복되지 않아야 하며, 부서ID가 null이면 출력안되게
    부서ID    부서명
    10       Administration
    20       Marketing
    30       Purchasing
    40       Human Resources
    50       Shipping
    60       IT
    그외      부서미정 
*/ 

SELECT DECODE(department_id
				,10,'Administration'
				,20,'Marketing'
				,30,'Purchasing'
				,40,'Human Resources'
				,50,'Shipping'
				,60,'IT'
				, '부서미정')	AS "부서"
	  ,COUNT(*) AS "인원수"
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id ASC;

SELECT CASE department_id
				WHEN 10 THEN 'Administration'
				WHEN 20 THEN 'Marketing'
				WHEN 30 THEN 'Purchasing'
				WHEN 40 THEN 'Human Resources'
				WHEN 50 THEN 'Shipping'
				WHEN 60 THEN 'IT'
				ELSE '부서미정'	
		END AS "부서"
		,COUNT(*) AS "인원수"
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id ASC;
