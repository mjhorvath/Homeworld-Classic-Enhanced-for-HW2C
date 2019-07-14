-- Pretty-Printed using HW2 Pretty-Printer 1.27 by Mikail.
-- Displays detailed information about unit caps when the user																																				
--  mouses over the units menu
--UnitCapInfoPopupWidth = 225
UnitCapInfoPopupWidth = 200
MAXHEIGHT = 325

UnitCapInfoPopup = 
{
	maxColor = 
	{
		255,
		0,
		0,
		255,
	},
	-- color for max pop reached
	availColor = 
	{
		0,
		255,
		0,
		255,
	},
	-- color for pop available
	size = 
	{
		0,
		0,
		800,
		600,
	},
	RootElementSettings = 
	{
		autosize = 1,
	},
	onShow = "UI_HideScreen('BuildQueueMenu')",
	stylesheet = "HW2StyleSheet",
	-- Flags
	pixelUVCoords = 1,
	-- Enter pixel coords for texture coords	
	clickThrough = 1,
	;
	-- Tab spacer frame to clone
	{
		type = "Frame",
		name = "frmTabSpacer",
		size = 
		{
			10,
			15,
		},
		giveParentMouseInput = 1,
	},
	-- Title to clone
	{
		type = "TextLabel",
		name = "lblNameToClone",
		position = 
		{
			4,
			0,
		},
		size = 
		{
			UnitCapInfoPopupWidth - 16,
			15,
		},
		Text = 
		{
			textStyle = "IGHeading2",
		},
		giveParentMouseInput = 1,
		dropShadow = 1,
		visible = 0,
	},
	-- Unit cap item to clone
	{
		type = "Frame",
		name = "frmItemToClone",
		autosize = 1,
		giveParentMouseInput = 1,
		visible = 0,
		;
		{
			type = "Frame",
			name = "frmName",
			position = 
			{
				4,
				0,
			},
			size = 
			{
				UnitCapInfoPopupWidth - 50,
				15,
			},
			autoarrange = 1,
			autoarrangeWidth = 300,
			-- this is needed b/c of spacers
			
		},
		{
			type = "TextLabel",
			name = "lblUnitCap",
			position = 
			{
				UnitCapInfoPopupWidth - 46,
				0,
			},
			size = 
			{
				45,
				15,
			},
			Text = 
			{
				font = "ChatFont",
				color = 
				{
					255,
					255,
					255,
					255,
				},
				hAlign = "Right",
				vAlign = "Middle",
				text = "<c %06x>%d</c> \/ %d",
				offset = 
				{
					 - 6,
					0,
				},
			},
			giveParentMouseInput = 1,
			dropShadow = 1,
		},
	},
	{
		type = "Frame",
		position = {2,104},
		size = 
		{
			100,
			200,
		},
		autosize = 1,
		backgroundColor = "IGColorBackground1",
		giveParentMouseInput = 1,
		autoarrange = 1,
		autoarrangeWidth = UnitCapInfoPopupWidth,
		maxSize = 
		{
			UnitCapInfoPopupWidth,
			MAXHEIGHT,
		},
		;
		-- Frame to hold all unit caps
		{
			type = "Frame",
			name = "frmItems",
			autosize = 1,
			autoarrange = 1,
			autoarrangeWidth = UnitCapInfoPopupWidth,
			giveParentMouseInput = 1,
		},
	},
	-- TEA
	{
		type = "Frame",
		position = {0, 0},
		size = {800, 100},
		giveParentMouseInput = 1,
		;
		-- player
		{
			type = "TextLabel",
			name= "TEA_Player_0",
			giveParentMouseInput = 1,
			position = {2, 2},
			size = {94, 16},
			backgroundColor = "IGColorBackground1",
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
				text = "PLAYER:",
			},
		},
		{
			type = "TextLabel",
			name= "TEA_Player_1",
			giveParentMouseInput = 1,
			position = {2, 18},
			size = {94, 16},
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
			},
		},
		{
			type = "TextLabel",
			name= "TEA_Player_2",
			giveParentMouseInput = 1,
			position = {2, 34},
			size = {94, 16},
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
			},
		},
		{
			type = "TextLabel",
			name= "TEA_Player_3",
			giveParentMouseInput = 1,
			position = {2, 50},
			size = {94, 16},
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
			},
		},
		{
			type = "TextLabel",
			name= "TEA_Player_4",
			giveParentMouseInput = 1,
			position = {2, 66},
			size = {94, 16},
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
			},
		},
		{
			type = "TextLabel",
			name= "TEA_Player_5",
			giveParentMouseInput = 1,
			position = {2, 82},
			size = {94, 16},
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
			},
		},
		{
			type = "TextLabel",
			name= "TEA_Player_6",
			giveParentMouseInput = 1,
			position = {2, 98},
			size = {94, 16},
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
			},
		},
		-- race
		{
			type = "TextLabel",
			name= "TEA_Race_0",
			giveParentMouseInput = 1,
			position = {98, 2},
			size = {30, 16},
			backgroundColor = "IGColorBackground1",
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
				text = "RACE:",
			},
		},
		-- rus
		{
			type = "TextLabel",
			name= "TEA_RUs_0",
			giveParentMouseInput = 1,
			position = {130, 2},
			size = {30, 16},
			backgroundColor = "IGColorBackground1",
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
				text = "RUs:",
			},
		},
		-- researching
		{
			type = "TextLabel",
			name= "TEA_Researching_0",
			giveParentMouseInput = 1,
			position = {162, 2},
			size = {94, 16},
			backgroundColor = "IGColorBackground1",
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
				text = "RESEARCHING:",
			},
		},
		-- building
		{
			type = "TextLabel",
			name= "TEA_Building_0",
			giveParentMouseInput = 1,
			position = {258, 2},
			size = {318, 16},
			backgroundColor = "IGColorBackground1",
			Text =
			{
				textStyle = "IGHeading2",
				hAlign = "Left",
				offset = {4, 1},
				color = { 255, 255, 255, 255},
				text = "BUILDING:",
			},
		},
	},
}

