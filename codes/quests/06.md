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
CHECK="192.168.0.51"
RULES=$(sudo firewall-cmd --list-rich-rules | cut -d'"' -f 4)

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