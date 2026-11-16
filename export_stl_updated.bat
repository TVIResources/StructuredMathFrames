@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM Export every component defined in structured_math_updated.json.
REM Usage: export_stl_updated.bat [path\to\model.scad] [output_directory]

set "SCRIPT_DIR=%~dp0"
set "SCAD_FILE=%~1"
if not defined SCAD_FILE set "SCAD_FILE=%SCRIPT_DIR%UEB_braille_alphabet_and_word_board.scad"
set "OUTPUT_DIR=%~2"
if not defined OUTPUT_DIR set "OUTPUT_DIR=%SCRIPT_DIR%exported_stls"
set "PARAM_FILE=%SCRIPT_DIR%structured_math_updated.json"
set "COMPONENT_LIST=%TEMP%\openscad_components_%RANDOM%.txt"

if not exist "%SCAD_FILE%" (
  echo ERROR: OpenSCAD source not found: "%SCAD_FILE%"
  echo Pass the .scad path as the first argument.
  exit /b 1
)
if not exist "%PARAM_FILE%" (
  echo ERROR: Parameter file not found: "%PARAM_FILE%"
  exit /b 1
)
where openscad.exe >nul 2>nul
if errorlevel 1 (
  echo ERROR: openscad.exe was not found in PATH. Add OpenSCAD to PATH or edit this script.
  exit /b 1
)
where py.exe >nul 2>nul
if errorlevel 1 (
  echo ERROR: Python 3 launcher "py" is required to read the JSON parameter sets.
  exit /b 1
)

py -3 -c "import json; [print(k) for k in json.load(open(r'%PARAM_FILE%', encoding='utf-8'))['parameterSets']]" > "%COMPONENT_LIST%"
if errorlevel 1 (
  echo ERROR: Could not read parameter sets from "%PARAM_FILE%".
  del "%COMPONENT_LIST%" 2>nul
  exit /b 1
)
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

set /a INDEX=0
set /a FAILED=0
for /f "usebackq delims=" %%C in ("%COMPONENT_LIST%") do (
  set /a INDEX+=1
  echo [!INDEX!] Exporting %%C
  openscad.exe -o "%OUTPUT_DIR%\%%C.stl" -p "%PARAM_FILE%" -P "%%C" "%SCAD_FILE%"
  if errorlevel 1 (
    echo FAILED: %%C
    set /a FAILED+=1
  ) else (
    echo OK: %%C
  )
)
del "%COMPONENT_LIST%" 2>nul

if not "!FAILED!"=="0" (
  echo Export finished with !FAILED! failure(s).
  exit /b 1
)
echo Export complete: !INDEX! STL files in "%OUTPUT_DIR%"
exit /b 0
