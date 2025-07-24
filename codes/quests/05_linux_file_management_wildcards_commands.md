# 📁 Linux 파일 관리 명령어 와일드카드 실습 문제
## 실습 환경 설정

- 실습 디렉터리 생성
```
mkdir wildcard_file_practice && \
cd wildcard_file_practice
```

- 테스트 파일들 생성
```
touch report{1,2,3}.txt && \
touch data{1,2,3}.csv data_old.csv && \
touch image{1,2,3}.jpg photo.gif && \
touch backup{2023,2024}.tar config.conf && \
touch log_{error,access,system}.txt && \
touch temp{1,2,3}.tmp && \
touch file{001,002,010}.dat && \
touch scrpit{1,2}.sh test_script.sh && \
touch document.pdf presentation.ppt spreadsheet.xls && \
touch {readme,change}.md license.txt && \
touch {old,new,final}_report.txt && \
ls -l
```
- 기본 디렉터리들 생성
```
mkdir archives backup logs images documents scripts
```
## 📁 1. mkdir 명령어 와일드카드 실습
### 1-1. 연도별 백업 디렉터리 생성
-  2020년부터 2024년까지 백업 디렉터리를 한 번에 생성하세요
-  예: backup_2020, backup_2021, backup_2022, backup_2023, backup_2024

```
[parksejin@localhost wildcard_file_practice]$ mkdir backup_{2020..2024} && \
> ls -l
```
### 1-2. 월별 로그 디렉터리 생성
-  logs 디렉터리 안에 01월부터 12월까지 디렉터리 생성
- 예: logs/log_01, logs/log_02, ..., logs/log_12
```
[parksejin@localhost wildcard_file_practice]$ mkdir -p logs/ && \
> mkdir logs/log_{01..12} && \
> ls -l logs/
```
### 1-3. 프로젝트별 디렉터리 생성
- project_A, project_B, project_C 디렉터리를 한 번에 생성하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir project_{A..C} && \
> ls -l
```
### 1-4. 계층적 디렉터리 생성
- data/2024/{01,02,03} 구조로 디렉터리를 생성하세요
- (data 디렉터리 안에 2024 디렉터리, 그 안에 01, 02, 03 디렉터리)
```
[parksejin@localhost wildcard_file_practice]$ mkdir -p data/2024/{01..03} && \
> ls -l data/2024/
```
## 📁 2. cp 명령어 와일드카드 실습
### 2-1. 확장자별 파일 복사
- 모든 .txt 파일을 backup 디렉터리로 복사하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir backup && \
> cp *.txt ./backup/ && \
> ls -l backup/
```
### 2-2. 특정 패턴 파일 복사
- "report"로 시작하는 모든 파일을 documents 디렉터리로 복사하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir documents && \
> cp report* ./documents && \
> ls -l documents/
```
### 2-3. 숫자가 포함된 파일 복사
- 파일명에 숫자가 포함된 모든 이미지 파일(.jpg, .png)을 images 디렉터리로 복사하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir images/ && \
> cp *{0-9}*.{jpg,png} ./images && \
> ls -l images
```
### 2-4. 특정 범위의 파일 복사
- data1.csv, data2.csv, data3.csv 파일만 backup 디렉터리로 복사하세요
```
[parksejin@localhost wildcard_file_practice]$ cp data{1..3}.csv ./backup && \
> ls -l backup/
```
### 2-5. 복합 조건 파일 복사
- "log_"로 시작하는 .txt 파일들을 logs 디렉터리로 복사하세요
```
[parksejin@localhost wildcard_file_practice]$ cp log_*.txt logs/ && \
> ls -l logs/
```
## 📁 3. mv 명령어 와일드카드 실습
### 3-1. 임시 파일 이동
- 모든 .tmp 파일을 temp 디렉터리로 이동하세요 (mkdir temp 먼저 실행)
```
[parksejin@localhost wildcard_file_practice]$ mkdir temp/ && \
> mv *.tmp ./temp/ && \
> ls -l temp/
```
### 3-2. 백업 파일 정리
- "backup_"로 시작하는 모든 파일을 archives 디렉터리로 이동하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir archives && \
> mv backup_* ./archives && \
> ls -l archives
```
### 3-3. 스크립트 파일 정리
- 모든 .sh 파일을 scripts 디렉터리로 이동하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir scripts && \
> mv *.sh ./scripts && \
> ls -l scripts/
```
### 3-4. 특정 패턴 파일 이동
- "file_"로 시작하고 3자리 숫자가 포함된 .dat 파일들을 data 디렉터리로 이동하세요
- (data 디렉터리가 없다면 먼저 생성)
```
[parksejin@localhost wildcard_file_practice]$ mv file[0-9][0-9][0-9].dat ./data && \
> ls -l data/
```
### 3-5. 조건부 파일 이동
- "old_" 또는 "new_"로 시작하는 모든 파일을 archives 디렉터리로 이동하세요
```
[parksejin@localhost wildcard_file_practice]$ mv {old,new}_* archives/ && \
> ls -l archives/
```
## 📁 4. rm 명령어 와일드카드 실습
### 4-1. 임시 파일 삭제
- 모든 .tmp 파일을 삭제하세요 (주의 : 실제로는 신중히 실행)
```
[parksejin@localhost wildcard_file_practice]$ rm -r ./temp/*.tmp && \
> ls -l temp/
```
### 4-2. 특정 패턴 파일 삭제
- "temp"로 시작하는 모든 파일을 삭제하세요
```
[parksejin@localhost wildcard_file_practice]$ rm -r temp* && \
> ls -l
```
### 4-3. 백업 파일 정리
- 2023년 백업 파일만 삭제하세요 (backup_2023.tar)
```
[parksejin@localhost wildcard_file_practice]$ rm -r  archives/backup_2023.tar/ && \
> ls -l archives/
```
### 4-4. 조건부 파일 삭제
- 확장자가 3글자가 아닌 파일들을 삭제하세요
- 힌트: 확장자가 .jpg, .png, .gif, .txt, .csv, .tar, .dat, .pdf, .ppt, .xls가 아닌 파일
```
[parksejin@localhost wildcard_file_practice]$ rm -r !(*.???) && \
> ls -l
```
## 📁 5. 복합 명령어 실습
### 5-1. 파일 정리 시스템
- 1단계: 모든 이미지 파일(.jpg, .png, .gif)을 images 디렉터리로 이동
```
[parksejin@localhost wildcard_file_practice]$ mkdir images && \
> mv *.{jpg,png,gif} ./images && \
> ls -l images/
```
- 2단계: 모든 문서 파일(.pdf, .ppt, .xls, .md)을 documents 디렉터리로 이동
```
[parksejin@localhost wildcard_file_practice]$ mkdir documents && \
> mv *.{pdf,ppt,xls,md} ./documents && \
> ls -l documents/
```
- 3단계: 모든 데이터 파일(.csv, .dat)을 data 디렉터리로 이동 (없으면 생성)
```
[parksejin@localhost wildcard_file_practice]$ mkdir data && \
> mv *.{csv,dat} ./data/ && \
> ls -l data/
```
### 5-2. 백업 및 정리 작업
- 1단계: 모든 .txt 파일을 backup/txt_files 디렉터리로 복사 (디렉터리 생성 필요)
```
[parksejin@localhost wildcard_file_practice]$ mkdir -p backup/txt_files && \
> cp *.txt ./backup/txt_files/ && \
> ls -l ./backup/txt_files/
```
### 5-3. 날짜별 로그 정리
- 1단계: logs 디렉터리에 error, access, system 하위 디렉터리 생성
```
[parksejin@localhost wildcard_file_practice]$ mkdir -p logs/{error,access,system} && \
> ls -l && \
> ls -l logs/
```
- 2단계: log_error.txt를 logs/error/로 이동

- 3단계: log_access.txt를 logs/access/로 이동

- 4단계: log_system.txt를 logs/system/로 이동
```
[parksejin@localhost wildcard_file_practice]$ mv log_error.txt ./logs/error/ && \
> mv log_access.txt logs/access/ && \
> mv log_system.txt logs/system/ && \
> ls -l ./logs/error && \
> ls -l ./logs/access && \
> ls -l ./logs/system
```
## 📁6. 고급 와일드카드 실습
### 6-1. 복잡한 패턴 매칭
- "report" 또는 "data"로 시작하고 숫자가 포함된 모든 파일을 찾아서 processed 디렉터리로 복사하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir processed && \
> mv {report,data}*[0-9]* ./processed && \
> ls -l processed
```
### 6-2. 제외 패턴 활용
- 모든 파일 중에서 "final_"로 시작하지 않는 .txt 파일들을 draft 디렉터리로 이동하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir draft && \
> mv !(final_*).txt draft/ && \
> ls -l draft/
```
### 6-3. 범위 지정 패턴
- 파일명에 001부터 009까지의 숫자가 포함된 파일들을 single_digit 디렉터리로 복사하세요
```
[parksejin@localhost wildcard_file_practice]$ mkdir single_digit/ && \
> mv *[000..009]* single_digit/ && \
> ls -l
```
## 📁 7. 실전 시나리오 문제
### 7-1. 프로젝트 정리 시나리오
- 시나리오 : 프로젝트 종료 후 파일 정리

- 완료된 리포트 파일들(report*.txt)을 completed 디렉터리로 이동
```
[parksejin@localhost wildcard_file_practice]$ mkdir completed && \
> mv ./processed/report{1..3}.txt completed/ && \
> mv ./backup/txt_files/report{1..3}.txt completed/ && \
> ls -l completed/
```
- 백업 파일들(backup_*)을 archive 디렉터리로 이동
```
[parksejin@localhost wildcard_file_practice]$ mkdir archive && \
> mv backup* ./archive && \
> ls -l archive
```
- 불필요한 임시 파일들(*.tmp)을 삭제
```
[parksejin@localhost wildcard_file_practice]$ rm -r *.tmp
```
### 7-2. 로그 관리 시나리오
- 시나리오: 서버 로그 정리

- 2024년 로그 파일들을 logs/2024 디렉터리로 이동

- 에러 로그들을 logs/errors 디렉터리로 복사

- 2023년 로그 파일들을 삭제

- 시스템 로그들을 logs/system 디렉터리로 이동

### 7-3. 개발 환경 정리 시나리오
- 시나리오: 개발 프로젝트 구조 정리

- 모든 스크립트 파일(*.sh)을 scripts 디렉터리로 이동

- 설정 파일들(*.conf, *.config)을 config 디렉터리로 복사

- 문서 파일들(*.md, *.txt)을 docs 디렉터리로 이동

- 데이터 파일들(*.csv, *.dat)을 data 디렉터리로 이동

## 📁 8. 보너스 문제
### 8-1. 한 줄 명령어 도전
- 모든 이미지 파일을 images 디렉터리로 이동하고, 모든 문서 파일을 docs 디렉터리로 이동하는 작업을 
한 줄의 명령어로 실행하세요 (세미콜론 또는 && 사용)

### 8-2. 조건부 실행
- images 디렉터리가 존재하면 모든 .jpg 파일을 이동하고, 존재하지 않으면 디렉터리를 생성한 후 이동하는 명령어를 작성하세요

### 8-3. 파일 개수 확인 후 실행
- .txt 파일이 5개 이상 있으면 backup 디렉터리로 복사하고, 그렇지 않으면 "파일이 부족합니다" 메시지를 출력하세요

## 📁 9. 검증 명령어
- 각 문제를 해결한 후 다음 명령어들로 결과를 확인하세요

### 디렉터리 구조 확인
```
ls -la
```
### 특정 디렉터리 내용 확인
```
ls -la backup/

ls -la images/

ls -la documents/
```
### 파일 개수 확인
```
ls *.txt | wc -l

ls *.jpg | wc -l
```
#### 전체 파일 목록 확인
```
find . -type f | sort
```

## 📁 10. 주의사항
### ⚠️ 실습 시 주의사항
- rm 명령어 사용 시 특히 주의하세요
- 중요한 파일은 미리 백업하세요
- 와일드카드 패턴이 의도한 파일들만 선택하는지 먼저 ls 명령어로 확인하세요
- 실제 서버에서는 더욱 신중히 실행하세요
## 실제 명령 실행 전에 패턴이 올바른지 확인
```
echo cp *.txt backup/    # 실제로는 실행되지 않고 명령어만 출력

ls *.txt                 # 선택될 파일들 미리 확인
```
## 힌트
- `{}` 중괄호 확장 활용 : mkdir {dir1,dir2,dir3}
- `[]` 문자 범위 활용 : [1-3], [a-z]
- `* `와일드카드 활용 : file*, *.txt
- `?` 단일 문자 활용 : file?.txt
- 복합 패턴 활용 : *[0-9]*, file[1-3].txt
- 디렉터리 생성 시 -p 옵션 활용 : mkdir -p path/to/directory

## 🚀 해결방안
### 6-2. 제외 패턴 활용
- 모든 파일 중에서 "final_"로 시작하지 않는 .txt 파일들을 draft 디렉터리로 이동하세요
```
# 처음시도 
mv !{final_*}.txt draft/
# 그러나 {}안에 final_을 넣을 경우 f,i,n,a,l,_ 이 되어 f,i,n,a,l,_ 들어간 모든 문자를 출력하지 않게 된다
```
### 🚀 Solution
```
[parksejin@localhost wildcard_file_practice]$ mkdir draft && \
> mv !(final_*).txt draft/ && \
> ls -l draft/
```
### 4-4. 조건부 파일 삭제
- 확장자가 3글자가 아닌 파일들을 삭제하세요
- 힌트: 확장자가 .jpg, .png, .gif, .txt, .csv, .tar, .dat, .pdf, .ppt, .xls가 아닌 파일
```
# 부정문을 쓸 때 (), {} 밖에 !를 써야됨
```
### 🚀 Solution
```
[parksejin@localhost wildcard_file_practice]$ rm -r !(*.???) && \
> ls -l
```