@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"c:\Sites\work\weibo\vendor\bundles\ruby\1.9.1\bin\ruby.exe" "c:/Sites/work/weibo/vendor/bundles/ruby/1.9.1/bin/thin" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"%~dp0ruby.exe" "%~dpn0" %*
