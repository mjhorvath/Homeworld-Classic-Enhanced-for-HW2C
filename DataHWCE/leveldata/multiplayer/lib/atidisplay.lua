-- this script uses ATI text to display data to the screen
-- unfortunately the method I used has issues with binding keyboard keys (see below)
-- I tried using normal UI screens, but there's no way to show wide text (e.g. player names)

-- ATI Parameter indices for bounty display (must also exist in ati.lua)
BEN_PlayerResearch 	= 0
BEN_Parameters 		= 1
TEA_PlayerResearch	= 0
TEA_PlayerName		= 1
TEA_PlayerRace		= 2
TEA_PlayerRUs		= 3
TEA_PlayerBuild		= 4
TEA_PlayerColour	= 5
TEA_Parameters		= 6
BOU_PlayerName		= 0
BOU_PlayerBounty 	= 1
BOU_PlayerColour	= 2
BOU_Parameters		= 3
FLT_PlayerItem		= 0
FLT_Parameters		= 1
TIM_GameTime		= 0
TIM_Parameters		= 1
MSG_CloseMe		= 0
MSG_Parameters		= 1

BEN_FLT_Active		= 1
TEA_Active		= 1

function ATI_init()
	ATI_LoadTemplates([[data:leveldata\multiplayer\lib\atitemplates.lua]])
	ATI_CreateParameters(BEN_Parameters)
	ATI_CreateParameters(TEA_Parameters)
	ATI_CreateParameters(BOU_Parameters)
	ATI_CreateParameters(FLT_Parameters)
	ATI_CreateParameters(TIM_Parameters)
	-- the F11 and F12 keys only work if:
	-- a) "Data\locale\english\scripts\keybindings.lua" has been modified to include the F11 and F12 keys
	-- b) you are creating a regular command-line mod instead of a gamerule mod (unless I missed some way of inserting locale data into a gamerule mod)
	-- otherwise you need to bind it to keys that are already listed in "keybindings.lua"
	-- you cannot bind two functions to the same key using UI_BindKeyEvent
	-- there's no way to differentiate between a single key press or a keyboard combo (e.g. K versus SHIFT + K)
	UI_BindKeyEvent(IKEY, "Toggle_BEN_FLT")
	UI_BindKeyEvent(QKEY, "Toggle_TEA")
	Rule_Remove("ATI_init")
	Rule_AddInterval("DisplayAllATIMessages", 1)
end

function DisplayAllATIMessages()
	ATI_Clear()
	TIM_ATI_display()
	for iPlayerIndex = 0, (Universe_PlayerCount() - 1) do
		if (iPlayerIndex == FE_GetCurrentPlayerIndex()) then
			if (BEN_FLT_Active == 1) then
				MSG_ATI_display()
				if (BentusiRoulette ~= 0) then
					BEN_ATI_display(iPlayerIndex)
				end
				if (SpecialFleets ~= 0) then
					FLT_ATI_display(iPlayerIndex)
				end
			end
			if (BOUNTY_Level > 0) then
				BOU_ATI_display()
			end
			if (TEA_Active == 1) then
				TEA_ATI_display(iPlayerIndex)
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Bentusi Roulette

function BEN_ATI_display(playerIndex)
	-- rect to left just above taskbar
	local BEN_Rectangle = {0.01, 0.1725, 0.15, 0.02}
	for i = 1, getn(BEN_GrantStrings[playerIndex + 1]) do
		local BEN_ThisString = BEN_GrantStrings[playerIndex + 1][i]
		ATI_AddString(BEN_PlayerResearch, BEN_ThisString)
		ATI_Display2D("BEN_Template", BEN_Rectangle, 0)
		BEN_Rectangle[2] = BEN_Rectangle[2] + 0.02
	end
	BEN_Rectangle = {0.17, 0.1725, 0.15, 0.02}
	for i = 1, getn(BEN_RestrictStrings[playerIndex + 1]) do
		local BEN_ThisString = BEN_RestrictStrings[playerIndex + 1][i]
		ATI_AddString(BEN_PlayerResearch, BEN_ThisString)
		ATI_Display2D("BEN_Template", BEN_Rectangle, 0)
		BEN_Rectangle[2] = BEN_Rectangle[2] + 0.02
	end
end

-------------------------------------------------------------------------------
-- Special Fleets

function FLT_ATI_display(playerIndex)
	-- rect to left just above taskbar
	local FLT_Rectangle = {0.99, 0.1725, 0.3, 0.02}
	for i = 1, getn(FLT_PlayerStrings[playerIndex + 1]) do
		local FLT_ThisString = FLT_PlayerStrings[playerIndex + 1][i]
		ATI_AddString(FLT_PlayerItem, FLT_ThisString)
		ATI_Display2D("FLT_Template", FLT_Rectangle, 0)
		FLT_Rectangle[2] = FLT_Rectangle[2] + 0.02
	end
end

-------------------------------------------------------------------------------
-- Team Progress

function TEA_ATI_display(playerIndex)
	local TEA_Rectangle = {0.01, 0.97, 0.98, 0.02,}
	local TEA_ColourNorm = {1,1,1,1}
	local TEA_ColourAlly = {1,1,0,1}
	local TEA_ColourSelf = {0,1,0,1}
	local ListCount = 1
	ATI_AddString(TEA_PlayerName, "PLAYER:")
	ATI_AddString(TEA_PlayerRace, "RACE:")
	ATI_AddString(TEA_PlayerRUs, "RUs:")
	ATI_AddString(TEA_PlayerResearch, "RESEARCHING:")
	--ATI_AddString(TEA_PlayerBuild, "BUILDING:")
	ATI_AddColour(TEA_PlayerColour, TEA_ColourNorm)
	ATI_Display2D("TEA_Template", TEA_Rectangle, 0)
	TEA_Rectangle[2] = TEA_Rectangle[2] - 0.02
	-- for every other player...
	for otherPlayerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the other player is not you but is allied to you...
--		if (otherPlayerIndex ~= playerIndex) and (AreAllied(playerIndex, otherPlayerIndex) == 1) then
		if (AreAllied(playerIndex, otherPlayerIndex) == 1) then
			local sPlayerName = Player_GetName(otherPlayerIndex)
			local sRace = Player_Races[otherPlayerIndex + 1]
			local iRUs = Player_GetRU(otherPlayerIndex)
			local aResearchList = TechList[sRace].research
			local aSubsystemList = TechList[sRace].subsystems
			local aShipList = TechList[sRace].ships
			local sResearch = "(nothing)"
			local sBuild = "(nothing)"
			local hasResearched = 0
			local hasBuilt = 0
			-- for every research class...
			for l = 1, getn(aResearchList) do
				local lCount = aResearchList[l]
				-- for every research item belonging to that class...
				for m = 1, getn(lCount.items) do
					local mCount = lCount.items[m]
					-- if the other player is researching that item...
					if (Player_HasQueuedResearch(otherPlayerIndex, mCount.type) == 1) then
						if (hasResearched == 0) then
							sResearch = mCount.name
							hasResearched = 1
						else
							sResearch = sResearch .. ", " .. mCount.name
						end
					end
				end
			end
			-- disabled this until I can come up with a better solution
			-- since there is simply too little space on the screen
			-- and I figured showing research was more important
			-- for every subsystem class...
			--for l = 1, getn(aSubsystemList) do
			--	local lCount = aSubsystemList[l]
			--	-- for every subsystem type belonging to that class...
			--	for m = 1, getn(lCount.items) do
			--		local mCount = lCount.items[m]
			--		-- if the other player is building that item...
			--		if (Player_HasQueuedBuild(otherPlayerIndex, mCount.type) == 1) then
			--			if (hasBuilt == 0) then
			--				sBuild = mCount.name
			--				hasBuilt = 1
			--			else
			--				sBuild = sBuild .. ", " .. mCount.name
			--			end
			--		end
			--	end
			--end
			-- for every ship class...
			--for l = 1, getn(aShipList) do
			--	local lCount = aShipList[l]
			--	-- for every ship type belonging to that class...
			--	for m = 1, getn(lCount.items) do
			--		local mCount = lCount.items[m]
			--		-- if the other player is building that item...
			--		if (Player_HasQueuedBuild(otherPlayerIndex, mCount.type) == 1) then
			--			if (hasBuilt == 0) then
			--				sBuild = mCount.name
			--				hasBuilt = 1
			--			else
			--				sBuild = sBuild .. ", " .. mCount.name
			--			end
			--		end
			--	end
			--end
			ATI_AddWString(TEA_PlayerName, sPlayerName)
			ATI_AddString(TEA_PlayerRace, sRace)
			ATI_AddString(TEA_PlayerRUs, iRUs)
			ATI_AddString(TEA_PlayerResearch, sResearch)
			--ATI_AddString(TEA_PlayerBuild, sBuild)
			-- these colors don't look so hot :(
			--if (otherPlayerIndex == playerIndex) then
			--	ATI_AddColour(TEA_PlayerColour, TEA_ColourSelf)
			--else
			--	ATI_AddColour(TEA_PlayerColour, TEA_ColourAlly)
			--end
			ATI_AddColour(TEA_PlayerColour, TEA_ColourNorm)
			ATI_Display2D("TEA_Template", TEA_Rectangle, 0)
			TEA_Rectangle[2] = TEA_Rectangle[2] - 0.02
			ListCount = ListCount + 1
		end
	end
end

-------------------------------------------------------------------------------
-- Bounties

function BOU_ATI_display()
	-- the bounty text gets put into a rectangle. set up this rectangle now
	local BOU_Rectangle = {0.8, 0.8, 0.2, 0.02,}
	local BOU_PrintfCharacters = {"0","1","2","3","4","5","6","7","8","9",}
	ATI_AddString(BOU_PlayerName, "PLAYER")
	ATI_AddString(BOU_PlayerBounty, "BOUNTY")
	ATI_AddColour(BOU_PlayerColour, {1,1,1,1,})
	ATI_Display2D("BOU_Template", BOU_Rectangle, 0)
	BOU_Rectangle[2] = BOU_Rectangle[2] - 0.02
	for otherPlayerIndex = 0, (Universe_PlayerCount() - 1) do
		-- if the player is alive...
		if (Player_IsAlive(otherPlayerIndex) == 1) then
			local BOU_formatted = " "
			local BOU_number = BOUNTY_PlayerBounties[otherPlayerIndex + 1]
			local BOU_BountyString = ""
			local BOU_BountyRatio = BOU_number / BOUNTY_MaxPossible
			local BOU_ColourMeter = {1 - BOU_BountyRatio, BOU_BountyRatio, 0, 1,}

			-- format the strings using our own printf
			if (BOU_number < 1) then
				BOU_formatted = " 0"
			else
				while (BOU_number >= 1) do
					local BOU_index = floor(mod(BOU_number, 10))
					BOU_formatted = BOU_PrintfCharacters[BOU_index + 1] .. BOU_formatted
					BOU_number = BOU_number / 10
				end
			end
			BOU_BountyString = BOU_formatted

			-- display the formatted strings
			ATI_AddWString(BOU_PlayerName, Player_GetName(otherPlayerIndex))
			ATI_AddString(BOU_PlayerBounty, BOU_BountyString)
			ATI_AddColour(BOU_PlayerColour, BOU_ColourMeter)
			ATI_Display2D("BOU_Template", BOU_Rectangle, 0)

			-- move the rectangle down a bit for the next player
			BOU_Rectangle[2] = BOU_Rectangle[2] - 0.02
		end
	end
end

-------------------------------------------------------------------------------
-- Timer & Clock

function TIM_ATI_display()
	local TIM_Rectangle = {0.99, 0.95, 0.3, 0.02}
	local world_time = date("%X")
	ATI_AddString(TIM_GameTime, world_time)
	ATI_Display2D("TIM_Template", TIM_Rectangle, 0)
	TIM_Rectangle[2] = TIM_Rectangle[2] - 0.02

	local game_time = Universe_GameTime()
	local game_h = floor(game_time/3600)
	local game_m = floor(game_time/60 - game_h*60)
	local game_s = game_time - game_m * 60 - game_h * 3600
	local game_str = format("%2.0fh %2.0fm %3.1fs",game_h, game_m, game_s)
	ATI_AddString(TIM_GameTime, game_str)
	ATI_Display2D("TIM_Template", TIM_Rectangle, 0)
	TIM_Rectangle[2] = TIM_Rectangle[2] - 0.02
end


-------------------------------------------------------------------------------
-- Friendly message

function MSG_ATI_display()
	local MSG_Rectangle = {0, 0, 1, 1}
	local MSG_String = "Press SHIFT + I and SHIFT + Q to hide these screens."
	ATI_AddString(MSG_CloseMe, MSG_String)
	ATI_Display2D("MSG_Template", MSG_Rectangle, 0)
end


-------------------------------------------------------------------------------
-- Toggle displays on/off
-- see caveats, above
--

function Toggle_BEN_FLT()
	if (BEN_FLT_Active == 0) then
		BEN_FLT_Active = 1
	else
		BEN_FLT_Active = 0
	end
	DisplayAllATIMessages()
end

function Toggle_TEA()
	if (TEA_Active == 0) then
		TEA_Active = 1
	else
		TEA_Active = 0
	end
	DisplayAllATIMessages()
end
