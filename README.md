# Uni_Assembly_2023

PTE-TTK Uni programming 2023-24/1

Learning compilers and assembly for university

## If you copy the code, at least change it

---
---

### To make this work

In dosbox config, at the very bottom have this
and make sure that this whole repo is in ```C:\DosBox\```

``` txt
[autoexec]
# Lines in this section will be run at startup.
# You can put your MOUNT lines here.
mount c C:\DosBox\masm611
c:
SET PATH=C:\BINR;c:\BIN;%PATH%
SET INCLUDE=C:\INCLUDE
SET INIT=C:\
SET HELPFILES=C:\HELP\*.HLP
SET ASMEX=C:\SAMPLES
SET TMP=C:\

C:\BINR\PWB.EXE
```
