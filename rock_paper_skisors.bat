@echo off
set tie=0
set win=0
set lose=0
set ties=0
set wins=0
set loses=0
color 0A
title R.P.S
:front
echo rock paper skisors
echo normal or hard?
choice /C NH /M imput:
if %errorlevel% equ 2 goto startH
if %errorlevel% equ 1 goto startN
echo error
timeout 1 >nul
goto front
echo.
:startN
echo wins=%win%
echo loses=%lose%
echo ties=%tie%
echo.
echo enter "R", "P", or "S"
echo.
choice /C RPS /N /M imput:
echo.
set user=%errorlevel%
SET /A test=%RANDOM% * 3 / 32768 + 1
if %user% equ %test% goto same
if %test% equ 1 goto Rock
if %test% equ 2 goto Paper
if %test% equ 3 goto Skisors
echo error
goto startN
:same
set /A tie=%tie%+1
echo both people picked the same item
echo.
timeout 1 >nul
goto startN
:Rock
echo AI picked Rock
echo.
timeout 1 >nul
if %user% equ 1 echo error
if %user% equ 2 goto win
if %user% equ 3 goto lose
echo error
timeout 1 >nul
goto startN
:Paper
echo AI picked Paper
echo.
timeout 1 >nul
if %user% equ 3 goto win
if %user% equ 1 goto lose
if %user% equ 2 echo error
echo error
timeout 1 >nul
goto startN
:Skisors
echo AI picked skisor
echo.
timeout 1 >nul
if %user% equ 1 goto win
if %user% equ 2 goto lose
if %user% equ 3 echo error
echo error
timeout 1 >nul
goto startN
:lose
echo you lose
set /A lose=%lose%+1
echo.
timeout 1 >nul
goto startN
echo error
:win
echo you win
set /A win=%win%+1
echo.
timeout 1 >nul
goto startN
echo error
pause
:startH
echo wins=%wins%
echo loses=%loses%
echo ties=%ties%
echo.
echo enter "R", "P", or "S"
echo.
choice /C RPS /N /M imput:
echo.
set users=%errorlevel%
SET /A tests=%RANDOM% * 3 / 32768 + 1
SET /A testz=%RANDOM% * 3 / 32768 + 1
if %tests% equ 1 set Hin2=Rock
if %tests% equ 2 set Hin2=Paper
if %tests% equ 3 set Hin2=Skisors
if %testz% equ 1 set Hin=Rock
if %testz% equ 2 set Hin=Paper
if %testz% equ 3 set Hin=Skisors
if %users% equ %tests% goto sames
if %tests% equ 1 goto Rocks
if %tests% equ 2 goto Papers
if %tests% equ 3 goto Skisorz
echo error
timeout 1 >nul
goto startH
:sames
if %testz% neq %tests% goto testz
echo both people picked the same item
set /A ties=%ties%+1
echo.
timeout 1 >nul
goto startH
:Rocks
echo rock
echo AI picked %Hin2% and %Hin%
echo.
timeout 1 >nul
if %user% equ 1 echo errors
if %user% equ 2 goto stage
if %user% equ 3 goto loses
echo error
timeout 1 >nul
goto startN
:Papers
echo paper
echo AI picked %Hin2% and %Hin%
echo.
timeout 1 >nul
if %user% equ 3 goto stage
if %user% equ 1 goto loses
if %user% equ 2 echo errors
echo error
timeout 1 >nul
goto startN
:Skisorz
echo skisors
goto startH
echo AI picked %Hin2% and %Hin%
echo.
timeout 1 >nul
if %user% equ 1 goto stage
if %user% equ 2 goto loses
if %user% equ 3 echo errors
echo error
timeout 1 >nul
goto startN
:loses
echo you lose
set /A loses=%loses%+1
echo.
timeout 1 >nul
goto startN
echo error
:win
echo you win
set /A wins=%wins%+1
echo.
timeout 1 >nul
goto startN
echo error
pause
:stage
if %testz% equ 1 goto rock2
if %testz% equ 2 goto paper2
if %testz% equ 3 goto skisors2
:rock2
if %users% equ 1 goto wins
if %users% equ 2 goto wins
if %users% equ 3 goto loses
echo error
timeout 1 >nul
goto startH
:paper2
if %users% equ 1 goto loses
if %users% equ 2 goto wins
if %users% equ 3 goto wins
echo error
timeout 1 >nul
:skisors2
goto startH
if %users% equ 1 goto wins
if %users% equ 2 goto loses
if %users% equ 3 goto wins
echo error
timeout 1 >nul
goto startH