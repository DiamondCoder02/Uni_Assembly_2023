ORIGIN = PWB
ORIGIN_VER = 2.1.49
PROJ = KOVACS2
PROJFILE = ..\..\PWB00408.mak
BUILDDIR = .
DEBUG = 0

ASM  = ml
H2INC  = h2inc
AFLAGS_G  = /Cx /W2 /WX
AFLAGS_D  = /Zi
AFLAGS_R  = /nologo
MAPFILE_D  = NUL
MAPFILE_R  = NUL
LFLAGS_G  = /NOI /BATCH /ONERROR:NOEXE
LFLAGS_D  = /CO /FAR /PACKC
LFLAGS_R  = /EXE /FAR /PACKC
LINKER	= link
ILINK  = ilink
LRF  = echo > NUL
ILFLAGS  = /a /e
BSCMAKE  = bscmake
SBRPACK  = sbrpack
NMAKEBSC1  = set
NMAKEBSC2  = nmake

FILES  = KOVACS2.ASM
OBJS  = .\KOVACS2.obj
SBRS  = .\KOVACS2.sbr

all: .\$(PROJ).exe

.SUFFIXES:
.SUFFIXES:
.SUFFIXES: .obj .sbr .asm

.\KOVACS2.obj : KOVACS2.ASM
!IF $(DEBUG)
	$(ASM) /c $(AFLAGS_G) $(AFLAGS_D) /Fo.\KOVACS2.obj KOVACS2.ASM
!ELSE
	$(ASM) /c $(AFLAGS_G) $(AFLAGS_R) /Fo.\KOVACS2.obj KOVACS2.ASM
!ENDIF

.\KOVACS2.sbr : KOVACS2.ASM
!IF $(DEBUG)
	$(ASM) /Zs $(AFLAGS_G) $(AFLAGS_D) /FR.\KOVACS2.sbr KOVACS2.ASM
!ELSE
	$(ASM) /Zs $(AFLAGS_G) $(AFLAGS_R) /FR.\KOVACS2.sbr KOVACS2.ASM
!ENDIF


.\$(PROJ).exe : $(OBJS)
!IF $(DEBUG)
	$(LRF) @<<.\$(PROJ).lrf
$(RT_OBJS: = +^
) $(OBJS: = +^
)
$@
$(MAPFILE_D)
$(LIBS: = +^
) +
$(LLIBS_G: = +^
) +
$(LLIBS_D: = +^
)
$(DEF_FILE) $(LFLAGS_G) $(LFLAGS_D);
<<
!ELSE
	$(LRF) @<<.\$(PROJ).lrf
$(RT_OBJS: = +^
) $(OBJS: = +^
)
$@
$(MAPFILE_R)
$(LIBS: = +^
) +
$(LLIBS_G: = +^
) +
$(LLIBS_R: = +^
)
$(DEF_FILE) $(LFLAGS_G) $(LFLAGS_R);
<<
!ENDIF
	$(LINKER) @.\$(PROJ).lrf

.\$(PROJ).bsc : $(SBRS)
	$(BSCMAKE) @<<
$(BRFLAGS) $(SBRS)
<<


.asm.obj :
!IF $(DEBUG)
	$(ASM) /c $(AFLAGS_G) $(AFLAGS_D) /Fo$@ $<
!ELSE
	$(ASM) /c $(AFLAGS_G) $(AFLAGS_R) /Fo$@ $<
!ENDIF

.asm.sbr :
!IF $(DEBUG)
	$(ASM) /Zs $(AFLAGS_G) $(AFLAGS_D) /FR$@ $<
!ELSE
	$(ASM) /Zs $(AFLAGS_G) $(AFLAGS_R) /FR$@ $<
!ENDIF


run: .\$(PROJ).exe
	.\$(PROJ).exe $(RUNFLAGS)

debug: .\$(PROJ).exe
	CV $(CVFLAGS) .\$(PROJ).exe $(RUNFLAGS)
