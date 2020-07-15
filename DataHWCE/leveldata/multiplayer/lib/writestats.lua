-------------------------------------------------------------------------------
-- writes ending stats to a file. Call this before you call the setGameOver() function.
--
function WriteStats()
	local fdate = date("%m-%d-%Y_%H_%M_%S")
	if (strsub(fdate, 1, 1) == "0") then
		fdate = strsub(fdate, 2)	
	end
	dofilepath([[data:scripts/race.lua]])
	local WriteFile = HW2Path() .. "Bin\\LOGFILES\\EndGame_" .. fdate .. ".stats"
	local WriteHandle = openfile(WriteFile, "w+")
	closefile(WriteHandle)
	local WriteHandle = openfile(WriteFile, "a")
	local WriteString = "  GameRulesName = \"" .. GameRulesName .. "\","
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		local sRace = Player_Races[iPlayerIndex + 1]
		local LocalPlayer = FE_GetCurrentPlayerIndex()
		WriteString = WriteString .. "\n  Player" .. playerIndex .. " = {"
		WriteString = WriteString .. "\n    DETAILS = {"
		WriteString = WriteString .. "\n      LocalPlayer = "
		if (playerIndex == LocalPlayer) then
			WriteString = WriteString .. 1 .. ","
		else
			WriteString = WriteString .. 0 .. ","
		end
		WriteString = WriteString .. "\n      IsAlive = " .. Player_IsAlive(playerIndex) .. ","
		WriteString = WriteString .. "\n      Team = " .. Player_Team(playerIndex) .. ","
		WriteString = WriteString .. "\n      RUs = " .. Player_GetRU(playerIndex) .. ","
		WriteString = WriteString .. "\n" .. "    },"
		dofilepath([[data:scripts/building and research/]] .. sRace .. [[/build.lua]])
		WriteString = WriteString .. "\n    BUILD = {"
		for i, iCount in build do
			local WriteNumber = Player_GetNumberOfSquadronsOfTypeAwakeOrSleeping(playerIndex, iCount.ThingToBuild)
			WriteString = WriteString .. "\n      {Type = " .. iCount.Type .. ", ThingToBuild = \"" .. iCount.ThingToBuild .. "\", Number = " .. WriteNumber .. ",},"
		end
		WriteString = WriteString .. "\n" .. "    },"
		dofilepath([[data:scripts/building and research/]] .. sRace .. [[/research.lua]])
		WriteString = WriteString .. "\n    RESEARCH = {"
		for i, iCount in research do
			WriteString = WriteString .. "\n      {Name = \"" .. iCount.Name .. "\", Completed = " .. Player_HasResearch(playerIndex, iCount.Name) .. ",},"
		end
		WriteString = WriteString .. "\n" .. "    },"
		WriteString = WriteString .. "\n" .. "  },"
	end
	WriteString = WriteString .. "\n"
	write(WriteHandle, WriteString)
	closefile(WriteHandle)
end
