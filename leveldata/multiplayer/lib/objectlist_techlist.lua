-- Probabilities and costs need to be updated/corrected from their default 
-- values. Probabilities are intended for HWC crate awards and Bentusi Roulette 
-- research awards, and costs are intended for HWC bounties. However, HWU does 
-- not do crates or bounties at the moment, so they can be ignored for the time 
-- being. Ships and classes must be listed in order of their probabilities, 
-- from lowest to highest, except for those with a probability of 0 which are 
-- ignored.
--
-- Probabilities work as follows: A random number between 0 and 1 is generated 
-- by the gametype script. This number is then compared to each item in the 
-- TechList table in the order they are listed. If the random number is less 
-- than the specified probability for that item but greater than the prob-
-- ability of the previous item, then the first item is selected. So, for 
-- instance, a random number of 0.47421 is generated and checked versus the 
-- list of Hiigaran corvettes. If the probabilities for the Gunship, Pulsar 
-- Gunship, and Minelayer corvettes are 0.33, 0.67 and 1.00 respectively, then 
-- the Pulsar Gunship is selected because the random number is greater than 
-- 0.33 but less than or equal to 0.67. The same works for the tech classes.
--
-- type = the identifier of the item within the game code. usually case-
--	  insensitive, except in the case of research
-- name = display name
-- prob = HWC Crate and GPE Bentusi Roulette probability
-- cost = HWC Bounty RU value
-- targ = HWC list of ships that are able to build the named subsystem (not 
--        implemented currently)
--
-- missing from this list:
--	vgr_commstation_hwc
--	vgr_prisonstation_hwc
--	CarrierHealthUpgrade1_carrieronly
--	CarrierHealthUpgrade2_carrieronly
--	CarrierMAXSPEEDUpgrade1_carrieronly
--	CarrierMAXSPEEDUpgrade2_carrieronly
--	CarrierBUILDSPEEDUpgrade1_carrieronly
--	vgr_commstation_substation
--
-- The Player_HasQueuedResearch function is unfortunately case-sensitive unlike 
-- all the other build/research functions. This means that capitalization must 
-- be the same both in this list and in build.lua/research.lua. I would prefer 
-- that they were always lower case.
--

TechList =
{
	hiigaran =
	{
		research =
		{
			{
				class = "mothership",
				prob = 0.1,
				items =
				{
					{type = "MothershipHealthUpgrade1", name = "Mothership Hull 1", prob = 0.14, cost = 1000,},
					{type = "MothershipMAXSPEEDUpgrade1", name = "Mothership Engine 1", prob = 0.28, cost = 1000,},
					{type = "MothershipBUILDSPEEDUpgrade1", name = "Mothership BuildSpeed", prob = 0.42, cost = 1000,},
					{type = "HyperspaceCostUpgrade1", name = "Improved Hyperspace Drive 1", prob = 0.5600000000000001, cost = 1000,},
					{type = "HyperspaceCostUpgrade2", name = "Improved Hyperspace Drive 2", prob = 0.7, cost = 1000,},
					{type = "MothershipMAXSPEEDUpgrade2", name = "Mothership Engine 2", prob = 0.84, cost = 1000,},
					{type = "MothershipHealthUpgrade2", name = "Mothership Hull 2", prob = 1, cost = 1000,},
				},
			},
			{
				class = "cruiser",
				prob = 0.2,
				items =
				{
					{type = "BattlecruiserIonWeapons", name = "Battlecruiser Chassis", prob = 0.2, cost = 1000,},
					{type = "BattlecruiserHealthUpgrade1", name = "Battlecruiser Hull  1", prob = 0.4, cost = 1000,},
					{type = "BattlecruiserMAXSPEEDUpgrade1", name = "Battlecruiser Engine 1", prob = 0.6, cost = 1000,},
					{type = "BattlecruiserMAXSPEEDUpgrade2", name = "Battlecruiser Engine 2", prob = 0.8, cost = 1000,},
					{type = "BattlecruiserHealthUpgrade2", name = "Battlecruiser Hull 2", prob = 1, cost = 1000,},
				},
			},
			{
				class = "carrier",
				prob = 0.3,
				items =
				{
					{type = "CarrierHealthUpgrade1", name = "Carrier Hull 1", prob = 0.1, cost = 1000,},
					{type = "CarrierMAXSPEEDUpgrade1", name = "Carrier Engine 1", prob = 0.2, cost = 1000,},
					{type = "CarrierBUILDSPEEDUpgrade1", name = "Carrier BuildSpeed", prob = 0.3, cost = 1000,},
					{type = "ShipyardHealthUpgrade1", name = "Shipyard Hull 1", prob = 0.4, cost = 1000,},
					{type = "ShipyardMAXSPEEDUpgrade1", name = "Shipyard Engine 1", prob = 0.5, cost = 1000,},
					{type = "ShipyardBUILDSPEEDUpgrade1", name = "Shipyard BuildSpeed", prob = 0.6, cost = 1000,},
					{type = "ShipyardMAXSPEEDUpgrade2", name = "Shipyard Engine 2", prob = 0.7, cost = 1000,},
					{type = "ShipyardHealthUpgrade2", name = "Shipyard Hull 2", prob = 0.8, cost = 1000,},
					{type = "CarrierMAXSPEEDUpgrade2", name = "Carrier Engine 2", prob = 0.9, cost = 1000,},
					{type = "CarrierHealthUpgrade2", name = "Carrier Hull 2", prob = 1, cost = 1000,},
				},
			},
			{
				class = "destroyer",
				prob = 0.4,
				items =
				{
					{type = "DestroyerTech", name = "Destroyer Chassis", prob = 0.2, cost = 1000,},
					{type = "DestroyerHealthUpgrade1", name = "Destroyer Hull  1", prob = 0.4, cost = 1000,},
					{type = "DestroyerMAXSPEEDUpgrade1", name = "Destroyer Engine 1", prob = 0.6, cost = 1000,},
					{type = "DestroyerMAXSPEEDUpgrade2", name = "Destroyer Engine 2", prob = 0.8, cost = 1000,},
					{type = "DestroyerHealthUpgrade2", name = "Destroyer Hull 2", prob = 1, cost = 1000,},
				},
			},
			{
				class = "frigate",
				prob = 0.5,
				items =
				{
					{type = "TorpedoFrigateHealthUpgrade1", name = "Torpedo Frigate Armor 1", prob = 0.07000000000000001, cost = 1000,},
					{type = "TorpedoFrigateMAXSPEEDUpgrade1", name = "Torpedo Frigate Engine 1", prob = 0.14, cost = 1000,},
					{type = "IonCannonFrigateHealthUpgrade1", name = "Ion Frigate Armor 1", prob = 0.21, cost = 1000,},
					{type = "IonCannonFrigateMAXSPEEDUpgrade1", name = "Ion Frigate Engine 1", prob = 0.28, cost = 1000,},
					{type = "AssaultFrigateHealthUpgrade1", name = "Flak Frigate Armor 1", prob = 0.35, cost = 1000,},
					{type = "AssaultFrigateMAXSPEEDUpgrade1", name = "Flak Frigate Engine 1", prob = 0.42, cost = 1000,},
					{type = "AssaultFrigateMAXSPEEDUpgrade2", name = "Flak Frigate Engine 2", prob = 0.49, cost = 1000,},
					{type = "AssaultFrigateHealthUpgrade2", name = "Flak Frigate Armor 2", prob = 0.5600000000000001, cost = 1000,},
					{type = "IonCannonFrigateMAXSPEEDUpgrade2", name = "Ion Frigate Engine 2", prob = 0.63, cost = 1000,},
					{type = "IonCannonFrigateHealthUpgrade2", name = "Ion Frigate Armor 2", prob = 0.7, cost = 1000,},
					{type = "TorpedoFrigateMAXSPEEDUpgrade2", name = "Torpedo Frigate Engine 2", prob = 0.77, cost = 1000,},
					{type = "TorpedoFrigateHealthUpgrade2", name = "Torpedo Frigate Armor 2", prob = 0.84, cost = 1000,},
					{type = "ImprovedTorpedo", name = "Improved Torpedoes", prob = 0.91, cost = 1000,},
					{type = "DefenseFieldFrigateShield", name = "Defense Field", prob = 1, cost = 1000,},
				},
			},
			{
				class = "corvette",
				prob = 0.6,
				items =
				{
					{type = "AssaultCorvetteHealthUpgrade1", name = "Gunship Armor 1", prob = 0.11, cost = 1000,},
					{type = "AssaultCorvetteMAXSPEEDUpgrade1", name = "Gunship Engine 1", prob = 0.22, cost = 1000,},
					{type = "PulsarCorvetteHealthUpgrade1", name = "Pulsar Armor 1", prob = 0.33, cost = 1000,},
					{type = "PulsarCorvetteMAXSPEEDUpgrade1", name = "Pulsar Engine 1", prob = 0.44, cost = 1000,},
					{type = "PulsarCorvetteMAXSPEEDUpgrade2", name = "Pulsar Engine 2", prob = 0.55, cost = 1000,},
					{type = "PulsarCorvetteHealthUpgrade2", name = "Pulsar Armor 2", prob = 0.66, cost = 1000,},
					{type = "AssaultCorvetteMAXSPEEDUpgrade2", name = "Gunship Engine 2", prob = 0.77, cost = 1000,},
					{type = "AssaultCorvetteHealthUpgrade2", name = "Gunship Armor 2", prob = 0.88, cost = 1000,},
					{type = "GraviticAttractionMines", name = "Minelaying Technology", prob = 1, cost = 1000,},
				},
			},
			{
				class = "fighter",
				prob = 0.7,
				items =
				{
					{type = "InterceptorMAXSPEEDUpgrade1", name = "Interceptor Engine 1", prob = 0.14, cost = 1000,},
					{type = "AttackBomberMAXSPEEDUpgrade1", name = "Bomber Engine 1", prob = 0.28, cost = 1000,},
					{type = "AttackBomberMAXSPEEDUpgrade2", name = "Bomber Engine 2", prob = 0.42, cost = 1000,},
					{type = "InterceptorMAXSPEEDUpgrade2", name = "Interceptor Engine 2", prob = 0.5600000000000001, cost = 1000,},
					{type = "ScoutPingAbility", name = "Enhanced Scout Sensors", prob = 0.7, cost = 1000,},
					{type = "AttackBomberImprovedBombs", name = "Improved Bombs", prob = 0.84, cost = 1000,},
					{type = "ScoutEMPAbility", name = "Electro-Magnetic Pulse", prob = 1, cost = 1000,},
				},
			},
			{
				class = "platform",
				prob = 0.8,
				items =
				{
					{type = "PlatformIonWeapons", name = "Platform Ion Weapons", prob = 0.2, cost = 1000,},
					{type = "GunTurretHealthUpgrade1", name = "Gun Platform Hull 1", prob = 0.4, cost = 1000,},
					{type = "IonTurretHealthUpgrade1", name = "Ion Beam Platform Hull 1", prob = 0.6, cost = 1000,},
					{type = "GunTurretHealthUpgrade2", name = "Gun Platform Hull 2", prob = 0.8, cost = 1000,},
					{type = "IonTurretHealthUpgrade2", name = "Ion Beam Platform Hull 2", prob = 1, cost = 1000,},
				},
			},
			{
				class = "resource",
				prob = 0.9,
				items =
				{
					{type = "ResourceCollectorHealthUpgrade1", name = "Resource Collector Hull 1", prob = 0.2, cost = 1000,},
					{type = "ResourceControllerHealthUpgrade1", name = "Mobile Refinery Hull 1", prob = 0.4, cost = 1000,},
					{type = "ResourceControllerHealthUpgrade2", name = "Mobile Refinery Hull 2", prob = 0.6, cost = 1000,},
					{type = "ResourceCollectorHealthUpgrade2", name = "Resource Collector Hull 2", prob = 0.8, cost = 1000,},
					{type = "RepairAbility", name = "Collector Repair", prob = 1, cost = 1000,},
				},
			},
			{
				class = "noncombat",
				prob = 1,
				items =
				{
					{type = "ECMProbe", name = "Sensors Distortion Probe", prob = 0.5, cost = 1000,},
					{type = "SensDisProbe", name = "Proximity Sensor Probe", prob = 1, cost = 1000,},
				},
			},
		},
		subsystems =
		{
			{
				class = "mothership",
				prob = 0,
				items =
				{
					{type = "Hgn_MS_Module_Research", name = "Mothership Research Module", prob = 1, cost = 1500,},
					{type = "Hgn_C_Module_Research", name = "Carrier Research Module", prob = 1, cost = 1500,},
					{type = "Hgn_C_Module_FireControl", name = "Carrier Fire Control Tower", prob = 1, cost = 1500,},
					{type = "Hgn_C_Module_FireControl_nores", name = "Carrier Fire Control Tower", prob = 0, cost = 1500,},
					{type = "Hgn_C_Module_HyperspaceInhibitor", name = "Carrier Gravity Well Generator", prob = 1, cost = 1500,},
					{type = "Hgn_MS_Module_CloakGenerator", name = "Mothership Cloak Generator", prob = 1, cost = 750,},
					{type = "Hgn_SY_Production_CapShip", name = "Shipyard Capital Class Facility", prob = 1, cost = 1800,},
					{type = "Hgn_MS_Module_FireControl", name = "Mothership Fire Control Tower", prob = 1, cost = 1500,},
					{type = "Hgn_MS_Module_FireControl_nores", name = "Mothership Fire Control Tower", prob = 0, cost = 1500,},
					{type = "Hgn_MS_Production_CapShip", name = "Mothership Capital Class Facility", prob = 1, cost = 1800,},
					{type = "Hgn_C_Module_ResearchAdvanced", name = "Carrier Adv. Research Module", prob = 1, cost = 2250,},
					{type = "Hgn_MS_Module_HyperspaceInhibitor", name = "Mothership Gravity Well Generator", prob = 1, cost = 1500,},
					{type = "Hgn_C_Module_CloakGenerator", name = "Carrier Cloak Generator", prob = 1, cost = 750,},
					{type = "Hgn_MS_Module_Hyperspace", name = "Mothership Hyperspace Module", prob = 1, cost = 1000,},
					{type = "Hgn_MS_Module_ResearchAdvanced", name = "Mothership Adv. Research Module", prob = 1, cost = 2250,},
					{type = "Hgn_C_Module_Hyperspace", name = "Carrier Hyperspace Module", prob = 1, cost = 1000,},
				},
			},
			{
				class = "cruiser",
				prob = 0,
				items =
				{
				},
			},
			{
				class = "carrier",
				prob = 0.05,
				items =
				{
				},
			},
			{
				class = "destroyer",
				prob = 0.15,
				items =
				{
				},
			},
			{
				class = "frigate",
				prob = 0.35,
				items =
				{
					{type = "Hgn_MS_Production_Frigate", name = "Mothership Frigate Facility", prob = 1, cost = 1000,},
					{type = "Hgn_C_Production_Frigate", name = "Carrier Frigate Facility", prob = 1, cost = 1000,},
				},
			},
			{
				class = "corvette",
				prob = 0.55,
				items =
				{
					{type = "Hgn_MS_Production_Corvette", name = "Mothership Corvette Facility", prob = 1, cost = 800,},
					{type = "Hgn_C_Production_Corvette", name = "Carrier Corvette Facility", prob = 1, cost = 800,},
				},
			},
			{
				class = "fighter",
				prob = 0.75,
				items =
				{
					{type = "Hgn_MS_Production_Fighter", name = "Mothership Fighter Facility", prob = 1, cost = 500,},
					{type = "Hgn_C_Production_Fighter", name = "Carrier Fighter Facility", prob = 1, cost = 500,},
				},
			},
			{
				class = "platform",
				prob = 0.8,
				items =
				{
					{type = "Hgn_C_Module_PlatformControl", name = "Carrier Platform Control Module", prob = 1, cost = 500,},
					{type = "Hgn_MS_Module_PlatformControl", name = "Mothership Platform Control Module", prob = 1, cost = 500,},
				},
			},
			{
				class = "resource",
				prob = 0.92,
				items =
				{
				},
			},
			{
				class = "noncombat",
				prob = 1,
				items =
				{
					{type = "Hgn_MS_Sensors_DetectCloaked", name = "Mothership Anti-Cloaking Sensors", prob = 1, cost = 250,},
					{type = "Hgn_MS_Sensors_AdvancedArray", name = "Mothership Advanced Sensors Array", prob = 1, cost = 250,},
					{type = "Hgn_C_Sensors_DetectHyperspace", name = "Carrier Hyperspace Sensors", prob = 1, cost = 250,},
					{type = "Hgn_C_Sensors_DetectCloaked", name = "Carrier Anti-Cloaking Sensors", prob = 1, cost = 250,},
					{type = "Hgn_C_Sensors_AdvancedArray", name = "Carrier Advanced Sensors Array", prob = 1, cost = 250,},
					{type = "Hgn_MS_Sensors_DetectHyperspace", name = "Mothership Hyperspace Sensors", prob = 1, cost = 250,},
				},
			},
		},
		ships =
		{
			{
				class = "mothership",
				prob = 0,
				items =
				{
					{type = "Hgn_Mothership", name = "Mothership", prob = 1, cost = 8000,},
					{type = "Hgn_Mothership_Nores", name = "Mothership", prob = 0, cost = 8000,},
				},
			},
			{
				class = "cruiser",
				prob = 0,
				items =
				{
					{type = "Hgn_Battlecruiser", name = "Battlecruiser", prob = 1, cost = 4000,},
					{type = "Hgn_Battlecruiser_nores", name = "Battlecruiser", prob = 0, cost = 4000,},
				},
			},
			{
				class = "carrier",
				prob = 0.05,
				items =
				{
					{type = "Hgn_Carrier", name = "Carrier", prob = 0.9, cost = 2800,},
					{type = "Hgn_Carrier_nores", name = "Carrier", prob = 0, cost = 2800,},
					{type = "Hgn_Shipyard", name = "Shipyard", prob = 1, cost = 3500,},
					{type = "Hgn_Shipyard_nores", name = "Shipyard", prob = 0, cost = 3500,},
					{type = "Hgn_Shipyard_Elohim", name = "Shipyard", prob = 1, cost = 3200,},
				},
			},
			{
				class = "destroyer",
				prob = 0.15,
				items =
				{
					{type = "Hgn_Destroyer", name = "Destroyer", prob = 1, cost = 2000,},
				},
			},
			{
				class = "frigate",
				prob = 0.35,
				items =
				{
					{type = "Hgn_AssaultFrigate", name = "Flak Frigate", prob = 0.2, cost = 700,},
					{type = "Hgn_DefenseFieldFrigate", name = "Defense Field Frigate", prob = 0.4, cost = 1250,},
					{type = "Hgn_IonCannonFrigate", name = "Ion Frigate", prob = 0.6, cost = 700,},
					{type = "Hgn_MarineFrigate", name = "Marine Frigate", prob = 0.7, cost = 700,},
					{type = "Hgn_MarineFrigate_Soban", name = "Marine Frigate", prob = 0.8, cost = 700,},
					{type = "Hgn_TorpedoFrigate", name = "Torpedo Frigate", prob = 1, cost = 700,},
				},
			},
			{
				class = "corvette",
				prob = 0.55,
				items =
				{
					{type = "Hgn_AssaultCorvette", name = "Gunship", prob = 0.4, cost = 625,},
					{type = "Hgn_PulsarCorvette", name = "Pulsar Gunship", prob = 0.9, cost = 625,},
					{type = "Hgn_MinelayerCorvette", name = "Minelayer", prob = 1, cost = 800,},
				},
			},
			{
				class = "fighter",
				prob = 0.75,
				items =
				{
					{type = "Hgn_Scout", name = "Scout", prob = 0.3, cost = 350,},
					{type = "Hgn_AttackBomber", name = "Bomber", prob = 0.5, cost = 550,},
					{type = "Hgn_Interceptor", name = "Interceptor", prob = 1, cost = 500,},
				},
			},
			{
				class = "platform",
				prob = 0.8,
				items =
				{
					{type = "Hgn_GunTurret", name = "Gun Platform", prob = 0.5, cost = 300,},
					{type = "Hgn_IonTurret", name = "Ion Beam Platform", prob = 1, cost = 300,},
				},
			},
			{
				class = "resource",
				prob = 0.92,
				items =
				{
					{type = "Hgn_ResourceCollector", name = "Resource Collector", prob = 0.7, cost = 400,},
					{type = "Hgn_ResourceController", name = "Mobile Refinery", prob = 1, cost = 800,},
				},
			},
			{
				class = "noncombat",
				prob = 1,
				items =
				{
					{type = "Hgn_ProximitySensor", name = "Proximity Sensor", prob = 0.3, cost = 250,},
					{type = "Hgn_ECMProbe", name = "Sensors Distortion Probe", prob = 0.6, cost = 600,},
					{type = "Hgn_Probe", name = "Probe", prob = 1, cost = 150,},
				},
			},
		},
	},
	vaygr =
	{
		research =
		{
			{
				class = "mothership",
				prob = 0.1,
				items =
				{
					{type = "MothershipBUILDSPEEDUpgrade1", name = "Mothership BuildSpeed", prob = 0.2, cost = 1000,},
					{type = "SuperCapHealthUpgrade1", name = "Capital Ship Hull  1", prob = 0.4, cost = 1000,},
					{type = "SuperCapSpeedUpgrade1", name = "Capital Ship Engines 1", prob = 0.6, cost = 1000,},
					{type = "SuperCapHealthUpgrade2", name = "Capital Ship Hull  2", prob = 0.8, cost = 1000,},
					{type = "SuperCapSpeedUpgrade2", name = "Capital Ship Engines 2", prob = 1, cost = 1000,},
				},
			},
			{
				class = "cruiser",
				prob = 0.2,
				items =
				{
					{type = "BattlecruiserIonWeapons", name = "Battlecruiser Chassis", prob = 1, cost = 1000,},
				},
			},
			{
				class = "carrier",
				prob = 0.3,
				items =
				{
					{type = "CarrierBUILDSPEEDUpgrade1", name = "Carrier BuildSpeed", prob = 0.5, cost = 1000,},
					{type = "ShipyardBUILDSPEEDUpgrade1", name = "Shipyard BuildSpeed", prob = 1, cost = 1000,},
				},
			},
			{
				class = "destroyer",
				prob = 0.4,
				items =
				{
					{type = "DestroyerGuns", name = "Destroyer Chassis", prob = 1, cost = 1000,},
				},
			},
			{
				class = "frigate",
				prob = 0.5,
				items =
				{
					{type = "FrigateTech", name = "Frigate Chassis", prob = 0.14, cost = 1000,},
					{type = "FrigateAssault", name = "Assault Frigate Chassis", prob = 0.28, cost = 1000,},
					{type = "FrigateHealthUpgrade1", name = "Frigate Class Armor 1", prob = 0.42, cost = 1000,},
					{type = "FrigateSpeedUpgrade1", name = "Frigate Class Engines 1", prob = 0.5600000000000001, cost = 1000,},
					{type = "FrigateHealthUpgrade2", name = "Frigate Class Armor 2", prob = 0.7, cost = 1000,},
					{type = "SpeedUpgrade2", name = "Frigate Class Engines 2", prob = 0.84, cost = 1000,},
					{type = "FrigateInfiltrationTech", name = "Infiltration Pods", prob = 1, cost = 1000,},
				},
			},
			{
				class = "corvette",
				prob = 0.6,
				items =
				{
					{type = "CorvetteTech", name = "Corvette Chassis", prob = 0.13, cost = 1000,},
					{type = "CorvetteLaser", name = "Corvette Laser Systems", prob = 0.26, cost = 1000,},
					{type = "CorvetteCommand", name = "Command Corvette Systems", prob = 0.39, cost = 1000,},
					{type = "CorvetteHealthUpgrade1", name = "Corvette Class Armor 1", prob = 0.52, cost = 1000,},
					{type = "CorvetteSpeedUpgrade1", name = "Corvette Class Engines 1", prob = 0.65, cost = 1000,},
					{type = "CorvetteHealthUpgrade2", name = "Corvette Class Armor 2", prob = 0.78, cost = 1000,},
					{type = "CorvetteSpeedUpgrade2", name = "Corvette Class Engines 2", prob = 0.91, cost = 1000,},
					{type = "CorvetteGraviticAttraction", name = "Corvette Minelaying Systems", prob = 1, cost = 1000,},
				},
			},
			{
				class = "fighter",
				prob = 0.7,
				items =
				{
					{type = "LanceBeams", name = "Lance Beams", prob = 0.17, cost = 1000,},
					{type = "PlasmaBombs", name = "Fusion Bombs", prob = 0.34, cost = 1000,},
					{type = "FighterspeedUpgrade1", name = "Fighter Class Engines 1", prob = 0.51, cost = 1000,},
					{type = "FighterspeedUpgrade2", name = "Fighter Class Engines 2", prob = 0.6800000000000001, cost = 1000,},
					{type = "ScoutEMPAbility", name = "Scout Electro-Magnetic Pulse", prob = 0.85, cost = 1000,},
					{type = "BomberImprovedBombs", name = "Improved Bombs", prob = 1, cost = 1000,},
				},
			},
			{
				class = "platform",
				prob = 0.8,
				items =
				{
					{type = "PlatformHeavyMissiles", name = "Platform Heavy Missile System", prob = 0.25, cost = 1000,},
					{type = "PlatformHealthUpgrade1", name = "Platform Class Armor 1", prob = 0.5, cost = 1000,},
					{type = "PlatformHealthUpgrade2", name = "Platform Class Armor 2", prob = 0.75, cost = 1000,},
					{type = "HyperspaceGateTech", name = "Hyperspace Gate Generators", prob = 1, cost = 1000,},
				},
			},
			{
				class = "resource",
				prob = 0.9,
				items =
				{
					{type = "UtilityHealthUpgrade1", name = "Utility Class Armor 1", prob = 0.33, cost = 1000,},
					{type = "UtilityHealthUpgrade2", name = "Utility Class Armor 2", prob = 0.66, cost = 1000,},
					{type = "RepairAbility", name = "Resource Collector Repair Systems", prob = 1, cost = 1000,},
				},
			},
			{
				class = "noncombat",
				prob = 1,
				items =
				{
					{type = "ProbeSensorDisruption", name = "Sensors Distortion Probe", prob = 0.5, cost = 1000,},
					{type = "ProbeProxSensor", name = "Proximity Sensor Probe", prob = 1, cost = 1000,},
				},
			},
		},
		subsystems =
		{
			{
				class = "mothership",
				prob = 0,
				items =
				{
					{type = "Vgr_C_Module_FireControl", name = "Carrier Fire Control Tower", prob = 1, cost = 1500,},
					{type = "Vgr_MS_Module_CloakGenerator", name = "Mothership Cloak Generator", prob = 1, cost = 750,},
					{type = "Vgr_MS_Module_HyperspaceInhibitor", name = "Mothership Gravity Well Generator", prob = 1, cost = 1500,},
					{type = "Vgr_C_Module_HyperspaceInhibitor", name = "Carrier Gravity Well Generator", prob = 1, cost = 1500,},
					{type = "Vgr_C_Module_Hyperspace", name = "Carrier Hyperspace Module", prob = 1, cost = 1000,},
					{type = "Vgr_MS_Module_Research", name = "Mothership Research Module", prob = 1, cost = 500,},
					{type = "Vgr_MS_Production_CapShip", name = "Mothership Capital Class Facility", prob = 1, cost = 1250,},
					{type = "Vgr_C_Module_CloakGenerator", name = "Carrier Cloak Generator", prob = 1, cost = 750,},
					{type = "Vgr_MS_Module_FireControl", name = "Mothership Fire Control Tower", prob = 1, cost = 1500,},
					{type = "Vgr_SY_Production_CapShip", name = "Shipyard Capital Class Facility", prob = 1, cost = 1250,},
					{type = "Vgr_C_Module_Research", name = "Carrier Research Module", prob = 1, cost = 500,},
					{type = "Vgr_MS_Module_Hyperspace", name = "Mothership Hyperspace Module", prob = 1, cost = 1000,},
				},
			},
			{
				class = "cruiser",
				prob = 0,
				items =
				{
				},
			},
			{
				class = "carrier",
				prob = 0.05,
				items =
				{
				},
			},
			{
				class = "destroyer",
				prob = 0.15,
				items =
				{
				},
			},
			{
				class = "frigate",
				prob = 0.35,
				items =
				{
					{type = "Vgr_C_Production_Frigate", name = "Carrier Frigate Facility", prob = 1, cost = 900,},
					{type = "Vgr_MS_Production_Frigate", name = "Mothership Frigate Facility", prob = 1, cost = 900,},
				},
			},
			{
				class = "corvette",
				prob = 0.55,
				items =
				{
					{type = "Vgr_C_Production_Corvette", name = "Carrier Corvette Facility", prob = 1, cost = 725,},
					{type = "Vgr_MS_Production_Corvette", name = "Mothership Corvette Facility", prob = 1, cost = 725,},
					{type = "Vgr_C_Production_Corvette_carrieronly", name = "Mothership Corvette Facility", prob = 0, cost = 725,},
				},
			},
			{
				class = "fighter",
				prob = 0.75,
				items =
				{
					{type = "Vgr_C_Production_Fighter", name = "Carrier Fighter Facility", prob = 1, cost = 450,},
					{type = "Vgr_MS_Production_Fighter", name = "Mothership Fighter Facility", prob = 1, cost = 450,},
					{type = "Vgr_C_Production_Fighter_carrieronly", name = "Mothership Fighter Facility", prob = 0, cost = 450,},
				},
			},
			{
				class = "platform",
				prob = 0.8,
				items =
				{
					{type = "Vgr_C_Module_PlatformControl", name = "Carrier Platform Control Module", prob = 1, cost = 625,},
					{type = "Vgr_MS_Module_PlatformControl", name = "Mothership Platform Control Module", prob = 1, cost = 625,},
				},
			},
			{
				class = "resource",
				prob = 0.92,
				items =
				{
				},
			},
			{
				class = "noncombat",
				prob = 1,
				items =
				{
					{type = "Vgr_C_Sensors_DetectHyperspace", name = "Carrier Hyperspace Sensors", prob = 1, cost = 250,},
					{type = "Vgr_MS_Sensors_AdvancedArray", name = "Mothership Advanced Sensors Array", prob = 1, cost = 250,},
					{type = "Vgr_C_Sensors_AdvancedArray", name = "Carrier Advanced Sensors Array", prob = 1, cost = 250,},
					{type = "Vgr_MS_Sensors_DetectHyperspace", name = "Mothership Hyperspace Sensors", prob = 1, cost = 250,},
				},
			},
		},
		ships =
		{
			{
				class = "mothership",
				prob = 0,
				items =
				{
					{type = "Vgr_Mothership", name = "Mothership", prob = 1, cost = 8000,},
					{type = "Vgr_Mothership_Makaan", name = "Mothership", prob = 1, cost = 8000,},
				},
			},
			{
				class = "cruiser",
				prob = 0,
				items =
				{
					{type = "Vgr_BattleCruiser", name = "Battlecruiser", prob = 1, cost = 4000,},
				},
			},
			{
				class = "carrier",
				prob = 0.05,
				items =
				{
					{type = "Vgr_Carrier", name = "Carrier", prob = 0.9, cost = 1700,},
					{type = "Vgr_ShipYard", name = "Shipyard", prob = 1, cost = 4000,},
					{type = "Vgr_Carrier_CarrierOnly", name = "Carrier", prob = 0, cost = 1700,},
				},
			},
			{
				class = "destroyer",
				prob = 0.15,
				items =
				{
					{type = "Vgr_Destroyer", name = "Destroyer", prob = 1, cost = 2000,},
				},
			},
			{
				class = "frigate",
				prob = 0.35,
				items =
				{
					{type = "Vgr_AssaultFrigate", name = "Assault Frigate", prob = 0.4, cost = 700,},
					{type = "Vgr_HeavyMissileFrigate", name = "Heavy Missile Frigate", prob = 0.75, cost = 700,},
					{type = "Vgr_InfiltratorFrigate", name = "Infiltrator Frigate", prob = 1, cost = 800,},
				},
			},
			{
				class = "corvette",
				prob = 0.55,
				items =
				{
					{type = "Vgr_LaserCorvette", name = "Laser Corvette", prob = 0.4, cost = 650,},
					{type = "Vgr_MissileCorvette", name = "Missile Corvette", prob = 0.8, cost = 625,},
					{type = "Vgr_CommandCorvette", name = "Command Corvette", prob = 0.9, cost = 400,},
					{type = "Vgr_MinelayerCorvette", name = "Minelayer", prob = 1, cost = 800,},
				},
			},
			{
				class = "fighter",
				prob = 0.75,
				items =
				{
					{type = "Vgr_Scout", name = "Survey Scout", prob = 0.25, cost = 350,},
					{type = "Vgr_Bomber", name = "Bomber", prob = 0.5, cost = 550,},
					{type = "Vgr_Interceptor", name = "Assault Craft", prob = 0.75, cost = 500,},
					{type = "Vgr_LanceFighter", name = "Lance Fighter", prob = 1, cost = 500,},
				},
			},
			{
				class = "platform",
				prob = 0.8,
				items =
				{
					{type = "Vgr_WeaponPlatform_gun", name = "Gun Platform", prob = 0.4, cost = 300,},
					{type = "Vgr_WeaponPlatform_missile", name = "Heavy Missile Platform", prob = 0.8, cost = 300,},
					{type = "Vgr_HyperSpace_Platform", name = "Hyperspace Gate", prob = 1, cost = 750,},
				},
			},
			{
				class = "resource",
				prob = 0.92,
				items =
				{
					{type = "Vgr_ResourceCollector", name = "Resource Collector", prob = 0.7, cost = 400,},
					{type = "Vgr_ResourceController", name = "Mobile Refinery", prob = 1, cost = 800,},
				},
			},
			{
				class = "noncombat",
				prob = 1,
				items =
				{
					{type = "Vgr_Probe_Prox", name = "Proximity Sensor", prob = 0.3, cost = 250,},
					{type = "Vgr_Probe_ECM", name = "Sensors Distortion Probe", prob = 0.6, cost = 500,},
					{type = "Vgr_Probe", name = "Probe", prob = 1, cost = 150,},
				},
			},
		},
	},
}
