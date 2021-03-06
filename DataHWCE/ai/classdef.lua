-- Pretty-Printed using HW2 Pretty-Printer 1.27 by Mikail.
--																																															
-- classdef.lua
--
-- This file only contains ship classfication lists that allow the AI script writer to seperate each ship
-- into different subclasses (fighters, corvettes, anti-fighter, fast, slow,...) This is done to make it easier
-- (and faster) to refer to a ship based on its generalized properties.
--
-- Custom classes can be added at the end but have to be added in a very specific way.
-- 
aitrace("CPU: CLASSDEF LOADED")
-- table of all squadron class lists
squadclass = {}
-- is mothership

squadclass[eMotherShip] = 
{
	HGN_MOTHERSHIP,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
}

-- can harvest

squadclass[eCollector] = 
{
	HGN_RESOURCECOLLECTOR,
	VGR_RESOURCECOLLECTOR,
}

-- is a good scout/explorer

squadclass[eScout] = 
{
	HGN_SCOUT,
	HGN_PROBE,
	HGN_PROXIMITYSENSOR,
	HGN_ECMPROBE,
	VGR_SCOUT,
	VGR_PROBE,
	VGR_PROBE_PROX,
	VGR_PROBE_ECM,
}

-- is a refinery

squadclass[eRefinery] = 
{
	HGN_RESOURCECONTROLLER,
	VGR_RESOURCECONTROLLER,
}

-- can build ships

squadclass[eBuilder] = 
{
	HGN_MOTHERSHIP,
	HGN_CARRIER,
	-- will need subsystem
	HGN_SHIPYARD,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_CARRIER,
	-- will need subsystem
	VGR_SHIPYARD,
	VGR_COMMSTATION_HWC,
	VGR_PRISONSTATION_HWC,
}

-- can be used as a resource dropoff

squadclass[eDropOff] = 
{
	HGN_MOTHERSHIP,
	HGN_CARRIER,
	-- will need subsystem
	HGN_SHIPYARD,
	HGN_RESOURCECONTROLLER,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_CARRIER,
	-- will need subsystem
	VGR_SHIPYARD,
	VGR_RESOURCECONTROLLER,
	VGR_COMMSTATION_HWC,
	VGR_PRISONSTATION_HWC,
}

-- can be used as a salvage dropoff

squadclass[eSalvageDropOff] = 
{
	HGN_MOTHERSHIP,
	HGN_CARRIER,
	HGN_SHIPYARD,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_CARRIER,
	VGR_SHIPYARD,
}

-- is a fighter

squadclass[eFighter] = 
{
	HGN_INTERCEPTOR,
	HGN_ATTACKBOMBER,
	HGN_ATTACKBOMBERELITE,
	VGR_INTERCEPTOR,
	VGR_BOMBER,
	VGR_LANCEFIGHTER,
	KPR_ATTACKDROID,
	KPR_ATTACKDROID_HWC,
}

-- is a corvette

squadclass[eCorvette] = 
{
	HGN_ASSAULTCORVETTE,
	HGN_PULSARCORVETTE,
	HGN_MINELAYERCORVETTE,
	VGR_MISSILECORVETTE,
	VGR_LASERCORVETTE,
	VGR_MINELAYERCORVETTE,
	VGR_COMMANDCORVETTE,
	KPR_MOVER,
}

-- is a frigate

squadclass[eFrigate] = 
{
	HGN_ASSAULTFRIGATE,
	HGN_DEFENSEFIELDFRIGATE,
	HGN_IONCANNONFRIGATE,
	HGN_MARINEFRIGATE,
	HGN_MARINEFRIGATE_SOBAN,
	HGN_TORPEDOFRIGATE,
	HGN_TORPEDOFRIGATEELITE,
	VGR_ASSAULTFRIGATE,
	VGR_HEAVYMISSILEFRIGATE,
	VGR_INFILTRATORFRIGATE,
}

-- can capture other ships

squadclass[eCapture] = 
{
	HGN_MARINEFRIGATE,
	HGN_MARINEFRIGATE_SOBAN,
	VGR_INFILTRATORFRIGATE,
}

-- has shields

squadclass[eShield] = 
{
	HGN_DEFENSEFIELDFRIGATE,
}

-- is a platform

squadclass[ePlatform] = 
{
	HGN_GUNTURRET,
	HGN_IONTURRET,
	VGR_WEAPONPLATFORM_GUN,
	VGR_WEAPONPLATFORM_MISSILE,
	VGR_HYPERSPACE_PLATFORM,
}

-- good at attacking fighters

squadclass[eAntiFighter] = 
{
	HGN_INTERCEPTOR,
	HGN_ASSAULTCORVETTE,
	HGN_ASSAULTFRIGATE,
	HGN_GUNTURRET,
	VGR_INTERCEPTOR,
	VGR_ASSAULTFRIGATE,
	VGR_WEAPONPLATFORM_GUN,
	KPR_ATTACKDROID,
	KPR_DESTROYER,
	KPR_ATTACKDROID_HWC,
	KPR_DESTROYER_HWC,
}

-- good at killing corvettes

squadclass[eAntiCorvette] = 
{
	HGN_PULSARCORVETTE,
	HGN_TORPEDOFRIGATE,
	HGN_TORPEDOFRIGATEELITE,
	HGN_DESTROYER,
	VGR_LANCEFIGHTER,
	VGR_LAZERCORVETTE,
	VGR_DESTROYER,
	KPR_DESTROYER,
	KPR_DESTROYERM10,
	KPR_ATTACKDROID,
	KPR_MOVER,
	KPR_ATTACKDROID_HWC,
	KPR_DESTROYER_HWC,
}

-- good at killing frigates

squadclass[eAntiFrigate] = 
{
	HGN_IONTURRET,
	HGN_ATTACKBOMBER,
	HGN_ATTACKBOMBERELITE,
	HGN_IONCANNONFRIGATE,
	HGN_MARINEFRIGATE,
	HGN_MARINEFRIGATE_SOBAN,
	HGN_DEFENSEFIELDFRIGATE,
	HGN_DESTROYER,
	HGN_BATTLECRUISER,
	VGR_BOMBER,
	VGR_HEAVYMISSILEFRIGATE,
	VGR_INFILTRATORFRIGATE,
	VGR_DESTROYER,
	VGR_BATTLECRUISER,
	VGR_WEAPONPLATFORM_MISSILE,
	KPR_DESTROYER,
	KPR_DESTROYERM10,
	KPR_MOVER,
	KPR_SAJUUK,
	KPR_SAJUUK_HWC,
	KPR_DESTROYER_HWC,
}

-- is a capital ship

squadclass[eCapital] = 
{
	HGN_CARRIER,
	HGN_MOTHERSHIP,
	HGN_SHIPYARD,
	HGN_DESTROYER,
	HGN_BATTLECRUISER,
	HGN_DREADNAUGHT,
	VGR_CARRIER,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_SHIPYARD,
	VGR_DESTROYER,
	VGR_BATTLECRUISER,
	KPR_DESTROYER_HWC,
	KPR_SAJUUK_HWC,
	VGR_COMMSTATION_HWC,
	VGR_PRISONSTATION_HWC,
}

-- eCollector + eScout (maybe refineries - but those things are pretty tough?)
-- this is currently only used to count the number of 'military units' the player/enemy has

squadclass[eNonThreat] = 
{
	HGN_RESOURCECOLLECTOR,
	VGR_RESOURCECOLLECTOR,
	HGN_RESOURCECONTROLLER,
	VGR_RESOURCECONTROLLER,
	HGN_CARRIER,
	HGN_MOTHERSHIP,
	HGN_SHIPYARD,
	VGR_CARRIER,
	VGR_MOTHERSHIP,
	VGR_MOTHERSHIP_MAKAAN,
	VGR_SHIPYARD,
	HGN_SCOUT,
	HGN_PROBE,
	HGN_PROXIMITYSENSOR,
	HGN_ECMPROBE,
	VGR_SCOUT,
	VGR_PROBE,
	VGR_PROBE_PROX,
	VGR_PROBE_ECM,
	VGR_HYPERSPACE_PLATFORM,
	VGR_COMMSTATION,
	VGR_PRISONSTATION,
	VGR_COMMSTATION_HWC,
	VGR_PRISONSTATION_HWC,
}

-- is a hyperspace gate

squadclass[eHyperspaceGate] = 
{
	VGR_HYPERSPACE_PLATFORM,
}

-- good at killing subsystems

squadclass[eSubSystemAttackers] = 
{
	HGN_ATTACKBOMBER,
	HGN_ATTACKBOMBERELITE,
	VGR_BOMBER,
	KPR_ATTACKDROID,
	KPR_ATTACKDROID_HWC,
}

-- non critical subsystems

squadclass[eNonCriticalSubSys] = 
{
	CLOAKGENERATOR,
	FIRECONTROLTOWER,
	ADVANCEDARRAY,
	CLOAKSENSOR,
}

-- good at killing repairing collectors

squadclass[eGoodRepairAttackers] = 
{
	HGN_INTERCEPTOR,
	HGN_ASSAULTFRIGATE,
	HGN_IONCANNONFRIGATE,
	HGN_DESTROYER,
	HGN_BATTLECRUISER,
	VGR_INTERCEPTOR,
	VGR_MISSILECORVETTE,
	VGR_ASSAULTFRIGATE,
	VGR_DESTROYER,
	VGR_BATTLECRUISER,
	KPR_ATTACKDROID,
	KPR_MOVER,
	KPR_DESTROYER,
	KPR_DESTROYERM10,
	KPR_SAJUUK_HWC,
	KPR_ATTACKDROID_HWC,
	KPR_DESTROYER_HWC,
	KPR_SAJUUK_HWC,
}

-------------------------------------------
-- CUSTOM classes
-- eMaxCount equals 22; do not exceed eMaxUserCount (equals 32)
eUselessShips = eMaxCount
eBattleCruiser = eMaxCount + 1

eATTACKBOMBER			= eMaxCount + 2
eHGN_ATTACKBOMBER		= eATTACKBOMBER
eVGR_BOMBER			= eATTACKBOMBER
eHGN_ASSAULTFRIGATE		= eMaxCount + 3
eHGN_TORPEDOFRIGATE		= eHGN_ASSAULTFRIGATE
eWEAPONPLATFORM_GUN		= eMaxCount + 4
eWEAPONPLATFORM_ION		= eMaxCount + 5
eHGN_IONTURRET			= eWEAPONPLATFORM_ION
eVGR_WEAPONPLATFORM_MISSILE	= eWEAPONPLATFORM_ION
eHGN_GUNTURRET			= eWEAPONPLATFORM_GUN
eVGR_WEAPONPLATFORM_GUN		= eWEAPONPLATFORM_GUN
eHGN_INTERCEPTOR		= eMaxCount + 6
eHGN_ASSAULTCORVETTE		= eMaxCount + 7
eHGN_PULSARCORVETTE		= eMaxCount + 8
eHGN_IONCANNONFRIGATE		= eMaxCount + 9

-- this number should be one greater then the highest class
sg_maxClasses			= eMaxCount + 10

-- ships that the AI should not build because they are not used properly
squadclass[eUselessShips] = 
{
	HGN_MINELAYERCORVETTE,
	VGR_MINELAYERCORVETTE,
	VGR_COMMANDCORVETTE,
}

-- is a battlecruiser
squadclass[eBattleCruiser] = 
{
	HGN_BATTLECRUISER,
	VGR_BATTLECRUISER,
	KPR_SAJUUK,
	KPR_SAJUUK_HWC,
}

-- had to add classes for each shiptype in order for DEFINED ROLES to work properly... sucks, I know :(
-- exceeded eMaxUserCount!!! Ooops!!! Have to consolidate a few... Hope it works!!!
--squadclass[eHGN_ATTACKBOMBER] = {HGN_ATTACKBOMBER,HGN_ATTACKBOMBERELITE,}
--squadclass[eVGR_BOMBER] = {VGR_BOMBER,}
--squadclass[eHGN_ASSAULTFRIGATE] = {HGN_ASSAULTFRIGATE,}
--squadclass[eHGN_TORPEDOFRIGATE] = {HGN_TORPEDOFRIGATE,}
--squadclass[eHGN_GUNTURRET] = {HGN_GUNTURRET,}
--squadclass[eHGN_IONTURRET] = {HGN_IONTURRET,}
--squadclass[eVGR_WEAPONPLATFORM_GUN] = {VGR_WEAPONPLATFORM_GUN,}
--squadclass[eVGR_WEAPONPLATFORM_MISSILE] = {VGR_WEAPONPLATFORM_MISSILE,}
--squadclass[eHGN_INTERCEPTOR] = {HGN_INTERCEPTOR,}
--squadclass[eHGN_ASSAULTCORVETTE] = {HGN_ASSAULTCORVETTE,}
--squadclass[eHGN_PULSARCORVETTE] = {HGN_PULSARCORVETTE,}
--squadclass[eHGN_IONCANNONFRIGATE] = {HGN_IONCANNONFRIGATE,}

squadclass[eATTACKBOMBER] = {HGN_ATTACKBOMBER,HGN_ATTACKBOMBERELITE,VGR_BOMBER,}
squadclass[eHGN_ASSAULTFRIGATE] = {HGN_ASSAULTFRIGATE,HGN_TORPEDOFRIGATE,}
squadclass[eWEAPONPLATFORM_ION] = {HGN_IONTURRET,VGR_WEAPONPLATFORM_MISSILE,}
squadclass[eWEAPONPLATFORM_GUN] = {HGN_GUNTURRET,VGR_WEAPONPLATFORM_GUN,}
squadclass[eHGN_INTERCEPTOR] = {HGN_INTERCEPTOR,}
squadclass[eHGN_ASSAULTCORVETTE] = {HGN_ASSAULTCORVETTE,}
squadclass[eHGN_PULSARCORVETTE] = {HGN_PULSARCORVETTE,}
squadclass[eHGN_IONCANNONFRIGATE] = {HGN_IONCANNONFRIGATE,}


--
-- FUNCTIONS TO ADD SQUADRON TYPES TO CLASS SYSTEM
--

function FastAddToClass(tbl, classid)	
	for a, b in tbl do	
		AddToClass(b, classid)
	end
end

function ClassInitialize()	
	for i = 0, sg_maxClasses do	
		if (squadclass[i]) then	
			FastAddToClass(squadclass[i], i)
		end
	end
	-- debug: name all the classes to be displayed on screen
	AddClassName(eMotherShip, "Motherships")
	AddClassName(eCollector, "Collectors")
	AddClassName(eDropOff, "DropOffs")
	AddClassName(eFighter, "Fighters")
	AddClassName(eFrigate, "Frigates")
	AddClassName(eCorvette, "Corvettes")
	AddClassName(eCapital, "Capital")
	AddClassName(eAntiFighter, "AntiFighter")
	AddClassName(eAntiCorvette, "AntiCorvette")
	AddClassName(eAntiFrigate, "AntiFrigate")
	AddClassName(ePlatform, "Platform")
	AddClassName(eRefinery, "Refinery")
	AddClassName(eHyperspaceGate, "HypGates")
	AddClassName(eShield, "Shields")
	AddClassName(eCapture, "Capture")
	AddClassName(eSubSystemAttackers, "SubSysKillas")
	AddClassName(eBattleCruiser, "BattleCruiser")
end
