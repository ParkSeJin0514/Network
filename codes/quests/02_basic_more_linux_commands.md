## 📁 연습문제 1. 기본 파일 시스템 탐색
### 1-1. 현재 위치 확인 및 이동
- 현재 작업 디렉터리의 절대 경로를 출력하시오
```
[parksejin@localhost quests]$ pwd
```
- 홈 디렉터리로 이동하시오
```
[parksejin@localhost ~]$ cd ~
```
- 루트 디렉터리(/)로 이동하시오
```
[parksejin@localhost ~]$ cd /
```
- 다시 홈 디렉터리로 돌아가시오
```
[parksejin@localhost /]$ cd ~
```
### 1-2. 디렉터리 내용 확인
- 현재 디렉터리의 파일과 폴더 목록을 출력하시오
```
[parksejin@localhost home]$ ls
```
- 숨김 파일을 포함한 모든 파일의 상세 정보를 출력하시오
```
[parksejin@localhost home]$ ls -a
```
- /etc 디렉터리의 내용을 확인하시오
```
[parksejin@localhost etc]$ ls
```
## 📁 연습문제 2. 디렉터리 및 파일 생성
### 2-1. 디렉터리 구조 생성
- 다음과 같은 디렉터리 구조를 생성하시오

practice/
```
[parksejin@localhost quests]$ mkdir practice
```
├── documents/
```
[parksejin@localhost practice]$ mkdir documents
```
│   ├── reports/ls
```
[parksejin@localhost documents]$ mkdir reports
[parksejin@localhost documents]$ cd reports
[parksejin@localhost reports]$ mkdir ls
```
│   └── notes/
```
[parksejin@localhost documents]$ mkdir notes
```
├── images/
```
[parksejin@localhost practice]$ mkdir images
```
└── backup/
```
[parksejin@localhost practice]$ mkdir backup
```
### 2-2. 파일 생성 및 내용 작성
- practice/documents/ 디렉터리에 readme.txt 파일을 생성하고 "Hello Linux!"라는 내용을 작성하시오
```
[parksejin@localhost documents]$ echo "Hello Linux!" > readme.txt
```
- documents/notes/ 디렉터리에 memo.txt 파일을 생성하고 "Linux 명령어 연습 중"이라는 내용을 작성하시오
```
[parksejin@localhost notes]$ echo "Practice Linux" > memo.txt
```
## 📁 연습문제 3. 파일 내용 확인 및 조작
### 3-1. 파일 내용 출력
- 앞서 생성한 readme.txt 파일의 내용을 출력하시오
```
[parksejin@localhost documents]$ cat readme.txt
```
- memo.txt 파일의 내용을 출력하시오
```
[parksejin@localhost documents]$ cat notes/memo.txt
```
### 3-2. 파일 복사
- readme.txt 파일을 backup/ 디렉터리에 복사하시오
```
[parksejin@localhost practice]$ cp documents/readme.txt documents/backup
```
- documents/ 디렉터리 전체를 backup/ 디렉터리에 복사하시오
```
[parksejin@localhost practice]$ cp -r documents backup
```
## 📁 연습문제 4. 파일 이동 및 이름 변경
### 4-1. 파일 이동
- memo.txt 파일을 documents/ 디렉터리로 이동하시오
```
[parksejin@localhost practice]$ mv documents/notes/memo.txt documents
```
- images/ 디렉터리를 practice/media/로 이름을 변경하시오
```
[parksejin@localhost practice]$ mv images media
```
### 4-2. 파일 이름 변경
- readme.txt를 introduction.txt로 이름을 변경하시오
```
[parksejin@localhost practice]$ mv documents/readme.txt introduction.txt
```
- memo.txt를 study_notes.txt로 이름을 변경하시오
```
[parksejin@localhost practice]$ mv memo.txt study_notes.txt
```
## 📁 연습문제 5. 종합 실습
### 5-1. 프로젝트 디렉터리 생성
- 다음 요구사항에 따라 프로젝트 디렉터리를 생성하시오
- my_project/라는 최상위 디렉터리 생성
```
[parksejin@localhost practice]$ mkdir my_project
```
- 하위에 src/, docs/, tests/, config/ 디렉터리 생성
```
[parksejin@localhost my_project]$ mkdir src docs tests config
```
- src/ 디렉터리에 main.py 파일 생성
- (내용: "# Main Python File")
```
[parksejin@localhost my_project]$ echo "# Main Python File" > src/main.py
```
- docs/ 디렉터리에 README.md 파일 생성 (내용: "# My Project Documentation")
```
[parksejin@localhost my_project]$ echo "# My Project Documentation" > ./docs/README.md
```
- config/ 디렉터리에 settings.conf 파일 생성 (내용: "# Configuration File")
```
[parksejin@localhost my_project]$ echo "# Configuration File" > ./config/settings.conf
```
### 5-2. 백업 및 정리
- 전체 my_project/ 디렉터리를 my_project_backup/으로 복사하시오
```
[parksejin@localhost quests]$ cp -r  my_project my_project_backup
```
- my_project/src/main.py 파일을 my_project/src/app.py로 이름을 변경하시오
```
[parksejin@localhost quests]$ mv my_project/src/main.py my_project/src/app.py
```
- my_project/docs/README.md 파일을 my_project/ 디렉터리로 이동하시오
```
[parksejin@localhost quests]$ mv my_project/docs/README.md my_project
```