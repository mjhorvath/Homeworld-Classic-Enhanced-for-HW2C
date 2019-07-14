-- Research, ships & modules restricted by individual gamerules
RestrictedBy =
{
	MPRestrict =
	{
		hiigaran =
		{
			build =
			{
				"Hgn_Shipyard_SPG",
				"Hgn_MS_Production_CorvetteMover",
				"Kpr_Mover",
			},
			research =
			{
				-- hiigaran, singleplayer
				"AssaultCorvetteEliteWeaponUpgrade",	-- would like to enable this, just for fun
				"AttackBomberEliteWeaponUpgrade",	-- would like to enable this, just for fun
				"SensorsDowngrade1",
				"SensorsDowngrade2",
				"SensorsDowngrade3",
				"SensorsBackToNormal1",
				"SensorsBackToNormal2",
				"SensorsBackToNormal3",
				"MoverHealthDowngrade",
				"MoverHealthUpgrade",
				"FrigateHealthUpgradeSPGAME",
				"DamageMoverTech",
				"KeeperHealthUpgradeSPGAME_LOW",
				"KeeperHealthUpgradeSPGAME_MED",
				"KeeperHealthUpgradeSPGAME_HIGH",
				"KeeperWeaponUpgradeSPGAME_M10_LVL_1",
				"KeeperWeaponUpgradeSPGAME_M10_LVL_2",
				"KeeperWeaponUpgradeSPGAME_M10_LVL_3",
				"KeeperWeaponUpgradeSPGAME_M10_LVL_4",
				"KeeperWeaponUpgradeSPGAME_M10_LVL_5",
				"KeeperWeaponUpgradeSPGAME_M10_LVL_6",
				"KeeperHealthUpgradeSPGAME_M10_LVL_1",
				"KeeperHealthUpgradeSPGAME_M10_LVL_2",
				"KeeperHealthUpgradeSPGAME_M10_LVL_3",
				"AttackDroidHealthUpgradeSPGAME_LOW",
				"AttackDroidHealthUpgradeSPGAME_MED",
				"AttackDroidHealthUpgradeSPGAME_HIGH",
				"AttackDroidWeaponUpgradeSPGAME_LOW",
				"AttackDroidWeaponUpgradeSPGAME_MED",
				"AttackDroidWeaponUpgradeSPGAME_HIGH",
				"RadiationDefenseField",
			},
		},
		vaygr =
		{
			build =
			{
				"Vgr_PlanetKillerMissile",
			},
			research =
			{
				-- vaygr, singleplayer
				"WeakVgrHeavyMissiles",
				"HyperspaceRecoveryTimeUpgradeSPGAME",
				"HyperspaceTransitionTimeUpgradeSPGAME",
				"VaygrCarrierHealthRegenDowngrade",
				"ShipyardSpeedDowngradeSPGAME",
				"SuperCapHealthUpgradeSPGAME",
				"VaygrFrigateHealthUpgradeSPGAME",
				"VaygrFrigateHealthRegenDowngradeSPGAME",
				"CorvetteHealthUpgradeSPGAME",
				"ExtraStrongVgrHeavyMissilesSPGAME",
				"VaygrCaptureHack",
				"VaygrReduceCaptureHack",
				"VaygrRadiationImmunityHack",
				"VaygrCarrierHealthUpgrade",
			},
		},
	},
	-- these don't appear in build.lua, so trying to grant or restrict them results in an error
	motherships =
	{
		hiigaran =
		{
			build =
			{
				"Hgn_Mothership",
				"Hgn_Mothership_nores",
			},
			research = {},
		},
		vaygr =
		{
			build =
			{
				"vgr_mothership",
				"vgr_mothership_makaan",
			},
			research = {},
		},
	},
	-- "Start With" is set to "Mothership".
	StartWithMothership = 
	{
		hiigaran =
		{
			build =
			{
			},
			research =
			{
				"CarrierHealthUpgrade1_carrieronly",
				"CarrierHealthUpgrade2_carrieronly",
				"CarrierMAXSPEEDUpgrade1_carrieronly",
				"CarrierMAXSPEEDUpgrade2_carrieronly",
				"CarrierBUILDSPEEDUpgrade1_carrieronly",
			},
		},
		vaygr =
		{
			build =
			{
				"Vgr_Carrier_carrieronly",
				"Vgr_C_Production_Fighter_carrieronly",
				"Vgr_C_Production_Corvette_carrieronly",
			},
			research =
			{
				"SuperCapHealthUpgrade1_carrieronly",
				"SuperCapHealthUpgrade2_carrieronly",
				"SuperCapSpeedUpgrade1_carrieronly",
				"SuperCapSpeedUpgrade2_carrieronly",
				"CarrierBUILDSPEEDUpgrade1_carrieronly",
			},
		},
	},
	-- "Start With" is set to "Carrier Only".
	StartWithCarrierOnly = 
	{
		hiigaran =
		{
			build =
			{
				"Hgn_Shipyard",
				"Hgn_Shipyard_nores",
			},
			research =
			{
				"CarrierHealthUpgrade1",
				"CarrierHealthUpgrade2",
				"CarrierMAXSPEEDUpgrade1",
				"CarrierMAXSPEEDUpgrade2",
				"CarrierBUILDSPEEDUpgrade1",
			},
		},
		vaygr =
		{
			build =
			{
				"Vgr_Shipyard",
				"Vgr_Carrier",
				"Vgr_C_Production_Fighter",
				"Vgr_C_Production_Corvette",
			},
			research =
			{
				"SuperCapHealthUpgrade1",
				"SuperCapHealthUpgrade2",
				"SuperCapSpeedUpgrade1",
				"SuperCapSpeedUpgrade2",
				"CarrierBUILDSPEEDUpgrade1",
			},
		},
	},
	-- "Start With" is set to "HW1 Map Default".
	StartWithMapDefault = 
	{
		hiigaran =
		{
			build =
			{
			},
			research =
			{
				"CarrierHealthUpgrade1_carrieronly",
				"CarrierHealthUpgrade2_carrieronly",
				"CarrierMAXSPEEDUpgrade1_carrieronly",
				"CarrierMAXSPEEDUpgrade2_carrieronly",
				"CarrierBUILDSPEEDUpgrade1_carrieronly",
			},
		},
		vaygr =
		{
			build =
			{
				"Vgr_CarrierOnly_carrieronly",
				"Vgr_C_Production_Fighter_carrieronly",
				"Vgr_C_Production_Corvette_carrieronly",
			},
			research =
			{
				"SuperCapHealthUpgrade1_carrieronly",
				"SuperCapHealthUpgrade2_carrieronly",
				"SuperCapSpeedUpgrade1_carrieronly",
				"SuperCapSpeedUpgrade2_carrieronly",
				"CarrierBUILDSPEEDUpgrade1_carrieronly",
			},
		},
	},
	-- "Research" is set to "Off".
	ResearchOff =
	{
		hiigaran =
		{
			build =
			{
				"Hgn_C_Module_FireControl",
				"Hgn_MS_Module_FireControl",
				"Hgn_C_Module_ResearchAdvanced",
				"Hgn_MS_Module_ResearchAdvanced",
				"Hgn_Carrier",
				"Hgn_Shipyard",
				"Hgn_Battlecruiser",
			},
			research =
			{
			},
		},
		vaygr =
		{
			build =
			{
			},
			research =
			{
			},
		},
	},
	-- "Research" is set to "On".
	ResearchOn = 
	{
		hiigaran =
		{
			build =
			{
				"Hgn_C_Module_FireControl_nores",
				"Hgn_MS_Module_FireControl_nores",
				"Hgn_Carrier_nores",
				"Hgn_Shipyard_nores",
				"Hgn_Battlecruiser_nores",
			},
			research =
			{
			},
		},
		vaygr =
		{
			build =
			{
			},
			research =
			{
			},
		},
	},
	-- "Hyperspace" is set to "Off".
	HyperspaceOff =
	{
		hiigaran =
		{
			build =
			{
				"Hgn_C_Module_Hyperspace",
				"Hgn_C_Module_HyperspaceInhibitor",
				"Hgn_C_Sensors_DetectHyperspace",
				"Hgn_MS_Module_Hyperspace",
				"Hgn_MS_Module_HyperspaceInhibitor",
				"Hgn_MS_Sensors_DetectHyperspace",
			},
			research =
			{
				"HyperspaceCostUpgrade1",
				"HyperspaceCostUpgrade2",
			},
		},
		vaygr =
		{
			build =
			{
				"Vgr_C_Module_Hyperspace",
				"Vgr_C_Module_HyperspaceInhibitor",
				"Vgr_C_Sensors_DetectHyperspace",
				"Vgr_MS_Module_Hyperspace",
				"Vgr_MS_Module_HyperspaceInhibitor",
				"Vgr_MS_Sensors_DetectHyperspace",
				"Vgr_HyperSpace_Platform",
			},
			research =
			{
				"HyperspaceGateTech",
			},
		},
	},
	-- "Research" is set to "On".
	HyperspaceOn =
	{
		hiigaran =
		{
			build =
			{
			},
			research =
			{
			},
		},
		vaygr =
		{
			build =
			{
			},
			research =
			{
			},
		},
	},
	-- resourcing is disabled.
	ResourceOff =
	{
		hiigaran =
		{
			build =
			{
				"Hgn_ResourceCollector",
				"Hgn_ResourceController",
			},
			research =
			{
			},
		},
		vaygr =
		{
			build =
			{
				"Vgr_ResourceCollector",
				"Vgr_ResourceController",
			},
			research =
			{
			},
		},
	},
	-- resourcing is enabled.
	ResourceOn =
	{
		hiigaran =
		{
			build =
			{
			},
			research =
			{
			},
		},
		vaygr =
		{
			build =
			{
			},
			research =
			{
			},
		},
	},
}
