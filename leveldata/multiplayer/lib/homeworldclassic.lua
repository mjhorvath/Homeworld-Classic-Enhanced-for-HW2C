
--==============================================================================
-- Make sure nobody can hyperspace
-- (Very slow.)
function DisableHyperspaceRule()
	-- disable the hyperspace ability for all ships owned by the player
	SobGroup_AbilityActivate("Player_Ships" .. hyperspacePlayerIndex, AB_Hyperspace, 0)

	-- rotate to next player for the next frame
	if (hyperspacePlayerIndex == (Universe_PlayerCount() - 1)) then
		hyperspacePlayerIndex = 0
	else
		hyperspacePlayerIndex = hyperspacePlayerIndex + 1
	end
end


--------------------------------------------------------------------------------
-- Rule to inject resources.
--
function ResourceInjectionRule()
	local resourcesToInject = GetGameSettingAsNumber("resourceinjection")
	HWC_trace("ResourceInjectionRule: Injecting " .. resourcesToInject .. " resources.")

	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		if (Player_IsAlive(playerIndex) == 1) then
			local currentResources = Player_GetRU(playerIndex)
			Player_SetRU(playerIndex, currentResources + resourcesToInject)
			-- if the player is the local player, announce the RU injection
			if (Player_IsLocal(playerindex) == 1) then
				Sound_SpeechPlay("data:sound\\speech\\allships\\HEIDI\\ResourceInjectionReceived")
			end
		end
	end
end


--------------------------------------------------------------------------------
-- Rule to inject lump sum resources.
--
function ResourceLumpSumRule()
	local resourcesToInject = GetGameSettingAsNumber("resourcelumpsum")
	HWC_trace("ResourceLumpSumRule: Injecting a lump sum of " .. resourcesToInject .. " resources.")

	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		if (Player_IsAlive(playerIndex) == 1) then
			local currentResources = Player_GetRU(playerIndex)
			Player_SetRU(playerIndex, currentResources + resourcesToInject)
			-- if the player is the local player, announce the RU injection
			if (Player_IsLocal(playerindex) == 1) then
				Sound_SpeechPlay("data:sound\\speech\\allships\\HEIDI\\ResourceInjectionReceived")
			end
		end
	end
	Rule_Remove("ResourceLumpSumRule")
end


--------------------------------------------------------------------------------
-- Delete any resourcers that players might build or launch.
-- (Kind of slow.)
function DestroyResourcersRule()
	local GroupName = "ResourcersToDestroy"
	local sRace = Player_Races[resourcePlayerIndex + 1]
	-- for every ship in the list of restricted resourcers...
	for k, iCount in RestrictedBy.ResourceOff[sRace].build do
		-- fill the group with all ships of that type belonging to the player
		Player_FillShipsByType(GroupName, resourcePlayerIndex, iCount)
		-- if the sobgroup is not empty, then despawn and destroy the ships
		if (SobGroup_Empty(GroupName) == 0) then
			SobGroup_Despawn(GroupName)
			SobGroup_SetHealth(GroupName, 0)
		end
	end

	if (resourcePlayerIndex == (Universe_PlayerCount() - 1)) then
		resourcePlayerIndex = 0
	else
		resourcePlayerIndex = resourcePlayerIndex + 1
	end

--	local duration = Universe_GameTime() - resourceStartCountingTime
--	if (duration >= resourceStopCountingTime) then
--		Rule_Remove("DestroyResourcersRule")
--	end
end


--------------------------------------------------------------------------------
-- See if a position is OK for spawning crate.
-- !!! intersect a generic sphere
function CratePositionIsOK(posTable)
	local result = 1

	-- create a volume at the given location
	Volume_AddSphere("CrateDetectVolumeTest" .. volumePositionCounter, posTable, CRATES_PlayerNearRadius * 2)

	-- for each player...
	for iPlayer = 0, (Universe_PlayerCount() - 1) do
		-- fill a sobgroup with all ships belonging to the player that are inside the volume
		SobGroup_FillSobGroupInVolume("CrateMothership", "Player_Ships" .. iPlayer, "CrateDetectVolumeTest" .. volumePositionCounter)
		-- if the sobgroup is not empty, the result is failure
		if (SobGroup_Empty("CrateMothership") == 0) then
			result = 0
			break
		end
	end

	-- delete the volume
	Volume_Delete("CrateDetectVolumeTest" .. volumePositionCounter)
	volumePositionCounter = volumePositionCounter + 1
	-- return the result
	return result
end


--------------------------------------------------------------------------------
-- Figure out where to put a crate.
--
function GetBestCrateLocation()
	local universeSize = Universe_GetWorldBounds()
	local cratePosition, averageMSPosition, displacement, randPos = {0,0,0,}, {0,0,0,}, {}, {}
	local directionVectors = {{0,0,0,}, {0,0,0,}, {0,0,0,}, {0,0,0,}, {0,0,0,}, {0,0,0,},}
	local alivePlayers, length = 0, 0

	-- do a pass to determine position of motherships and get average
	-- for each other player find mothership
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		if (Player_IsAlive(playerIndex) == 1) then
			local playerPlusOne = playerIndex + 1
			local sRace = Player_Races[playerIndex + 1]
			local mothershipPosition = {0,0,0,}
			local theta, phi, radius = srandom(CRA_Seed, 360), srandom(CRA_Seed, 180), srandom(CRA_Seed, 1000)
			local raceShips = TechList[sRace].ships

			-- keeps trying to add motherships or carriers to the sobgroup, then gets the position of the sobgroup.
			SobGroup_Clear("CrateMothership")
			for j = 1, getn(raceShips) do
				local jClass = raceShips[j]
				if (jClass.class == "mothership") then
					for k = 1, getn(jClass.items) do
						local sShip = jClass.items[k].type
						Player_FillShipsByType("CrateMothership", playerIndex, sShip)
						if (SobGroup_Empty("CrateMothership") == 0) then
							break
						end
					end
					if (SobGroup_Empty("CrateMothership") == 0) then
						break
					end
				end
			end
			if (SobGroup_Empty("CrateMothership") == 1) then
				for j = 1, getn(raceShips) do
					local jClass = raceShips[j]
					if (jClass.class == "carrier") then
						for k = 1, getn(jClass.items) do
							local sShip = jClass.items[k].type
							Player_FillShipsByType("CrateMothership", playerIndex, sShip)
							if (SobGroup_Empty("CrateMothership") == 0) then
								break
							end
						end
						if (SobGroup_Empty("CrateMothership") == 0) then
							break
						end
					end
				end
			else
				mothershipPosition = SobGroup_GetPosition("CrateMothership")
			end

			-- calculate a random position within a sphere
			displacement =
			{
				radius * cos(theta) * sin(phi),
				radius * cos(phi),
				radius * sin(theta) * sin(phi),
			}

			-- We now have a position for a mothership, or at least some ship
			HWC_trace("GetBestCrateLocation: Player " .. playerIndex .. "'s mothership's location: " .. vstr(mothershipPosition))
			mothershipPosition = vaddV(mothershipPosition, displacement)
			averageMSPosition = vaddV(averageMSPosition, mothershipPosition)

			directionVectors[playerPlusOne][1] = mothershipPosition[1]
			directionVectors[playerPlusOne][2] = mothershipPosition[2]
			directionVectors[playerPlusOne][3] = mothershipPosition[3]
			HWC_trace("GetBestCrateLocation: Player" .. playerIndex .. "'s destination vector: " .. vstr(directionVectors[playerPlusOne]))
			alivePlayers = alivePlayers + 1
		end
	end

	-- average position of players' motherships
	averageMSPosition = vdivide(averageMSPosition, alivePlayers)
	HWC_trace("GetBestCrateLocation: Average of players' motherships' locations: " .. vstr(averageMSPosition))

	-- for each other player
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		if (Player_IsAlive(playerIndex) == 1) then
			local playerPlusOne = playerIndex + 1
			local playerBounty = BOUNTY_PlayerBounties[playerPlusOne]

			-- calculate the vector from the average position to this mothership's position
			local dest = vsubtractV(directionVectors[playerPlusOne], averageMSPosition)

			-- calculate the length of the vector
			local length2 = sqrt(vsum(vpower(dest, 2)))

			-- normalize the vector and multiply it by the inverse of the player's bounty
			dest = vdivide(dest, length2 * playerBounty * -1)
			HWC_trace("GetBestCrateLocation: Player " .. playerIndex .. "'s crate weighting vector: " .. vstr(dest))

			-- set the starting vector to favor the direction that weaker players are in
			cratePosition = vaddV(cratePosition, dest)
		end
	end

	-- calulate the length of the crate's position
	length = sqrt(vsum(vpower(cratePosition, 2)))

	-- normalize the crate's position
	cratePosition = vdivide(cratePosition, length)
	HWC_trace("GetBestCrateLocation: Normalized crate position: " .. vstr(cratePosition))

	-- add a large random element to the location
	randPos =
	{
		srandom(CRA_Seed, CRATES_RandomLowDistance, CRATES_RandomHighDistance),
		srandom(CRA_Seed, CRATES_RandomLowDistance, CRATES_RandomHighDistance),
		srandom(CRA_Seed, CRATES_RandomLowDistance, CRATES_RandomHighDistance),
	}
	cratePosition = vmultiplyV(cratePosition, randPos)

	-- add the crate's position to the motherships' average position
	cratePosition = vaddV(cratePosition, averageMSPosition)

	-- add another large random element to the location	
	randPos =
	{
		srandom(CRA_Seed, universeSize[1] / -3, universeSize[1] / 3),
		srandom(CRA_Seed, universeSize[2] / -3, universeSize[2] / 3),
		srandom(CRA_Seed, universeSize[3] / -3, universeSize[3] / 3),
	}
	cratePosition = vaddV(cratePosition, randPos)

	-- add a displacement to offset the location until it is valid. (Add a bit of randomness to the displacement vector.)
	local theta, phi, radius = srandomSet(CRA_Seed, 360, 180, 1000)
	displacement =
	{
		radius * cos(theta) * sin(phi),
		radius * cos(phi),
		radius * sin(theta) * sin(phi),
	}

	-- keep adding the displacement until the location is OK
	while (CratePositionIsOK(cratePosition) == 0) do
		cratePosition = vaddV(cratePosition, displacement)
		-- !!! place check not to exceed game world edge?
		-- !!! wrap ..if hit edge...alter displacement value
	end

	-- clip the location to the world bounds
	cratePosition = Universe_ClipToWorldBounds(cratePosition)
	return vfloor(cratePosition)
end


--------------------------------------------------------------------------------
-- Called when we need to actually spawn a crate.
--
function SelectivlyPlaceCrate()
	-- for every player...
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the player's crate spawn group is empty...
		if (SobGroup_Empty("CrateSpawnGroup" .. playerIndex) == 1) then
			local cratePosition = GetBestCrateLocation()
			HWC_trace("SelectivlyPlaceCrate: Spawning crate at: " .. vstr(cratePosition))
			-- create a crate detection volume at the best location
			Volume_AddSphere("CrateDetectVolume" .. playerIndex, cratePosition, CRATES_PlayerNearRadius)
			-- spawn a neutral crate within the volume
			SobGroup_SpawnNewShipInSobGroup(-1, "Meg_Crate", "Crate", "CrateSpawnGroup" .. playerIndex, "CrateDetectVolume" .. playerIndex)
			-- post a quick message (did not occur in HW1, an audio que would be nice too)
			Subtitle_Message("Crate spawned.", 10)
			-- there's one more crate, now
			CRATES_NumberCrates = CRATES_NumberCrates + 1
			-- record the time the crate was spawned
			CRATES_SpawnTime[playerIndex + 1] = Universe_GameTime()
			HWC_trace("SelectivlyPlaceCrate: Added a crate to slot " .. playerIndex .. ". There are now " .. CRATES_NumberCrates .. " in the universe.")
			return
		end
	end
	HWC_trace("SelectivlyPlaceCrate: No empty crate spawn groups... Not spawning.")
end


--------------------------------------------------------------------------------
-- Handles the spawning of crates.
--
function SpawnCratesRule()
	local Prob = srandom(CRA_Seed)
	HWC_trace("SpawnCratesRule: Maybe adding a crate. Prob: " .. Prob)
	if (Prob > CRATES_AddACrateProb) then
		SelectivlyPlaceCrate()
	end
end


--------------------------------------------------------------------------------
-- Choose what ship type to reward the player with.
--
function ChooseCrateRewardShip(iPlayer)
	local sRace, iCount, ShipType, ShipName = Player_Races[iPlayer + 1], 0, "", ""
	local Prob, Prob1, Prob2 = 1, srandom(CRA_Seed), srandom(CRA_Seed)
	local ShipList = TechList[sRace].ships
	HWC_trace("ChooseCrateRewardShip: Rewarding a ship from Race " .. sRace .. ".")
	
	-- for every class in the list of ships...
	for i = 1, getn(ShipList) do
		local iClass = ShipList[i]
		local ClassProb = iClass.prob
		-- check if the probablility for the class falls within a certain range
		if ((ClassProb <= Prob) and (ClassProb >= Prob1)) then
			HWC_trace("ChooseCrateRewardShip: TechList[" .. sRace .. "].ships[" .. i .. "].prob = " .. ClassProb .. " >= " .. Prob1 .. " = Prob1")
			Prob = ClassProb
			iCount = i
		end
	end
	Prob = 1

	-- for every ship within the class...
	for i = 1, getn(ShipList[iCount].items) do
		local iType = ShipList[iCount].items[i]
		local TypeType = iType.type
		local TypeName = iType.name
		local TypeProb = iType.prob
		-- check if the ship's probability falls within a certain range
		if ((TypeProb <= Prob) and (TypeProb >= Prob2)) then
			HWC_trace("ChooseCrateRewardShip: TechList[" .. sRace .. "].ships[" .. iCount .. "].types[" .. i .. "].prob = " .. TypeProb .. " >= " .. Prob2 .. " = Prob2")
			Prob = TypeProb
			ShipType = TypeType
			ShipName = TypeName
		end
	end

	-- if the ship is restricted, then iterate through the function again
	if (IsBuildRestricted(iPlayer, sRace, ShipType) == 1) then
		ShipType, ShipName = ChooseCrateRewardShip(iPlayer)
	end

	HWC_trace("ChooseCrateRewardShip: Awarding " .. ShipType .. " to Player " .. iPlayer .. ".")
	return ShipType, ShipName
end


--------------------------------------------------------------------------------
-- Choose a subsystem to give to the player. (Doesn't work, yet.)
--
function ChooseCrateRewardSubsystem(iPlayer)
	local sRace, iCount, ShipName = Player_Races[iPlayer + 1], 0, ""
	local Prob, Prob1, Prob2 = 1, srandom(CRA_Seed), srandom(CRA_Seed)

	HWC_trace("ChooseCrateRewardSubsystem: Rewarding a subsystem from Race " .. sRace .. ".")

	-- for every class in the list of subsystems...
	for k, iClass in TechList[sRace].subsystems do
		local ClassProb = iClass.prob
		-- check whether the class's probability falls within a certain range
		if ((ClassProb <= Prob) and (ClassProb >= Prob1)) then
			HWC_trace("ChooseCrateRewardSubsystem: TechList[" .. sRace .. "].subsystems[" .. k .. "].prob = " .. ClassProb .. " >= " .. Prob1 .. " = Prob1")
			Prob = ClassProb
			iCount = k
		end
	end
	Prob = 1

	-- for every subsystem within the class...
	for k, iType in TechList[sRace].subsystems[iCount].types do
		local TypeProb, TypeName = iType.prob, iType.item
		-- check whether the subsystem's probability falls within a certain range
		if ((TypeProb <= Prob) and (TypeProb >= Prob2)) then
			HWC_trace("ChooseCrateRewardSubsystem: TechList[" .. sRace .. "].subsystems[" .. iCount .. "].types[" .. k .. "].prob = " .. TypeProb .. " >= " .. Prob2 .. " = Prob2")
			Prob = TypeProb
			ShipName = TypeName
		end
	end

	-- if the subsytem is restricted, then iterate through the function again
	if (IsBuildRestricted(iPlayer, ShipName) == 1) then
		ShipName = ChooseCrateRewardSubsystem(iPlayer)
	end

	HWC_trace("ChooseCrateRewardSubsystem: Awarding " .. ShipName .. " to Player " .. iPlayer .. ".")
	return ShipName
end


--------------------------------------------------------------------------------
-- Choose a technology to give to the player.
--
function ChooseCrateRewardTech(iPlayer)
	HWC_trace("ChooseCrateRewardTech: Choosing a tech for Player " .. iPlayer)
	local sRace = Player_Races[iPlayer + 1]
	local researchList = TechList[sRace].research
	-- for each class of research item...
	for i = 1, getn(researchList) do
		local iClass = researchList[i]
		-- for each research item in the class...
		for j = 1, getn(iClass.items) do
			local jType = iClass.items[j]
			local TypeType = jType.type
			local TypeName = jType.name
			local IsCurrently = Player_HasQueuedResearch(iPlayer, TypeType)
			local IsRestricted = IsResearchRestricted(iPlayer, TypeType)
			local IsGranted = IsResearchGranted(iPlayer, TypeType)
			HWC_trace("ChooseCrateRewardTech: Trying to grant " .. TypeType .. " to Player " .. iPlayer)
			-- check whether the player already has the research, is currently researching the research, or whether the research is restricted
			if ((IsCurrently == 0) and (IsRestricted == 0) and (IsGranted == 0)) then
				HWC_trace("ChooseCrateRewardTech: Granting " .. TypeType .. " to Player " .. iPlayer)
				-- return the name of the research
				return TypeType, TypeName
	--		else
	--			HWC_trace("ChooseCrateRewardTech: Can't grant " .. TypeType ..  " to Player " .. iPlayer .. ". The item is currently being researched, has already been researched, or is restricted.")
			end
		end
	end
	HWC_trace("ChooseCrateRewardTech: There is no research left to grant to Player " .. iPlayer)
	return "", ""
end


--------------------------------------------------------------------------------
-- Gives a crate to a player.
--
function GivePlayerCrateReward(iPlayer, iVolume)
	local HasMothership = PlayerHasMothership(iPlayer)
	local prob = srandom(CRA_Seed)

	-- if a mothership should be spawned and the player has no mothership...
	if ((prob <= CRATES_GetMotherShipCarrierIfDontHaveOne) and (HasMothership == 0)) then
		local shipType = GetValidMothership(iPlayer)
		local tempDisplayText = ""
		-- if the player is the local player, play an effect
		if (Player_IsLocal(iPlayer) == 1) then
			Sound_SpeechPlay("data:sound\\speech\\allships\\HEIDI\\CrateFoundShips")
		end
		-- spawn the mothership
		SobGroup_SpawnNewShipInSobGroup(iPlayer, shipType, "NewCrateCarrier", "Player_Ships" .. iPlayer, "CrateDetectVolume" .. iVolume)
		HWC_trace("GivePlayerCrateReward: Player " .. iPlayer .. " gets a " .. shipType .. ".")
		tempDisplayText = "Crate found. " .. shipType .. " recovered."

	-- if a ship should be spawned...
	elseif (prob <= CRATES_GetAShip) then
		local shipType, shipName = ChooseCrateRewardShip(iPlayer)
		-- if the player is the local player, play an effect
		if (Player_IsLocal(iPlayer) == 1) then
			Sound_SpeechPlay("data:sound\\speech\\allships\\HEIDI\\CrateFoundShips")
		end
		-- spawn the ship
		SobGroup_SpawnNewShipInSobGroup(iPlayer, shipType, "NewCrateShip", "Player_Ships" .. iPlayer, "CrateDetectVolume" .. iVolume)
		HWC_trace("GivePlayerCrateReward: Player " .. iPlayer .. " gets a " .. shipType)
		tempDisplayText = "Crate found. " .. shipName .. " recovered."

	-- if a research item should be granted...
	elseif ((prob <= CRATES_GetResearch) and (GetGameSettingAsString("research") ~= "off")) then
		local techType, techName = ChooseCrateRewardTech(iPlayer)
		-- if research name is not blank...
		if (techType ~= "") then
			-- if the player is the local player, play an effect
			if (Player_IsLocal(iPlayer) == 1) then
				Sound_SpeechPlay("data:sound\\speech\\allships\\HEIDI\\CrateFoundTechnology")
			end
			-- grant the research item
			Player_GrantResearchOption(iPlayer, techType)
			HWC_trace("GivePlayerCrateReward: Player " .. iPlayer .. " gets " .. techType .. " technology.")
			tempDisplayText = "Crate found. " .. techName .. " technology recovered."
		end

	-- if resources should be granted...
	elseif (prob <= CRATES_GetRUs) then
		local RUs = srandom(CRA_Seed, CRATES_MinRUsGiven, CRATES_MaxRUsGiven)
		-- if the player is the local player, play an effect
		if (Player_IsLocal(iPlayer) == 1) then
			Sound_SpeechPlay("data:sound\\speech\\allships\\HEIDI\\CrateFoundResources")
		end
		-- grant the resources
		Player_SetRU(iPlayer, Player_GetRU(iPlayer) + RUs)
		HWC_trace("GivePlayerCrateReward: Player " .. iPlayer .. " gets " .. RUs .. "RUs.")
		tempDisplayText = "Crate found. " .. RUs .. " RUs recovered."
	end

	-- if the player is the local player, print text to the screen
	if (Player_IsLocal(iPlayer) == 1) then
		Subtitle_Message(tempDisplayText, 30)
	end
end


--------------------------------------------------------------------------------
-- Handles checking if players get the crates.
--
function CheckCratesRule()
	-- if there are any crates...
	if (CRATES_NumberCrates > 0) then
		-- for every player...
		for playerIndex = 0, (Universe_PlayerCount() - 1) do
			-- if the player's spawn group has a crate in it...
			if (SobGroup_Empty("CrateSpawnGroup" .. playerIndex) == 0) then
				-- check if it's time for the crate to expire
				if ((Universe_GameTime() - CRATES_SpawnTime[playerIndex + 1]) > CRATES_ExpiryTime) then
					-- kill the crate
					SobGroup_Despawn("CrateSpawnGroup" .. playerIndex)
					SobGroup_Clear("CrateSpawnGroup" .. playerIndex)
					-- kill the volume
					Volume_Delete("CrateDetectVolume" .. playerIndex)
					-- there's one less crate, now
					CRATES_NumberCrates = CRATES_NumberCrates - 1
				-- else, the crate is not dead yet
				else
					-- for every player in a randomized list of players...
					for i, iPlayer in Universe_RandomPlayerList() do
						-- check if the player has any ships in the crate's detection volume, then put the ships into a sobgroup
						SobGroup_FillSobGroupInVolume("CrateMothership", "Player_Ships" .. iPlayer, "CrateDetectVolume" .. playerIndex)
						-- if the sobgroup is not empty...
						if (SobGroup_Empty("CrateMothership") == 0) then
							-- remove any megaliths, etc.
							for k, shipType in CrateExclusions do
								SobGroup_RemoveType("CrateMothership", shipType)
							end
							-- if the sobgroup is still not empty, then it means that the player's ship(s) has collided with crate's detection volume
							if (SobGroup_Empty("CrateMothership") == 0) then
								HWC_trace("CheckCratesRule: Player " .. iPlayer .. " gets crate #" .. playerIndex .. ".")
								-- award the crate to the player
								GivePlayerCrateReward(iPlayer, playerIndex)
								-- kill the crate
								SobGroup_Despawn("CrateSpawnGroup" .. playerIndex)
								SobGroup_Clear("CrateSpawnGroup" .. playerIndex)
								-- kill the volume
								Volume_Delete("CrateDetectVolume" .. playerIndex)
								-- there's one less crate, now
								CRATES_NumberCrates = CRATES_NumberCrates - 1
								break
							end
						end
					end
				end
			end
		end
	end
end


--------------------------------------------------------------------------------
-- Returns a valid mothership name, depending on the gamerule.
-- not sure these tables exist anymore
function GetValidMothership(iPlayerIndex)
	local sRace = Player_Races[iPlayerIndex + 1]
	local StartWith = GetGameSettingAsString("startwith")
	for k, sShip in carrierShips[iPlayerIndex] do
		if (StartWith == "carrieronly") then
			for j, sRepl in BuildCarrierReplaced[sRace] do
				if (sShip ~= sRepl) then
					return sShip
				end
			end
		elseif (StartWith == "mothership") or (StartWith == "frommap") then
			for j, sRepl in BuildCarrierReplacedBy[sRace] do
				if (sShip ~= sRepl) then
					return sShip
				end
			end
		end
	end
	return ""
end


--------------------------------------------------------------------------------
-- Returns true if the player has a mothership.
--
function PlayerHasMothership(iPlayer)
	local sRace = Player_Races[iPlayer + 1]
	local raceShips = TechList[sRace].ships
	local raceShipsNum = getn(raceShips)
	for j = 1, raceShipsNum do
		local jClass = raceShips[j]
		if (jClass.class == "mothership") then
			for k = 1, getn(jClass.items) do
				local sShip = jClass.items[k].type
				Player_FillShipsByType("CrateMothership", iPlayer, sShip)
				if (SobGroup_Empty("CrateMothership") == 0) then
					return 1
				end
			end
		end
	end
	for j = 1, raceShipsNum do
		local jClass = raceShips[j]
		if (jClass.class == "carrier") then
			for k = 1, getn(jClass.items) do
				local sShip = jClass.items[k].type
				Player_FillShipsByType("CrateMothership", iPlayer, sShip)
				if (SobGroup_Empty("CrateMothership") == 0) then
					return 1
				end
			end
		end
	end
	return 0
end


--------------------------------------------------------------------------------
-- Compute bounty value for a given player.
--
function GetPlayerBountyWorthDeterm(shipWorth, RUWorth, totalShipWorth, totalRUWorth)
	local playerCurrentShipWorth, playerRUWorth, worth = 0, 0, 0
	-- adjust the player's ship-worth so that it's a fraction of the total, then adjust it again by a set multiplier
	if (totalShipWorth > 0) then
		playerCurrentShipWorth = BOUNTY_CurrentShipWorth * shipWorth / totalShipWorth
	end
	-- adjust the player's RU-worth so that it's a fraction of the total, then adjust it again by a set multiplier
	if (totalRUWorth > 0) then
		playerRUWorth = BOUNTY_ResourcesInPossesion * RUWorth / totalRUWorth
	end
	-- add the ship-worth and RU-worth
	worth = playerCurrentShipWorth + playerRUWorth
	-- return the worth
	return worth
end


---------------------------------------------------------------------------------
-- Handles updating player bounties and the on-screen bounties display.
--
function UpdateBountyStats()
	local alivePlayers, totalShipCost, totalRUs, totalWorth = 0, 0, 0, 0
	local playerShipCosts, playerRUs, playerWorth = {0,0,0,0,0,0,}, {0,0,0,0,0,0,}, {0,0,0,0,0,0,}


	------------------------------------------------------------------------
	-- Compute ship and RU worth for each player.
	--

	-- for each player...
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the player is alive...
		if (Player_IsAlive(playerIndex) == 1) then
			local playerPlusOne = playerIndex + 1
			local sRace = Player_Races[playerIndex + 1]
			local ShipList = TechList[sRace].ships
			alivePlayers = alivePlayers + 1
			HWC_trace("UpdateBountyStats: Checking Player " .. playerIndex .. ", race " .. sRace .. ".")

			-- for each ship in the player's race...
			for i = 1, getn(ShipList) do
				local iClass = ShipList[i]
				for j = 1, getn(iClass.items) do
					local jType = iClass.items[j]
					local TypeType = jType.type
					local TypeCost = jType.cost
					-- fill all ships of this type that the player has in his/her possession into a sobgroup
					SobGroup_FillShipsByType("BountyCounterGroup", "Player_Ships" .. playerIndex, TypeType)
					-- count the number of ships in the sobgroup
					local shipCount = SobGroup_Count("BountyCounterGroup")
					if (shipCount > 0) then
						HWC_trace("UpdateBountyStats: Player " .. playerIndex .. " has " .. shipCount .. " " .. TypeType .. ".")
						-- calculate the cost of these ships and add them to the player total
						playerShipCosts[playerPlusOne] = playerShipCosts[playerPlusOne] + shipCount * TypeCost
					end
				end
			end

			-- add the player total to the fleet total
			totalShipCost = totalShipCost + playerShipCosts[playerPlusOne]
			-- compute the player's RU worth
			playerRUs[playerPlusOne] = Player_GetRU(playerIndex)
			-- add this to the total fleet RU worth
			totalRUs = totalRUs + playerRUs[playerPlusOne]
		end
	end


	------------------------------------------------------------------------
	-- We now have ship-worth and RU-worth for each player (as well as all players). Let's calculate a player's total worth.
	--

	-- for each player...
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		local playerPlusOne = playerIndex + 1
		-- get the player's adjusted worth
		playerWorth[playerPlusOne] = GetPlayerBountyWorthDeterm(playerShipCosts[playerPlusOne], playerRUs[playerPlusOne], totalShipCost, totalRUs)
		HWC_trace("UpdateBountyStats: Player " .. playerIndex .. " has " .. playerShipCosts[playerPlusOne] .. " in ships, " .. playerRUs[playerPlusOne] .. " in RUs, " .. playerWorth[playerPlusOne] .. " total.")
		-- add the player's worth to the fleet total
		totalWorth = totalWorth + playerWorth[playerPlusOne]
	end

	-- for each player...
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		local playerPlusOne = playerIndex + 1
		-- process the player's worth further
		local cap = playerWorth[playerPlusOne] * alivePlayers * BOUNTY_Level / totalWorth
		-- place a cap on the player's worth
		if (cap > BOUNTY_MaxPossible) then
			cap = BOUNTY_MaxPossible
		end
		-- store the current value in the BOUNTY_PlayerBounties table
		BOUNTY_PlayerBounties[playerPlusOne] = cap
		-- adjust the value further using another multiplier
		cap = cap * BOUNTY_ActualRURatio
		-- use this new value as the basis for the actual bounty awards
		Player_SetBounty(playerIndex, floor(cap))
	end
end


--------------------------------------------------------------------------------
-- Grants all research to all players and kills this rule.
--
function GrantAllResearchRule()
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		Player_GrantAllResearch(playerIndex)
	end
	Rule_Remove("GrantAllResearchRule")
end


--------------------------------------------------------------------------------
-- Spawns all ships placed in hyperspace by the level file.
--
function SpawnPlayerFleetInHyperspaceRule()
	HWC_trace("HWC: Spawning fleet in hyperspace.")
	local PlayerCount = Universe_PlayerCount() - 1
	for playerIndex = 0, PlayerCount do
		local EH_SobName = "HE_Formation" .. (playerIndex + 1)
		local EH_SobEmpty = SobGroup_Empty(EH_SobName)
		if (EH_SobEmpty == 0) then
			SobGroup_Spawn(EH_SobName, "StartPos" .. playerIndex)
			SobGroup_ParadeSobGroup(EH_SobName, "Player_Ships" .. playerIndex, 0)
		end
	end
	Rule_Remove("SpawnPlayerFleetInHyperspaceRule")
end


--------------------------------------------------------------------------------
-- Kills all ships placed in hyperspace by the level file.
--
function DespawnPlayerFleetInHyperspaceRule()
	HWC_trace("DespawnPlayerFleetInHyperspaceRule: Despawning fleet in hyperspace.")
	local PlayerCount = Universe_PlayerCount() - 1
	for playerIndex = 0, PlayerCount do
		local EH_SobName = "HE_Formation" .. (playerIndex + 1)
		SobGroup_Create(EH_SobName)
		local EH_SobEmpty = SobGroup_Empty(EH_SobName)
		if (EH_SobEmpty == 0) then
			SobGroup_Move(playerIndex, EH_SobName, "PointOfNoReturn")
			SobGroup_SetHealth(EH_SobName, 0)
		end
	end
	Rule_Remove("DespawnPlayerFleetInHyperspaceRule")
end
