-------------------------------------------------------------------------------
-- randomly restricts and grants research options
-- what's done here is very similar to the "DisableListOfResearch" function in "definedroles.lua"
-- they're different enough that code consolidation may not be warranted
--
function BentusiRoulette_Init()
	-- for every player...
	for iPlayerIndex = 0, (Universe_PlayerCount() - 1) do
		local iResearchSetting = GetGameSettingAsNumber("RouletteResearch")
		local sRace = Player_Races[iPlayerIndex + 1]
		local raceResearch = TechList[sRace].research
		local iGrant = 1
		local iRestrict = 1
		local getnT = 0
		-- count the total number of research items
		for i = 1, getn(raceResearch) do
			for j = 1, getn(raceResearch[i].items) do
				getnT = getnT + 1
			end
		end
		-- while iGrant is less than or equal to iResearchSetting...
		while (iGrant <= iResearchSetting) do
			local getnG = getn(Player_GrantedResearch[iPlayerIndex + 1][sRace])
			local getnR = getn(Player_RestrictedResearch[iPlayerIndex + 1][sRace])
			BEN_trace([[BentusiRoulette_Init: iGrant = ]] .. iGrant .. [[, getnG = ]] .. getnG .. [[, getnR = ]] .. getnR .. [[, getnT = ]] .. getnT)
			-- if there are any research items left to grant or restrict...
			if ((getnG + getnR) < getnT) then
				iGrant = iGrant + GetResearchGrant(iPlayerIndex, sRace, raceResearch)
			-- else...
			else
				BEN_trace([[BentusiRoulette_Init: there are no more research items to grant or restrict.]])
				break
			end
		end

		-- add the column heading
		tinsert(BEN_GrantStrings[iPlayerIndex + 1], "BENTUSI GRANTS:")

		-- while iRestrict is less than or equal to iResearchSetting...
		while (iRestrict <= iResearchSetting) do
			local getnG = getn(Player_GrantedResearch[iPlayerIndex + 1][sRace])
			local getnR = getn(Player_RestrictedResearch[iPlayerIndex + 1][sRace])
			BEN_trace([[BentusiRoulette_Init: iRestrict = ]] .. iRestrict .. [[, getnG = ]] .. getnG .. [[, getnR = ]] .. getnR .. [[, getnT = ]] .. getnT)
			-- if there are any research items left to grant or restrict...
			if ((getnG + getnR) < getnT) then
				iRestrict = iRestrict + GetResearchRestriction(iPlayerIndex, sRace, raceResearch)
			-- else...
			else
				BEN_trace([[BentusiRoulette_Init: there are no more research items to grant or restrict.]])
				break
			end
		end
		-- add the column heading
		tinsert(BEN_RestrictStrings[iPlayerIndex + 1], "BENTUSI RESTRICTIONS:")
	end
	Rule_Remove("BentusiRoulette_Init")
end

-------------------------------------------------------------------------------
-- get an available research grant
--

function GetResearchGrant(iPlayerIndex, sRace, raceResearch)
	local iRand1 = srandom(BEN_Seed)
	-- for every research class...
	for i = 1, getn(raceResearch) do
		local iClass = raceResearch[i]
		if (iRand1 <= iClass.prob) then
			local iRand2 = srandom(BEN_Seed)
			-- for every item within that class...
			for j = 1, getn(iClass.items) do
				local jItem = iClass.items[j]
				if (iRand2 <= jItem.prob) then
					local researchitem = jItem.type
					local researchname = jItem.name
					-- if the research item has not already been restricted...
					if (IsResearchRestricted(iPlayerIndex, sRace, researchitem) == 0) then
						-- if the research item has not already been granted...
						if (IsResearchGranted(iPlayerIndex, sRace, researchitem) == 0) then
							-- grant the research item
							BEN_trace([[GetResearchGrant: Player ]] .. iPlayerIndex .. [[ has been granted "]] .. researchitem .. [[".]])
							Player_GrantResearchOption(iPlayerIndex, researchitem)
							tinsert(Player_GrantedResearch[iPlayerIndex + 1][sRace], researchitem)
							tinsert(BEN_GrantStrings[iPlayerIndex + 1], researchname)
							return 1
						-- else...
						else
							BEN_trace([[GetResearchGrant: "]] .. researchitem .. [[" has already been granted. Can't grant again.]])
						end
					-- else...
					else
						BEN_trace([[GetResearchGrant: "]] .. researchitem .. [[" has already been restricted. Can't grant.]])
					end
				end
			end
		end
	end
	return 0
end


-------------------------------------------------------------------------------
-- resets the strings passed to the ATI function
--

function GetResearchRestriction(iPlayerIndex, sRace, raceResearch)
	local iRand1 = srandom(BEN_Seed)
	-- for every research class...
	for i = 1, getn(raceResearch) do
		local iClass = raceResearch[i]
		if (iRand1 <= iClass.prob) then
			local iRand2 = srandom(BEN_Seed)
			-- for every item within that class...
			for j = 1, getn(iClass.items) do
				local jItem = iClass.items[j]
				if (iRand2 <= jItem.prob) then
					local researchitem = jItem.type
					local researchname = jItem.name
					-- if the research item has not already been restricted...
					if (IsResearchRestricted(iPlayerIndex, sRace, researchitem) == 0) then
						-- if the research item has not already been granted...
						if (IsResearchGranted(iPlayerIndex, sRace, researchitem) == 0) then
							-- restrict the research item
							BEN_trace([[GetResearchRestriction: Player ]] .. iPlayerIndex .. [[ has been restricted "]] .. researchitem .. [[".]])
							Player_RestrictResearchOption(iPlayerIndex, researchitem)
							tinsert(Player_RestrictedResearch[iPlayerIndex + 1][sRace], researchitem)
							tinsert(BEN_RestrictStrings[iPlayerIndex + 1], researchname)
							return 1
						-- else...
						else
							BEN_trace([[GetResearchRestriction: "]] .. researchitem .. [[" has already been granted. Can't restrict.]])
						end
					-- else...
					else
						BEN_trace([[GetResearchRestriction: "]] .. researchitem .. [[" has already been restricted. Can't restrict again.]])
					end
				end
			end
		end
	end
	return 0
end


-------------------------------------------------------------------------------
-- resets the strings passed to the ATI function
-- no longer used since the ATI display is now toggleable
--
function BEN_ClearStrings()
	BEN_GrantStrings = {{},{},{},{},{},{},}
	BEN_RestrictStrings = {{},{},{},{},{},{},}
	Rule_Remove("BEN_ClearStrings")
end
