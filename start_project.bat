@echo off

rem ///////////////////////////////////////
rem /// file start_vs_code.bat
rem ///copyright TonkaIn
rem /// brief start Visual studio code with the sourced development environment 

rem Source the development environment 
call  %~dp0config\set_env.bat
call  %~dp0config\create_config_files.bat
rem call Visual Studio 2019 with the project  folder 
start "" "%VSCODE_DIR%\Code.exe" %~dp0.
