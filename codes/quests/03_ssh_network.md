# 🧪 Network Shell Script 실습 문제
## 💻 문제 환경 설정
- 실습을 위해 다음 파일들을 생성하세요
## 🔹 1. 네트워크 로그 파일 생성
```
cat > network.log << 'EOF'
2024-01-15 10:30:25 192.168.1.100 CONNECT success
2024-01-15 10:30:30 192.168.1.101 CONNECT failed
2024-01-15 10:31:15 192.168.1.102 CONNECT success
2024-01-15 10:31:20 192.168.1.100 DISCONNECT success
2024-01-15 10:32:10 192.168.1.103 CONNECT success
2024-01-15 10:32:15 192.168.1.101 CONNECT success
2024-01-15 10:33:25 192.168.1.104 CONNECT failed
2024-01-15 10:33:30 192.168.1.102 DISCONNECT success
EOF
```

## 🔹 3. 접속 통계 파일 생성
```
cat > connections.txt << 'EOF'
192.168.1.100 5
192.168.1.101 12
192.168.1.102 8
192.168.1.103 3
192.168.1.104 15
192.168.1.105 7
EOF
```
## 📁 문제 1. 네트워크 연결 상태 분석기
### 요구사항
- network.log 파일을 분석하여 연결 성공/실패 통계를 - - 출력하는 스크립트 작성
- 전체 연결 시도 수, 성공 수, 실패 수를 계산
- 성공률을 백분율로 표시 (소수점 제거)
### 출력 형태
```
=== 네트워크 연결 분석 결과 ===
전체 연결 시도: X건
성공: Y건
실패: Z건
성공률: W%
```
### 제한사항
- if문과 변수만 사용
- grep, wc, cut 명령어 활용
- 파일명은 스크립트 실행 시 첫 번째 인자로 받기

### 🔧 정답
```
#!/bin/bash

V_NETLOG="network.log"
TOTAL_LINE=$(wc -l < "$V_NETLOG")
TOTAL_SUC=$(cut -d" " -f 5 < "$V_NETLOG" | grep "success" | wc -l)
TOTAL_FAIL=$(cut -d" " -f 5 < "$V_NETLOG" | grep "failed" | wc -l)
TOTAL_AVG=$(($TOTAL_SUC * 100 / $TOTAL_LINE))

echo "=== 네트워크 연결 분석 결과 ==="
echo "전체 연결 시도: $TOTAL_LINE건"
echo "성공: $TOTAL_SUC건"
echo "실패: $TOTAL_FAIL건"
echo "성공률: $TOTAL_AVG%"
```
```
[parksejin@localhost quests]$ source searchlog.sh
=== 네트워크 연결 분석 결과 ===
전체 연결 시도: 8건
성공: 6건
실패: 2건
성공률: 75%
```
## 📁 문제 2. IP 주소별 접속 빈도 상위 리스트
### 요구사항
- network.log에서 IP 주소별 접속 횟수를 계산
- 접속 횟수 기준으로 내림차순 정렬하여 상위 3개만 출력
- 각 IP의 첫 접속 시간도 함께 표시
### 출력 형태
```
=== 접속 빈도 TOP 3 ===
1위: 192.168.1.XXX (X회) - 첫 접속: 10:XX:XX
2위: 192.168.1.XXX (X회) - 첫 접속: 10:XX:XX  
3위: 192.168.1.XXX (X회) - 첫 접속: 10:XX:XX
```
### 제한사항
- if문과 변수만 사용
- cut, sort, uniq, grep 명령어 활용
- head나 tail로 결과 제한

### 🔧 정답
```
#!/bash/bash

V_LINE1=$(cut -d" " -f3 $1 | sort | uniq -c | sort -nr | sed -n '1p')
V_LINE2=$(cut -d" " -f3 $1 | sort | uniq -c | sort -nr | sed -n '2p')
V_LINE3=$(cut -d" " -f3 $1 | sort | uniq -c | sort -nr | sed -n '3p')

echo "=== 접속 빈도 TOP 3 ==="

if [ -n "$V_LINE1" ]; then
        V_L1=$(echo "$V_LINE1" | tr -s " ")
        V_COUNT1=$(echo "$V_L1" | cut -d" " -f 2)
        V_IP1=$(echo "$V_L1" | cut -d" " -f 3)
        V_FIRST=$(grep "$V_IP1" $1 | head -1 | cut -d" " -f2)
        echo "1위: $V_IP1 (${V_COUNT1}회) - 첫 접속: $V_FIRST"
fi

if [ -n "$V_LINE2" ]; then
        V_L2=$(echo "$V_LINE2" | tr -s " ")
        V_COUNT2=$(echo "$V_L2" | cut -d" " -f 2)
        V_IP2=$(echo "$V_L2" | cut -d" " -f 3)
        V_SECOND=$(grep "$V_IP2" $1 | head -1 | cut -d" " -f2)
        echo "2위: $V_IP2 (${V_COUNT2}회) - 첫 접속: $V_SECOND"
fi

if [ -n "$V_LINE2" ]; then
        V_L3=$(echo "$V_LINE3" | tr -s " ")
        V_COUNT3=$(echo "$V_L3" | cut -d" " -f 2)
        V_IP3=$(echo "$V_L3" | cut -d" " -f 3)
        V_THIRD=$(grep "$V_IP3" $1 | head -1 | cut -d" " -f2)
        echo "3위: $V_IP3 (${V_COUNT3}회) - 첫 접속: $V_THIRD"
fi
```
```
[parksejin@localhost quests]$ source connectlog.sh network.log
=== 접속 빈도 TOP 3 ===
1위: 192.168.1.102 (2회) - 첫 접속: 10:31:15
2위: 192.168.1.101 (2회) - 첫 접속: 10:30:30
3위: 192.168.1.100 (2회) - 첫 접속: 10:30:25
```

## 📁 문제 3. 서버 상태 점검 스크립트
### 요구사항
- servers.sh 실행해 각 서버에 대해 ping 테스트 실행
- 응답 있는 서버와 없는 서버를 구분하여 출력
- 응답 시간이 100ms 이상인 서버는 "느림" 표시
```
입력 형태:
	~$ servers.sh 123.92.0.12
출력 형태:
=== 서버 상태 점검 결과 ===
[정상] web01 (123.92.0.12) - 응답시간: XXms
OR
=== 서버 상태 점검 결과 ===
[오프라인] db01 (123.92.0.11) - 응답없음
...
```
### 제한사항
- if문과 변수만 사용
- cut, ping 명령어 활용
- ping은 1회만 실행 (ping -c 1)

### 🔧 정답

```
#!/bin/bash

V_PING="$1"
V_PING_CHECK=$(ping -c 1 "$V_PING")
V_PING_TIME=$(echo "$V_PING_CHECK" | grep "time=" | cut -d" " -f 7)

echo "=== 서버 상태 점검 결과 ==="

if echo "$V_PING_CHECK" | grep -q "1 received"; then
        echo "[정상] ($V_PING) - 응답시간 : "$V_PING_TIME"ms"
else
        echo "[오프라인] ($V_PING) - 응답없음"
fi
```
```
[mk@192.168.0.100 ~/parksejin]$ source servers.sh 192.168.0.4
=== 서버 상태 점검 결과 ===
[정상] (192.168.0.4) - 응답시간 : time=1.11ms

[mk@192.168.0.100 ~/parksejin]$ source servers.sh 192.168.0.0
=== 서버 상태 점검 결과 ===
[오프라인] (192.168.0.0) - 응답없음
```
## 📁 문제 4. 네트워크 트래픽 임계값 모니터링
### 요구사항
- connections.txt에서 접속 수가 10 이상인 IP를 "높음", 5-9는 "보통", 4 이하는 "낮음"으로 분류
- 각 분류별로 개수 계산하여 출력
- "높음" 분류의 IP들만 별도로 나열
### 출력 형태
```
=== 트래픽 분석 결과 ===
높음(10회 이상): X개
보통(5-9회): Y개  
낮음(4회 이하): Z개

[주의 필요 IP 목록]
192.168.1.XXX (XX회)
192.168.1.XXX (XX회)
```
### 제한사항
- if문과 변수만 사용
- cut, sort 명령어 활용
- 숫자 비교를 위한 조건문 사용
### 🔧 정답
```
#!/bin/bash

V_CHECK="$1"
HIGH=0
MEDIUM=0
LOW=0
HIGH_IP=""

while read V_LINE_CHECK
do
        V_LINE=$(echo "$V_LINE_CHECK" | cut -d" " -f 2)
        V_IP=$(echo "$V_LINE_CHECK" | cut -d" " -f 1)

        if [ "$V_LINE" -ge 10 ]; then
                HIGH="$(( HIGH+1 ))"

                HIGH_IP="${HIGH_IP}${V_IP} ("$V_LINE"회)\n"

        elif [ "$V_LINE" -ge 5 ] && [ "$V_LINE" -le 9 ]; then
                MEDIUM="$(( MEDIUM+1 ))"

        elif [ "$V_LINE" -le 4 ]; then
                LOW="$(( LOW+1 ))"
        fi
done < "$V_CHECK"

echo -e "=== 트래픽 분석 결과 ===
높음(10회 이상): "$HIGH"개
보통(5-9회): "$MEDIUM"개
낮음(4회 이하): "$LOW"개

[주의 필요 IP 목록]
"$HIGH_IP""
```
```
[parksejin@localhost quests]$ source checkconnections.sh connections.txt
=== 트래픽 분석 결과 ===
높음(10회 이상): 2개
보통(5-9회): 3개
낮음(4회 이하): 1개

[주의 필요 IP 목록]
192.168.1.101 (12회)
192.168.1.104 (15회)
```