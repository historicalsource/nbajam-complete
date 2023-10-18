@echo off
path d:\;c:\bat;c:\bin;c:\dos;c:\brief;c:\nu;c:\mw;c:\uv;c:\ca\bin;c:\ca\binb;c:\windows
set mouse=c:\mouse
c:\qemm\loadhi /r:2 c:\mouse\mouse
rem pause
rem c:\qemm\loadhi /r:2 c:\mouse\mouse
rem c:\pckwik\superpck /e

c:\qemm\loadhi /r:2 c:\dos\smartdrv.exe
c:\uv\uv /l
rem c:\qemm\loadhi /r:2 c:\uv\uv /l

rem c:\qemm\loadhi /r:1 c:\uv\de /r
rem c:\pckwik\pckscrn /s:128 /b:15
rem c:\qemm\loadhi c:\pckwik\pckkey /m3 /vc+
c:\qemm\loadhi /r:1 kbfix2 /D0 /F0 /KT0
c:\qemm\loadhi /r:1 doskey /insert

set temp=d:
set tmp=d:
set dircmd=/o

set bpath=c:\brief\macros
set bhelp=c:\brief\help
set bfile=c:\brief\state.rst
set bbackup=c:\brief\backup
set bsuffix=ASM
set bflags=-i120k2l130Mpu100 -mSL -mrestore -m120 -Dega -D101key
set btmp=d:\
set bcasm="!make"
set bcc="!cl /c /W2 /Od %%s.c"

set lib=c:\ca\lib
set include=c:\ca\include
set link=/CP:1
set helpfiles=c:\ca\help\*.hlp
set init=c:\ca\init
set asmex=c:\ca\samples

set imgdir=c:\video\bball\img
set srcdir=c:\video\bball\img
set vdadir=c:\video\bball\vda
set artaddr=2a0
set trgtaddr=280
set mwmouse=32
rem set mwcard=8
set mwcard=560
set mwpath=c:\mw
set mwfont=system08.fnt
set tvpath=d:
set tvparm=d:
set tvopts=/v80,50

ldkey
copy c:\command.com d:
set comspec=d:\command.com
copy c:\brief\e.exe d:
copy c:\brief\101key.drv d:
copy c:\bin\make.exe d:
copy c:\bin\gspa.exe d:
copy c:\bin\gsplnk.exe d:
copy c:\bin\tv.exe d:
copy c:\bin\crnchlst.exe d:
copy c:\bin\preasm.exe d:
mkdir d:\mw
copy c:\mw\*.* d:\mw
cd video\bball
copy make.ini d:
copy bb.tvs d:
copy bb.map d:
copy bb.cmd d:
rem copy *.obj d:
rem copy disp.equ d:
rem copy mproc.equ d:
rem copy game.equ d:
prompt $p$g
echo *******************************
echo * Basketball development mode *
echo *******************************
rem set mouse=c:\mouse

