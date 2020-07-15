if not (RUsRatio) then			RUsRatio = 1			end
if not (PebRatio) then			PebRatio = 3/4			end
if not (RUScale) then			RUScale = 2 * 700 / 575		end
if not (MapScale) then			MapScale = 161 / 325 * 3/4		end
if not (UniverseScale) then		UniverseScale = 1.2		end
if not (MinSensorsZoomOverride) then	MinSensorsZoomOverride = 12000	end
if not (MaxSensorsZoomOverride) then	MaxSensorsZoomOverride = 100000	end
if not (AdvancedGameRule) then		AdvancedGameRule = 1		end
if not (my_seed) then			my_seed = {763261}		end

dofilepath("data:scripts/utilfunc.lua")

CountLPs, CountRUs, CountLoops, PebCount = 0, 0, 0, 0
PebNumo, PebDeno = decimal_to_fraction(PebRatio)
debug_objects = 0

--------------------------------------------------------------------------------
-- Map Conversion Data

-- RU conversion table
RUTable =
{
	-- hw1: 11, 25, 40, 100, 400
	-- hwc: 0, 160, 720, 2600, 7920
	-- mod: 100, 100, 100, 100, 100
	-- hw2: 0, 0, 9000, 18000, 40000
	-- hwcasteroid_1 has no latch points
	-- need a fifth asteroid model
	asteroid0 = {"hwcasteroid_2",	15,	3000,},
	asteroid1 = {"hwcasteroid_2",	25,	5000,},
	asteroid2 = {"hwcasteroid_2",	40,	8000,},
	asteroid3 = {"hwcasteroid_3",	100,	20000,},
	asteroid4 = {"hwcasteroid_4",	400,	80000,},
	-- hw1: 50, 108, 250, 700, ???
	-- hwc: 50, 108, 250, 700, ???
	dustcloud0 = {"hwcasteroid_2",	50,	10000,},
	dustcloud1 = {"hwcasteroid_3",	108,	21600,},
	dustcloud2 = {"hwcasteroid_3",	250,	50000,},
	dustcloud3 = {"hwcasteroid_4",	700,	140000,},
	dustcloud4 = {"hwcasteroid_4",	1500,	300000,},
	-- hw1: 100, 100, 100, 100
	-- hwc: 100, 100, 100, 100
	nebula0 = {"hwcasteroid_3",	100,	20000,},
	nebula1 = {"hwcasteroid_3",	100,	20000,},
	nebula2 = {"hwcasteroid_3",	100,	20000,},
	nebula3 = {"hwcasteroid_3",	100,	20000,},
	nebula4 = {"hwcasteroid_3",	100,	20000,},
	-- hwc: 0, 0
	-- hwc: 6000, 10000
	dcrystal0 = {"hwccrystal_1",	6000,	12000,},
	dcrystal1 = {"hwccrystal_2",	10000,	20000,},
}

-- cloud types & radii (temporary)
CloudScale =
{
	dustcloud0 = {"dustcloud_0",		100,	100,},
	dustcloud1 = {"dustcloud_nores",	200,	200,},
	dustcloud2 = {"dustcloud_nores2",	600,	600,},
	dustcloud3 = {"dustcloud_nores3",	1200,	1200,},
	dustcloud4 = {"dustcloud_nores3",	1800,	1800,},
}

RUInfo =
{
	-- Type = #LatchPts
	hwcasteroid_1 = 0,
	hwcasteroid_2 = 1,
	hwcasteroid_3 = 1,
	hwcasteroid_4 = 2,
	hwcasteroid_5 = 3,
}

PebTypes =
{
	"pebble_0",
	"pebble_1",
	"pebble_2",
}

-- ship conversion table
ShipTable =
{
	-- hgn only
	r1 =
	{
		advancesupportfrigate = "hgn_defensefieldfrigate",
		attackbomber = "hgn_attackbomber",
		carrier = "hgn_carrier",
		cloakedfighter = "hgn_attackbomberelite",
		cloakgenerator = "hgn_ionturret",
		cryotray = "hgn_hscore",
		dddfrigate = "hgn_assaultfrigate",
		drone = "hgn_targetdrone",
		gravwellgenerator = "hgn_gunturret",
		headshotasteroid = "hgn_destroyer",
		heavycorvette = "hgn_pulsarcorvette",
		heavycruiser = "hgn_battlecruiser",
		heavydefender = "hgn_interceptor",
		heavyinterceptor = "hgn_interceptor",
		ioncannonfrigate = "hgn_ioncannonfrigate",
		lightcorvette = "hgn_assaultcorvette",
		lightdefender = "hgn_interceptor",
		lightinterceptor = "hgn_scout",
		minelayercorvette = "hgn_minelayercorvette",
		missiledestroyer = "hgn_destroyer",
		mothership = "hgn_mothership",
		multiguncorvette = "hgn_assaultcorvetteelite",
		probe = "hgn_probe",
		proximitysensor = "hgn_proximitysensor",
		repaircorvette = "hgn_resourcecollector",
		researchship = "hgn_gunturret",				-- no good HW2 equivalent
		resourcecollector = "hgn_resourcecollector",
		resourcecontroller = "hgn_resourcecontroller",
		salcapcorvette = "hgn_marinefrigate",
		sensorarray = "hgn_ecmprobe",
		standarddestroyer = "hgn_destroyer",
		standardfrigate = "hgn_assaultfrigate",
		targetdrone = "hgn_targetdrone",
	},
	-- vgr only
	r2 =
	{
		advancesupportfrigate = "vgr_heavymissilefrigate",
		attackbomber = "vgr_bomber",
		carrier = "vgr_carrier",
		cloakgenerator = "vgr_weaponplatform_missile",
		cryotray = "hgn_hscore",
		defensefighter = "hgn_interceptor",
		dfgfrigate = "vgr_heavymissilefrigate",
		gravwellgenerator = "vgr_weaponplatform_gun",
		headshotasteroid = "vgr_destroyer",
		heavycorvette = "vgr_lasercorvette",
		heavycruiser = "vgr_battlecruiser",
		heavydefender = "vgr_lancefighter",
		heavyinterceptor = "vgr_interceptor",
		ioncannonfrigate = "vgr_heavymissilefrigate",
		lightcorvette = "vgr_missilecorvette",
		lightdefender = "vgr_scout",
		lightinterceptor = "vgr_scout",
		minelayercorvette = "vgr_minelayercorvette",
		missiledestroyer = "vgr_destroyer",
		mothership = "vgr_mothership",
		multiguncorvette = "vgr_commandcorvette",
		probe = "vgr_probe",
		proximitysensor = "vgr_probe_prox",
		repaircorvette = "vgr_resourcecollector",
		researchship = "hgn_gunturret",				-- no good HW2 equivalent
		resourcecollector = "vgr_resourcecollector",
		resourcecontroller = "vgr_resourcecontroller",
		salcapcorvette = "vgr_infiltratorfrigate",
		sensorarray = "vgr_probe_ecm",
		standarddestroyer = "vgr_destroyer",
		standardfrigate = "vgr_assaultfrigate",
		targetdrone = "hgn_targetdrone",
	},
	-- vgr only
	p1 =
	{
		p1fighter = "vgr_interceptor",
		p1ionarrayfrigate = "vgr_heavymissilefrigate",
		p1missilecorvette = "vgr_missilecorvette",
		p1mothership = "vgr_commstation_hwc",
		p1standardcorvette = "vgr_lasercorvette",
	},
	-- hgn only
	p2 =
	{
		p2advanceswarmer = "kpr_attackdroid_hwc",
		p2fuelpod = "kpr_mover",
		p2mothership = "kpr_sajuuk_hwc",
		p2multibeamfrigate = "kpr_destroyer_hwc",
		p2swarmer = "kpr_attackdroid_hwc",
	},
	-- vgr only
	p3 =
	{
		p3frigate = "vgr_planetkillermissile",
		p3megaship = "vgr_planetkiller",
		p3destroyer = "vgr_destroyer",
	},
	-- vgr and meg only
	traders =
	{
		cargobarge = "sp_tanker",
		floatingcity = "vgr_prisonstation_hwc",
		ghostship = "meg_chimera",
		junk_lgun = "vgr_weaponplatform_gun",
		junk_sgun = "vgr_weaponplatform_missile",
		junkyarddawg = "vgr_minelayercorvette",
		junkyardhq = "meg_foundry",
		miningbase = "meg_gehenna_4",
		researchstation = "meg_tanis",
		researchstationbridge = "meg_tanis_structuremedium",
		researchstationtower = "meg_tanis_structuremedium2",
	},
	-- mostly meg
	derelicts =
	{
		advancesupportfrigate = "meg_misslefrigate",
		angelmoon = "meg_bigred",
		angelmoon_clean = "meg_foundry",
		carrier = "sp_tanker",
		crate = "",					-- can't use meg_crate
		dddfrigate = "meg_misslefrigate",
		fragment = "meg_sajhulknose",
		fragmentpanel0a = "meg_sajhulkpanels",
		fragmentpanel0b = "meg_sajhulkpanels",
		fragmentpanel0c = "meg_sajhulkpanels",
		fragmentpanel1 = "meg_sajhulkpanels_ui",
		fragmentpanel2 = "meg_sajhulkpanels_ui",
		fragmentpanel3 = "meg_sajhulkpanels_ui",
		fragmentstrut = "meg_sajhulkturret",
		heavycorvette = "meg_salvagecollector",
		heavycruiser = "kpr_destroyer",
		homeworld = "meg_tanis",
		ioncannonfrigate = "meg_misslefrigate",
		junk0_antenna = "meg_veildebris_bit1",
		junk0_fin1 = "meg_veildebris_bit2",
		junk0_fin2 = "meg_veildebris_bit3",
		junk0_gunammo = "meg_veildebris_bit4",
		junk0_lgun = "meg_veildebris_bit5",
		junk0_panel = "meg_veildebris_bit6",
		junk0_sensors = "meg_veildebris_bit7",
		junk0_sgun = "meg_veildebris_bit8",
		junk1_parta = "meg_veildebris_bit9",
		junk1_partb = "meg_veildebris_bit10",
		junk1_shell = "meg_veildebris_bit11",
		junk1_strut = "meg_veildebris_bit12",
		junk2_panela = "meg_veildebris_bit13",
		junk2_panelb = "meg_veildebris_bit14",
		junk2_panelc = "meg_veildebris_bit15",
		junk2_paneld = "meg_veildebris_chunk1_nd",
		junk2_shipwreck = "meg_veildebris_chunk_lighthouse",
		junk3_boiler = "meg_veildebris_chunk2_nd",
		junk3_boilercasing = "meg_veildebris_chunk3_nd",
		lifeboat = "meg_chimera",
		lightcorvette = "meg_salvagecollector",
		m13panela = "meg_foundrydebris_flake1",
		m13panelb = "meg_foundrydebris_flake2",
		m13panelc = "meg_foundrydebris_flake3",
		minelayercorvette = "meg_salvagecollector",
		multiguncorvette = "kpr_mover_capture",
		planetoforigin = "meg_bentus",
		planetoforigin_scarred = "meg_bentus_ruined",
		prisonshipnew = "vgr_commstation",
		prisonshipold = "vgr_prisonstation",
		repaircorvette = "meg_salvagecollector",
		resourcecontroller = "vgr_resourcecontroller",
		salcapcorvette = "meg_salvagecollector",
		scaffold = "meg_tanis",
		scaffold_scarred = "meg_tanis",
		scaffoldfingera_scarred = "meg_tanisstructure_medium",
		scaffoldfingerb_scarred = "meg_tanisstructure_medium2",
		shipwreck = "meg_misslefrigate",
		standardfrigate = "meg_misslefrigate",
	},
	race_sect =
	{
		smothership = "hgn_mothership",
		srecon = "hgn_scout",
		sacolyte = "hgn_interceptor",
		smimic = "hgn_attackbomber",
		sacv = "hgn_assaultcorvette",
		smcv = "hgn_pulsarcorvette",
		srammingfrigate = "hgn_marinefrigate",
		smultibeamfrigate = "hgn_ioncannonfrigate",
		shivefrigate = "hgn_assaultfrigate",
		sdestroyer = "hgn_destroyer",
		sdreadnought = "hgn_battlecruiser",
		scarrier = "hgn_carrier",
		sprocessor = "hgn_resourcecontroller",
		sworker = "hgn_resourcecollector",
		sleech = "hgn_ionturret",
		ssentinel = "hgn_gunturret",
	},
	race_beast =
	{
		bmothership = "vgr_mothership",
		brecon = "vgr_scout",
		bacolyte = "vgr_lancefighter",
		binterceptor = "hgn_interceptor",
		bcloakedfighter = "vgr_lancefighter",
		battackbomber = "vgr_bomber",
		bmultiguncorvette = "vgr_assaultcorvette",
		bmissilecorvette = "vgr_missilecorvette",
		bheavycorvette = "vgr_lasercorvette",
		bionarrayfrigate = "vgr_assaultfrigate",
		bmultibeamfrigate = "vgr_heavymissilefrigate",
		bhivefrigate = "vgr_assaultfrigate",
		bdfgfrigate = "vgr_infiltratorfrigate",
		brammingfrigate = "vgr_infiltratorfrigate",
		bmissiledestroyer = "vgr_destroyer",
		bheavycruiserbcarrier = "vgr_battlecruiser",
		bprocessor = "vgr_resourcecontroller",
		bworker = "vgr_resourcecollector",
		bcruisemissile = "vgr_planetkillermissile",
		bsentinel = "vgr_weaponplatform_gun",
	},
	race_kushan =
	{
		kcarrier = "hgn_carrier",
		kheavyinterceptor = "hgn_interceptor",
		kheavydefender = "hgn_interceptor",
		kattackbomber = "hgn_attackbomber",
		kheavycorvette = "hgn_assaultcorvetteelite",
		kmultiguncorvette = "hgn_assaultcorvette",
		ksalcapcorvette = "hgn_pulsarcorvette",
		kioncannonfrigate = "hgn_ioncannonfrigate",
		kadvancesupportfrigate = "hgn_assaultfrigate",
		kstandarddestroyer = "hgn_destroyer",
		kheavycruiser = "hgn_battlecruiser",
		kproximitysensor = "hgn_proximitysensor",
		kgravwellgenerator = "hgn_ionturret",
	},
	race_taidan =
	{
		tcarrier = "vgr_carrier",
		theavyinterceptor = "vgr_interceptor",
		tattackbomber = "vgr_bomber",
		theavydefender = "vgr_lancefighter",
		tmultiguncorvette = "vgr_lasercorvette",
		tminelayercorvette = "vgr_minelayercorvette",
		tsalcapcorvette = "vgr_commandcorvette",
		tstandardfrigate = "vgr_assaultfrigate",
		tioncannonfrigate = "vgr_heavymissilefrigate",
		tadvancesupportfrigate = "vgr_infiltratorfrigate",
		tdfgfrigate = "vgr_infiltratorfrigate",
		tstandarddestroyer = "vgr_destroyer",
		tmissiledestroyer = "vgr_destroyer",
		theavycruiser = "vgr_battlecruiser",
		tresourcecollector = "vgr_resourcecollector",
		tproximitysensor = "vgr_probe_prox",
		tgravwellgenerator = "vgr_weaponplatform_gun",
	},
	race_p1 =
	{
		p1mothership = "vgr_commstation_hwc",
		p1outpost = "vgr_prisonstation_hwc",
		p1fighter = "vgr_interceptor",
		p1standardcorvette = "vgr_lasercorvette",
		p1missilecorvette = "vgr_missilecorvette",
		p1ionarrayfrigate = "vgr_heavymissilefrigate",
	},
	race_traders =
	{
		trcargobarge = "sp_tanker",
		trghostship = "meg_chimera",
		trfloatingcity = "vgr_prisonstation_hwc",
		trjunk_lgun = "vgr_weaponplatform_gun",
		trjunk_sgun = "vgr_weaponplatform_missile",
		trjunkyarddawg = "vgr_minelayercorvette",
		trjunkyardhq = "meg_foundry",
		trminingbase = "meg_gehenna_4",
		trresearchstation = "meg_tanis",
	},
	-- still need to think of some HW2 equivalents for these
	race_derelict =
	{
		homeworld = "",
		lavaball = "",
		mattworld = "",
		planetoforigin = "",
		planetoforigin_scarred = "",
		galaxy = "",
		dcrystal0 = "",					-- resources
		dcrystal1 = "",					-- resources
		dplanetoforigin = "",
		ddeadplanet = "",
		dfirstplanet = "",
		ghostship = "",
		decclesiam = "",
		decclesiaminfected = "",
		dprisonship = "",
		dprisonshipinfected = "",
		dnomadfieldemitter = "",
		dnomadmoon = "",
		dbiggun = "",
		dbiggununit = "",
		djunk1parta = "",
		djunk1shell = "",
		djunk1strut = "",
		djunk2shipwreck = "",
		djunk3boiler = "",
		djunk3boilercasing = "",
		dbeastdockingbay = "",
		dbeastmothership = "",
		dacolyte = "",
		dionarrayfrigate = "",
		dioncannonfrigate = "",
		dkushancarrier = "",
		drko = "",
		dcrate = "",
		dbuoy = "",
		dmessagepod = "",
		dnisbuoy = "",
		dcrate = "",
		dcrystal0 = "",
		dcrystal1 = "",
		dslipgatelarge = "",
		dslipgatemedium = "",
		dslipgatesmall = "",
		dslipgatesmall = "",
		dslipgatenode = "",
	},
}

MusicTable =
{
	["-1"] = "data:sound/music/battle/battle_01",
	-- hw1
	["0"] = "data:sound/music/battle/battle_01",
	["1"] = "data:sound/music/battle/battle_04",
	["2"] = "data:sound/music/battle/battle_04_alt",
	["3"] = "data:sound/music/battle/battle_06",
	["4"] = "data:sound/music/battle/battle_keeper",
	["5"] = "data:sound/music/battle/battle_movers",
	["6"] = "data:sound/music/battle/battle_planetkillers",
	["7"] = "data:sound/music/battle/battle_sajuuk",
	["8"] = "data:sound/music/battle/bentus_arrival",
	["9"] = "data:sound/music/ambient/amb_01",
	["10"] = "data:sound/music/ambient/amb_02",
	["11"] = "data:sound/music/ambient/amb_03",
	["12"] = "data:sound/music/ambient/amb_04",
	["13"] = "data:sound/music/ambient/amb_05",
	["14"] = "data:sound/music/ambient/amb_06",
	["15"] = "data:sound/music/ambient/amb_07",
	["16"] = "data:sound/music/ambient/amb_08",
	["17"] = "data:sound/music/ambient/amb_09",
	["18"] = "data:sound/music/ambient/amb_10",
	["19"] = "data:sound/music/ambient/amb_11",
	["20"] = "data:sound/music/ambient/amb_12",
	["21"] = "data:sound/music/ambient/amb_13",
	["22"] = "data:sound/music/ambient/amb_14",
	["23"] = "data:sound/music/battle/battle_01",
	["24"] = "data:sound/music/battle/battle_04",
	["25"] = "data:sound/music/battle/battle_04_alt",
	["26"] = "data:sound/music/battle/battle_06",
	["27"] = "data:sound/music/battle/battle_keeper",
	["28"] = "data:sound/music/battle/battle_movers",
	["29"] = "data:sound/music/battle/battle_planetkillers",
	["30"] = "data:sound/music/battle/battle_sajuuk",
	["31"] = "data:sound/music/battle/bentus_arrival",
	["32"] = "data:sound/music/ambient/amb_01",
	["33"] = "data:sound/music/ambient/amb_02",
	["34"] = "data:sound/music/ambient/amb_03",
	["35"] = "data:sound/music/ambient/amb_04",
	["36"] = "data:sound/music/ambient/amb_05",
	["37"] = "data:sound/music/ambient/amb_06",
	["38"] = "data:sound/music/ambient/amb_07",
	["39"] = "data:sound/music/ambient/amb_08",
	["40"] = "data:sound/music/ambient/amb_09",
	["41"] = "data:sound/music/ambient/amb_10",
	["42"] = "data:sound/music/ambient/amb_11",
	["43"] = "data:sound/music/ambient/amb_12",
	["44"] = "data:sound/music/ambient/amb_13",
	["45"] = "data:sound/music/ambient/amb_14",
	["46"] = "data:sound/music/battle/battle_01",
	["47"] = "data:sound/music/battle/battle_04",
	-- cata
	["48"] = "data:sound/music/battle/battle_04",
	["49"] = "data:sound/music/battle/battle_04",
}

BackgroundTable =
{
	default = "m02",
	-- hw1
	ez01 = "m01",
	ez02 = "m07",
	ez03 = "m07",	-- doesn't exist, but some maps reference it anyway
	ez04 = "m15",
	ez05 = "m15",
	ez06 = "m13",
	ez07 = "m08",
	ez08 = "m14",
	ez09 = "m09",
	ez10 = "m10",
	ez11 = "m11",
	ez12 = "m06",
	ez13 = "m03",
	ez14 = "m04",
	ez15 = "m05",
	ez16 = "m12",
	-- cata
	mission01 = "m01",
	mission02 = "m07",
	mission03 = "m07",
	mission04 = "m15",
	mission05 = "m15",
	mission06 = "m13",
	mission07 = "m08",
	mission08 = "m14",
	mission09 = "m09",
	mission10 = "m10",
	mission11 = "m11",
	mission12 = "m06",
	mission13 = "m03",
	mission14 = "m04",
	mission15 = "m05",
	mission16 = "m12",
	mission17 = "m12",
	nis01 = "m01",
	nis02 = "m07",
	nis03 = "m07",
	nis04 = "m15",
	nis05 = "m15",
	nis06 = "m13",
	nis07 = "m08",
	nis08 = "m14",
	nis09 = "m09",
	nis10 = "m10",
}


--------------------------------------------------------------------------------
-- Standard Map Code

levelDesc = [[HW1 - ]] .. LevelName
maxPlayers = min(NumberOfPlayers, 6)
player = {}

for k = 1, maxPlayers do
	player[k] = {id = k - 1, name = "Vaygr", resources = 1500, raceID = 2, startPos = 1,}
end

function DetermChunk()
	addPoint("PointOfNoReturn", {0,1000000,0,}, {0,0,0,})
	addNebula("DeadMansJump", "MP_Bentusi_Radiation", {0,1000000,0,}, {0,0,0,0,}, 0, 10000)
	setWorldBoundsInner({0, 0, 0,}, {UniverseSize[1] * MapScale * UniverseScale, UniverseSize[3] * MapScale * UniverseScale, UniverseSize[2] * MapScale * UniverseScale,})
	for i, iCount in StartPoints do
		AddStartPoints(i, iCount)
		createSOBGroup("HE_Formation" .. i)
	end
	if (AdvancedGameRule == 1) then
		SpawnPlayerFleet()
	end
	for i, iCount in Derelicts do
		AddSquadrons("", iCount[1], iCount[2], iCount[3], iCount[4], iCount[5], 0, "derelicts")
	end

	-- derelicts and squadrons aren't currently stored in separate tables though they will/should be
	-- until formations are properly supported, only add one of each ship otherwise you will have overlapping ships and lots of lag as they try to spread out
	-- even with formations properly supported, the lag is still going to be considerably higher than it ever was in HW1
	-- alternately, I could just ignore squadrons entirely and only spawn derelicts since AI squadrons just sit there not doing anything unlike in HW1
--	for i, iCount in Squadrons do
--		local sFormation = iCount[]
--		if (sFormation == "null_formation") then
--		elseif (sFormation == "parade_formation") then
--		elseif (sFormation == "delta_formation") then
--		elseif (sFormation == "broad_formation") then
--		elseif (sFormation == "delta3d_formation") then
--		elseif (sFormation == "claw_formation") then
--		elseif (sFormation == "wall_formation") then
--		elseif (sFormation == "sphere_formation") then
--		elseif (sFormation == "picket_formation") then
--		else
--			print("hwclassicmaps: formation type " .. sFormation .. " not recognized.")
--		end
--		for j = 1, iCount[1] do
--			AddSquadrons(iCount[2], iCount[3], iCount[4], iCount[5], iCount[6], iCount[7], 0, iCount[9])
--		end
--	end

	local ResourceBlobs = 0
	for i, iCount in Resources do
		AddResources(iCount[1], iCount[2], iCount[3], iCount[4], iCount[5], iCount[6], iCount[7], iCount[8])
		ResourceBlobs = ResourceBlobs + 1
	end
	for i, iCount in Crystals do
		AddCrystals(iCount[1], iCount[2], iCount[3])
	end

	print("hwclassicmaps: CountLPs = " .. CountLPs)
	print("hwclassicmaps: CountRUs = " .. CountRUs)
	print("hwclassicmaps: CountLoops = " .. CountLoops)
	print("hwclassicmaps: ResourceBlobs = " .. ResourceBlobs)
end

function NonDetermChunk()
	local MinSensorsZoom = max(SensorsZoom[1] * MapScale, MinSensorsZoomOverride)
	local MaxSensorsZoom = min(SensorsZoom[2] * MapScale, MaxSensorsZoomOverride)
	setSensorsManagerCameraDistances(MinSensorsZoom, MaxSensorsZoom)
	setGlareIntensity(0)
	setLevelShadowColour(0, 0, 0, 1)
	if (BackgroundTable[LevelBackground]) then
		loadBackground(BackgroundTable[LevelBackground])
	else
		loadBackground(BackgroundTable["default"])
		print("hwclassicmaps: background " .. LevelBackground .. " not recognized, loading default instead.")
	end
	if (MusicTable[LevelMusic]) then
		setDefaultMusic(MusicTable[LevelMusic])
	else
		setDefaultMusic(MusicTable["0"])
		print("hwclassicmaps: music " .. LevelMusic .. " not recognized, loading default instead.")
	end
end


--------------------------------------------------------------------------------
-- Custom Functions

--CountLPs, CountRUs = 0, 0
CountFormation = {0,0,0,0,0,0,}

function SpawnPlayerFleet()
	for i, iCount in StartShips do
		local ShipNumber, ShipName, ShipType, ShipPosition, iPlayer, ShipRotation = iCount[1], iCount[2], iCount[3], iCount[4], iCount[5], iCount[6]
		if (iPlayer < 6) then
			local iPlayerPlus = iPlayer + 1
			if ((ShipPosition[1] == 0) and (ShipPosition[2] == 0) and (ShipPosition[3] == 0)) then
				ShipPosition[1] = StartPoints[iPlayerPlus][1]
				ShipPosition[2] = StartPoints[iPlayerPlus][2]
				ShipPosition[3] = StartPoints[iPlayerPlus][3]
				ShipRotation[3] = StartPoints[iPlayerPlus][4]
			end
			if ((ShipPosition[1] == StartPoints[iPlayerPlus][1]) and (ShipPosition[2] == StartPoints[iPlayerPlus][2]) and (ShipPosition[3] == StartPoints[iPlayerPlus][3])) then
				local Angle = StartPoints[iPlayerPlus][4] + 180
				local Radius = 5000
				local AdjX = cos(Angle) * Radius
				local OppY = sin(Angle) * Radius
				ShipPosition = {ShipPosition[1] + AdjX, ShipPosition[2] + OppY, ShipPosition[3],}
			end
			for j = 1, ShipNumber do
				local SquadNum = CountFormation[iPlayerPlus]
				local SquadName = "HE_Player" .. iPlayerPlus .. "Squadron" .. SquadNum
				local SquadGroup = "HE_Formation" .. iPlayerPlus
				AddSquadrons(SquadName, ShipType, ShipPosition, iPlayer, ShipRotation, iCount[7], 1, iCount[9])
				addToSOBGroup(SquadName, SquadGroup)
				CountFormation[iPlayerPlus] = SquadNum + 1
			end
		end
	end
end

function AddStartPoints(i, tCoords)
	local StartCoo = {tCoords[1] * MapScale * -1, tCoords[3] * MapScale, tCoords[2] * MapScale,}
	addPoint("StartPos" .. (i - 1), StartCoo, {0, tCoords[4] - 90, 0,})
end

function AddSquadrons(sName, sType, tPosition, iPlayer, tRotation, fValue, bHyper, sRace)
	local HW2Type = ShipTable[sRace][sType]
	if ((HW2Type ~= "") and (HW2Type ~= nil) and (iPlayer < 6)) then
		addSquadron(sName, HW2Type, {tPosition[1] * MapScale * -1, tPosition[3] * MapScale, tPosition[2] * MapScale,}, iPlayer, {tRotation[1], tRotation[3] - 90, tRotation[2],}, fValue, bHyper)
	else
		print("hwclassicmaps: ship type " .. sType .. " not recognized.")
	end
end

function AddCrystals(iAmount, sType, tPosition)
	local HW2Type = RUTable[sType][1]
--	local RUValue = round(RUTable[sType][2] * RUScale)
	local RUValue = RUTable[sType][3]
	if (iAmount > 1) then
		for j = 1, iAmount do
			local r, u, v = 10000, srandom3(my_seed, 180), srandom3(my_seed, 360)
			local cooX = r * cos(u)
			local cooY = r * sin(v) * sin(u)
			local cooZ = r * cos(v) * sin(u)
			local tCoordinates = {(tPosition[1] + cooX) * MapScale * -1, (tPosition[3] + cooZ) * MapScale, (tPosition[2] + cooY) * MapScale,}
			addSalvage(HW2Type, tCoordinates, RUValue, 0, 0, 0, 0)
		end
	else
		addSalvage(HW2Type, {tPosition[1] * MapScale * -1, tPosition[3] * MapScale, tPosition[2] * MapScale,}, RUValue, 0, 0, 0, 0)
	end
end

function AddResources(tPosition, sLayout, sDistribution, iNumResources, fA, fB, fRotY, fRotZ)
	local Relative, iModulos = 0, 0
	for k, iCount in Distributions[sDistribution] do
		if (RUTable[k]) then
			Relative = Relative + iCount
		else
			Distributions[sDistribution][k] = 0
			print("hwclassicmaps: resource type " .. k .. " not recognized.")
		end
	end
	if (Relative > 0) then
		for k, iCount in Distributions[sDistribution] do
			if (iCount > 0) then
				local kRes = RUTable[k]
				local HW2Type = kRes[1]
				local RUValue = kRes[2] * RUScale
				local Amount = iNumResources * iCount / Relative
				if (RUsRatio > 0) then
					RUValue = RUValue / RUsRatio
					Amount = Amount * RUsRatio
				end
				if (PebRatio > 0) then
					RUValue = RUValue / (1-PebRatio)
				end
--				RUValue = round(RUValue)	-- disabled for being wildly inconsistent
				RUValue = kRes[3]
				Amount = round(Amount)
				iModulos = iModulos + mod(iCount * iNumResources, Relative)
				for j = 1, Amount do
					local cooX, cooY, cooZ = 0, 0, 0
					if (sLayout == "cylinder") then
						local r, w, v = sqrt(srandom(my_seed)) * fA, srandom3(my_seed, -fB, fB), srandom(my_seed) * 360
						cooX = w / 2
						cooY = r * sin(v)
						cooZ = r * cos(v)
					--elseif ((sLayout == "sphere") or (sLayout == "nebula")) then
					elseif (sLayout == "sphere") then
						local r, u, v = sqrt(srandom(my_seed)) * fA, srandom(my_seed) * 180, srandom(my_seed) * 360
						cooX = r * cos(u)
						cooY = r * sin(v) * sin(u)
						cooZ = r * cos(v) * sin(u)
					elseif (sLayout == "rectangle") then
						local l, w, h = srandom3(my_seed, -fA, fA), srandom3(my_seed, -fB, fB), srandom3(my_seed, -fRotY, fRotY)
						cooX = l
						cooY = w
						cooZ = h
						fRotY = 0
--					elseif (sLayout == "nebula") then
						-- to do
					end
					print_objects("-- sLayout = " .. sLayout .. ", cooX = " .. cooX .. ", cooY = " .. cooY .. ", cooZ = " .. cooZ .. ", j = " .. j)
					local yCooX = cooX * cos(fRotY) + cooZ * sin(fRotY)
					local yCooY = cooY * 1
					local yCooZ = cooX * -1 * sin(fRotY) + cooZ * cos(fRotY)
					local zCooX = yCooX * cos(fRotZ) - yCooY * sin(fRotZ)
					local zCooY = yCooX * sin(fRotZ) + yCooY * cos(fRotZ)
					local zCooZ = yCooZ * 1
					local tCoordinates = {(tPosition[1] + zCooX) * MapScale * -1, (tPosition[3] + zCooZ) * MapScale, (tPosition[2] + zCooY) * MapScale,}
					if ((PebRatio > 0) and (PebCount < PebNumo)) then
						local temp_peb = ceil(srandom(my_seed) * srandom(my_seed) * getn(PebTypes))
						addPebble(PebTypes[temp_peb], tCoordinates, 0, 0, 0)
						print_objects("addPebble(\"" .. PebTypes[temp_peb] .. "\", {" .. tCoordinates[1] .. "," .. tCoordinates[2] .. "," .. tCoordinates[3] .. ",}, 0, 0, 0)")
					else
						if ((k == "dustcloud0") or (k == "dustcloud1") or (k == "dustcloud2") or (k == "dustcloud3") or (k == "dustcloud4")) then
							addAsteroid(HW2Type, tCoordinates, RUValue, 0, 0, 0, 0)
							addDustCloud("polySurface1", CloudScale[k][1], tCoordinates, {1, 1, 1, 1,}, 0, CloudScale[k][2])
							print_objects("addAsteroids(\"" .. HW2Type .. "\", {" .. tCoordinates[1] .. "," .. tCoordinates[2] .. "," .. tCoordinates[3] .. ",}, " .. RUValue .. ", 0, 0, 0, 0)")
							print_objects("addDustCloud(\"poluSurface1\", " .. CloudScale[k][1] .. ", {" .. tCoordinates[1] .. "," .. tCoordinates[2] .. "," .. tCoordinates[3] .. ",}, {1,1,1,1,}, 0, " .. CloudScale[k][2] .. ")")
						elseif ((k == "nebula0") or (k == "nebula1") or (k == "nebula2") or (k == "nebula3") or (k == "nebula4")) then
--							addAsteroid(HW2Type, tCoordinates, RUValue, 0, 0, 0, 0)
--							print_objects("addAsteroids(\"" .. HW2Type .. "\", {" .. tCoordinates[1] .. "," .. tCoordinates[2] .. "," .. tCoordinates[3] .. ",}, " .. RUValue .. ", 0, 0, 0, 0)")
						else
							addAsteroid(HW2Type, tCoordinates, RUValue, 0, 0, 0, 0)
							print_objects("addAsteroids(\"" .. HW2Type .. "\", {" .. tCoordinates[1] .. "," .. tCoordinates[2] .. "," .. tCoordinates[3] .. ",}, " .. RUValue .. ", 0, 0, 0, 0)")
						end
--						print("hwclassicmaps: added HW2Type = " .. HW2Type .. " at " .. vstr(tCoordinates))
					end
					PebCount = PebCount + 1
					if (PebCount == PebDeno) then
						PebCount = 0
					end
				end
				CountLoops = CountLoops + Amount
				CountLPs = CountLPs + Amount * RUInfo[HW2Type]
				CountRUs = CountRUs + Amount * RUValue
--				print("hwclassicmaps: HW2Type = " .. HW2Type .. ", Amount = " .. Amount .. ", RUValue = " .. RUValue ..)
			end
		end
		if (iModulos > 0) then
--			print("hwclassicmaps: iNumResources = " .. iNumResources)
--			print("hwclassicmaps: iModulos = " .. iModulos)
			AddResources(tPosition, sLayout, sDistribution, iModulos, fA, fB, fRotY, fRotZ)
		end
	end
end

function print_objects(in_string)
	if (debug_objects == 1) then
		print(in_string)
	end
end
