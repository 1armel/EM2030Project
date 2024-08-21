@echo off

rem -----------------------------------------------------------------------------------------------
rem creation of cmake-variants.json and settings.json files. NO EDIT THIS SECTION
rem ------------------------------------------------------------------------------------------------
echo {>.vscode/cmake-variants.json
 
echo   "NAME_PROJECT": {>>.vscode/cmake-variants.json
echo      "default": "%NAME_PROJECT%",>>.vscode/cmake-variants.json
echo      "choices": {    >>.vscode/cmake-variants.json
echo        "%NAME_PROJECT%": {    >>.vscode/cmake-variants.json
echo          "short": "%NAME_PROJECT%",>>.vscode/cmake-variants.json
echo          "long": "%NAME_PROJECT%",>>.vscode/cmake-variants.json
echo          "settings": {    >>.vscode/cmake-variants.json
echo            "NAME_PROJECT": "%NAME_PROJECT%">>.vscode/cmake-variants.json
echo          }>>.vscode/cmake-variants.json
echo        }>>.vscode/cmake-variants.json
echo      }>>.vscode/cmake-variants.json
echo    },>>.vscode/cmake-variants.json
rem echo  "TARGET_SYSTEM": {>>.vscode/cmake-variants.json
rem echo     "default": "STM32F746",>>.vscode/cmake-variants.json
rem echo     "choices": {    >>.vscode/cmake-variants.json
rem echo       "STM32F746": {    >>.vscode/cmake-variants.json
rem echo         "short": "STM32F746",>>.vscode/cmake-variants.json
rem echo         "long": "STM32F746",>>.vscode/cmake-variants.json
rem echo         "settings": {    >>.vscode/cmake-variants.json
rem echo           "TARGET_SYSTEM": "STM32F746">>.vscode/cmake-variants.json
rem echo         }>>.vscode/cmake-variants.json
rem echo       },>>.vscode/cmake-variants.json
rem echo       "STM32F756": {    >>.vscode/cmake-variants.json
rem echo        "short": "STM32F756",>>.vscode/cmake-variants.json
rem echo        "long": "STM32F756",>>.vscode/cmake-variants.json
rem echo        "settings": {    >>.vscode/cmake-variants.json
rem echo          "TARGET_SYSTEM": "STM32F756">>.vscode/cmake-variants.json
rem echo        }>>.vscode/cmake-variants.json
rem echo      }>>.vscode/cmake-variants.json
rem echo     }>>.vscode/cmake-variants.json
rem echo   },>>.vscode/cmake-variants.json
echo    "buildType": {    >>.vscode/cmake-variants.json
echo      "default": "Debug",>>.vscode/cmake-variants.json
echo      "choices": {    >>.vscode/cmake-variants.json
echo        "Release": {    >>.vscode/cmake-variants.json
echo          "short": "Release",>>.vscode/cmake-variants.json
echo          "long": "Release",>>.vscode/cmake-variants.json
echo          "buildType": "Release">>.vscode/cmake-variants.json
echo        },>>.vscode/cmake-variants.json
echo        "Debug": {    >>.vscode/cmake-variants.json
echo          "short": "Debug",>>.vscode/cmake-variants.json
echo          "long": "Debug",>>.vscode/cmake-variants.json
echo          "buildType": "Debug">>.vscode/cmake-variants.json
echo        }>>.vscode/cmake-variants.json
echo      }>>.vscode/cmake-variants.json
echo    }>>.vscode/cmake-variants.json
echo  }>>.vscode/cmake-variants.json
 
echo {>.vscode/settings.json
echo   "files.autoGuessEncoding" : true,>>.vscode/settings.json
echo     "cmake.configureOnOpen"  : true,>>.vscode/settings.json
echo     "cmake.buildDirectory"   : "%BUILD_DIR%/build/${variant:TARGET_SYSTEM}",>>.vscode/settings.json
echo     "cmake.generator"        : "Ninja",>>.vscode/settings.json

echo      "cmake.cmakePath": "%TOOLCHAIN_CMAKE%/cmake",>>.vscode/settings.json

echo      "cmake.configureSettings": {>>.vscode/settings.json
echo        "CMAKE_MAKE_PROGRAM":"%TOOLCHAIN_NINJA%/ninja">>.vscode/settings.json
echo      },>>.vscode/settings.json

echo     "cmake.preferredGenerators": [>>.vscode/settings.json
echo       "Ninja",>>.vscode/settings.json
echo       ],>>.vscode/settings.json
echo }>>.vscode/settings.json

rem -----------------------------------------------------------------------------------------------
rem creation of cmake-variants.json file. NO EDIT THIS SECTION
rem ------------------------------------------------------------------------------------------------
rem echo {>.vscode/cmake-variants.json
rem setlocal EnableDelayedExpansion
rem set LF=^
rem 
rem 
rem set string=   "TARGET_SYSTEM": {!LF!^
rem      "default": "%NAME_PROJECT%",!LF!^
rem      "choices": {    !LF!^
rem        "%NAME_PROJECT%": {    !LF!^
rem          "short": "%NAME_PROJECT%",!LF!^
rem          "long": "%NAME_PROJECT%",!LF!^
rem          "settings": {    !LF!^
rem            "TARGET_SYSTEM": "%NAME_PROJECT%"!LF!^
rem          }!LF!^
rem        }!LF!^
rem      }!LF!^
rem    },!LF!^
rem    "buildType": {    !LF!^
rem      "default": "Release",!LF!^
rem      "choices": {    !LF!^
rem        "Release": {    !LF!^
rem          "short": "Release",!LF!^
rem          "long": "Release",!LF!^
rem          "buildType": "Release"!LF!^
rem        },!LF!^
rem        "Debug": {    !LF!^
rem          "short": "Debug",!LF!^
rem          "long": "Debug",!LF!^
rem          "buildType": "Debug"!LF!^
rem        }!LF!^
rem      }!LF!^
rem    }!LF!^
rem  }
rem  echo !string!>>.vscode/cmake-variants.json
rem 
rem echo {>.vscode/settings.json
rem set string=    "files.autoGuessEncoding" : true,!LF!^
rem     "cmake.configureOnOpen"  : true,!LF!^
rem     "cmake.buildDirectory"   : "%BUILD_DIR%/build/${variant: TARGET_SYSTEM}_${variant:buildType}",!LF!^
rem     "cmake.generator"        : "Ninja",!LF!^
rem     "cmake.preferredGenerators": [!LF!^
rem       "Ninja",!LF!^
rem       ],!LF!^
rem }
rem  echo !string!>>.vscode/settings.json