PS C:\Users\Administrator> cd C:\
PS C:\> cd C:\Develops
PS C:\Develops> pwd

Path
----
C:\Develops

#mkdir을 이용하여 temp_dir 생성
PS C:\Develops> mkdir temp_dir


    디렉터리: C:\Develops


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-15   오후 1:59                temp_dir


PS C:\Develops> ls


    디렉터리: C:\Develops


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-14  오전 11:59                Downloads
d-----      2025-07-15   오후 1:59                temp_dir
d-----      2025-07-15  오전 10:00                VMs

#mkdir을 이용하여 first_dir 생성
PS C:\Develops> mkdir first_dir
PS C:\Develops\temp_dir> ls


    디렉터리: C:\Develops\temp_dir


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-15   오후 2:21                first_dir\
-a----      2025-07-15   오후 2:24             17 first_file.txt

#rm을 이용하여 first_dir 삭제
PS C:\Develops\temp_dir> rm first_dir
PS C:\Develops\temp_dir> ls


    디렉터리: C:\Develops\temp_dir


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 2:24             17 first_file.txt

#mv를 이용하여 first_dir, first_file.txt Develops로 이동
PS C:\Develops> cd temp_dir
PS C:\Develops\temp_dir> ls


    디렉터리: C:\Develops\temp_dir


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-15   오후 2:38                first_dir
-a----      2025-07-15   오후 2:42              0 first_file.txt


PS C:\Develops\temp_dir> mv first_dir C:\Develops
PS C:\Develops\temp_dir> ls


    디렉터리: C:\Develops\temp_dir


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 2:42              0 first_file.txt


PS C:\Develops\temp_dir> mv first_file.txt C:\Develops
PS C:\Develops\temp_dir> ls
PS C:\Develops\temp_dir> cd C:\Develops
PS C:\Develops> ls


    디렉터리: C:\Develops


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-14  오전 11:59                Downloads
d-----      2025-07-15   오후 2:38                first_dir
d-----      2025-07-15   오후 2:49                temp_dir
d-----      2025-07-15   오후 2:00                temp_dir_graphic
d-----      2025-07-15  오전 10:00                VMs
-a----      2025-07-15   오후 2:42              0 first_file.txt