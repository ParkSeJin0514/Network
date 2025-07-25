# Network Shell Script 실습 문제
## 문제 환경 설정
- 실습을 위해 다음 파일들을 생성하세요
## 1. 네트워크 로그 파일 생성
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
```
##3. 접속 통계 파일 생성
cat > connections.txt << 'EOF'
192.168.1.100 5
192.168.1.101 12
192.168.1.102 8
192.168.1.103 3
192.168.1.104 15
192.168.1.105 7
EOF
```
## 문제 1. 네트워크 연결 상태 분석기
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
## 문제 2. IP 주소별 접속 빈도 상위 리스트
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

## 문제 3. 서버 상태 점검 스크립트
- 요구사항
```servers.sh 실행해 각 서버에 대해 ping 테스트 실행
응답 있는 서버와 없는 서버를 구분하여 출력
응답 시간이 100ms 이상인 서버는 "느림" 표시
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