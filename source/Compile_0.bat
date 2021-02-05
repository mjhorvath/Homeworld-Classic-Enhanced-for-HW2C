:: syntax: cscript [script file] [LuaC Path] [.arciv file] [destination folder]
set ScrPath=D:\Working\Homeworld\HW2_ArcivCompiler\HW2_ArcivCompiler.js
set LuaPath=D:\Working\Homeworld\LuaC\LuaC4.exe
set ArcPath=D:\Working\Homeworld\Projects\HWClassicMaps\HWClassicMaps.arciv
set OutPath=D:\Working\Homeworld\Projects\HWClassicMaps\Compiled

cscript "%ScrPath%" "%LuaPath%" "%ArcPath%" "%OutPath%"
