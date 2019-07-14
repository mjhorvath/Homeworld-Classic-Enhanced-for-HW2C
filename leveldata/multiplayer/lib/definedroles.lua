-- global variables
-- need to reduce JOB_DutiesList and JOB_TeamsList to a single table named JOB_PlayersList
-- this table should store each player's team and job info
JOB_DutiesList = {}
JOB_TeamsList = {}
JOB_CurrentTeam = 1


-------------------------------------------------------------------------------
-- initially disables builds and research based on role
--	JOB_DutiesList[iTeam][iDuty][iPlayer] = playerIndex
--	JOB_TeamsList[iTeam][iPlayer] = playerIndex
--
function DefinedRoles_Init()
	-- fill the team and job tables
	CreateTeams()

	-- for every type of job...
	for i = 1, RolesNumber do
		local job = RolesTable[i]
		local jobtechclasses = job.techclasses

		-- create a sobgroup for this job
		SobGroup_Create("dr_" .. job.name .. "_group")

		RolesTable[i].research = {}
		RolesTable[i].subsystems = {}
		RolesTable[i].ships = {}

		-- build a list of technologies associated with this job
		for j = 1, RacesNumber do
			local thisRace = RacesList[j]
			local techRace = TechList[thisRace]

			RolesTable[i].research[thisRace] = {}
			RolesTable[i].subsystems[thisRace] = {}
			RolesTable[i].ships[thisRace] = {}

			for k = 1, getn(jobtechclasses) do
				local kCount = jobtechclasses[k]
				for m = 1, getn(techRace.research) do
					local mCount = techRace.research[m]
					if (kCount == mCount.class) then
						for l = 1, getn(mCount.items) do
							local lCount = mCount.items[l]
							tinsert(RolesTable[i].research[thisRace], lCount.type)
						end
						break
					end
				end
				for m = 1, getn(techRace.subsystems) do
					local mCount = techRace.subsystems[m]
					if (kCount == mCount.class) then
						for l = 1, getn(mCount.items) do
							local lCount = mCount.items[l]
							tinsert(RolesTable[i].subsystems[thisRace], lCount.type)
						end
						break
					end
				end
				for m = 1, getn(techRace.ships) do
					local mCount = techRace.ships[m]
					if (kCount == mCount.class) then
						for l = 1, getn(mCount.items) do
							local lCount = mCount.items[l]
							tinsert(RolesTable[i].ships[thisRace], lCount.type)
						end
						break
					end
				end
			end
		end
	end

	-- for every team...
	for i = 1, getn(JOB_TeamsList) do
		local thisTeam = JOB_TeamsList[i]
		local thisDutyTeam = JOB_DutiesList[i]
		-- for every player on the team...
		for j = 1, getn(thisTeam) do
			local playerIndex = thisTeam[j]
			local sRace = Player_Races[playerIndex + 1]
			local iDuty = GetGameSettingAsNumber("Duty" .. playerIndex)
			DEF_trace([[DefinedRoles_Init: Now setting up Player ]] .. playerIndex .. [[. Team: ]] .. i .. [[; Race: ]] .. sRace .. [[; Job: ]] .. iDuty .. [[;]])
			-- if the player does not have the capital role...
			if (iDuty ~= RolesCapital) then
				-- for every type of job...
				for k = 1, RolesNumber do
					local job = RolesTable[k]
					-- if a teammate has the capital role, or if the player does not have this job, but a teammate does...
					if ((thisDutyTeam[RolesCapital] ~= nil) or ((iDuty ~= k) and (thisDutyTeam[k] ~= nil))) then
						-- build a list of technologies associated with this job
						-- normally, I would only restrict items belonging to the player's race
						-- however, in this case I want every race's ships restricted since there's a chance a player might get some motherships from other races (i.e. Defined Roles' capital role)
						-- unfortunately, the way HWU is set up, a subsystem can appear in multiple races, resulting in a possible conflict
						-- this is also why there are so many "luaplayer 334" subsystem errors in HW2.log
						DisableListOfBuilds(playerIndex, sRace, job.ships[sRace])
						DisableListOfBuilds(playerIndex, sRace, job.subsystems[sRace])
						DisableListOfResearch(playerIndex, sRace, job.research[sRace])
					end
				end
				-- if a teammate has the capital role...
				if (thisDutyTeam[RolesCapital] ~= nil) then
					-- set this player's "mode", which adjusts the win condition
					JOB_PlayerModes[playerIndex] = 1
				end
			end
			-- if the player is a CPU player...
			if (CPU_Exist(playerIndex) == 1) then
				-- activate the special AI routines
				CPU_DoString(playerIndex, [[DefinedRolesActivated = 1]])

				if (iDuty ~= RolesFighter) then
					CPU_DoString(playerIndex, [[sg_dofighters = 0]])
				end
				if (iDuty ~= RolesCorvette) then
					CPU_DoString(playerIndex, [[sg_docorvettes = 0]])
				end
				if (iDuty ~= RolesFrigate) then
					CPU_DoString(playerIndex, [[sg_dofrigates = 0]])
				end
				if ((iDuty ~= RolesCapital) and (thisDutyTeam[RolesCapital] ~= nil)) then
					-- turn off all build/research-related behavior
					CPU_DoString(playerIndex, [[sg_dobuild = 0; sg_dosubsystems = 0; sg_doresearch = 0; sg_doupgrades = 0]])
				end
			end
		end
	end
	Rule_AddInterval("TradeShips", 1)
	Rule_Remove("DefinedRoles_Init")
end


-------------------------------------------------------------------------------
-- periodically checks and switches ownership of ships to the correct teammate
-- also transfers completed research and RUs to the correct teammate(s)
--	JOB_DutiesList[iTeam][iDuty][iPlayer] = playerIndex
--	JOB_TeamsList[iTeam][iPlayer] = playerIndex
--
function TradeShips()
	-- fill the team and job tables
	CreateTeams()

	-- for every player on the current team...
	for i = 1, getn(JOB_TeamsList[JOB_CurrentTeam]) do
		local playerIndex = JOB_TeamsList[JOB_CurrentTeam][i]
		local sRace = Player_Races[playerIndex + 1]
		local iDuty = GetGameSettingAsNumber("Duty" .. playerIndex)
		local iRUs = Player_GetRU(playerIndex)

		-- for every type of job...
		for j = 1, getn(RolesTable) do
			local job = RolesTable[j]
			local sobname = "dr_" .. job.name .. "_group"

			-- clear the sobgroup
			SobGroup_Clear(sobname)

			-- sort the player's ships into the proper sobgroup
			for k, kRace in job.ships do
				for l = 1, getn(kRace) do
					local shiptype = kRace[l]
					SobGroup_SobGroupAdd(sobname, Player_GetShipsByType(playerIndex, shiptype))
				end
			end

			-- if this is not the player's job, but somebody on the team does have the job...
			local playertable = JOB_DutiesList[JOB_CurrentTeam][j]
			if (iDuty ~= j) and (playertable ~= nil) then
				local iNumber = getn(playertable)
				local iRandom = srandom(DEF_Seed, iNumber)
				local randomPlayerIndex = playertable[iRandom]

				-- transfer all ships for this job to the proper teammate (chosen randomly)
				SobGroup_SwitchOwner(sobname, randomPlayerIndex)
			end
		end
		-- if this player does not have the capital role, but another player on the team does...
		local playertable = JOB_DutiesList[JOB_CurrentTeam][RolesCapital]
		if (iDuty ~= RolesCapital) and (playertable ~= nil) then
			local iNumber = getn(playertable)
			local iRandom = srandom(DEF_Seed, iNumber)
			local randomPlayerIndex = playertable[iRandom]
			local randomPlayerRUs = Player_GetRU(randomPlayerIndex)

			-- transfer all RUs to a teammate with the capital role (chosen randomly)
			Player_SetRU(randomPlayerIndex, randomPlayerRUs + iRUs)
			Player_SetRU(playerIndex, 0)
		end
	end

	-- cycle to the next team
	if (JOB_CurrentTeam >= getn(JOB_TeamsList)) then
		JOB_CurrentTeam = 1
	else
		JOB_CurrentTeam = JOB_CurrentTeam + 1
	end
end


-------------------------------------------------------------------------------
-- notifies the player of any research transfers
--
function NotifyOfResearchTransfer(playerIndex, researchItem, notification)
	if (notification == "") then
		return 0
	end
	-- if the player is the local player (hope this doesn't cause de-syncs)...
	if (playerIndex == FE_GetCurrentPlayerIndex()) then
		for i = 1, getn(JOB_PlayerGrantItems[playerIndex + 1]) do
			if (researchItem == JOB_PlayerGrantItems[playerIndex + 1][i]) then
				return 0
			end
		end
		tinsert(JOB_PlayerGrantItems[playerIndex + 1], researchItem)
		DEF_PlayerGrantStrings[playerIndex + 1] = notification
		Rule_AddInterval("DEF_ClearStrings", 60)
	end
end


-------------------------------------------------------------------------------
-- resets the strings passed to the ATI function
--
function DEF_ClearStrings()
	DEF_PlayerGrantStrings[FE_GetCurrentPlayerIndex() + 1] = ""
	Rule_Remove("DEF_ClearStrings")
end


-------------------------------------------------------------------------------
-- Kills a player if the player has no production capability
-- Legacy code. No longer used.
--
function KillPlayerIfPlayerHasNoProduction(playerIndex)
	if ((Player_IsAlive(playerIndex) == 1) and (Player_HasShipWithBuildQueue(playerIndex) == 0)) then
		Player_Kill(playerIndex)
	end
end


-------------------------------------------------------------------------------
-- Kills a player if the team has no production capability
-- Legacy code. No longer used.
--
function KillPlayerIfTeamHasNoProduction(playerIndex)
	local nPlay = getn(JOB_TeamsList[JOB_CurrentTeam])
	local bDead = 1
	for j = 1, nPlay do
		local otherPlayerIndex = JOB_TeamsList[JOB_CurrentTeam][j]
		if ((Player_IsAlive(otherPlayerIndex) == 1) and (Player_HasShipWithBuildQueue(otherPlayerIndex) == 1)) then
			bDead = 0
			break
		end
	end
	if (bDead == 1) then
		Player_Kill(playerIndex)
	end
end


-------------------------------------------------------------------------------
-- sort players into teams and give each player a job
--
function CreateTeams()
	-- reset the team and job tables
	-- note these are global variables!
	JOB_TeamsList = {}
	JOB_DutiesList = {}
	-- for every player...
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the player is alive...
		if (Player_IsAlive(playerIndex) == 1) then
			local sRace = Player_Races[playerIndex + 1]
			local iDuty = GetGameSettingAsNumber("Duty" .. playerIndex)
			local iTeam = 0
			local bAlly = 0
			-- put the player into an existing team if allied
			-- don't use for ... in here
			for i = 1, getn(JOB_TeamsList) do
				if (AreAllied(JOB_TeamsList[i][1], playerIndex) == 1) then
					tinsert(JOB_TeamsList[i], playerIndex)
					iTeam = i
					bAlly = 1
					break
				end
			end
			-- otherwise create a new team and add the player to it
			if (bAlly == 0) then
				tinsert(JOB_TeamsList, {playerIndex,})
				tinsert(JOB_DutiesList, {})
				iTeam = getn(JOB_TeamsList)
			end
			-- store the player's job
			if (JOB_DutiesList[iTeam][iDuty] == nil) then
				JOB_DutiesList[iTeam][iDuty] = {}
			end
			tinsert(JOB_DutiesList[iTeam][iDuty], playerIndex)
		end
	end
end
