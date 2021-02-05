set ScrPath=D:\Working\Homeworld\HW2_MapConverter\HW2_MapConverter\HW2_MapConverter.js
set SrcPath=D:\Working\Homeworld\HW2_HWClassicMaps\Source_1
set OutPath=D:\Working\Homeworld\HW2_HWClassicMaps\temp
set ScrArgs=-incVariables -incFunctions
cscript "%ScrPath%" "%SrcPath%\Badlands4\Badlands4.level" "%OutPath%\HW1_Badlands4.level" -rus 1/2 -peb 3/4 -debug
pause
