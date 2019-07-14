-- the RacesOrder table determines the order in which the races appear in the frontend menu
-- otherwise they would not appear in any particular order at all
RacesNumber = 2
RacesList =
{
	"hiigaran",
	"vaygr",
}

-- List of player-owned ships that should not get counted when determining where to place a crate. (E.g., megaliths.)
CrateExclusions =
{
	"Meg_Crate",
	"Meg_Asteroid",
	"Meg_AsteroidMP",
	"Meg_Asteroid_NoSubs",
	"Meg_BalcoraGate",
	"Meg_Bentus",
	"Meg_Bentus_Ruined",
	"Meg_Bentus_Ruins_Core_1",
	"Meg_Bentus_Ruins_Core_2",
	"Meg_Bentus_Ruins_Core_3",
	"Meg_Bentus_Ruin_1",
	"Meg_Bentus_Ruin_2",
	"Meg_Bentus_Ruin_3",
	"Meg_Bentus_Ruin_4",
	"Meg_Bentus_Ruin_5",
	"Meg_Bentus_Ruin_6",
	"Meg_Bentus_Ruin_7",
	"Meg_Bentus_Ruin_8",
	"Meg_Bentus_Ruin_9",
	"Meg_Bentus_Ruin_10",
	"Meg_Bentus_Ruin_11",
	"Meg_BigRed",
	"Meg_Chimera",
	"Meg_DreadnaughtBerth",
	"Meg_Foundry",
	"Meg_FoundryDebris_Chunk1",
	"Meg_FoundryDebris_Chunk2",
	"Meg_FoundryDebris_Chunk3",
	"Meg_FoundryDebris_Chunk4",
	"Meg_FoundryDebris_Flake1",
	"Meg_FoundryDebris_Flake2",
	"Meg_FoundryDebris_Flake3",
	"Meg_FoundryDebris_Flake4",
	"Meg_Gehenna_1",
	"Meg_Gehenna_2",
	"Meg_Gehenna_3",
	"Meg_Gehenna_4",
	"Meg_Gehenna_5",
	"Meg_Gehenna_6",
	"Meg_Gehenna_7",
	"Meg_MissleFrigate",
	"Meg_ProgenitorPowerModule",
	"Meg_ProgenitorPowerTrigger",
	"Meg_ProgenitorPowerTrigger_NoUI",
	"Meg_SajHulkNose",
	"Meg_SajHulkNose_UI",
	"Meg_SajHulkPanels",
	"Meg_SajHulkPanels_UI",
	"Meg_SajHulkTurret",
	"Meg_SalvageCollector",
	"Meg_Tanis",
	"Meg_TanisStructure_Medium",
	"Meg_TanisStructure_Medium2",
	"Meg_VeilDebris_Bit1",
	"Meg_VeilDebris_Bit2",
	"Meg_VeilDebris_Bit3",
	"Meg_VeilDebris_Bit4",
	"Meg_VeilDebris_Bit5",
	"Meg_VeilDebris_Bit6",
	"Meg_VeilDebris_Bit7",
	"Meg_VeilDebris_Bit8",
	"Meg_VeilDebris_Bit9",
	"Meg_VeilDebris_Bit10",
	"Meg_VeilDebris_Bit11",
	"Meg_VeilDebris_Bit12",
	"Meg_VeilDebris_Bit13",
	"Meg_VeilDebris_Bit14",
	"Meg_VeilDebris_Bit15",
	"Meg_VeilDebris_Chunk1",
	"Meg_VeilDebris_Chunk1_ND",
	"Meg_VeilDebris_Chunk2",
	"Meg_VeilDebris_Chunk2_ND",
	"Meg_VeilDebris_Chunk3",
	"Meg_VeilDebris_Chunk3_ND",
	"Meg_VeilDebris_Chunk4",
	"Meg_VeilDebris_Chunk4_ND",
	"Meg_VeilDebris_Chunk5",
	"Meg_VeilDebris_Chunk5_ND",
	"Meg_VeilDebris_Chunk_Lighthouse",
	"Meg_VeilDebris_Flake1",
	"Meg_VeilDebris_Flake2",
	"Meg_VeilDebris_Flake3",
	"Meg_VeilDebris_Flake4",
	"Meg_VeilDebris_Flake5",
	"Meg_VeilDebris_Flake6",
	"Meg_VeilDebris_Flake7",
	"Meg_VeilDebris_Flake8",
	"Meg_VeilDebris_Flake9",
	"Meg_VeilDebris_Flake10",
}


--==============================================================================
-- RANDOM MUSIC
--

-- the playlist for the random music script
TracksNumber = 20
TracksTable =
{
	-- title, filepath, playing time (s),					-- default time
	{"Ambient No.1", "ambient\\amb_01", 628,},				-- 157
	{"Ambient No.2", "ambient\\amb_02", 660,},				-- 110
	{"Ambient No.3", "ambient\\amb_03", 620,},				-- 155
	{"Ambient No.4", "ambient\\amb_04", 660,},				-- 110
	{"Ambient No.5", "ambient\\amb_05", 645,},				-- 129
	{"Ambient No.6", "ambient\\amb_06", 618,},				-- 103
	{"Ambient No.7", "ambient\\amb_07", 620,},				-- 124
	{"Ambient No.8", "ambient\\amb_08", 705,},				-- 141
	{"Ambient No.12", "ambient\\amb_12", 628,},				-- 108
	{"Ambient No.13", "ambient\\amb_13", 684,},				-- 114
	{"Ambient No.14", "ambient\\amb_14", 725,},				-- 145
	{"Battle No.1", "battle\\battle_01", 552,},				-- 276
	{"Battle No.4", "battle\\battle_04", 678,},				-- 226
	{"Battle No.4, Alternate", "battle\\battle_04_alt", 720,},		-- 180
	{"Battle No.6", "battle\\battle_06", 764,},				-- 191
	{"Battle - Keeper", "battle\\battle_keeper", 708,},			-- 177
	{"Battle - Movers", "battle\\battle_movers", 632,},			-- 158
	{"Battle - Planet Killers", "battle\\battle_planetkillers", 748,},	-- 187
	{"Battle - Sajuuk", "battle\\battle_sajuuk", 644,},			-- 161
	{"Battle - Arrival", "battle\\battle_arrival", 640,},			-- 64
}
