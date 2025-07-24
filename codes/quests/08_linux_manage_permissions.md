# 📁 Linux 권한 관리 실습 문제
- 실습 환경 설정
- 먼저 다음 명령어들을 실행하여 실습 환경을 구성하세요
## 실습 디렉터리 생성
```
# root 안에서 실행
su -
```
```
mkdir permission_practice
cd permission_practice
```

## 사용자 및 그룹 생성 (관리자 권한 필요)
```
sudo useradd -m -s /bin/bash alice
sudo useradd -m -s /bin/bash bob
sudo useradd -m -s /bin/bash charlie
sudo useradd -m -s /bin/bash diana
sudo useradd -m -s /bin/bash eve
```

## 그룹 생성
```
sudo groupadd developers
sudo groupadd managers
```

## 사용자를 그룹에 추가
```
sudo usermod -a -G developers alice
sudo usermod -a -G developers bob
sudo usermod -a -G developers charlie
sudo usermod -a -G managers diana
sudo usermod -a -G managers alice
# eve는 기타 사용자로 어떤 그룹에도 속하지 않음
```

## 복잡한 디렉터리 구조 생성
```
mkdir -p {company/{departments/{dev,hr,finance,marketing},projects/{project_a,project_b,project_c}},shared/{documents,resources,tools},private/{alice,bob,charlie,diana,eve},backup/{daily,weekly,monthly},logs/{2023/{01..12},2024/{01..12}}}
```

## 다양한 파일 생성
```
touch company/departments/dev/{main.py,test.py,config.py,README.md}
touch company/departments/hr/{employees.xlsx,contracts.pdf,policies.txt}
touch company/departments/finance/{budget.xlsx,reports.pdf,invoices.csv}
touch company/projects/project_a/{spec.doc,code.zip,data.json}
touch company/projects/project_b/{requirements.txt,source.tar.gz,notes.md}
touch shared/documents/{manual.pdf,guidelines.txt,templates.docx}
touch shared/resources/{images.zip,fonts.tar,icons.png}
touch private/alice/{personal.txt,settings.conf,backup.tar}
touch private/bob/{notes.md,config.json,archive.zip}
touch backup/daily/{backup_$(date +%Y%m%d).tar.gz,log_$(date +%Y%m%d).txt}
touch logs/2024/06/{access.log,error.log,debug.log,system.log}
```

## 실행 가능한 스크립트 파일 생성
```
echo '#!/bin/bash' > shared/tools/deploy.sh
echo 'echo "Deployment script"' >> shared/tools/deploy.sh
echo '#!/bin/bash' > shared/tools/backup.sh
echo 'echo "Backup script"' >> shared/tools/backup.sh
echo '#!/bin/bash' > company/departments/dev/build.sh
echo 'echo "Build script"' >> company/departments/dev/build.sh
```

## 설정 파일 생성
```
echo "database_host=localhost" > company/departments/dev/database.conf
echo "api_key=secret123" > company/departments/dev/api.conf
echo "salary_data=confidential" > company/departments/hr/salaries.txt
```
```
echo "실습 환경이 구성되었습니다!"
tree permission_practice
```

## 📁 1. 기본 권한 설정
### 1-1. 개발팀 파일 권한 설정
- 개발팀(developers 그룹) 관련 파일들의 권한을 다음과 같이 설정하세요
- company/departments/dev/ 디렉터리 : 개발팀만 접근 가능, 소유자와 그룹은 읽기/쓰기/실행 가능
- company/departments/dev/main.py : 개발팀은 읽기/쓰기, 기타는 읽기만 가능
- company/departments/dev/build.sh : 개발팀만 실행 가능
```
[root@localhost permission_practice]# sudo chgrp developers ./company/departments/dev/
[root@localhost permission_practice]# ls -l company/departments/
total 0
drwxr-xr-x. 2 root developers 123 Jul 21 16:48 dev
```
```
[root@localhost permission_practice]# chmod 770 company/departments/dev
[root@localhost permission_practice]# ls -l company/departments/
total 0
drwxrwx---. 2 root develops 123 Jul 21 16:48 dev
```
```
[root@localhost permission_practice]# sudo chgrp developers company/departments/dev/main.py 
[root@localhost permission_practice]# chmod 764 company/departments/dev/main.py 
[root@localhost permission_practice]# ls -l company/departments/dev/main.py 
-rwxrw-r--. 1 root developers 0 Jul 21 16:48 company/departments/dev/main.py
```
```
[root@localhost permission_practice]# sudo chgrp developers company/departments/dev/build.sh 
[root@localhost permission_practice]# chmod 010 company/departments/dev/build.sh
[root@localhost permission_practice]# ls -l company/departments/dev/build.sh 
------x---. 1 root developers 32 Jul 21 16:48 company/departments/dev/build.sh
```

### 1-2. 개인 디렉터리 보안 설정
- 각 사용자의 개인 디렉터리와 파일을 다음과 같이 설정하세요
- private/alice/ 디렉터리 : alice만 접근 가능
- private/alice/personal.txt : alice만 읽기/쓰기 가능
- private/bob/config.json : bob만 읽기/쓰기 가능
```
[root@localhost permission_practice]# sudo chown alice:alice private/alice/
[root@localhost permission_practice]# ls -l private/
drwxr-xr-x. 2 alice alice 65 Jul 21 16:48 alice
```
```
[root@localhost permission_practice]# sudo chown alice:alice private/alice/personal.txt 
[root@localhost permission_practice]# chmod 600 private/alice/personal.txt 
[root@localhost permission_practice]# ls -l private/alice/
-rw-------. 1 alice alice 0 Jul 21 16:48 personal.txt
```
```
[root@localhost permission_practice]# chown bob:bob private/bob/config.json
[root@localhost permission_practice]# chmod 600 private/bob/config.json 
[root@localhost permission_practice]# ls -l private/bob/
-rw-------. 1 bob  bob  0 Jul 21 22:08 config.json
```

## 📁 2. 그룹 기반 권한 관리
### 2-1. 공유 리소스 접근 권한
- shared/ 디렉터리의 권한을 다음과 같이 설정하세요
- shared/documents/ : developers와 managers 그룹 모두 읽기 가능, 소유자만 쓰기 가능
- shared/resources/ : developers 그룹만 접근 가능
- shared/tools/ : 모든 사용자가 읽기 가능, developers 그룹만 실행 가능
```
[root@localhost permission_practice]# sudo groupadd alice_bob
[root@localhost permission_practice]# sudo usermod -aG alice_bob alice
[root@localhost permission_practice]# sudo usermod -aG alice_bob bob
[root@localhost permission_practice]# sudo chgrp alice_bob shared/documents/ && \
> chmod 240 shared/documents/ && \
> ls -l shared/
d-w-r-----. 2 alice alice_bob 68 Jul 21 16:48 documents
```
```
[root@localhost permission_practice]# sudo chgrp developers shared/resources/
[root@localhost permission_practice]# ls -l shared/
drwxr-xr-x. 2 root developers 58 Jul 21 16:48 resources
```
```
[root@localhost permission_practice]# sudo chgrp developers shared/tools/ && \
> chmod 654 shared/tools/ && \
> ls -l shared/
drw-r-xr--. 2 root developers 40 Jul 21 16:48 tools
```

### 2-2. 프로젝트별 협업 권한
- 프로젝트 디렉터리의 권한을 다음과 같이 설정하세요
- company/projects/project_a/ : developers 그룹 구성원들이 협업할 수 있도록 설정
- company/projects/project_b/ : alice와 bob만 접근 가능하도록 설정
```
[root@localhost permission_practice]# sudo chgrp developers company/projects/project_a
[root@localhost permission_practice]# ls -l company/projects/
drwxr-xr-x. 2 root developers 55 Jul 21 16:48 project_a
```
```
[root@localhost permission_practice]# sudo chown alice:bob company/projects/project_b && \
> chmod 770 company/projects/project_b && \
> ls -l company/projects/
drwxrwx---. 2 alice bob        67 Jul 21 22:08 project_b
```
## 📁 3. 고급 권한 설정
### 3-1. 특수 권한 적용
- 다음 파일들에 특수 권한을 설정하세요
- shared/tools/deploy.sh : SetGID 설정으로 developers 그룹 권한으로 실행
- backup/ 디렉터리 : Sticky Bit 설정으로 파일 소유자만 삭제 가능
- company/departments/hr/salaries.txt : SetUID 설정 (실제 환경에서는 권장하지 않지만 실습용)
```
[root@localhost permission_practice]# sudo chgrp developers shared/tools/deploy.sh
[root@localhost permission_practice]# chmod g+s shared/tools/deploy.sh 
[root@localhost permission_practice]# ls -l shared/tools/
-rw-r-Sr--. 1 root developers 37 Jul 21 16:48 deploy.sh
```
```
[root@localhost permission_practice]# chmod +t backup/
[root@localhost permission_practice]# ls -l 
drwxr-xr-t. 5 root root 48 Jul 21 16:48 backup
```
```
[root@localhost permission_practice]# chmod ugo+s company/departments/hr/salaries.txt && \
> ls -l company/departments/hr/
-rwSr-Sr--. 1 root root 25 Jul 21 16:48 salaries.txt
```
### 3-2. 숫자 표기법으로 복합 권한 설정
- 다음 파일들의 권한을 숫자 표기법으로 설정하세요
- company/departments/finance/budget.xlsx : 소유자(rw-), 그룹(r--), 기타(---)
- shared/documents/manual.pdf : 소유자(rw-), 그룹(r--), 기타(r--)
- logs/2024/06/system.log : 소유자(rw-), 그룹(r--), 기타(---)
```
[root@localhost permission_practice]# chmod 640 company/departments/finance/budget.xlsx
[root@localhost permission_practice]# ls -l company/departments/finance/
-rw-r-----. 1 root root 0 Jul 21 16:48 budget.xlsx
```
```
[root@localhost permission_practice]# chmod 644 shared/documents/manual.pdf 
[root@localhost permission_practice]# ls -l shared/documents/
-rw-r--r--. 1 root root 0 Jul 21 16:48 manual.pdf
```
```
[root@localhost permission_practice]# chmod 640 logs/2024/06/system.log 
[root@localhost permission_practice]# ls -l logs/2024/06
-rw-r-----. 1 root root 0 Jul 21 16:48 system.log
```

## 📁 4. 소유권 및 그룹 관리
### 4-1. 소유권 변경
- 다음과 같이 파일과 디렉터리의 소유권을 변경하세요
- company/departments/dev/ 디렉터리와 모든 하위 파일 : alice 소유, developers 그룹
- company/departments/hr/ 디렉터리와 모든 하위 파일 : diana 소유, managers 그룹
- shared/tools/ 디렉터리와 모든 하위 파일 : root 소유, developers 그룹
```
[root@localhost permission_practice]# sudo chown -R alice:developers company/departments/dev/
[root@localhost permission_practice]# ls -la company/departments/dev/
drwxrw-r--. 2 alice developers 123 Jul 21 22:08 .
-rw-r--r--. 1 alice developers  18 Jul 21 22:08 api.conf
------x---. 1 alice developers  32 Jul 21 22:08 build.sh
-rw-r--r--. 1 alice developers   0 Jul 21 22:08 config.py
-rw-r--r--. 1 alice developers  24 Jul 21 22:08 database.conf
-rw-r--r--. 1 alice developers   0 Jul 21 22:08 main.py
-rw-r--r--. 1 alice developers   0 Jul 21 22:08 README.md
-rw-r--r--. 1 alice developers   0 Jul 21 22:08 test.py
```
```
[root@localhost permission_practice]# sudo chown -R diana:managers company/departments/hr/
[root@localhost permission_practice]# ls -la company/departments/hr/
drwxr-xr-x. 2 diana managers 89 Jul 21 22:08 .
-rw-r--r--. 1 diana managers  0 Jul 21 22:08 contracts.pdf
-rw-r--r--. 1 diana managers  0 Jul 21 22:08 employees.xlsx
-rw-r--r--. 1 diana managers  0 Jul 21 22:08 policies.txt
-rw-r-Sr--. 1 diana managers 25 Jul 21 22:08 salaries.txt
```
```
[root@localhost permission_practice]# sudo chown -R root:developers shared/tools/
[root@localhost permission_practice]# ls -la shared/tools/
drw-r-xr--. 2 root developers 40 Jul 21 22:08 .
-rw-r--r--. 1 root developers 33 Jul 21 22:08 backup.sh
-rw-r-Sr--. 1 root developers 37 Jul 21 22:08 deploy.sh
```
### 4-2. 그룹 전용 변경
- 다음 디렉터리들의 그룹만 변경하세요
- company/projects/ : managers 그룹으로 변경
- backup/daily/ : developers 그룹으로 변경
```
[root@localhost permission_practice]# sudo chgrp managers company/projects/ && \
> ls -l company/
drwxr-xr-x. 5 root managers 57 Jul 21 16:48 projects
```
```
[root@localhost permission_practice]# sudo chgrp developers backup/daily/ && \
> ls -l company/
drwxr-xr-x. 2 root developers 60 Jul 21 16:48 daily
```
## 📁 6. umask 및 기본 권한 관리
### 6-1. umask 설정 및 테스트
- 현재 시스템의 umask 값을 확인하고 다음과 같이 변경한 후 테스트하세요 : umask 값을 027로 설정
- 새 파일과 디렉터리를 생성하여 기본 권한 확인
- 원래 umask 값으로 복원
```
[root@localhost permission_practice]# umask
0022
[root@localhost permission_practice]# umask 027
[root@localhost permission_practice]# umask
0027
```
```
[root@localhost ~]# mkdir hello
[root@localhost ~]# touch hi.txt
[root@localhost ~]# ls -l
drwxr-x---. 2 root root   6 Jul 21 18:01 hello
-rw-r-----. 1 root root   0 Jul 21 18:01 hi.txt
```
```
[root@localhost ~]# umask 022
[root@localhost ~]# umask
0022
```
```
[root@localhost ~]# mkdir hellow022
[root@localhost ~]# touch wassup022.txt
[root@localhost ~]# ls -l
drwxr-xr-x. 2 root root   6 Jul 21 18:02 hellow022
-rw-r--r--. 1 root root   0 Jul 21 18:02 wassup022.txt
```
### 6-2. 사용자별 umask 커스터마이징
- 각 사용자별로 다른 umask 값을 설정하세요
- alice: umask 022 (일반적인 개발자 설정)
- diana: umask 077 (보안 강화 설정)
- eve: umask 002 (그룹 협업 친화적 설정)
```
[root@localhost ~]# echo "umask 022" | sudo tee -a /home/alice/.bashrc                   # tee : 입력받은 내용을 화면에 출력하면서 동시에 파일로 저장
umask 022                   # root에서 alice 사용자의 .bashrc에 umask 022 설정 추가 (-a)append
[root@localhost ~]# sudo su - alice                 # alice 사용자로 로그인
[alice@localhost ~]$ umask                  # alice 사용자의 umask 값 확인
0022
```
```
[root@localhost ~]# echo "umask 077" | sudo tee -a /home/diana/.bashrc                   # tee : 입력받은 내용을 화면에 출력하면서 동시에 파일로 저장
umask 077                   # root에서 diana 사용자의 ./bashrc에 umask 077 설정 추가 (-a)append
[root@localhost ~]# sudo su - diana                  # diana 사용자로 로그인
[diana@localhost ~]$ umask                  # diana 사용자의 umask 값 확인
0077
```
```
[root@localhost ~]# echo "umask 002" | sudo tee -a /home/eve/.bashrc
umask 002
[root@localhost ~]# sudo su - eve
[eve@localhost ~]$ umask
0002
```
## 📁 8. 실행 권한 및 스크립트 관리
### 8-1. 스크립트 실행 환경 설정
- 다음 스크립트 파일들의 실행 권한을 적절히 설정하세요
- shared/tools/deploy.sh : developers 그룹만 실행 가능
- shared/tools/backup.sh : alice와 diana만 실행 가능 (ACL 사용)
- company/departments/dev/build.sh : 소유자만 실행 가능
```
[root@localhost permission_practice]# chmod 654 shared/tools/deploy.sh
[root@localhost permission_practice]# ls -l shared/tools/
-rw-r-xr--. 1 root developers 37 Jul 21 16:48 deploy.sh
```
```
[root@localhost permission_practice]# sudo chown alice:diana shared/tools/backup.sh 
[root@localhost permission_practice]# chmod 654 shared/tools/backup.sh 
[root@localhost permission_practice]# ls -l shared/tools/
-rw-r-xr--. 1 alice diana      33 Jul 21 16:48 backup.sh
```
```
[root@localhost permission_practice]# chmod 700 company/departments/dev/build.sh 
[root@localhost permission_practice]# ls -l company/departments/dev/
-rwx------. 1 alice  developers 32 Jul 21 16:48 build.sh
```
### 8-2. 시스템 스크립트 보안 설정
- 시스템 관리용 스크립트를 다음과 같이 설정하세요
- root 소유의 시스템 관리 스크립트 생성 (system_check.sh)
- 일반 사용자가 sudo 없이 실행할 수 있도록 SetUID 설정
- 실행 로그를 남기도록 권한 설정
```
[root@localhost permission_practice]# nano system_check.sh
# nano
date >> ./system_check.log
uptime >> ./system_check.log
df -h >> ./system_check.log
```
```
[root@localhost permission_practice]# chmod o+s system_check.sh         # SETUID 권한 부여
[root@localhost permission_practice]# ls -l
-rwxr-xr-t. 1 root root  1 Jul 21 23:04 system_check.sh
```
```
[root@localhost permission_practice]# ./system_check.sh                 # system_check.sh 실행
[root@localhost permission_practice]# ls -l
-rw-r--r--. 1 root root 900 Jul 21 23:12 system_check.log               # 실행 후 생긴 system_check.log
```
```
[root@localhost permission_practice]# cat system_check.log              # system_check.log 내용 출력
Mon Jul 21 11:10:16 PM KST 2025
 23:10:16 up  1:03,  2 users,  load average: 0.00, 0.02, 0.00
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                870M     0  870M   0% /dev/shm
tmpfs                348M  9.4M  339M   3% /run
/dev/mapper/rl-root   17G  5.6G   12G  33% /
/dev/nvme0n1p1       960M  366M  595M  39% /boot
tmpfs                174M  124K  174M   1% /run/user/1000
---
```
## 📁 9. 디렉터리별 접근 제어
### 9-1. 계층적 접근 제어
- 다음과 같은 계층적 접근 권한을 설정하세요
- company/ : 모든 직원이 읽기 가능
- company/departments/ : 각 부서원만 해당 부서 디렉터리 접근 가능
- company/departments/finance/ : managers 그룹만 접근 가능
- company/projects/ : 프로젝트 참여자만 해당 프로젝트 접근 가능
```
[root@localhost permission_practice]# chmod 744 company/ && \
> ls -l ./
drwxr--r--. 4 root root 41 Jul 21 16:48 company
```
```
[root@localhost permission_practice]# sudo groupadd finance
[root@localhost permission_practice]# sudo groupadd marketing
[root@localhost permission_practice]# sudo chgrp finance company/departments/finance/
[root@localhost permission_practice]# sudo chgrp marketing company/departments/marketing/
[root@localhost permission_practice]# chmod 770 company/departments/dev/
[root@localhost permission_practice]# chmod 770 company/departments/finance/
[root@localhost permission_practice]# chmod 770 company/departments/hr/
[root@localhost permission_practice]# chmod 770 company/departments/marketing/
[root@localhost permission_practice]# ls -l company/departments/
drwxrwx---. 2 alice developers 123 Jul 21 22:08 dev
drwxrwx---. 2 root  finance     64 Jul 21 22:08 finance
drwxrwx---. 2 diana managers    89 Jul 21 22:08 hr
drwxrwx---. 2 root  marketing    6 Jul 21 22:08 marketing
```
```
[root@localhost permission_practice]# chmod 070 company/departments/finance/
[root@localhost permission_practice]# ls -l company/departments/
d---rwx---. 2 root  managers    64 Jul 21 16:48 finance
```
```
[root@localhost permission_practice]# sudo chown alice:developers company/projects/
[root@localhost permission_practice]# chmod 070 company/projects/
[root@localhost permission_practice]# ls -l company/
d---rwx---. 5 alice developers 57 Jul 21 22:08 projects
```
### 9-2. 임시 작업 공간 설정
- 임시 작업을 위한 공간을 다음과 같이 설정하세요
- temp/ 디렉터리 생성 (모든 사용자가 파일 생성 가능)
- Sticky Bit 설정으로 자신의 파일만 삭제 가능
- 1주일 후 자동 삭제되도록 권한 설정 (cron 작업용)
```
[root@localhost permission_practice]# mkdir temp/
[root@localhost permission_practice]# chmod 1777 temp/
[root@localhost permission_practice]# ls -l
drwxrwxrwt. 2 root root    6 Jul 21 23:27 temp
```
```
[root@localhost permission_practice]# sudo crontab -e
# vi
# 0 > "0분에" | 3 > "오전3시에" | * > "매일" | * > "매주" | * > "매월"
# /tmp/temp > "이 디렉토리 아래에서 검색" | -type f > "파일만 찾음" | -mtime +7 > "마지막 수정일이 7일 이상 지난 파일" | -exec rm -f {} \; > "찾은 파일을 rm -f로 강제 삭제 ({}는 해당 파일 이름)
0 3 * * * find /tmp/temp -type f -mtime +7 -exec rm -f {} \;
# 작성 후 나가는 법
ESC > :wq > ENTER
```
## 📁 10. 백업 및 아카이브 권한 관리
### 10-1. 백업 파일 보안
- 백업 관련 파일들의 보안을 다음과 같이 설정하세요
- backup/daily/ : developers 그룹이 백업 생성 가능, 읽기 전용
- backup/weekly/ : managers만 접근 가능
- backup/monthly/ : root만 접근 가능
모든 백업 파일은 생성 후 읽기 전용으로 자동 변경
```
[root@localhost permission_practice]# chmod 464 backup/daily/
[root@localhost permission_practice]# ls -l backup/
dr--rw-r--. 2 root developers 60 Jul 21 22:08 daily
```
```
[root@localhost permission_practice]# sudo chgrp managers backup/weekly/
[root@localhost permission_practice]# chmod 070 backup/weekly/
[root@localhost permission_practice]# ls -l backup/
d---rwx---. 2 root managers    6 Jul 21 22:08 weekly
```
```
[root@localhost permission_practice]# chmod 700 backup/monthly/
[root@localhost permission_practice]# ls -l backup/
drwx------. 2 root root        6 Jul 21 22:08 monthly
```
