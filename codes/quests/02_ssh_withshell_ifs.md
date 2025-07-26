# 🧪 Shell 조건문 및 텍스트 처리 실습 문제
## 💻 실습 환경 설정
## 🔹 1. 실습 디렉토리 생성 및 이동
```bash
mkdir ~/shell_practice
cd ~/shell_practice
```
## 🔹 2. 실습용 데이터 파일 생성
- students.txt 파일 생성
```bash
cat > students.txt << EOF
김철수:수학:85:영어:92:과학:78
이영희:수학:95:영어:88:과학:91
박민수:수학:76:영어:79:과학:82
최지원:수학:88:영어:95:과학:89
정우진:수학:92:영어:76:과학:94
김지현:수학:83:영어:91:과학:87
이준호:수학:79:영어:84:과학:76
박서연:수학:97:영어:93:과학:96
한도윤:수학:81:영어:77:과학:83
송민재:수학:86:영어:89:과학:91
EOF
```
- server_logs.txt 파일 생성
```bash
cat > server_logs.txt << EOF
2024-01-15 10:30:15 INFO User login successful: user001
2024-01-15 10:31:22 ERROR Database connection failed
2024-01-15 10:32:05 INFO User login successful: user002
2024-01-15 10:33:18 WARNING Memory usage high: 85%
2024-01-15 10:34:25 ERROR Authentication failed: user003
2024-01-15 10:35:10 INFO User logout: user001
2024-01-15 10:36:33 ERROR Network timeout occurred
2024-01-15 10:37:45 INFO System backup started
2024-01-15 10:38:52 WARNING Disk space low: 90%
2024-01-15 10:39:15 ERROR Database connection failed
2024-01-15 10:40:28 INFO User login successful: user004
2024-01-15 10:41:35 ERROR Authentication failed: user005
EOF
```
- sales_data.txt 파일 생성
```bash
cat > sales_data.txt << EOF
2024-01,서울,노트북,1500000
2024-01,부산,스마트폰,800000
2024-01,대구,태블릿,600000
2024-01,서울,스마트폰,850000
2024-02,부산,노트북,1450000
2024-02,서울,태블릿,620000
2024-02,대구,스마트폰,780000
2024-02,서울,노트북,1520000
2024-03,부산,태블릿,590000
2024-03,대구,노트북,1480000
2024-03,서울,스마트폰,820000
2024-03,부산,스마트폰,790000
EOF
```
- words.txt 파일 생성
```bash
cat > words.txt << EOF
apple
banana
Apple
cherry
BANANA
date
Cherry
elderberry
Apple
fig
banana
CHERRY
EOF
```

## 🧭 실습 문제
## 📁 문제 1 : 학생 성적 분석기 
- 파일 : grade_analyzer.sh
### 요구사항
- students.txt 파일을 분석하여 다음 기능을 수행하는 스크립트 작성
- 사용자로부터 과목명을 입력받아 해당 과목의 통계 정보 출력
- 조건문을 사용하여 입력 검증 및 등급 분류 수행

### 구현해야 할 기능
- 사용자가 입력한 과목이 유효한지 검사 (수학, 영어, 과학)
- 해당 과목의 모든 점수를 추출하여 정렬된 목록 출력
- 최고점, 최저점, 평균점수 계산
- 90점 이상(A), 80점 이상(B), 70점 이상(C), 그 외(D) 등급별 학생 수 출력
- 평균이 85점 이상이면 "우수", 75점 이상이면 "양호", 그 외는 "보통" 출력

### 힌트
- cut, grep, sort, wc 명령어 활용
- 파이프라인으로 명령어 연결
- 조건문으로 점수 범위 검사

### 🔧 정답
```bash
#!/bin/bash

# 사용 가능 과목명
V_MATH="수학"
V_ENGLISH="영어"
V_SCIENCE="과학"

# 사용자 입력
read -p "input subject : " V_SUBJECT

# 유효성 검사 및 과목 필드 번호 지정
# "FIELD" 를 이용하여 "cut" 대신 해서 점수 추출
if [ "$V_SUBJECT" = "$V_MATH" ]; then
    FIELD=3
elif [ "$V_SUBJECT" = "$V_ENGLISH" ]; then
    FIELD=5
elif [ "$V_SUBJECT" = "$V_SCIENCE" ]; then
    FIELD=7
else
    echo "There is no such subject!"
fi

# 점수 추출 및 정렬
# 여기서 중요한건 "$FIELD" 가 변수 정의가 되지 않았는데 실행이 되는 이유는 if문에서 "수학" 을 받았을 때 "FIELD=3" 이 동작하면서 자동으로 변수로 지정
# 지정된 "FIELD=3" 은 "V_SCORES" 에서 수학에 대한 점수를 자동으로 "3" 으로 추출
V_SCORES=$(cut -d ":" -f $FIELD "$1" | sort -nr)
echo "=== $V_SUBJECT RESULT ==="
echo "[정렬된 점수 목록]"
echo "$V_SCORES"

# 점수 계산을 위한 준비
TOTAL=0
COUNT=0
A=0
B=0
C=0
D=0
MAX=0
MIN=100

# read : 표준 입력으로부터 한 줄을 읽어 변수에 저장
# -r : 줄 바꿈을 특수 문자로 해석하지 않고 그대로 읽도록 함
while read -r SCORE
do
    # 총합 및 개수
    TOTAL=$((TOTAL + SCORE))
    COUNT=$((COUNT + 1))

    # 최고점, 최저점 갱신
    if [ "$SCORE" -gt "$MAX" ]; then
        MAX=$SCORE
    fi
    if [ "$SCORE" -lt "$MIN" ]; then
        MIN=$SCORE
    fi

    # 등급 분류
    # "A=$((A + 1))" 을 이용해서 "A=0" 에서 점수에 따라 누적 후 출력
    if [ "$SCORE" -ge 90 ]; then
        A=$((A + 1))
    elif [ "$SCORE" -ge 80 ]; then
        B=$((B + 1))
    elif [ "$SCORE" -ge 70 ]; then
        C=$((C + 1))
    else
        D=$((D + 1))
    fi
    # 파일을 읽어오는게 아닌 변수에 있는 문자열을 읽어오기 때문에 "<<<" 사용
done <<< "$V_SCORES"

# 평균 계산
AVG=$((TOTAL / COUNT))

# 결과 출력
echo
echo "[통계 정보]"
echo "최고점수: $MAX"
echo "최저점수: $MIN"
echo "평균점수: $AVG"

echo
echo "[등급별 학생 수]"
echo "A (90점 이상): $A 명"
echo "B (80점 이상): $B 명"
echo "C (70점 이상): $C 명"
echo "D (그 외): $D 명"

# 종합 평가 우수, 양호, 보통 출력
echo
echo "[평가]"
if [ "$AVG" -ge 85 ]; then
	echo "종합 평가: 우수 ($AVG점)"
elif [ "$AVG" -ge 75 ]; then
	echo "종합 평가: 양호 ($AVG점)"
else
	echo "종합 평가: 보통 ($AVG점)"
fi
```
### 🔧 결과
```bash
[parksejin@localhost quests]$ source grade_analyzer.sh students.txt
input subject : 수학
=== 수학 RESULT ===
[정렬된 점수 목록]
97
95
92
88
86
85
83
81
79
76

[통계 정보]
최고점수: 97
최저점수: 76
평균점수: 86

[등급별 학생 수]
A (90점 이상): 3 명
B (80점 이상): 5 명
C (70점 이상): 2 명
D (그 외): 0 명

[평가]
종합 평가: 우수 (86점)
```

## 📁 문제 2 : 서버 로그 모니터링 도구
- 파일 : log_monitor.sh
### 요구사항
- server_logs.txt 파일을 분석하여 로그 수준별 통계 및 문제 상황 감지
조건문을 사용하여 경고 수준 결정

### 구현해야 할 기능
- 전체 로그 라인 수 출력
- ERROR, WARNING, INFO 각각의 개수 계산 및 출력
- ERROR 로그만 별도 파일(errors.log)로 저장
- 가장 많이 발생한 ERROR 유형 찾기 (중복 제거 후 개수 확인)
- ERROR 비율이 30% 이상이면 "위험", 20% 이상이면 "주의", 그 외는 "정상" 출력
- 마지막 5개 로그 항목을 시간 역순으로 출력

### 힌트
- grep, wc, uniq, sort, tail 명령어 활용
- 리다이렉션으로 파일 저장
- 수치 계산을 위한 조건문 사용

### 🔧 정답
```bash
#!/bin/bash

V_LOG_FILE="server_logs.txt"

# "server_logs.txt" 를 입력 받아 결과 출력
V_TOTAL_LOG_LINE=$(wc -l < "$V_LOG_FILE")
echo "Total Log Line : $V_TOTAL_LOG_LINE"

# "server_logs.txt" 를 읽어온 후 "ERROR, WARNING, INFO"  찾은 후 출력
V_ERROR_LOG=$(cut -d" " -f 3 "$V_LOG_FILE" | grep -i "ERROR" | wc -l)
V_WARNING_LOG=$(cut -d" " -f 3 "$V_LOG_FILE" | grep -i "WARNING" | wc -l)
V_INFO_LOG=$(cut -d" " -f 3 "$V_LOG_FILE" | grep -i "INFO" | wc -l)

echo "ERROR : $V_ERROR_LOG"
echo "WARNING : $V_WARNING_LOG"
echo "INFO : $V_INFO_LOG"

# "ERROR" 찾은 후 "errors.log" 에 저장
grep "ERROR" "$V_LOG_FILE" > errors.log

# "errors.log" 에서 제일 많이 "ERROR" 가 나온 한 줄 출력
# "awk '{$1=$1; print}' 를 이용하여 맨 앞의 숫자를 제거하지 않고 공백을 없앤 후 출력
V_MOST_ERROR=$(cut -d" " -f 4- errors.log | sort | uniq -c | sort -nr | head -n 1 | awk '{$1=$1; print}')
echo "MOST ERROR : $V_MOST_ERROR"

# 총 로그 중 에러 비율 계산
V_RATE=$((V_ERROR_LOG * 100 / V_TOTAL_LOG_LINE))

# 비율이 30% 이상이면 "DANGER", 20% 이상이면 "CAUTION", 그 미만이면 "NORMAL" 출력
if [ "$V_RATE" -ge 30 ]; then
        echo "ERROR STATUS : DANGER"
elif [ "$V_RATE" -ge 20 ]; then
        echo "ERROR STATUS : CAUTION"
else
        echo "ERROR STATUS : NORMAL"
fi

# 로그 역순 정렬 후 마지막 줄부터 5줄 출력
echo "Last 5 Log : " && cut -d" " -f 2- "$V_LOG_FILE" | sort -r | head -n 5
```
### 🔧 결과
```bash
[yhc@192.168.0.51 ~/shell_practice]$ source log_monitor.sh 
Total Log Line : 12
ERROR : 5
WARNING : 2
INFO : 5
MOST ERROR : 2 Database connection failed
ERROR STATUS : DANGER
Last 5 Log : 
10:41:35 ERROR Authentication failed: user005
10:40:28 INFO User login successful: user004
10:39:15 ERROR Database connection failed
10:38:52 WARNING Disk space low: 90%
10:37:45 INFO System backup started
```
## 📁 문제 3 : 판매 데이터 분석 시스템
- 파일 : sales_analyzer.sh
### 요구사항
- sales_data.txt 파일을 분석하여 매출 데이터 통계 생성
- 사용자 입력에 따른 다양한 분석 결과 제공

### 구현해야 할 기능
- 사용자로부터 분석 타입 입력받기 (월별/지역별/제품별)
- 입력값이 유효하지 않으면 사용법 출력 후 종료
- 선택한 분석 타입에 따라 다음 수행:
- 월별 : 각 월의 총 매출액을 높은 순으로 정렬하여 출력
- 지역별 : 각 지역의 총 매출액과 평균 매출액 출력
- 제품별 : 각 제품의 판매 횟수와 총 매출액 출력
- 전체 매출액이 1000만원 이상이면 "목표 달성", 800만원 이상이면 "양호", 그 외는 "노력 필요" 출력

### 힌트
- cut, sort, uniq, grep 명령어 조합
- 필드 분리를 위한 -d 옵션 활용
- 조건문으로 분석 타입 분기 처리
### 🔧 정답
```bash
#!/bin/bash

read -r -p "분석 타입을 선택하세요 (월별/지역별/제품별) : " analysis_type

# 입력값 검증
if [ "$analysis_type" != "월별" ] && [ "$analysis_type" != "지역별" ] && [ "$analysis_type" != "제품별" ]; then
    echo "사용법 : 월별, 지역별, 제품별 중 하나를 입력하세요"
fi

echo "=== $analysis_type 매출 분석 결과 ==="

if [ "$analysis_type" = "월별" ]; then
    echo "[월별 총 매출액]"
    cut -d',' -f1,4 sales_data.txt | tr ',' ' ' | sort | cut -d' ' -f1 | uniq > months.tmp
    
    # "cat month.tmp" 를 읽고 "month" 에 저장 후 월과 총액 출력
    for month in $(cat months.tmp); do
    month_total=0
    for amount in $(grep "^$month," sales_data.txt | cut -d',' -f4); do
        month_total=$((month_total + amount))
    done
    echo "$month : $month_total원"
done | sort -k2 -nr

rm months.tmp

# 지역별 총액과 평균 출력
elif [ "$analysis_type" = "지역별" ]; then
    echo "지역별 총 매출액 및 평균:"
    cut -d',' -f2 sales_data.txt | sort | uniq > regions.tmp

    for region in $(cat regions.tmp); do
        region_total=0
        region_count=0
        for amount in $(grep ",$region," sales_data.txt | cut -d',' -f4); do
            region_total=$((region_total + amount))
            region_count=$((region_count + 1))
        done
        region_avg=$((region_total / region_count))
        echo "$region : 총 $region_total원, 평균 $region_avg원"
    done

    rm regions.tmp

else  # 제품별 판매 횟수와 총액 출력
    echo "제품별 판매 횟수 및 총 매출액:"
    cut -d',' -f3 sales_data.txt | sort | uniq > products.tmp
    
    for product in $(cat products.tmp); do
        product_count=$(grep ",$product," sales_data.txt | wc -l)
        product_total=0
        for amount in $(grep ",$product," sales_data.txt | cut -d',' -f4); do
            product_total=$((product_total + amount))
        done
        echo "$product : $product_count회 판매, 총 $product_total원"
    done
    
    rm products.tmp
fi

# 전체 매출액 계산
total_sales=0
for amount in $(cut -d',' -f4 sales_data.txt); do
    total_sales=$((total_sales + amount))
done

echo "전체 매출액 : $total_sales원"

# 목표 달성도 평가
if [ $total_sales -ge 10000000 ]; then
    achievement="목표 달성"
elif [ $total_sales -ge 8000000 ]; then
    achievement="양호"
else
    achievement="노력 필요"
fi

echo "달성도: $achievement"
```
### 🔧 결과
```bash
[parksejin@localhost quests]$ source sales_analyzer.sh
분석 타입을 선택하세요 (월별/지역별/제품별) : 월별
=== 월별 매출 분석 결과 ===
[월별 총 매출액]
2024-03 : 3680000원
2024-02 : 4370000원
2024-01 : 3750000원
전체 매출액 : 11800000원
달성도: 목표 달성
```
```bash
[parksejin@localhost quests]$ source sales_analyzer.sh
분석 타입을 선택하세요 (월별/지역별/제품별) : 지역별
=== 지역별 매출 분석 결과 ===
[지역별 총 매출액 및 평균]
서울 : 총 5310000원, 평균 1062000원
부산 : 총 3630000원, 평균 907500원
대구 : 총 2860000원, 평균 953333원
서울 : 총 5310000원, 평균 1062000원
부산 : 총 3630000원, 평균 907500원
서울 : 총 5310000원, 평균 1062000원
대구 : 총 2860000원, 평균 953333원
서울 : 총 5310000원, 평균 1062000원
부산 : 총 3630000원, 평균 907500원
대구 : 총 2860000원, 평균 953333원
서울 : 총 5310000원, 평균 1062000원
부산 : 총 3630000원, 평균 907500원
전체 매출액 : 11800000원
달성도: 목표 달성
```
## 📁 문제 4 : 단어 빈도 분석기
- 파일 word_frequency.sh
### 요구사항
- words.txt 파일의 단어들을 분석하여 빈도수 계산
- 대소문자 처리 옵션 제공

### 구현해야 할 기능
- 사용자로부터 대소문자 구분 여부 입력받기 (y/n)
- 입력값 검증 (y 또는 n이 아니면 재입력 요구)
- 대소문자 구분하지 않는 경우
- 모든 단어를 소문자로 변환
- 중복 제거 후 빈도수와 함께 출력
- 빈도수 기준 내림차순 정렬

#### 대소문자 구분하는 경우
- 원본 그대로 중복 제거 후 빈도수 계산
- 총 고유 단어 개수 출력
- 가장 빈도가 높은 단어가 3회 이상 나타나면 "높은 중복도", 2회면 "보통 중복도", 1회면 "낮은 중복도" 출력

### 힌트
- tr, sort, uniq, wc 명령어 활용
- 대소문자 변환을 위한 tr A-Z a-z
- 조건문으로 사용자 선택 처리

### 🔧 정답
```bash
vi word_frequency.sh
```
```bash
#!/bin/bash

v_file="$1"

read -p "대소문자를 구분하시겠습니까? y or n : " v_select
# 이중 if문 사용 / y 아니면 n 를 입력했을 때 결과 출력
# 다른 결과값 넣을시 "재입력하세요!" 출력
if [ "$v_select" = "n" ]; then
    many_word=$(tr -cs '[:alnum:]' '\n' < "$v_file" | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -rn)
    echo "$many_word"
elif [ "$v_select" = "y" ]; then
    many_word2=$(tr -cs '[:alnum:]' '\n' < "$v_file" | sort | uniq -c | sort -rn)
    echo "$many_word2"

# awk : 텍스트 파일에서 줄과 필드를 기준으로 데이터를 처리하는 명령
# 'NR==1' : 현재 줄 번호(NR)가 1일 때만 {} 내부의 명령을 실행
# {print $1} : 현재 줄의 첫 번째 필드($1)를 출력 (공백 또는 탭으로 나뉜 필드 기준)
    max_count=$(echo "$many_word2" | awk 'NR==1 {print $1}')

    if [ "$max_count" -ge 3 ]; then
        echo "높은 중복도"
    elif [ "$max_count" -eq 2 ]; then
        echo "보통 중복도"
    else
        echo "낮은 중복도"
    fi
else
    echo "재입력하세요!"
fi
```
### 🔧 결과
```bash
[parksejin@localhost shell_practice]$ source word_frequency.sh words.txt
대소문자를 구분하시겠습니까? y or n : y
      2 banana
      2 Apple
      1 fig
      1 elderberry
      1 date
      1 CHERRY
      1 Cherry
      1 cherry
      1 BANANA
      1 apple
보통 중복도
[parksejin@localhost shell_practice]$ source word_frequency.sh words.txt
대소문자를 구분하시겠습니까? y or n : n
      3 cherry
      3 banana
      3 apple
      1 fig
      1 elderberry
      1 date
[parksejin@localhost shell_practice]$ source word_frequency.sh words.txt
대소문자를 구분하시겠습니까? y or n : u
재입력하세요!
```