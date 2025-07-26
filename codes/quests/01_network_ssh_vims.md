# 🧪 vim 편집 실습 문제 (난이도 순으로 정렬, CRUD Mode 한정)
## 💻 실습 목표
- vim 편집기를 활용하여 텍스트 파일에서 Create / Read / Update / Delete 작업을 정확하게 수행

## 📁 실습 사전 환경 준비 (모든 컴퓨터 공통)
```bash
#!/bin/bash
mkdir -p ~/vim_crud_practice/{comp1,comp2,comp3}
cd ~/vim_crud_practice/comp1
echo -e "Apple\nBanana\nCherry" > fruits.txt

cd ../comp2
echo -e "1. Clean the house\n2. Buy groceries\n3. Call Mom" > todo.txt

cd ../comp3
echo -e "Name,Email\nJohn Doe,john@example.com\nJane Doe,jane@example.com" > users.csv

chmod +x setup_env.sh && ./setup_env.sh
```
## 🧭 실습 시나리오
- 각 실습은 서로 다른 SSH 대상에서 수행
```bash
ssh user@192.168.0.101  # 컴퓨터1 (comp1 디렉토리 실습)
ssh user@192.168.0.102  # 컴퓨터2 (comp2 디렉토리 실습)
ssh user@192.168.0.103  # 컴퓨터3 (comp3 디렉토리 실습)
```
## 🔧 실습 문제 (난이도 순)

## 🔹 실습 1. (기초 : Read & Search) – comp2/todo.txt
### 🔧 목표 : 복사, 붙여넣기 숙달
- 작업 경로 : ~/vim_crud_practice/comp2/todo.txt
- vim으로 파일 열기
- Buy groceries 줄을 복사한 뒤, 맨 아래에 두 번 붙여넣기
- 저장 후 종료
```bash
[parksejin@192.168.0.50 ~]$ ssh kangbeenlee@192.168.0.53
kangbeenlee@192.168.0.53 `s password : qwer1234
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Thu Jul 24 15:30:20 2025 from 192.168.0.3
```
```bash
[kangbeenlee@192.168.0.53 ~/vim_crud_practice/comp2]$ cat todo.txt
1. Clean the house
2. Buy groceries
3. Call Mom

2. Buy groceries
2. Buy groceries
```

#### ✅ 명령어 힌트 : /검색, yy, p, :wq

## 🔹 실습 2. (기초+ : Create & Append) – comp1/fruits.txt
### 🔧 목표 : 입력 모드와 줄 추가 숙련
- 작업 경로 : ~/vim_crud_practice/comp1/fruits.txt
- 마지막 줄 아래에 다음 과일 추가
- 저장 후 종료
```
Durian  
Elderberry
```
```bash
[parksejin@192.168.0.50 ~]$ ssh guinjung@192.168.0.59
guinjung@192.168.0.59`s password: 
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Thu Jul 24 15:27:16 2025 from 192.168.0.41
[guinjung@192.168.0.59 ~]$ 
```
```bash
[guinjung@192.168.0.59 ~/vim_crud_practice/comp1]$ cat fruits.txt 
Apple
Banana
Cherry
Durian
Elderberry
```
#### ✅ 명령어 힌트: G, o, i, ESC, :wq
## 🔹 실습 3. (중간 : Update + 반복 붙여넣기) – comp3/users.csv
### 🔧 목표 : 문자열 수정, 줄 삽입 반복
- 작업 경로 : ~/vim_crud_practice/comp3/users.csv
- john@example.com → john.doe@gmail.com으로 수정
- 수정한 라인을 복사한 후 아래 줄에 3번 반복 붙여넣기
- 저장 후 종료
```bash
[parksejin@192.168.0.50 ~]$ ssh ohjimin@192.168.0.4
ohjimin@192.168.0.4`s password: 
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Thu Jul 24 15:26:59 2025 from 192.168.0.3
```
```bash
[ohjimin@192.168.12.129 ~/vim_crud_practice/comp3]$ cat users.csv 
Name,Email
John Doe,john.doe@gmail.com
Jane Doe,jane@example.com


John Doe,john.doe@gmail.com
John Doe,john.doe@gmail.com
John Doe,john.doe@gmail.com
```

#### ✅ 명령어 힌트 : :%s///, yy, p, :wq

## 🔹 실습 4. (중상 : Delete & Navigation) – comp1/fruits.txt
### 🔧 목표 : 줄 삭제 후 조작
- 작업 경로 : ~/vim_crud_practice/comp1/fruits.txt
- Cherry 해당 줄을 삭제
- 저장 후 종료
```bash
[parksejin@192.168.0.50 ~]$ ssh im@192.168.0.31
im@192.168.0.31`s password: 
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Thu Jul 24 15:45:16 2025 from 192.168.0.53
```
```bash
[im@192.168.0.31 ~/vim_crud_practice/comp1]$ vi fruits.txt 
[im@192.168.0.31 ~/vim_crud_practice/comp1]$ cat fruits.txt 
Apple
Banana
```
#### ✅ 명령어 힌트 : /Cherry, dd, :wq
## 🔹 실습 5. (심화 : 다중 치환 + 복구) – comp3/users.csv
### 🔧 목표 : 반복 치환, 삭제 복구
- 작업 경로 : ~/vim_crud_practice/comp3/users.csv
- 모든 Doe → Smith로 전체 치환
- 실수로 한 줄을 삭제한 뒤, 삭제된 줄 복구
- 저장 후 종료
```bash
[parksejin@192.168.0.50 ~]$ ssh shinbeomjun@192.168.0.34
shinbeomjun@192.168.0.34`s password: 
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Thu Jul 24 15:38:08 2025 from 192.168.0.46
범준바보
```
```bash
[shinbeomjun@192.168.0.34 ~/vim_crud_practice/comp3]$ vi users.csv 
[shinbeomjun@192.168.0.34 ~/vim_crud_practice/comp3]$ cat users.csv 
Name,Email
John Smith,john@example.com
Jane Smith,jane@example.com
```
#### ✅ 명령어 힌트 : :%s/Doe/Smith/g, u, :wq
## 🎓 선택 학습 질문 (보조 학습)
- vim에서 실수로 삭제한 줄을 복구하려면?
```
 → u (undo), U (줄 단위 undo), Ctrl+r (redo)
```
- 여러 줄을 복사하고 여러 위치에 붙여넣으려면?
```
 → V (비쥬얼 모드로 여러 줄 선택) → y → 원하는 위치로 이동 후 p
```
- vim에서 반복 치환 명령은?
```
 → :%s/기존문자열/변경문자열/g
```
## 📎 복습 명령어 요약
```
i, o
입력 모드 진입 / 아래 줄 입력
ESC
명령 모드 전환
:w, :q, :wq, :q!
저장 / 종료 / 강제 종료
dd, yy, p
줄 삭제 / 복사 / 붙여넣기
/문자열
검색
:%s/a/b/g
전체 치환
u, Ctrl+r
undo / redo
```