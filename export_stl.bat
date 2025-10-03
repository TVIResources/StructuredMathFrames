@echo off
ECHO Batch script to export all components from the OpenSCAD file
ECHO Make sure OpenSCAD.exe is in your system's PATH, or update the script with the full path to the executable.

SET "scadFile=Structured_math.scad"
SET "outputDir=exported_stls"

mkdir "%outputDir%" 2>NUL

SET components=time_keeping_braille add_subtract_braille division_braille multiplication_braille storage_bay storage_bay_case operation_symbol_multiply_braille operation_symbol_add_braille operation_symbol_subtract_braille numbers_1_braille numbers_2_braille numbers_3_braille numbers_4_braille numbers_5_braille numbers_6_braille numbers_7_braille numbers_8_braille numbers_9_braille numbers_0_braille numbers_null time_keeping_print add_subtract_print division_print multiplication_print operation_symbol_multiply_print operation_symbol_add_print operation_symbol_subtract_print numbers_1_print numbers_2_print numbers_3_print numbers_4_print numbers_5_print numbers_6_print numbers_7_print numbers_8_print numbers_9_print numbers_0_print operation_symbol_multiply_nemeth operation_symbol_add_nemeth operation_symbol_subtract_nemeth numbers_1_nemeth numbers_2_nemeth numbers_3_nemeth numbers_4_nemeth numbers_5_nemeth numbers_6_nemeth numbers_7_nemeth numbers_8_nemeth numbers_9_nemeth numbers_0_nemeth

FOR %%c IN (%components%) DO (
    ECHO Exporting %%c to STL...
    openscad.exe -o "%outputDir%\%%c.stl" -p "structured_math.json" -P "%%c" "%scadFile%"
)

ECHO All components have been exported to the "%outputDir%" folder.
PAUSE
