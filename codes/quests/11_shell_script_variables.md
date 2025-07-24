# 🧪 실습 문제 외부 인자를 사용한 파일 생성 스크립트
## 📘 문제 설명
- 쉘 스크립트를 작성하세요
- 이 스크립트는 외부 인자 2개를 받아 다음과 같이 동작해야 합니다
- 첫 번째 인자 : 생성할 파일 이름 (예 : result.txt)
- 두 번째 인자 : 파일에 저장할 문자열 내용

### 스크립트 실행 시
- 파일이 현재 디렉터리에 생성되어야 하며, 파일 내부에 두 번째 인자의 문자열이 저장되어야 합니다
- 파일 생성 성공 메시지를 출력해야 합니다

### 📄 파일명 예시
```
create_file.sh
```
### ✍️ 수강생이 작성해야 할 동작 흐름
- 인자 개수 확인 (2개 아닐 시 오류 메시지 출력)
- 변수에 인자 할당
- 파일 생성 및 내용 기록
- 완료 메시지 출력
### ✅ 실행 예제
```
$ ./create_file.sh welcome.txt "Hello Linux Learners!"
```
### 📂 결과
```
현재 디렉토리에 welcome.txt 파일이 생성됨
welcome.txt 파일 내용
Hello Linux Learners!

터미널 출력
[✔] welcome.txt 파일이 성공적으로 생성되었습니다
```

### 💡 힌트
- $1, $2를 사용하여 외부 인자를 받을 수 있습니다

### 📂 실행 결과
```
[parksejin@localhost Downloads]$ nano create_file.sh
```
```
# nano
make_text="$1"
input_variable="$2"

touch "$make_text"
echo "$input_variable" > "$make_text"
echo "$make_text is created Completed!"
```
```
[parksejin@localhost Downloads]$ source 80_1_shell_variables_aguments.sh welcome.txt "Hello Linux Learners"
welcome.txt is created Completed!
[parksejin@localhost Downloads]$ cat welcome.txt 
Hello Linux Learners
[parksejin@localhost Downloads]$ ls
80_1_shell_variables_aguments.sh  welcome.txt
```
