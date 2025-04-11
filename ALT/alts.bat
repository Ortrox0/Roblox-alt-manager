@echo off
setlocal EnableDelayedExpansion

:: Kolory (zmienne)
set "COLOR_RESET=07"
set "COLOR_ADD=0A"
set "COLOR_REMOVE=0C"
set "COLOR_EDIT=0E"
set "COLOR_USE=0D"

:: Ścieżka do folderu z kontami
set "ALT_DIR=%~dp0Roblox Alts"
if not exist "%ALT_DIR%" mkdir "%ALT_DIR%"

:GOTO_MAIN
cls
call :USE_ACCOUNT

goto :eof

:SHOW_HELP
cls
echo.
echo Dostepne ukryte komendy:
echo - settings / st / sg : przejdz do zarzadzania kontami
echo - help : pokazuje te informacje
echo - back / bc / exit / ex : powrot do poprzedniego menu
pause
goto MENU

:MENU
color %COLOR_RESET%
cls
echo.
echo      ____         ___  __    _       _      __ _____                  ___ 
echo     /___ \/\ /\  /___\/__\  /_\     /_\    / //__   \   /\  /\/\ /\  / __\
echo    //  / / / \ \//  // \// //_\\   //_\\  / /   / /\/  / /_/ / / \ \/__\//
echo   / \_/ /\ \_/ / \_// _  \/  _  \ /  _  \/ /___/ /    / __  /\ \_/ / \/  \
echo   \___,_\ \___/\___/\/ \_/\_/ \_/ \_/ \_/\____/\/     \/ /_/  \___/\_____/
echo ------------------------------------------------------------
echo ^|                    ROBLOX ALT MANAGER                   ^|
echo ------------------------------------------------------------
echo ^| 1: Zarzadzaj kontami                                    ^|
echo ^| 2: Uzyj konta                                           ^|
echo ^| 3: Wyjdz                                                ^|
echo ------------------------------------------------------------
echo.
set /p mainChoice=: 
call :CHECK_BACK "%mainChoice%" MENU

if /i "%mainChoice%"=="1" goto MANAGE_MENU
if /i "%mainChoice%"=="2" goto USE_ACCOUNT
if /i "%mainChoice%"=="3" exit
if /i "%mainChoice%"=="settings" goto MANAGE_MENU
if /i "%mainChoice%"=="st" goto MANAGE_MENU
if /i "%mainChoice%"=="sg" goto MANAGE_MENU
if /i "%mainChoice%"=="help" goto SHOW_HELP

goto MENU

:MANAGE_MENU
color %COLOR_EDIT%
cls
echo.
echo      ____         ___  __    _       _      __ _____                  ___ 
echo     /___ \/\ /\  /___\/__\  /_\     /_\    / //__   \   /\  /\/\ /\  / __\
echo    //  / / / \ \//  // \// //_\\   //_\\  / /   / /\/  / /_/ / / \ \/__\//
echo   / \_/ /\ \_/ / \_// _  \/  _  \ /  _  \/ /___/ /    / __  /\ \_/ / \/  \
echo   \___,_\ \___/\___/\/ \_/\_/ \_/ \_/ \_/\____/\/     \/ /_/  \___/\_____/
echo ------------------------------------------------------------
echo ^|                  ZARZADZANIE KONTAMI                    ^|
echo ------------------------------------------------------------
echo ^| 1: Dodaj konto                                           ^|
echo ^| 2: Usun konto                                            ^|
echo ^| 3: Edytuj konto                                          ^|
echo ^| 4: Powrot                                                ^|
echo ------------------------------------------------------------
echo.
set /p manageChoice=: 
call :CHECK_BACK "%manageChoice%" MENU

if "%manageChoice%"=="1" goto ADD_ALT
if "%manageChoice%"=="2" goto REMOVE_ALT
if "%manageChoice%"=="3" goto EDIT_ALT
if "%manageChoice%"=="4" goto MENU
goto MANAGE_MENU

:ADD_ALT
color %COLOR_ADD%
cls
echo.
echo      ____         ___  __    _       _      __ _____                  ___ 
echo     /___ \/\ /\  /___\/__\  /_\     /_\    / //__   \   /\  /\/\ /\  / __\
echo    //  / / / \ \//  // \// //_\\   //_\\  / /   / /\/  / /_/ / / \ \/__\//
echo   / \_/ /\ \_/ / \_// _  \/  _  \ /  _  \/ /___/ /    / __  /\ \_/ / \/  \
echo   \___,_\ \___/\___/\/ \_/\_/ \_/ \_/ \_/\____/\/     \/ /_/  \___/\_____/
echo ------------------------------------------------------------
echo ^|                DODAWANIE NOWEGO KONTA                   ^|
echo ------------------------------------------------------------
echo.
:add_input_name
set /p newAltName=Podaj nazwe konta: 
call :CHECK_BACK "%newAltName%" MANAGE_MENU
if /i "%newAltName%"=="back" goto MANAGE_MENU
if /i "%newAltName%"=="bc" goto MANAGE_MENU
if /i "%newAltName%"=="exit" goto MANAGE_MENU
if /i "%newAltName%"=="ex" goto MANAGE_MENU

:CONFIRM_NAME
echo.
echo Czy "%newAltName%" to dobra nazwa konta?
set /p confirm=Y/N: 
call :CHECK_BACK "%confirm%" MANAGE_MENU
if /i "%confirm%"=="N" goto add_input_name
if /i not "%confirm%"=="Y" goto CONFIRM_NAME

set "newPath=%ALT_DIR%\%newAltName%"
mkdir "%newPath%"
break > "%newPath%\Cookies.txt"
break > "%newPath%\Pass.txt"

echo.
set /p pass=Ustaw haslo: 
call :CHECK_BACK "%pass%" MANAGE_MENU
echo %pass% > "%newPath%\Pass.txt"

echo.
set /p cookie=Ustaw cookie: 
call :CHECK_BACK "%cookie%" MANAGE_MENU
echo %cookie% > "%newPath%\Cookies.txt"

echo.
color %COLOR_RESET%
goto MANAGE_MENU

:REMOVE_ALT
color %COLOR_REMOVE%
cls
echo.
echo      ____         ___  __    _       _      __ _____                  ___ 
echo     /___ \/\ /\  /___\/__\  /_\     /_\    / //__   \   /\  /\/\ /\  / __\
echo    //  / / / \ \//  // \// //_\\   //_\\  / /   / /\/  / /_/ / / \ \/__\//
echo   / \_/ /\ \_/ / \_// _  \/  _  \ /  _  \/ /___/ /    / __  /\ \_/ / \/  \
echo   \___,_\ \___/\___/\/ \_/\_/ \_/ \_/ \_/\____/\/     \/ /_/  \___/\_____/
echo ------------------------------------------------------------
echo ^|                    USUWANIE KONTA                       ^|
echo ------------------------------------------------------------
echo.
set i=0
for /d %%A in ("%ALT_DIR%\*") do (
    set /a i+=1
    echo !i!: %%~nxA
    set "account[!i!]=%%~nxA"
)
echo.
set /p delAcc=: 
call :CHECK_BACK "%delAcc%" MANAGE_MENU

if not defined account[%delAcc%] (
    echo Nieprawidlowy numer konta.
    pause
    goto MANAGE_MENU
)
set "accName=!account[%delAcc%]!"
set "accPath=%ALT_DIR%\!accName!"

echo.
echo Usunac konto "!accName!"? (Y/N)
set /p confirm1=: 
call :CHECK_BACK "%confirm1%" MANAGE_MENU
if /i not "%confirm1%"=="Y" goto MANAGE_MENU

echo Czy na pewno? Spowoduje to permamentna utrate danych. (wpisz "Tak")
set /p confirm2=: 
call :CHECK_BACK "%confirm2%" MANAGE_MENU
if /i not "%confirm2%"=="Tak" goto MANAGE_MENU

rmdir /s /q "%accPath%"
echo Konto usuniete.
color %COLOR_RESET%
goto MANAGE_MENU

:EDIT_ALT
color %COLOR_EDIT%
cls
echo.
echo      ____         ___  __    _       _      __ _____                  ___ 
echo     /___ \/\ /\  /___\/__\  /_\     /_\    / //__   \   /\  /\/\ /\  / __\
echo    //  / / / \ \//  // \// //_\\   //_\\  / /   / /\/  / /_/ / / \ \/__\//
echo   / \_/ /\ \_/ / \_// _  \/  _  \ /  _  \/ /___/ /    / __  /\ \_/ / \/  \
echo   \___,_\ \___/\___/\/ \_/\_/ \_/ \_/ \_/\____/\/     \/ /_/  \___/\_____/
echo ------------------------------------------------------------
echo ^|                    EDYCJA KONTA                         ^|
echo ------------------------------------------------------------
echo.
set i=0
for /d %%A in ("%ALT_DIR%\*") do (
    set /a i+=1
    echo !i!: %%~nxA
    set "account[!i!]=%%~nxA"
)
set /p editAcc=: 
call :CHECK_BACK "%editAcc%" MANAGE_MENU
if not defined account[%editAcc%] goto MANAGE_MENU

set "accName=!account[%editAcc%]!"
set "accPath=%ALT_DIR%\%accName%"

echo.
echo 1: Edytuj haslo
echo 2: Edytuj cookie
echo 3: Powrot
set /p editOption=: 
call :CHECK_BACK "%editOption%" MANAGE_MENU

if "%editOption%"=="1" (
    set /p newPass=Nowe haslo: 
    call :CHECK_BACK "%newPass%" MANAGE_MENU
    echo %newPass% > "%accPath%\Pass.txt"
) else if "%editOption%"=="2" (
    set /p newCookie=Nowy cookie: 
    call :CHECK_BACK "%newCookie%" MANAGE_MENU
    echo %newCookie% > "%accPath%\Cookies.txt"
)
color %COLOR_RESET%
goto MANAGE_MENU

:USE_ACCOUNT
color %COLOR_USE%
cls
echo.
echo      ____         ___  __    _       _      __ _____                  ___ 
echo     /___ \/\ /\  /___\/__\  /_\     /_\    / //__   \   /\  /\/\ /\  / __\
echo    //  / / / \ \//  // \// //_\\   //_\\  / /   / /\/  / /_/ / / \ \/__\//
echo   / \_/ /\ \_/ / \_// _  \/  _  \ /  _  \/ /___/ /    / __  /\ \_/ / \/  \
echo   \___,_\ \___/\___/\/ \_/\_/ \_/ \_/ \_/\____/\/     \/ /_/  \___/\_____/
echo ------------------------------------------------------------
echo ^|                    UZYWANIE KONTA                       ^|
echo ------------------------------------------------------------
set i=0
for /d %%A in ("%ALT_DIR%\*") do (
    set /a i+=1
    echo ^| !i!: %%~nxA                                           ^|
    set "account[!i!]=%%~nxA"
)
echo ^| 0: Skopiuj WSZYSTKIE Cookies.txt                        ^|
echo ------------------------------------------------------------
set /p accNum=: 
if /i "%accNum%"=="exit" goto USE_ACCOUNT
if /i "%accNum%"=="ex" goto USE_ACCOUNT
if /i "%accNum%"=="back" goto USE_ACCOUNT
if /i "%accNum%"=="bc" goto USE_ACCOUNT
if /i "%accNum%"=="settings" goto MANAGE_MENU
if /i "%accNum%"=="st" goto MANAGE_MENU
if /i "%accNum%"=="sg" goto MANAGE_MENU
if /i "%accNum%"=="help" goto SHOW_HELP

if "%accNum%"=="0" (
    set "TMPFILE=%TEMP%\cookies_temp.txt"
    if exist "!TMPFILE!" del "!TMPFILE!"
    for /d %%A in ("%ALT_DIR%\*") do (
        if exist "%%A\Cookies.txt" (
            for /f "usebackq delims=" %%C in ("%%A\Cookies.txt") do (
                echo %%C>>"!TMPFILE!"
                echo.>>"!TMPFILE!"
            )
        )
    )
    powershell -command "Get-Content -Raw -Encoding UTF8 -Path '!TMPFILE!' | Set-Clipboard"
    del "!TMPFILE!"
    echo Skopiowano wszystkie cookies do schowka.
    pause
    color %COLOR_RESET%
    goto USE_ACCOUNT
)


if not defined account[%accNum%] goto USE_ACCOUNT

set "selectedAccount=!account[%accNum%]!"
set "accountPath=%ALT_DIR%\%selectedAccount%"
echo.
echo 1: Skopiuj Cookies.txt
echo 2: Skopiuj Pass.txt
echo 3: Powrot
set /p choice=: 
call :CHECK_BACK "%choice%" USE_ACCOUNT

if "%choice%"=="1" (
    set "fileToCopy=Cookies.txt"
) else if "%choice%"=="2" (
    set "fileToCopy=Pass.txt"
) else (
    goto USE_ACCOUNT
)

set "filePath=%accountPath%\%fileToCopy%"
if exist "%filePath%" (
    powershell -command "Get-Content -Raw -Encoding UTF8 -Path '%filePath%' | Set-Clipboard"
    echo Skopiowano %fileToCopy% do schowka.
)
pause
color %COLOR_RESET%
goto USE_ACCOUNT

:CHECK_BACK
set "_input=%~1"
set "_backTarget=%~2"
if /i "%_input%"=="back" goto %_backTarget%
if /i "%_input%"=="bc" goto %_backTarget%
if /i "%_input%"=="exit" goto %_backTarget%
if /i "%_input%"=="ex" goto %_backTarget%
exit /b