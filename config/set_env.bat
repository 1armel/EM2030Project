@echo off

rem ///////////////////////////////////////////////
rem /// \file set_env.bat 
rem /// \copyright (c) TonkaIn - All rights reserved 
rem ///  unautorized copying of this file, via any medium is strictly prohibited
rem ///
rem /// \ author  Alucard Ntchouayang Noubissi 
rem /// \ version  1.2.0 
rem ///
rem /// \brief   Setup the development environment
rem /// 
rem /// \b  Description
rem /// This nifty little batch file sets up the development environment by adding 
rem /// environment variables for compiler, tools and build tools.
rem /// Additionally CMake and Ninja will be added to the systems PATH variable to 
rem /// make the build tools accessible for command line and CI builds.
rem ///
rem //////////////////////////////////////////////////////////////////////////////////////

rem -----------------------------------------------------------------------------------------------
rem CONFIG PROJECT
rem -----------------------------------------------------------------------------------------------
set NAME_PROJECT=PROJECT_V001

set BUILD_DIR=${workspaceFolder}



rem -----------------------------------------------------------------------------------------------
rem Build Tools
rem ------------------------------------------------------------------------------------------------
set TOOLCHAIN_CMAKE=C:/Program Files/CMake/bin

set TOOLCHAIN_NINJA=C:/Ninja

rem -----------------------------------------------------------------------------------------------
rem compiler 
rem -----------------------------------------------------------------------------------------------

rem ARM GCC
set ARM_TOOLCHAIN_PATH=C:/Program Files (x86)/GNU Arm Embedded Toolchain/bin

rem -----------------------------------------------------------------------------------------------
rem Debug Tools
rem ------------------------------------------------------------------------------------------------
set TOOLCHAIN_ST_LINK=C:/stlink-gdb-server/bin
set STM32CUBE_PROGRAMMER=C:/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin

set VSCODE_DIR=C:\Users\Tobi\AppData\Local\Programs\Microsoft VS Code




