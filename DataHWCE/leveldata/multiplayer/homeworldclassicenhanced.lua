-- this stuff needs to be here because the game will crash when testing the BIG file otherwise
-- for some reason it's not a problem when using the DATA directory instead of the BIG file
TracksNumber = 0
FleetsNumber = 0
RolesNumber = 0

function createtracktable()
	local temptable = {"Shuffle", "shuffle",}
	local indexcount = 0
	for trackindex = 1, TracksNumber do
		indexcount = trackindex * 2 + 2
		temptable[indexcount - 1] = TracksTable[trackindex][1]
		temptable[indexcount] = TracksTable[trackindex][2]
	end
	return temptable
end

function createfleettable()
	local temptable = {}
	local indexcount = 0
	for fleetindex = 1, FleetsNumber do
		indexcount = fleetindex * 2
		temptable[indexcount - 1] = FleetsTable[FleetsLabelIndex].startingfleets[fleetindex].label
		temptable[indexcount] = FleetsTable[FleetsLabelIndex].startingfleets[fleetindex].name
	end
	return temptable
end

function createroletable()
	local temptable = {}
	local indexcount = 0
	for roleindex = 1, RolesNumber do
		indexcount = roleindex * 2
		temptable[indexcount - 1] = RolesTable[roleindex].label
		temptable[indexcount] = roleindex
	end
	return temptable
end

-- load the following external files
dofilepath([[data:leveldata/multiplayer/lib/objectlist_definedroles.lua]])
dofilepath([[data:leveldata/multiplayer/lib/objectlist_rulerestrictions.lua]])
dofilepath([[data:leveldata/multiplayer/lib/objectlist_specialfleets.lua]])
dofilepath([[data:leveldata/multiplayer/lib/objectlist_techlist.lua]])
dofilepath([[data:leveldata/multiplayer/lib/objectlist_techlist.lua]])
dofilepath([[data:leveldata/multiplayer/lib/objectlist_misc.lua]])
dofilepath([[data:scripts/utilfunc.lua]])
dofilepath([[data:leveldata/multiplayer/lib/common.lua]])
dofilepath([[data:leveldata/multiplayer/lib/definedroles.lua]])
dofilepath([[data:leveldata/multiplayer/lib/bentusiroulette.lua]])
dofilepath([[data:leveldata/multiplayer/lib/specialfleets.lua]])
dofilepath([[data:leveldata/multiplayer/lib/homeworldclassic.lua]])
dofilepath([[data:leveldata/multiplayer/lib/wincondition.lua]])
dofilepath([[data:leveldata/multiplayer/lib/writestats.lua]])
dofilepath([[data:leveldata/multiplayer/lib/music.lua]])
dofilepath([[data:leveldata/multiplayer/lib/ATIdisplay.lua]])

GameRulesName = "HWC Enhanced 1.3.0"
Description = "Additional multiplayer options from the Homeworld Classic and Gameplay Enhanced mods."

Directories =
{
	Levels = "data:LevelData\\Multiplayer\\HomeworldClassic\\",
	ProfileLevels = "profiles:Levels\\HomeworldClassic\\",
--	Levels = "data:LevelData\\Multiplayer\\Deathmatch\\",
--	ProfileLevels = "profiles:Levels\\Deathmatch\\",
}

-- limit 32 options!!!
GameSetupOptions =
{
	-- resource mulitplier
	{
		name = "resources",
		locName = "$3240",
		tooltip = "$3239",
		default = 1,
		visible = 1,
		choices =
		{
			"$3241", "0.5",		-- Low
			"$3242", "1.0",		-- Standard
			"$3243", "2.0",		-- High
		},
	},
	-- unitcap option
	{
		name = "unitcaps",
		locName = "$3214",
		tooltip = "$3234",
		default = 1,
		visible = 1,
		choices =
		{
			"$3215",	"Small",	-- Low
			"$3216",	"Normal",	-- Medium
			"$3217",	"Large",	-- High
			"Off",		"Unlimited",
		},
	},
	-- starting resource option
	{
		name = "resstart",
		locName = "$3205",
		tooltip = "$3232",
		default = 0,
		visible = 1,
		choices =
		{
			"$3206", "1000",			-- Small (1000)
			"$3207", "3000",			-- Medium (3000)
			"$3208", "10000",			-- Large (10000)
--			"HW1 - Small (250)", "250",
--			"HW1 - Medium (750)", "750",
--			"HW1 - Large (2000)", "2000",
			"$3209", "0",				-- map default
			"Resourcing Disabled", "x",
		},
	},
	-- lock team option
	{
		name = "lockteams",
		locName = "$3220",
		tooltip = "$3235",
		default = 1,
		visible = 1,
		choices =
		{
			"$3221", "yes",
			"$3222", "no",
		},
	},
	-- start location option
	-- tried setting "fixed" as the default, but could not get it to work
	{
		name = "startlocation",
		locName = "$3225",
		tooltip = "$3237",
		default = 1,
		visible = 1,
		choices =
		{
			"$3226", "random",
			"$3227", "fixed",
		},
	},
	----------------------------------------------------------------------------
	-- options specific to HomeworldClassic gametype
	{
		name = "startwith",
		locName = "Start With",
		tooltip = "SELECT NORMAL, CARRIER OR CARRIER-ONLY BATTLE. SUPERCEDES \"SPECIAL FLEETS\" MODE.",
		default = 0,
		visible = 1,
		choices =
		{
			"Normal HW2",		"mothership",
			"Carrier Only",		"carrieronly",
			"HW1 Map Default",	"frommap",
		},
	},
	{
		name = "resourceinjection",
		locName = "Resource Injections",
		tooltip = "PERIODICALLY GIVE EVERYONE RESOURCES",
		default = 0,
		visible = 1,
		choices =
		{
			"Off",		0,
			"100 RUs",	100,
			"200 RUs",	200,
			"500 RUs",	500,
			"1000 RUs",	1000,
			"2000 RUs",	2000,
			"5000 RUs",	5000,
			"10000 RUs",	10000,
		},
	},
	{
		name = "resourceinjectionevery",
		locName = "...every",
		tooltip = "DURATION BETWEEN RESOURCE INJECTIONS",
		default = 0,
		visible = 1,
		choices =
		{
			"30 seconds",	30,	 	-- 30 sec
			"1 minute",	60,	 	--  1 min
			"2 minutes",	120,		--  2 min
			"5 minutes",	300,		--  5 min
			"10 minutes",	600,		-- 10 min
			"20 minutes",	1200,	  	-- 20 min
		},
	},
	{
		name = "resourcelumpsum",
		locName = "Resource Lump Sum",
		tooltip = "A SINGLE RESOURCE INJECTION",
		default = 0,
		visible = 1,
		choices =
		{
			"Off",		0,
			"500 RUs",	500,
			"1000 RUs",	1000,
			"2000 RUs",	2000,
			"5000 RUs",	5000,
			"10000 RUs",	10000,
			"20000 RUs",	20000,
		},
	},
	{
		name = "resourcelumpsumafter",
		locName = "...after",
		tooltip = "DURATION UNTIL LUMP SUM RESOURCE INJECTION",
		default = 0,
		visible = 1,
		choices =
		{
			"1 minute",	60,	 	--  1 min
			"2 minutes",	120,		--  2 min
			"5 minutes",	300,		--  5 min
			"10 minutes",	600,		-- 10 min
			"20 minutes",	1200,	  	-- 20 min
			"40 minutes",	2400,	  	-- 40 min
		},
	},
	{
		name = "bounties",
		locName = "Bounties",
		tooltip = "GRANTS AN RU BOUNTY UPON DESTROYING ENEMIES",
		default = 0,
		visible = 1,
		choices =
		{
			"Off",		0,
			"Small (15)",	15,
			"Medium (40)",	40,
			"Large (90)",	90,
		},
	},
	{
		name = "research",
		locName = "Research",
		tooltip = "ENABLE OR DISABLE RESEARCH. SUPERCEDES SPECIAL FLEETS.",
		default = 1,
		visible = 1,
		choices =
		{
			"Off",	"off",
			"On",	"on",
		},
	},
	{
		name = "crates",
		locName = "Crates",
		tooltip = "RANDOMLY SPAWNS CRATES CONTAINING SURPRISES",
		default = 0,
		visible = 1,
		choices =
		{
			"Off",			0,
			"every 1 minute",	60,	 	--  1 min
			"every 2 minutes",	120,		--  2 min
			"every 5 minutes",	300,		--  5 min
			"every 10 minutes",	600,		-- 10 min
			"every 20 minutes",	1200,	  	-- 20 min
			"every 40 minutes",	2400,	  	-- 40 min
		},
	},
	{
		name = "hyperspace",
		locName = "Hyperspace",
		tooltip = "ENABLE OR DISABLE HYPERSPACE",
		default = 1,
		visible = 1,
		choices =
		{
			"Off",	"off",
			"On",	"on",
		},
	},
	----------------------------------------------------------------------------
	-- options specific to Gameplay Enhanced gametype

	-- win condition
	{ 
		name = "wincondition", 
		locName = "Win Condition", 
		tooltip = "SELECT THE CONDITION FOR WINNING THE GAME", 
		default = 0, 
		visible = 1, 
		choices = 
		{
			"HW2 Normal",		0,
			"Kill Team Production",	1,
			"Kill All Enemy Ships",	2,
			"Destroy Mothership",	3,
			"Capture Capship",	4,
			"Quit Manually",	5,
		}, 
	}, 
	-- background music
	{ 
		name = "bgmusic", 
		locName = "Music", 
		tooltip = "SELECT THE BACKGROUND MUSIC", 
		default = 0, 
		visible = 1, 
		choices = createtracktable(),
	}, 
	-- game speed
	{
		name = "GameSpeed",
		locName = "Game Speed",
		tooltip = "CHANGE THE GAME SPEED TO A FRACTION OF ITS NORMAL VALUE",
		default = 0,
		visible = 1,
		choices =
		{
			"1×",	1.00,
			"3/4×",	0.75,
			"1/2×",	0.50,
			"1/4×",	0.25,
		},
	},
	-- Timer on/off
--	{
--		name = "timer",
--		locName = "Game Timer",
--		tooltip = "ENABLE IN-GAME TIMER",
--		default = 0,
--		visible = 1,
--		choices =
--		{
--			"Off",	0,
--			"On",	1,
--		},
--	},
--	-- Team progress on/off
--	{
--		name = "teamprogress",
--		locName = "Team Progress Meter",
--		tooltip = "SHOW TEAM BUILD/RESEARCH PROGRESS ON SCREEN",
--		default = 0,
--		visible = 1,
--		choices =
--		{
--			"Off",	0,
--			"On",	1,
--		},
--	},
--	-- Stats on/off
--	{
--		name = "enablestats",
--		locName = "Adv. Stats",
--		tooltip = "ENABLE ADVANCED STAT-LOGGING",
--		default = 0,
--		visible = 1,
--		choices =
--		{
--			"Off",	0,
--			"On",	1,
--		},
--	},
	-- Bentusi Roulette Option
	{
		name = "RouletteResearch",
		locName = "Bentusi Roulette",
		tooltip = "SELECT A NUMBER OF RESEARCH OPTIONS TO RANDOMLY GRANT OR RESTRICT",
		default = 0,
		visible = 1,
		choices =
		{
			"Off",  0,
			"1",    1,
			"2",    2,
			"3",    3,
			"4",    4,
			"5",    5,
			"6",    6,
			"7",    7,
		},
	},
	-- Jobs on/off
	{
		name = "DutiesOnOff",
		locName = "Defined Roles",
		tooltip = "ENABLE SPECIALIZED PLAYER ROLES. UNITCAPS OFF RECOMMENDED.",
		default = 0,
		visible = 1,
		choices =
		{
			"Off",	0,
			"On",	1,
		},
	},
	-- Player 1 job
	{
		name = "Duty0",
		locName = "Position 1 Role",
		tooltip = "CHOOSE THE JOB FOR PLAYER 1",
		default = 0,
		visible = 1,
		choices = createroletable(),
	},
	-- Player 2 job
	{
		name = "Duty1",
		locName = "Position 2 Role",
		tooltip = "CHOOSE THE JOB FOR PLAYER 2",
		default = 0,
		visible = 1,
		choices = createroletable(),
	},
	-- Player 3 job
	{
		name = "Duty2",
		locName = "Position 3 Role",
		tooltip = "CHOOSE THE JOB FOR PLAYER 3",
		default = 0,
		visible = 1,
		choices = createroletable(),
	},
	-- Player 4 job
	{
		name = "Duty3",
		locName = "Position 4 Role",
		tooltip = "CHOOSE THE JOB FOR PLAYER 4",
		default = 0,
		visible = 1,
		choices = createroletable(),
	},
	-- Player 5 job
	{
		name = "Duty4",
		locName = "Position 5 Role",
		tooltip = "CHOOSE THE JOB FOR PLAYER 5",
		default = 0,
		visible = 1,
		choices = createroletable(),
	},
	-- Player 6 job
	{
		name = "Duty5",
		locName = "Position 6 Role",
		tooltip = "CHOOSE THE JOB FOR PLAYER 6",
		default = 0,
		visible = 1,
		choices = createroletable(),
	},
	-- Fleets on/off
	{
		name = "FleetsOnOff",
		locName = "Special Fleets",
		tooltip = "ENABLE SPECIALIZED STARTING FLEETS",
		default = 0,
		visible = 1,
		choices =
		{
			"Off",	0,
			"On",	1,
		},
	},
	-- Player 1 starting fleet
	{
		name = "PlayerFleet0",
		locName = "Position 1 Fleet",
		tooltip = "CHOOSE THE STARTING FLEET FOR PLAYER 1",
		default = 0,
		visible = 1,
		choices = createfleettable(),
	},
	-- Player 2 starting fleet
	{
		name = "PlayerFleet1",
		locName = "Position 2 Fleet",
		tooltip = "CHOOSE THE STARTING FLEET FOR PLAYER 2",
		default = 0,
		visible = 1,
		choices = createfleettable(),
	},
	-- Player 3 starting fleet
	{
		name = "PlayerFleet2",
		locName = "Position 3 Fleet",
		tooltip = "CHOOSE THE STARTING FLEET FOR PLAYER 3",
		default = 0,
		visible = 1,
		choices = createfleettable(),
	},
	-- Player 4 starting fleet
	{
		name = "PlayerFleet3",
		locName = "Position 4 Fleet",
		tooltip = "CHOOSE THE STARTING FLEET FOR PLAYER 4",
		default = 0,
		visible = 1,
		choices = createfleettable(),
	},
	-- Player 5 starting fleet
	{
		name = "PlayerFleet4",
		locName = "Position 5 Fleet",
		tooltip = "CHOOSE THE STARTING FLEET FOR PLAYER 5",
		default = 0,
		visible = 1,
		choices = createfleettable(),
	},
	-- Player 6 starting fleet
	{
		name = "PlayerFleet5",
		locName = "Position 6 Fleet",
		tooltip = "CHOOSE THE STARTING FLEET FOR PLAYER 6",
		default = 0,
		visible = 1,
		choices = createfleettable(),
	},
}


--==============================================================================
-- Homeworld Classic variables

CRATES_ArePlayersNearUpdateTime 			= 4.0			-- bit mask to to ship near crate checking
CRATES_PlayerNearRadius 				= 800.0			-- radius in which a player must get of the crate before receiving the crate item
CRATES_MaximumCratesInTheWorldPerPlayer 		= 1			-- maximum numbr of crates that can exist in the world based on number of players in game
CRATES_ExpiryTime 					= 300.0			-- life span of crate in seconds before it expires
CRATES_RandomLowDistance, CRATES_RandomHighDistance	= 7000.0, 20000.0
CRATES_MaxRUsGiven, CRATES_MinRUsGiven			= 1000, 500

-- probabilities of getting any of these items (if less than or equal to the first value, else it moves onto the next value)
CRATES_AddACrateProb 					= 0.15
CRATES_GetMotherShipCarrierIfDontHaveOne		= 0.80
CRATES_GetAShip, CRATES_GetResearch, CRATES_GetRUs	= 0.90, 0.925, 1.00

-- crate dynamic data
CRATES_DetectPlayerIndex				= 0
CRATES_NumberCrates					= 0
CRATES_SpawnTime					= {0,0,0,0,0,0,}

-- tweakables for player bounties
BOUNTY_UpdateRate 					= 8
BOUNTY_MaxPossible					= 250
BOUNTY_ResourcesInPossesion 				= 0.35
BOUNTY_CurrentShipWorth 				= 0.70
BOUNTY_ActualRURatio					= 0.014

-- bounty dynamic data
BOUNTY_Level, BOUNTY_PlayerBounties			= 0, {1,1,1,1,1,1,}

-- counters
resourcePlayerIndex, hyperspacePlayerIndex 		= 0, 0
capturePlayerIndex, volumePositionCounter		= 0, 0

-- timers
resourceStartCountingTime, resourceStopCountingTime	= 0, 120

-- seeds used for random functions
-- they should be the only instances of the default random() function being called
CRA_Seed			= {random(763261)}
BEN_Seed			= {random(763261)}
COM_Seed			= {random(763261)}
DEF_Seed			= {random(763261)}
WIN_Seed			= {random(763261)}


--==============================================================================
-- Gameplay Enhanced variables

-- BENTUSI ROULETTE research grant and restriction messages
BEN_GrantStrings		= {{},{},{},{},{},{},}
BEN_RestrictStrings		= {{},{},{},{},{},{},}
-- SPECIAL FLEETS item messages
FLT_PlayerStrings		= {{},{},{},{},{},{},}
-- used to make DEFINED ROLES compatible with WIN CONDITION
JOB_PlayerModes			= {0,0,0,0,0,0,}
-- special messages regarding teammates with the "capital" role. pretty ugly
JOB_PlayerStrings		= {{{},{},{},{},{},{},},{{},{},{},{},{},{},},{{},{},{},{},{},{},},{{},{},{},{},{},{},},{{},{},{},{},{},{},},{{},{},{},{},{},{},},}
-- special messages for when a player is granted research by a teammate
JOB_PlayerGrantStrings		= {"","","","","","",}
-- used to keep track of which grants have already been applied
JOB_PlayerGrantItems		= {{},{},{},{},{},{},}
-- used to make HOMEWORLD CLASSIC, DEFINED ROLES, BENTUSI ROULETTE and SPECIAL FLEETS compatible with each other
Player_RestrictedResearch	= {{},{},{},{},{},{},}
Player_GrantedResearch		= {{},{},{},{},{},{},}
Player_RestrictedBuilds		= {{},{},{},{},{},{},}
Player_GrantedBuilds		= {{},{},{},{},{},{},}
Player_Races			= {}

--==============================================================================
-- game entry point
--
function OnInit()
	
	-- add this rule
	Rule_Add("MainRule")

	-- setup ATI messages
	Rule_Add("ATI_init")

	--======================================================================
	-- Homeworld Classic rules

	local PlayerCount = Universe_PlayerCount() - 1
--	local WinCondition = GetGameSettingAsString("wincondition")	-- defer to Gameplay Enhanced version of this script instead
	local StartWith = GetGameSettingAsString("startwith")
	local ResearchMode = GetGameSettingAsString("research")
	local HyperspaceMode = GetGameSettingAsString("hyperspace")
	local CratesMode = GetGameSettingAsNumber("crates")
	local ResourceMode = GetGameSettingAsString("resstart")
	local ResourceInjectionAmount = GetGameSettingAsNumber("resourceinjection")
	local ResourceInjectionTime = GetGameSettingAsNumber("resourceinjectionevery")
	local ResourceLumpSumAmount = GetGameSettingAsNumber("resourcelumpsum")
	local ResourceLumpSumTime = GetGameSettingAsNumber("resourcelumpsumafter")
	local BackgroundMusic = GetGameSettingAsString("bgmusic")
	local GameSpeed = GetGameSettingAsNumber("GameSpeed")
	local SpecialFleets = GetGameSettingAsNumber("FleetsOnOff")
	local DefinedRoles = GetGameSettingAsNumber("DutiesOnOff")
	local BentusiRoulette = GetGameSettingAsNumber("RouletteResearch")
	local WinCondition = GetGameSettingAsNumber("wincondition")
	--local AdvStats = GetGameSettingAsNumber("enablestats")
	--local TimerOnOff = GetGameSettingAsNumber("timer")
	--local TeamProgress = GetGameSettingAsNumber("teamprogress")
	BOUNTY_Level = GetGameSettingAsNumber("bounties")
	CRATES_DoWeNeedToAddCratesCheckTime = CratesMode	-- crates tweakables from Homeworld 1's crates.script. Check to see if add crates every x seconds.

	-- setup per-gamerule build/research restrictions
	print("HWC: Setting up per-gamerule build/research restrictions.")
	for playerIndex = 0, PlayerCount do
		local sRace = RacesList[Player_GetRace(playerIndex)]
		Player_Races[playerIndex + 1] = sRace
		Player_RestrictedResearch[playerIndex + 1][sRace] = {}
		Player_RestrictedBuilds[playerIndex + 1][sRace] = {}
		Player_GrantedResearch[playerIndex + 1][sRace] = {}
		Player_GrantedBuilds[playerIndex + 1][sRace] = {}
		DisableListOfBuilds(playerIndex, sRace, RestrictedBy.MPRestrict[sRace].build)
		DisableListOfResearch(playerIndex, sRace, RestrictedBy.MPRestrict[sRace].research)
		if (ResourceMode == "x") then
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.ResourceOff[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.ResourceOff[sRace].research)
		else
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.ResourceOn[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.ResourceOn[sRace].research)
		end
		if (HyperspaceMode == "off") then
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.HyperspaceOff[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.HyperspaceOff[sRace].research)
		else
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.HyperspaceOn[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.HyperspaceOn[sRace].research)
		end
		if (ResearchMode == "off") then
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.ResearchOff[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.ResearchOff[sRace].research)
		else
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.ResearchOn[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.ResearchOn[sRace].research)
		end
		if (StartWith == "mothership") then
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.StartWithMothership[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.StartWithMothership[sRace].research)
		elseif (StartWith == "carrieronly") then
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.StartWithCarrierOnly[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.StartWithCarrierOnly[sRace].research)
		elseif (StartWith == "frommap") then
			DisableListOfBuilds(playerIndex, sRace, RestrictedBy.StartWithMapDefault[sRace].build)
			DisableListOfResearch(playerIndex, sRace, RestrictedBy.StartWithMapDefault[sRace].research)
		end
		for j = 1, getn(RestrictedBy.motherships[sRace].build) do
			local jMothership = RestrictedBy.motherships[sRace].build[j]
			tinsert(Player_RestrictedBuilds[playerIndex + 1][sRace], jMothership)
		end
	end

	-- setup resource injections
	if (ResourceInjectionAmount > 0) then
		print("HWC: RESOURCE INJECTIONS of " .. ResourceInjectionAmount .. " RUs every " .. ResourceInjectionTime .. " seconds.")
		Rule_AddInterval("ResourceInjectionRule", ResourceInjectionTime)
	end

	-- setup lump sum resource injection
	if (ResourceLumpSumAmount > 0) then
		print("HWC: LUMP SUM RESOURCE INJECTION of " .. ResourceLumpSumAmount .. " RUs after " .. ResourceLumpSumTime .. " seconds.")
		Rule_AddInterval("ResourceLumpSumRule", ResourceLumpSumTime)
	end

	-- setup the "Resourcing Disabled" option
	if (ResourceMode == "x") then
		print("HWC: RESOURCING disabled.")
		SobGroup_Create("ResourcersToDestroy")
		resourceStartCountingTime = Universe_GameTime()
		Rule_AddInterval("DestroyResourcersRule", 1)
	end

	-- setup the "Start With" game modes
	if (StartWith == "mothership") then
		print("HWC: Setting up mothership battle.")
		if (ResearchMode == "off") then
			SetStartFleetSuffix("_nores")
		else
			SetStartFleetSuffix("")
		end
		Rule_Add("DespawnPlayerFleetInHyperspaceRule")
	elseif (StartWith == "carrieronly") then
		print("HWC: Setting up carrier battle.")
		if (SpecialFleets == 0) then
			if (ResearchMode == "off") then
				SetStartFleetSuffix("_carrieronly_nores")
			else
				SetStartFleetSuffix("_carrieronly")
			end
		end
		Rule_Add("DespawnPlayerFleetInHyperspaceRule")
	elseif (StartWith == "frommap") then
		print("HWC: Setting up HW1 map default battle.")
		SetStartFleetSuffix("_frommap")
		Rule_Add("SpawnPlayerFleetInHyperspaceRule")
	end

	-- setup the "no research" game mode
	if (ResearchMode == "off") then
		print("HWC: RESEARCH disabled.")
		-- allow time for mothership to come out of hyperspace (was 15 seconds)
		Rule_AddInterval("GrantAllResearchRule", 1)
	end

	-- setup the "no hyperspace" game mode
	if (HyperspaceMode == "off") then
		print("HWC: HYPERSPACE disabled.")
		-- too slow
--		Rule_AddInterval("DisableHyperspaceRule", 1)
	end

	-- setup the "crates" game mode
	if (CratesMode > 0) then
		print("HWC: CRATES enabled.")
		SobGroup_Create("CrateMothership")
		-- prevent telling stutter when first crate spawned
		Preload_Ship("Meg_Crate")

		-- create empty crate SobGroups. There can only be a max of 1 crate per player.
		for playerIndex = 0, PlayerCount do
			SobGroup_Create("CrateSpawnGroup" .. playerIndex)
		end

		Rule_AddInterval("SpawnCratesRule", CRATES_DoWeNeedToAddCratesCheckTime)
		Rule_AddInterval("CheckCratesRule", CRATES_ArePlayersNearUpdateTime)
	end

	-- setup for bounties
	if (BOUNTY_Level > 0) then
		print("HWC: BOUNTIES enabled.")
		SobGroup_Create("BountyCounterGroup")
		Rule_AddInterval("UpdateBountyStats", BOUNTY_UpdateRate)
	end

	--======================================================================
	-- Gameplay Enhanced rules

	-- setup background music
	if (BackgroundMusic == "shuffle") then
		Rule_Add("RandomMusicRule")
	else
		Rule_Add("PlayMusicRule")
	end

	-- setup game speed
	if (GameSpeed ~= 1) then
		print("GPE: Changing the game speed to " .. GameSpeed .. " times the normal value.")
		Universe_SlowDown(GetGameSettingAsNumber("GameSpeed"), 20)
	end

	-- setup special fleets. needs to come before defined roles
	if (SpecialFleets == 1) then
		if (StartWith == "mothership") or (StartWith == "carrieronly") then
			print("GPE: SPECIAL FLEETS enabled.")
			SetStartFleetSuffix("_frommap")
			Rule_Add("SpecialFleets_Init")
		else
			print("GPE: Disabling SPECIAL FLEETS. START WITH must be set to NORMAL or CARRIER ONLY.")
			Subtitle_Message("Disabling SPECIAL FLEETS. START WITH must be set to NORMAL or CARRIER ONLY.", 4)
		end
	end

	-- setup defined roles. needs to come before bentusi roulette
	if (DefinedRoles == 1) then
		print("GPE: DEFINED ROLES enabled.")
		Rule_Add("DefinedRoles_Init")
	end

	-- setup bentusi roulette
	if (BentusiRoulette ~= 0) then
		print("GPE: BENTUSI ROULETTE enabled.")
		Rule_Add("BentusiRoulette_Init")
	end

	-- setup win condition. needs to come very last
	if (WinCondition == 0) then
		print("GPE: WIN CONDITION set to kill player production ships.")
		Rule_AddInterval("CheckPlayerProductionShipsLeftRule", 1)
	elseif (WinCondition == 1) then
		print("GPE: WIN CONDITION set to kill team production ships.")
		Rule_AddInterval("CheckTeamProductionShipsLeftRule", 1)
	elseif (WinCondition == 2) then
		print("GPE: WIN CONDITION set to kill all ships.")
		Rule_AddInterval("CheckTeamAnyShipsLeftRule", 1)
	elseif (WinCondition == 3) then
		if (StartWith == "mothership") then
			print("HWC: Destroy mothership WIN CONDITION enabled.")
			Rule_AddInterval("CheckMothershipDeadRule", 1)
		else
			print("HWC: Destroy mothership WIN CONDITION is incompatible with carrier battles and HW2 Map Default. HW2 normal WIN CONDITION enabled, instead.")
			Rule_AddInterval("CheckPlayerProductionShipsLeftRule", 1)
		end
	elseif (WinCondition == 4) then
		print("HWC: Capture cap ship WIN CONDITION enabled.")
		for playerIndex = 0, PlayerCount do
			local CaptureGroupName = "captureGroup_" .. playerIndex
			SobGroup_Create(CaptureGroupName)
			SobGroup_SetSwitchOwnerFlag(CaptureGroupName, 0)
		end
		Rule_AddInterval("CheckCaptureStatusRule", 1)
	end
end


--------------------------------------------------------------------------------
-- Ends the game if there are no more live opponents.
--
function MainRule()
	local numAlive, numEnemies, gameOver = 0, 0, 1
	
	-- for each player...
	for playerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the player is alive...
		if (Player_IsAlive(playerIndex) == 1) then
			-- compare the player against all other players
			local otherPlayerIndex = 0
			for otherPlayerIndex = 0, (Universe_PlayerCount() - 1) do
				-- check to see if the players are enemies
				if (AreAllied(playerIndex, otherPlayerIndex) == 0) then
					-- check to see if the other player is still alive, else the game is over
					if (Player_IsAlive(otherPlayerIndex) == 1) then
						gameOver = 0
					else
						numEnemies = numEnemies + 1
					end
				end
			end
			numAlive = numAlive + 1
		end
	end
		
	-- special case - if there are no enemies then never end
	if ((numEnemies == 0) and (numAlive > 0)) then
		gameOver = 0
	end
	
	-- if gameOver flag is still set then the game is OVER
	if (gameOver == 1) then
		-- causes the game to drop to desktop due to HW2Path() function
		--if (AdvStats == 1) then
		--	WriteStats()
		--end
		Rule_Add("waitForEnd")
		Event_Start("endGame")
		Rule_Remove("MainRule")
	end
end


--------------------------------------------------------------------------------
--
--
function waitForEnd()
	if (Event_IsDone("endGame")) then
		setGameOver()
		Rule_Remove("waitForEnd")
	end
end


--==============================================================================
-- Create the Events table. The name of this table must always be Events (this is what the game looks for).
--
Events =
{
	endGame =
	{
		{
			{"wID = Wait_Start(5)", "Wait_End(wID)",},
		},
	},
}
