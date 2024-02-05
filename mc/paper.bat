@echo off

set "paperFolder=C:\Users\%USERNAME%\OneDrive\Documents\Paper"
set "javaCommand=java -Xmx4G -Xms1G -jar %paperFolder%\paper.jar"

rem 1. Check if the folder exists
if not exist "%paperFolder%" (
    echo Creating folder: %paperFolder%
    mkdir "%paperFolder%"
) else (
    goto start
)

:start
rem 2. Check if the file *paper*.jar exists
if not exist "%paperFolder%\paper*.jar" (
    echo Error: paper.jar not found in %paperFolder%
    echo.
    echo Please download the paper.jar file then continue
    start https://papermc.io/downloads/paper
    pause
    move "C:\Users\%USERNAME%\Downloads\paper*.jar" "%paperFolder%"
    goto start
)

rem 2.2 Move the downloaded paper*.jar files to %paperFolder%
move "C:\Users\%USERNAME%\Downloads\paper*.jar" "%paperFolder%"

rem 2.3 Rename the paper*.jar files to paper.jar
for %%F in ("%paperFolder%\paper*.jar") do (
    set "newFileName=%paperFolder%\paper.jar"
    ren "%%F" "paper.jar"
)

:stepThree
rem 3. Run the Java command
echo Running Java command: %javaCommand%
cd %paperFolder%
%javaCommand%

rem 3.2 Notify if Java command fails
if errorlevel 1 (
    echo Error: Java failed. 
)