# 🧪 환경 변수 및 초기화 스크립트 실습 문제
## 🔹 문제 1. 로그인 시마다 "Welcome, USERNAME" 메시지를 출력하시오
- 현재 로그인한 사용자명을 포함할 것 ($USER)
- 로그인할 때마다 자동으로 출력되도록 설정할 것
```
[parksejin@localhost ~]$ nano .bash_profile
# nano
echo "Welcome, $USER"
```
```
[parksejin@localhost ~]$ su - parksejin
Password: 
Welcome, parksejin
```
## 🔹 문제 2. 로그인 시 사용자의 Downloads/ 폴더 내 일반 파일을 삭제하시오
- 경로 : ~/Downloads/
- 일반 파일만 삭제 (서브디렉토리, 숨김파일은 삭제하지 않음)
- 로그인 시 자동 실행
```
[parksejin@localhost ~]$ nano .bash_profile
# nano
find ~/Downloads/ -type f -exec rm -f {} \;            # exec : 찾은 결과에 대해 명령어 실행
                                                       # rm -f {} : 찾은 각각의 파일을 rm -f 명령으로 삭제 ({}는 찾은 파일 하나하나를 의미)
                                                       # \; : -exec 명령의 종료를 의미함 (';'는 명령의 끝을 의미 / '\'는 ';'은 자체 명령어 구분자로 인식해서 \를 같이 써야됨)
```
```
[parksejin@localhost Downloads]$ touch test.txt
[parksejin@localhost ~]$ su - parksejin
Password: 
[parksejin@localhost ~]$ ls -l Downloads/
total 0
```
## 🔹 문제 3. 로그인할 때마다 ~/Downloads/ 경로에 다음 구조로 디렉토리 및 파일을 자동 생성하도록 설정하시오

- 생성 구조
```
~/Downloads/
 └── auto_created/
      ├── info.txt
      └── logs/
           └── log.txt
```
- 파일에는 임의의 간단한 문자열이 들어갈 것
- 매 로그인마다 자동 생성
```
[parksejin@localhost ~]$ nano .bash_profile
# nano
mkdir -p ~/Downloads/auto_created/logs/
touch ~/Downloads/auto_created/info.txt
touch ~/Downloads/auto_created/logs/log.txt
```
```
[parksejin@localhost ~]$ su - parksejin
Password: 
[parksejin@localhost ~]$ ls -l Downloads/
total 0
drwxr-xr-x. 3 parksejin parksejin 34 Jul 22 11:54 auto_created
[parksejin@localhost ~]$ ls -l Downloads/auto_created/
total 0
-rw-r--r--. 1 parksejin parksejin  0 Jul 22 11:54 info.txt
drwxr-xr-x. 2 parksejin parksejin 21 Jul 22 11:54 logs
[parksejin@localhost ~]$ ls -l Downloads/auto_created/logs
total 0
-rw-r--r--. 1 parksejin parksejin 0 Jul 22 11:54 log.txt
```

## 🔹 문제 4. /etc/profile을 수정하여, 로그인 시 모든 사용자에게 공지 메시지 /etc/login_notice.txt를 출력하도록 설정하시오
- 출력 방식은 cat, echo 등 자유
- 시스템 전체 사용자에게 적용
- /etc/login_notice.txt는 임의의 내용을 사전에 작성해 둘 것
- sudo 권한 필요
```
[parksejin@localhost /]$ sudo nano etc/login_notice.txt
# nano
Hello
```
```
[parksejin@localhost /]$ sudo nano etc/profile
# nano
cat ../../etc/login_notice.txt
```
```
[parksejin@localhost ~]$ su - parksejin 
Password: 
Hello
```
---
### 📁 각 실습 후 su - 사용자명, ls -R ~/Downloads, cat 등을 통해 적용 여부를 확인하십시오