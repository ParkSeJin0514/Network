# 🧪 문제 1. 특정 IP 차단 상태 확인 후 차단 설정
## ✅ 실행 예시
```bash
$ sudo ./problem1.sh
[INFO] 현재 rich rule 목록에 192.168.0.100 차단 룰이 존재하지 않습니다.
[INFO] 차단 룰을 추가합니다...
success

또는

$ sudo ./problem1.sh
[INFO] 192.168.0.100은 이미 차단되어 있습니다.
[SKIP] 추가 작업을 수행하지 않습니다.
```
### 🔧 정답
```bash
# "rules" 에서 포트 조회
CHECK="192.168.0.51"
RULES=$(sudo firewall-cmd --list-rich-rules | cut -d'"' -f 4)

# "$CHECK" 와 "$RULES" 가 같으면 추가 작업 X
# "$CHECK" 와 "$RULES" 가 같지 않으면 차단 추가 후 리로드
if [ "$CHECK" = "$RULES" ]; then
        echo "[INFO] $CHECK은 이미 차단되어 있습니다."
        echo "[SKIP] 추가 작업을 수행하지 않습니다."
elif [ "$CHECK" != "$RULES" ]; then
        echo "[INFO] 현재 rich rule 목록에 $RULES 차단 룰이 존재하지 않습니다."
        echo "[INFO] 차단 룰을 추가합니다." && sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.0.51" reject' && sleep 2 && sudo firewall-cmd --reload
fi    
```
### 🔧 결과
```bash
[parksejin@localhost ~]$ ./problem1.sh
[INFO] 현재 rich rule 목록에  차단 룰이 존재하지 않습니다.
[INFO] 차단 룰을 추가합니다.
success
success
[parksejin@localhost ~]$ sudo firewall-cmd --list-rich-rules
rule family="ipv4" source address="192.168.0.51" reject
```
```bash
[parksejin@localhost ~]$ ./problem1.sh
[INFO] 192.168.0.51은 이미 차단되어 있습니다.
[SKIP] 추가 작업을 수행하지 않습니다.
```
# 🔒 문제 2. 포트 8080이 열려 있다면 닫기
## ✅ 실행 예시
```bash
$ sudo ./problem2.sh
[INFO] 포트 8080/tcp 이 열려 있습니다. 제거합니다...
success

또는

$ sudo ./problem2.sh
[INFO] 포트 8080/tcp 이 열려 있지 않습니다. 아무 작업도 수행하지 않습니다.
```
### 🔧 정답
```bash
#!/bin/bash

V_PORT="8080"

if sudo firewall-cmd --list-ports | grep -q "$V_PORT/tcp"; then
    echo "[INFO] 포트 $V_PORT/tcp 이 이미 열려 있습니다. 아무 작업도 수행하지 않습니다."
else
    echo "[INFO] 포트 $V_PORT/tcp 이 열려 있지 않습니다. 추가합니다."
    sudo firewall-cmd --permanent --add-port=$V_PORT/tcp
    sudo firewall-cmd --reload
fi
```
### 🔧 결과
```bash
[INFO] 포트 8080/tcp 이 열려 있지 않습니다. 추가합니다.
success
success
[parksejin@localhost ~]$ sudo firewall-cmd --list-ports
8080/tcp
```
```bash
[parksejin@localhost ~]$ ./problem2.sh 
[INFO] 포트 8080/tcp 이 이미 열려 있습니다. 아무 작업도 수행하지 않습니다.
```
# 🧩 문제 3. SSH 서비스 제거 후 특정 IP만 허용 ✅ 실행 예시
## ✅ 실행 예시
```bash
$ sudo ./problem3.sh
[INFO] 8080 서비스가 열려 있습니다. 제거합니다...
success
[INFO] 192.168.0.10 IP에만 포트 8080 허용 규칙을 추가합니다...
success

또는

$ sudo ./problem3.sh
[INFO] SSH 서비스가 이미 제거되어 있습니다.
[INFO] 포트 8080 허용 규칙만 추가합니다...
success
problem3.sh
```
### 🔧 정답
```bash
V_IP="12.168.0.31"
V_PORT="8080"

# "$V_PORT" 를 이용하여 8080을 찾은 후 표준 출력과 에러를 "/dev/null"로 보냄
# 그 후 "rules" 추가
if [ -n "$(sudo firewall-cmd --list-ports | grep "$V_PORT")" ]; then
        echo "[INFO] $V_PORT 서비스가 열려 있습니다. 제거합니다..."
        sudo firewall-cmd --permanent --remove-port="$V_PORT"/tcp &> /dev/null
        echo "[INFO] $V_IP IP에만 포트 $V_PORT 허용 규칙을 추가합니다..."
        sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="V_IP" port="$V_PORT" accept' &> /dev/null
        sudo firewall-cmd --reload
else
        echo "[INFO] $V_PORT 서비스가 이미 제거되어 있습니다."
        echo "[INFO] 포트 $V_PORT 허용 규칙만 추가합니다..."
        sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="V_IP" port="$V_PORT" accept' &> /dev/null
        sudo firewall-cmd --reload
fi
```
### 🔧 결과
```bash
[parksejin@localhost ~]$ ./problem3.sh 
[sudo] password for parksejin: 
[INFO] 8080 서비스가 열려 있습니다. 제거합니다...
[INFO] 12.168.0.31 IP에만 포트 8080 허용 규칙을 추가합니다...
success
```
```bash
[parksejin@localhost ~]$ ./problem3.sh 
[INFO] 8080 서비스가 이미 제거되어 있습니다.
[INFO] 포트 8080 허용 규칙만 추가합니다...
success
```