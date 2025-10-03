# Script to export all components from the OpenSCAD file
# Set your file paths and output directory
$scadFile = "Structured_math.scad"
$outputDir = "exported_stls"
$components = @(
    "time_keeping_UEB",
    "add_subtract_UEB",
    "division_UEB",
    "multiplication_UEB",
    "storage_bay",
    "storage_bay_case",
    "operation_symbol_multiply_UEB",
    "operation_symbol_add_UEB",
    "operation_symbol_subtract_UEB",
    "numbers_1_UEB",
    "numbers_2_UEB",
    "numbers_3_UEB",
    "numbers_4_UEB",
    "numbers_5_UEB",
    "numbers_6_UEB",
    "numbers_7_UEB",
    "numbers_8_UEB",
    "numbers_9_UEB",
    "numbers_0_UEB",
    "numbers_null",
    "time_keeping_print",
    "add_subtract_print",
    "division_print",
    "multiplication_print",
    "operation_symbol_multiply_print",
    "operation_symbol_add_print",
    "operation_symbol_subtract_print",
    "numbers_1_print",
    "numbers_2_print",
    "numbers_3_print",
    "numbers_4_print",
    "numbers_5_print",
    "numbers_6_print",
    "numbers_7_print",
    "numbers_8_print",
    "numbers_9_print",
    "numbers_0_print",
    "operation_symbol_multiply_nemeth",
    "operation_symbol_add_nemeth",
    "operation_symbol_subtract_nemeth",
    "numbers_1_nemeth",
    "numbers_2_nemeth",
    "numbers_3_nemeth",
    "numbers_4_nemeth",
    "numbers_5_nemeth",
    "numbers_6_nemeth",
    "numbers_7_nemeth",
    "numbers_8_nemeth",
    "numbers_9_nemeth",
    "numbers_0_nemeth"
)

# Create the output directory if it doesn't exist
if (-not (Test-Path -Path $outputDir)) {
    New-Item -Path $outputDir -ItemType Directory
}

# Loop through each component and export it
foreach ($component in $components) {
    $outputFile = Join-Path -Path $outputDir -ChildPath "$($component).stl"
    Write-Host "Exporting $outputFile..."
    openscad.exe -o $outputFile -D "component=`"$component`"" $scadFile
}

Write-Host "Export process complete."