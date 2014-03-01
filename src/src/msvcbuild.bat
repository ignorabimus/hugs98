@setlocal
@set HSCOMPILE=cl /nologo /O2 /W3 /c /D_CRT_SECURE_NO_DEPRECATE /D_CRT_NONSTDC_NO_DEPRECATE /DWIN32 /D_CONSOLE /DHAVE_VSNPRINTF=1
@set HSLINK=link /nologo
@set HSLIB=lib /nologo
@set SOURCES=server.c builtin.c char.c compiler.c errors.c evaluator.c ffi.c goal.c input.c machdep.c machine.c module.c opts.c output.c plugin.c script.c static.c storage.c strutil.c subst.c type.c version.c
@set OBJECTS=server.obj builtin.obj char.obj compiler.obj errors.obj evaluator.obj ffi.obj goal.obj input.obj machdep.obj machine.obj module.obj opts.obj output.obj plugin.obj script.obj static.obj storage.obj strutil.obj subst.obj type.obj version.obj

@copy msc\config.h .
@copy msc\options.h .
@copy msc\platform.h .

@if "%1" == "static" goto STATIC
@if not exist bin\ (
  mkdir bin
)

%HSCOMPILE% /DNDEBUG /MT runhugs.c %SOURCES%
%HSLINK% /out:bin\runhugs.exe runhugs.obj %OBJECTS% advapi32.lib

%HSCOMPILE% /D_DEBUG /MDd runhugs.c %SOURCES%
%HSLINK% /out:bin\runhugs_d.exe runhugs.obj %OBJECTS% advapi32.lib

del runhugs.obj

@goto END

:STATIC
@if not exist lib\ (
  mkdir lib
)

%HSCOMPILE% /DNDEBUG /MT %SOURCES%
%HSLIB% /out:lib\hugsscript.lib %OBJECTS%

%HSCOMPILE% /D_DEBUG /MDd %SOURCES%
%HSLIB% /out:lib\hugsscript_d.lib %OBJECTS%

:END
del %OBJECTS%
