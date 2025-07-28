# ✅ 문제 : 간단한 서버 관리 스크립트 작성
## 🔧 요구사항
start: 포트 8000에서 http.server를 백그라운드로 실행 (nohup, 로그는 server.log)

stop: 실행 중인 프로세스를 찾아 종료

status: 프로세스가 실행 중인지 확인하여 출력

restart: 중지 후 다시 실행

### 🎯 실행 예시
$ ./webserver.sh start
서버가 백그라운드에서 시작되었습니다.

$ ./webserver.sh status
서버 실행 중입니다. PID: 13579

$ ./webserver.sh stop
서버가 종료되었습니다.

$ ./webserver.sh tail_log
… log message 확인

문제 모두 조건에 따라:
if [ "$1" == "start" ] 식으로 흐름 제어
변수 PORT, PID, LOGFILE 등을 정의해 구성 가능

### 🔧 정답

```
#!/bin/bash

CMD="nohup python3 -m http.server 8000 --bind 0.0.0.0"

if [ "$1" = "start" ]; then
        $CMD > server.log 2>&1 &
        echo "서버가 백그라운드에서 시작되었습니다."
elif [ "$1" = "status" ]; then
        jobs
elif [ "$1" = "stop" ]; then
        kill $(pgrep -f "python3 -m http.server 8000 --bind 0.0.0.0")
        echo "서버가 종료되었습니다."
elif [ "$1" = "restart" ]; then
        bash $0 stop
        sleep 2
        bash $0 start
        echo "서버가 다시 시작합니다."
elif [ "$1" = "server.log" ]; then
        cat < server.log
fi
```
### 🔧 결과

```
[parksejin@192.168.0.50 ~/Downloads/webroot]$ source webserver.sh start
서버가 백그라운드에서 시작되었습니다.
```
```
[parksejin@192.168.0.50 ~/Downloads/webroot]$ source webserver.sh stop
서버가 종료되었습니다.
[1]-  Terminated              $CMD > server.log 2>&1
[2]+  Exit 1                  $CMD > server.log 2>&1
```
```
[parksejin@192.168.0.50 ~/Downloads/webroot]$ source webserver.sh status
[1]+  Running                 $CMD > server.log 2>&1 &
```
```
[parksejin@192.168.0.50 ~/Downloads/webroot]$ source webserver.sh server.log
nohup: ignoring input
```