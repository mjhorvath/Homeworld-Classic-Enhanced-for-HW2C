--------------------------------------------------------------------------------
-- special debug commands, similar to the "aitrace" function
-- uncomment the lines to enable printing to "HW2.log"

function COM_trace(sString)
--	print("COMTRACE: " .. sString)
end

function BEN_trace(sString)
--	print("BENTRACE: " .. sString)
end

function DEF_trace(sString)
--	print("DEFTRACE: " .. sString)
end

function SPC_trace(sString)
--	print("SPCTRACE: " .. sString)
end

function HWC_trace(sString)
--	print("HWCTRACE: " .. sString)
end

function WIN_trace(sString)
--	print("WINTRACE: " .. sString)
end


-------------------------------------------------------------------------------
-- Disables a list of build abilities for a player
--
function DisableListOfBuilds(playerIndex, sRace, buildTable)
	for k = 1, getn(buildTable) do
		local buildItem = buildTable[k]
		-- if the research item hasn't already been restricted...
		if (IsBuildRestricted(playerIndex, sRace, buildItem) == 0) then
			-- if the research item hasn't already been granted...
			if (IsBuildGranted(playerIndex, sRace, buildItem) == 0) then
				COM_trace("DisableListOfBuilds: Disabling build option: " .. buildItem .. " for Player " .. playerIndex .. ".")
				Player_RestrictBuildOption(playerIndex, buildItem)
				tinsert(Player_RestrictedBuilds[playerIndex + 1][sRace], buildItem)
			else
				COM_trace([[DisableListOfBuilds: "]] .. buildItem .. [[" has already been granted. Can't restrict.]])
			end
		else
			COM_trace([[DisableListOfBuilds: "]] .. buildItem .. [[" has already been restricted. Can't restrict again.]])
		end
	end
end


-------------------------------------------------------------------------------
-- Disables a list of research abilities for a player
--
function DisableListOfResearch(playerIndex, sRace, researchTable)
	for k = 1, getn(researchTable) do
		local researchItem = researchTable[k]
		-- if the research item hasn't already been restricted...
		if (IsResearchRestricted(playerIndex, sRace, researchItem) == 0) then
			-- if the research item hasn't already been granted...
			if (IsResearchGranted(playerIndex, sRace, researchItem) == 0) then
				-- restrict the research item
				COM_trace("DisableListOfResearch: Disabling research option: " .. researchItem .. " for Player " .. playerIndex .. ".")
				Player_RestrictResearchOption(playerIndex, researchItem)
				tinsert(Player_RestrictedResearch[playerIndex + 1][sRace], researchItem)
			-- else...
			else
				COM_trace([[DisableListOfResearch: "]] .. researchItem .. [[" has already been granted. Can't restrict.]])
			end
		-- else...
		else
			COM_trace([[DisableListOfResearchDisableListOfResearch: "]] .. researchItem .. [[" has already been restricted. Can't restrict again.]])
		end
	end
end


-------------------------------------------------------------------------------
-- checks whether a research item has been restricted
--
function IsResearchRestricted(iPlayerIndex, sRace, sresearchItem)
	local researchList = Player_RestrictedResearch[iPlayerIndex + 1][sRace]
	for n = 1, getn(researchList) do
		local sCheckvs = researchList[n]
		if (strlower(sresearchItem) == strlower(sCheckvs)) then
			return 1
		end
	end
	return 0
end


-------------------------------------------------------------------------------
-- checks whether a research item has been granted
--
function IsResearchGranted(iPlayerIndex, sRace, sresearchItem)
	local researchList = Player_GrantedResearch[iPlayerIndex + 1][sRace]
	for n = 1, getn(researchList) do
		local sCheckvs = researchList[n]
		if (strlower(sresearchItem) == strlower(sCheckvs)) then
			return 1
		end
	end
	return 0
end


-------------------------------------------------------------------------------
-- checks whether a research item has been restricted
--
function IsBuildRestricted(iPlayerIndex, sRace, sbuildItem)
	local buildList = Player_RestrictedBuilds[iPlayerIndex + 1][sRace]
	for n = 1, getn(buildList) do
		local sCheckvs = buildList[n]
		if (strlower(sbuildItem) == strlower(sCheckvs)) then
			return 1
		end
	end
	return 0
end


-------------------------------------------------------------------------------
-- checks whether a research item has been granted
--
function IsBuildGranted(iPlayerIndex, sRace, sbuildItem)
	local buildList = Player_GrantedBuilds[iPlayerIndex + 1][sRace]
	for n = 1, getn(buildList) do
		local sCheckvs = buildList[n]
		if (strlower(sbuildItem) == strlower(sCheckvs)) then
			return 1
		end
	end
	return 0
end


--------------------------------------------------------------------------------
-- Returns true if the player is the local player.
--
function Player_IsLocal(iPlayer)
	if (iPlayer == FE_GetCurrentPlayerIndex()) then
		return 1
	end
	return 0
end


--------------------------------------------------------------------------------
-- Returns a table containing the player indices in random order.
--
function Universe_RandomPlayerList()
	local PlayerCount, PlayerTable, PlayerIndex = Universe_PlayerCount(), {}, 1
	while (getn(PlayerTable) < PlayerCount) do
		local PlayerRandom = srandom(CRA_Seed, 0, PlayerCount - 1)
		local PlayerAlready = 0
		for i, k in PlayerTable do
			if (k == PlayerRandom) then
				PlayerAlready = 1
				break
			end
		end
		if (PlayerAlready == 0) then
			PlayerTable[PlayerIndex] = PlayerRandom
			PlayerIndex = PlayerIndex + 1
		end
	end
	return PlayerTable
end
