-- table of previously-played tracks
playedBin = {}

function RandomMusicRule()
	-- function created by Mikail, EvilleJedi
	local passBool = 1
	local musicPath = [[data:sound\music\]]
	local listLen = getn(TracksTable)
	local binLen = getn(playedBin)
	local randNum = random(listLen)
	local track_title = TracksTable[randNum][1]
	local track_file = musicPath .. TracksTable[randNum][2]
	local track_length = TracksTable[randNum][3]
	local track_m = floor(track_length / 60)
	local track_s = track_length - track_m * 60
	local track_string = "Now playing (" .. randNum .. "/" .. listLen .. "): " .. track_title .. " (" .. track_m .. "m " .. track_s .. "s)"
	for k = 1, binLen do
--		print("playedBin[" .. k .. "] = " .. playedBin[k])
		-- don't play the same track twice
		if (playedBin[k] == randNum) then
			-- if the end of the list has been reached, start over
			if (k == listLen) then
				playedBin = {}
			end
			passBool = 0
			break
		end
	end
	if (passBool == 0) then
--		print("Track has already been played.")
		RandomMusicRule()
	else
		Sound_MusicPlay(track_file)
		Subtitle_Message(track_string, 10)
		print(track_string)
		tinsert(playedBin, randNum)
		Rule_AddInterval("RandomMusicRule", track_length)
		Rule_Remove("RandomMusicRule")
	end
end

-------------------------------------------------------------------------------
-- Plays the selected music track.
--
function PlayMusicRule()
	Sound_MusicPlay([[data:sound\music\]] .. GetGameSettingAsString("bgmusic"))
	Rule_Remove("PlayMusicRule")
end
