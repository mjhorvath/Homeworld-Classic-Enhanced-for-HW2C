-- Pretty-Printed using HW2 Pretty-Printer 1.27 by Mikail.
-- CpuBuild_Resourcing.lua																																																		
--
--  This file is responsible for determining what the CPU player should be building (ships and subsystems) in regards to resourcing
--  
aitrace("LOADING CPU RESOURCING")

function CpuResource_Init()	
	-- initialise the resourcers per path, used in code
	-- this is the number of collectors each dock path can handle,
	-- so a carrier with 2 paths can handle twice this number of collectors
	cpResourcersPerPath = 3.5
	-- initialise the resourcers per resource latch point on a resource
	cpNumCollectorsPerLatchPoint = 2
	-- distances for assessing threats to a resource blob
	-- ships that are closer than this get all of their value added to the calculation
	cpMaxThreatAddedDistance = 6000
	-- ships that are between max and this get their value reduced, down to 0 at this value
	cpMinThreatAddedDistance = 12000
	-- anything beyond is ignored
	-- set the path used by collectors, code needs this to count up the paths on a refinery
	SetResourceDockFamily("Utility")
	sg_minNumCollectors = 5
	sg_maxNumCollectors = 30
	-- based on unitcap and number of RUs on map
	-- should be getGameMaxUnitCaps()/4
	if (Override_ResourceInit) then	
		Override_ResourceInit()
	end
end

function CalcDesiredNumCollectors()	
	-- the number of collectors we want is based on the number of active resource
	-- slots in the level and then capped based on military, threat level and how
	-- much money we have in the bank
	-- balance building collectors with military
	-- first get some numbers based on difficulty
	local baseCollectors = 8 * s_numAlliesToCount
	local collectorsToMilitary = 0.8
	if (g_LOD == 0) then	
		-- EASY
		baseCollectors = 3 * s_numAlliesToCount
		collectorsToMilitary = 0.6
	elseif (g_LOD == 1) then	
		-- MEDIUM
		baseCollectors = 6 * s_numAlliesToCount
		collectorsToMilitary = 0.7
	elseif (g_LOD >= 2) then	
		-- HARD
		baseCollectors = 8 * s_numAlliesToCount
		collectorsToMilitary = 0.8
	end
	-- now calculate the max collectors to have based on our military
	local maxCollectorsForMilitary = baseCollectors
	if (s_militaryPop > 0) then	
		maxCollectorsForMilitary = maxCollectorsForMilitary + (s_militaryPop * collectorsToMilitary * s_numAlliesToCount)
	end
	-- increase the demand
	sg_desiredNumCollectors = GetActiveCollectorSlots() * cpNumCollectorsPerLatchPoint + 2
	-- reduce need for collectors as stored RUs increase
	local numRU = GetRU()
	if (numRU > 1000) then	
		sg_desiredNumCollectors = sg_desiredNumCollectors - ((numRU - 1000) / 1000)
	end
	-- min cap
	if (sg_desiredNumCollectors < baseCollectors) then	
		sg_desiredNumCollectors = baseCollectors
	end
	-- max cap
	if (sg_desiredNumCollectors >= maxCollectorsForMilitary) then	
		sg_desiredNumCollectors = maxCollectorsForMilitary
	end
	-- We also work out how often to try to build collectors.
	-- As we get more and more collectors we slow down the process of building more.
	local collectorsInSystem = numQueueOfClass(eCollector)
	if (DefinedRolesActivated == 1) then
		collectorsInSystem = PlayersUnitTypeCount(player_ally, player_total, eCollector)
	end
	if (collectorsInSystem > 20) then	
		sg_militaryToBuildPerCollector = 4
	elseif (collectorsInSystem > 16) then	
		sg_militaryToBuildPerCollector = 3
	elseif (collectorsInSystem > 12) then	
		sg_militaryToBuildPerCollector = 2
	elseif (collectorsInSystem > 9) then	
		sg_militaryToBuildPerCollector = 1
	else
		sg_militaryToBuildPerCollector = 0
	end
	-- if we're under attack cap the collector demand down to a minimum
	local threatLevel = UnderAttackThreat()
	if (threatLevel > 0) then	
		-- if we have money in the bank then kill all demand for collectors
		if (numRU > 1500) then	
			sg_desiredNumCollectors = 0
		else
			-- not enough cash to ignore collector building, but we want to concentrate more on military
			sg_militaryToBuildPerCollector = sg_militaryToBuildPerCollector + ((threatLevel / 50) + 1)
		end
	end
	-- if we are not 
	-- final step in working out how many collectors we want is to cap the number to an overall maximum
	if (sg_desiredNumCollectors > sg_maxNumCollectors) then	
		sg_desiredNumCollectors = sg_maxNumCollectors
	end
	--aitrace("CalcDesiredNumCollectors: sg_desiredNumCollectors:"..sg_desiredNumCollectors.." sg_militaryToBuildPerCollector:"..sg_militaryToBuildPerCollector)
end

function DoResourceBuild()
	aitrace("**DoResourceBuild")
	-- num collectors to num dropoffs to num military
	-- determine num collectors we want first based on military and dropoffs
	CalcDesiredNumCollectors()
	-- use class type incase we control other races collectors (or designers add more types of collectors, please god no :)
	local numCollectors = numQueueOfClass(eCollector)
	if (DefinedRolesActivated == 1) then
		numCollectors = PlayersUnitTypeCount(player_ally, player_total, eCollector)
	end
	if (numCollectors < sg_desiredNumCollectors and CanBuild(kCollector) == 1) then	
		aitrace("**DoResourceBuild: sg_desiredNumCollectors:" .. sg_desiredNumCollectors .. " numCollectors:" .. numCollectors)
		Build(kCollector)
		return
		1
	end
-- issue: the CPU can't count teammates' idle refineries or blob stuff
	local idleRefineries = GetNumberOfIdleRefineries()
	if (DefinedRolesActivated == 1) then
		idleRefineries = 0
	end
	-- only try to build more refineries if there are no idle ones
	if (idleRefineries <= 0) then
		-- work out how many blobs there are with too few refineries
		local numberOfActiveBlobs = GetActiveBlobCount()
		local neededRefineries = 0
		local neededSalvageDropOffs = 0
		for activeIndex = 0, (numberOfActiveBlobs - 1) do	
			local blobIndex = GetActiveBlobAt(activeIndex)
			local collectors = CollectorsAtBlob(blobIndex)
			local refineryCapacity = CollectorCapacityOfRefineriesAtBlob(blobIndex)
			-- if there are more collectors than the refineries at the blob can handle
			if (collectors > refineryCapacity) then	
				-- increment the correct total
				if (IsSalvage(blobIndex) ~= 0) then	
					neededSalvageDropOffs = neededSalvageDropOffs + 1
				else
					neededRefineries = neededRefineries + 1
				end
			end
		end
		-- if AI is under attack do not request for the following ships
		if (UnderAttackThreat() >  - 75) then	
			return
			0
		end
		-- make sure not build more than one refinery at the same time
		local numRefineriesQueued = numQueueOfClass(eDropOff) - numActiveOfClass(s_playerIndex, eDropOff)
		-- was there any demand for refineries?
		if (neededRefineries > 0 and numRefineriesQueued == 0) then	
			-- set demand to the number of needy blobs
			ShipDemandAddByClass(eRefinery, neededRefineries)
		end
		-- make sure not build more than one salvage dropoff at the same time
		local numSalDropsQueued = numQueueOfClass(eSalvageDropOff) - numActiveOfClass(s_playerIndex, eSalvageDropOff)
		-- was there any demand for salvage drop offs?
		if (neededSalvageDropOffs > 0 and numSalDropsQueued == 0) then	
			-- set demand to the number of needy blobs
			ShipDemandAddByClass(eSalvageDropOff, neededSalvageDropOffs)
		end
	end
	return
	0
end

