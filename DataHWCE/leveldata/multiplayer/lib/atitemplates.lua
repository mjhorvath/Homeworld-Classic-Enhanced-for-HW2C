TEA_PlayerResearch	= 0
TEA_PlayerName		= 1
TEA_PlayerRace		= 2
TEA_PlayerRUs		= 3
TEA_PlayerBuild		= 4
TEA_PlayerColour	= 5
TEA_Parameters		= 6
BEN_PlayerResearch	= 0
BEN_Parameters		= 1
FLT_PlayerItem		= 0
FLT_Parameters		= 1
BOU_PlayerName		= 0
BOU_PlayerBounty	= 1
BOU_PlayerColour	= 2
BOU_Parameters		= 3
TIM_GameTime		= 0
TIM_Parameters		= 1
MSG_CloseMe		= 0
MSG_Parameters		= 1

SCAR_ATITemplates =
{
	MSG_Template =
	{
		{
			stringParam = MSG_CloseMe,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyHorizCentre"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = 0,
				factorY = -0.6,
				visibility = {},
			},
		},
	},
	TEA_Template =
	{
		{
			stringParam = TEA_PlayerName,
			colourParam = TEA_PlayerColour,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = -1,
				factorY = -1,
				visibility = {},
			},
		},
		{
			stringParam = TEA_PlayerRace,
			colourParam = TEA_PlayerColour,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = -0.75,
				factorY = -1,
				visibility = {},
			},
		},
		{
			stringParam = TEA_PlayerRUs,
			colourParam = TEA_PlayerColour,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = -0.625,
				factorY = -1,
				visibility = {},
			},
		},
		{
			stringParam = TEA_PlayerResearch,
			colourParam = TEA_PlayerColour,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = -0.5,
				factorY = -1,
				visibility = {},
			},
		},
		{
			stringParam = TEA_PlayerBuild,
			colourParam = TEA_PlayerColour,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = 0.0,
				factorY = -1,
				visibility = {},
			},
		},
	},
	BEN_Template =
	{
		{
			stringParam = BEN_PlayerResearch,
			text =
			{
				colour = {1,1,1,1},
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = -1,
				factorY = -1,
				visibility = {},
			},
		},
	},
	FLT_Template =
	{
		{
			stringParam = FLT_PlayerItem,
			text =
			{
				colour = {1,1,1,1},
				dropshadow = 1,
				renderFlags = {"justifyRight"},
--				LODs = {1,"default",},
--				LODs = {1,"ATIControlGroupFont",},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = -1,
				factorY = -1,
				visibility = {},
			},
		},
	},
	BOU_Template =
	{
		{
			stringParam = BOU_PlayerName,
			colourParam = BOU_PlayerColour,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = -1,
				factorY = -1,
				visibility = {},
			},
		},
		{
			stringParam = BOU_PlayerBounty,
			colourParam = BOU_PlayerColour,
			text =
			{
				dropshadow = 1,
				renderFlags = {"justifyLeft"},
				LODs = {1,"Heading4Font",},
			},
			placement2D =
			{
				factorX = 0.5,
				factorY = -1,
				visibility = {},
			},
		},
	},
	TIM_Template =
	{
		{
			stringParam = TIM_GameTime,
			text =
			{
				colour = {1,1,1,1},
				dropshadow = 1,
				renderFlags = {"justifyRight"},
				LODs = {1,"Heading2Font",},
			},
			placement2D =
			{
				factorX = -1,
				factorY = -1,
				visibility = {},
			},
		},
	},
}

