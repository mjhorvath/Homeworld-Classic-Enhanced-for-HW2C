WIN_AnyPlayerIndex = 0

-------------------------------------------------------------------------------
-- Cycles through all players
--
function CyclePlayers()
	if (WIN_AnyPlayerIndex == (Universe_PlayerCount() - 1)) then
		WIN_AnyPlayerIndex = 0
	else
		WIN_AnyPlayerIndex = WIN_AnyPlayerIndex + 1
	end
end

-------------------------------------------------------------------------------
-- Kills a player if the player has no production capability
--
function CheckPlayerProductionShipsLeftRule()
	local bCycle = 1
	-- if the player is alive but has no ships of its own...
	if ((Player_IsAlive(WIN_AnyPlayerIndex) == 1) and (Player_HasShipWithBuildQueue(WIN_AnyPlayerIndex) == 0)) then
		-- if Defined Roles is active and the player has a teammate with the Capital role, then switch over to the Kill Team Production rule instead
		if (JOB_PlayerModes[WIN_AnyPlayerIndex] == 1) then
			bCycle = 0
			CheckTeamProductionShipsLeftRule()		
		-- otherwise, kill the player
		else
			Player_Kill(WIN_AnyPlayerIndex)
		end
	end
	if (bCycle == 1) then
		CyclePlayers()
	end
end

-------------------------------------------------------------------------------
-- Kills a player if no team member has any production capability
--
function CheckTeamProductionShipsLeftRule()
	local bDead = 1
	for otherPlayerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the player has an ally who is alive and has build-capable ships, then do not kill the player
		if ((AreAllied(WIN_AnyPlayerIndex, otherPlayerIndex) == 1) and (Player_IsAlive(otherPlayerIndex) == 1) and (Player_HasShipWithBuildQueue(otherPlayerIndex) == 1)) then
			bDead = 0
			break
		end
	end
	-- otherwise, kill the player
	if (bDead == 1) then
		Player_Kill(WIN_AnyPlayerIndex)
	end
	CyclePlayers()
end

-------------------------------------------------------------------------------
-- Kills a player if no team member has any ships
--
function CheckTeamAnyShipsLeftRule()
	local bDead = 1
	for otherPlayerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the player has an ally who is alive and possesses at least one ship, then do not kill the player
		if ((AreAllied(WIN_AnyPlayerIndex, otherPlayerIndex) == 1) and (Player_IsAlive(otherPlayerIndex) == 1) and (Player_NumberOfShips(otherPlayerIndex) > 0)) then
			bDead = 0
			break
		end
	end
	-- otherwise, kill the player
	if (bDead == 1) then
		Player_Kill(WIN_AnyPlayerIndex)
	end
	CyclePlayers()
end

-------------------------------------------------------------------------------
-- Counts the size of a player's fleet
--
function Player_NumberOfShips(iPlayer)
	local sRace = Player_Races[iPlayerIndex + 1]
	local ShipCount = 0
	local shipList = TechList[sRace].ships
	-- for every class...
	for i = 1, getn(shipList) do
		local iCount = shipList[i]
		-- for every item within that class...
		for j = 1, getn(iCount.items) do
			local jCount = iCount.items[j]
			-- keep a count of how many of this item the player owns
			ShipCount = ShipCount + Player_GetNumberOfSquadronsOfTypeAwakeOrSleeping(iPlayer, jCount.type)
		end
	end
	return ShipCount
end

-------------------------------------------------------------------------------
-- Returns the team number of the player (may be different than what is shown in the game-setup screen)
--
function Player_Team(iPlayer)
	local TeamsTable = {}
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		local IsAllied = 0
		for i = 1, getn(TeamsTable) do
			if (AreAllied(playerIndex, TeamsTable[i]) == 1) then
				IsAllied = 1
				break
			end
		end
		if (IsAllied == 0) then
			tinsert(TeamsTable, playerIndex)
		end
	end
	for i = 1, getn(TeamsTable) do
		if (AreAllied(iPlayer, TeamsTable[i]) == 1) then
			return i
		end
	end
end

--------------------------------------------------------------------------------
-- Checks to see if any players have had a ship captured.
--
function CheckCaptureStatusRule()
	local capturePlayerIndex = srandom(WIN_Seed, 0, Universe_PlayerCount() - 1)
	local groupName = "captureGroup_" .. capturePlayerIndex

	-- if the capturePlayerIndex player is alive...
	if (Player_IsAlive(capturePlayerIndex)) then
		-- if the group is not empty...
		if (SobGroup_Empty(groupName) == 0) then
			WIN_trace("CheckCaptureStatusRule: Player " .. capturePlayerIndex .. " has ships currently being captured.")

			-- for each player in a randomized list of players...
			for i, playerIndex in Universe_RandomPlayerList() do
				-- if the player is not the capturePlayerIndex player and the player is alive...
				if ((playerIndex ~= capturePlayerIndex) and (Player_IsAlive(playerIndex) == 1)) then
					-- check if the ship that was being captured is now owned by this player
					if (SobGroup_CountByPlayer(groupName, playerIndex) > 0) then
						-- announce the loss of the ship if capturePlayerIndex is the local player
						if (Player_IsLocal(capturePlayerIndex) == 1) then
							Sound_SpeechPlay("data:sound\\speech\\allships\\HEIDI\\ShipStolen")
						end

						-- wait a while before killing the capturePlayerIndex player
						Player_Kill(capturePlayerIndex)
					end
				end
			end
		end
	end

	-- if the capturePlayerIndex player is still alive...
	if (Player_IsAlive(capturePlayerIndex)) then
		-- update the list of ships this player owns that are being captured
		SobGroup_GetSobGroupBeingCapturedGroup("Player_Ships" .. capturePlayerIndex, groupName)
	end
end

--------------------------------------------------------------------------------
-- Kills players if they have no more motherships.
--
function CheckMothershipDeadRule()
	-- for each player...
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		local sRace = Player_Races[playerIndex + 1]
		local shipList = TechList[sRace].ships
		local MothershipIsDead = 1
		-- if the player is alive...
		if (Player_IsAlive(playerIndex) == 1) then
			-- for every class of ship...
			for k = 1, getn(shipList) do
				local kClass = shipList[k]
				-- if this is the "mothership" class...
				if (kClass.class == "mothership") then
					-- for every item belonging to that class...
					for l = 1, getn(kClass.items) do
						local lItem = kClass.items[l]
						-- check to see if the player has a mothership
						if (Player_GetNumberOfSquadronsOfTypeAwakeOrSleeping(playerIndex, lItem.type) > 0) then
							MothershipIsDead = 0
							break
						end
					end
					if (MothershipIsDead == 0) then
						break
					end
				end
			end
			-- if the player has no motherships, kill the player
			if (MothershipIsDead == 1) then
				WIN_trace("CheckMothershipDeadRule: Player " .. playerIndex .. " has no more motherships. Killing the player")
				Player_Kill(playerIndex)
			end
		end
	end
end
