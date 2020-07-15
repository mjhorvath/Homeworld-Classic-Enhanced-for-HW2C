Title:		Homeworld Classic Enhanced for Homeworld 2 Classic
Version:	1.2.7
Authors:	Mikali, Luke Moloney (original version)
Created:	2011/11/18
Updated:	2020/07/15
Homepage:	http://isometricland.net/homeworld/homeworld.php
Workshop:	http://steamcommunity.com/sharedfiles/filedetails/?id=401858560
ModDB:		http://www.moddb.com/mods/homeworld-classic-enhanced
Discussion:	Homeworld Classic Enhanced by Mikali
		  http://forums.relicnews.com/showthread.php?263886
		Homeworld Classic by Luke Moloney
		  http://forums.relicnews.com/showthread.php?t=22748
		Homeworld Classic Rebalance by Mikali
		  http://forums.relicnews.com/showthread.php?t=22972
		Converted HW1 maps by Mikali
		  http://forums.relicnews.com/showthread.php?t=81821
		Gameplay Enhanced by Mikali
		  http://forums.relicnews.com/showthread.php?t=111559


================================================================================


DESCRIPTION
This mod combines the HW Classic Rebalance and Gameplay Enhanced mods into one,
single mod, providing you with a greater number of gameplay options than either 
mod alone. Development of those mods has thus stopped in favor of this one.

INSTALLATION
Installation is done by subscribing to the mod on Steam Workshop if you have 
the Steam version of the game. For the GOG.com/ModDB version, extract the ZIP  
archive and copy the "DataHWClassicEnhanced" folder to your "Homeworld2Classic" 
directory, then add "-moddatapath DataHWClassicEnhanced -overrideBigFile 
-luatrace" to your Desktop shortcut's "Target" field.

INSTRUCTIONS
Also see the included documentation for Luke Moloney's original version of the 
Homeworld Classic mod for further gameplay instructions for the Homeworld Clas-
sic portions of this mod.

UNLIMITED UNITCAPS
You can set unitcaps to "off", which disables unitcaps and allows you to build 
as many of each type of ship as desired.

START WITH
Start with either a mothership and carrier (as per normal HW2), just a carrier 
(as per HW1's "carrier only" rule), or with the selection of ships designed 
into the level by the level author. This last option is available only for a 
certain number of HW1 converted levels included with my Homeworld Classic 
Rebalance mod. Further, the CARRIER ONLY mode supercedes the SPECIAL FLEETS 
game mode of this mod. So, enabling it will disable SPECIAL FLEETS.

RESOURCE INJECTIONS
Select whether RUs are injected into your coffers every x number of seconds, or 
at the beginning of play, as per HW1.

BOUNTIES
Receive a certain number of RUs for every ship you kill as per HW1. Bigger 
ships mean more RUs.

RESEARCH
Turn research on/off as per HW1. With research turned off you have all tech-
nologies at your disposal at the start of play without having to research them.

CRATES
As per HW1, every x number of seconds a magical crate will appear containing 
either a ship that you get to keep, some RUs or a technological advancement.

HYPERSPACE
This mode enables/disables hyperspace technologies for all players as per HW1. 
Feel what it was like when your parents were young and had to walk to whereever 
they were going, both ways, uphill and through the snow!

WIN CONDITION
1) HW2 Normal: Same as HW2 default. A player is killed if he/she has no more 
   production ships left.
2) Kill Team Production: A player is killed if there are no team members with 
   production ships.
3) Kill All Enemy Ships: A player is killed if there are no team members with 
   any ships.
4) Destroy Mothership: A player is killed if his mothership is destroyed. 
5) Capture Capship: A player is killed if one of his capital ships is captured.
6) Quit Manually: The game doesn't end until one team quits and leaves the 
   game. 

DEFINED ROLES
In this game-mode, one player controls production and capital ships; another 
player controls fighters, corvettes and probes; and another player controls 
resourcing, frigates and platforms. If no players on a team choose the "Pro-
duction/Capital" role, then all players on this team retain their mothership, 
carrier and production/research capability. If someone *does* select the "Pro-
duction/Capital" role, then other players on the team do not suffer from a unit 
cap.

BENTUSI ROULETTE
In this game-mode a selectable number of research options are randomly granted 
and restricted for each player at the beginning of gameplay. Press the "I" key 
to see which items were granted or restricted.

SPECIAL FLEETS
This mode gives the player extended starting fleet options. You can choose from 
several different fleet makeups, each being composed of a different assortment 
of ships and research. Note that START WITH must be set to NORMAL for this mode 
to work.

GAME SPEED
This setting allows one to slow the game down to a fraction of its default 
speed. 

BACKGROUND MUSIC
Here you can select which background track gets played while playing. There's 
also a "Shuffle" option to randomly switch between different songs.

GAME TIMER
An in-game clock and timer will appear in the top-right of the screen showing 
you the current local time and amount of time elapsed since the beginning of 
play.

TEAM PROGRESS METER
Pressing the "I" key enables an on-screen display showing your teammates' 
current RUs, production and research.

HW1 CONVERTED LEVELS
In case you're looking for your favorite multiplayer maps from HW1, I've also 
created a library of almost 250 converted levels from Homeworld 1 that are com-
patible with this mod! When playing using the "Start With" option set to "HW1 
Map Default", make sure to select the same race as is set for your position 
within the level file. You can see which race is set for your position by 
looking along the bottom row of the thumbnail image in game setup. You can also 
refer to the "Default Player Race" HTML chart included with the HW Classic Maps 
archive. The player races are listed in order from left to right. When you see 
"R1" it means you should pick the Hiigaran race. When you see "R2" it means you 
should pick the Vaygr race.

MODDING INSTRUCTIONS
The files in the "Data\leveldata\multiplayer\lib\" folder beginning with 
"objectlist" can be reconfigured to make the gamerules work with other mods. 
Simply add or remove items to or from the tables as needed, and the gamerules 
will automatically recognize the new objects. The tables themselves, however, 
should not be removed, or the game will break. Minimal instructions on 
modifying the tables can be found within the files themselves.


================================================================================


LICENSE
You're free to use this code in any way as long as proper credit is given for 
the work that I have done. See the section "Modding Instructions" for instruct-
ions on how to reconfigure the scripts to work with your mod.


================================================================================


CREDITS
• Luke "B1FF" Moloney for the HW Classic mod in its original state.
• Deionerra for dockpath info.
• LeviathanChiken for the crystals, as well as for taking interest in the mod 
  and furthering HWU! :)
• The Complex Team for their idea of using libraries to store the code for each 
  game-mode separately.
• Tamerlane for his "HW2Path" function.
• evillejedi for the beginnings of the random music track script.


================================================================================


TO DO

• SPECIAL FLEETS mode causes the starting ships to all point in the same 
  direction. It would be better to retain their original facing. (Maybe 
  impossible.)
• Rename all functions by adding a prefix to which game rule they belong to.
• Need to reduce JOB_DutiesList and JOB_TeamsList to a single table named 
  JOB_PlayersList. This table should store each player's team and job info.
• In the level files, make sure the algorithms used to produce the spherical, 
  cylindrical, etc. shapes produces volumes with even distributions. I had to 
  disable the existing code because it was causing problems and haven't re-
  placed it with something new.
• TEAM PROGRESS METER should show each team member's DEFINED ROLES job as well.
• Crates don't award subsystems. (Low priority or impossible.)
• Put all the ATI display stuff into "unitcapinfopopup.lua" instead or bind to 
  a different key. (But how do I display the player name if it is in wide or 
  Unicode format? Also, how can I modify "keybindings.lua" and have it load 
  from a gamerule mod BIG file?)
• Map thumbnails and HTML reference sheet should have a five-star rating system
  based on how well designed I think the map is.
• TEAM PROGRESS METER should display a longer list of build and research items. 
  The current list is too short and not very useful.


================================================================================


CHANGE LOG

1.2.7
• Moved the mod files into a subfolder of the GIT repository.

1.2.6
• Absence of "keeper.txt" may have been preventing the mod from running.
• Minor tweaks to AI.

1.2.5
• Tweaked several maps.
• Updated the HTML reference sheet with my own personal quality ratings for 
  many maps.

1.2.4
• The ATI display is now enabled by default, and I added a message telling 
  players how to hide it by pressing "SHIFT + I" and "SHIFT + Q".
• TEAM PROGRESS METER now attempts to show all of the research queue instead 
  of just the first item (i.e., like the build queue in previous versions).
• Unfortunately, in order to make room for the additional research items I had 
  to remove the list of build items.

1.2.3
• Some level files were producing strange *.stats files in the player profile 
  directory, requiring some tweaks.
• I discovered the hardcoded limit of 32 gametype settings that was causing 
  SPECIAL FLEETS to not work properly. As a result, I disabled the ADVANCED 
  STATS rule and reconfigured the IN-GAME TIMER and TEAM PRODUCTION METER to 
  always be enabled.
• The additional information displays can now be toggled on/off using the "I" 
  or "SHIFT + I" keys.
• Fixed the broken spherical resources *again*. (I guess it didn't stick last 
  time.)
• Fixed broken resources in the map "Empty Sphere (4)" and increased the pebble 
  to asteroid ratio to thin the resources.

1.2.2
• The vaygr ships and research were not being referenced properly. Apparently, 
  some code was copied over from HWU/GPE.

1.2.1
• TEAM PROGRESS METER wasn't showing items being researched. The 
  Player_HasQueuedResearch function is unfortunately case-sensitive, so the 
  names must be typed exactly alike in all locations.
• The "display" names in the TechList table are now more descriptive. Before, 
  there was no way to distinguish between carrier, MS or shipyard build speed 
  technologies.
• Various changes to the onscreen ATI text and templates.
• Updated the WIN CONDITIONS so that they don't try and reference "build.lua" 
  or "research.lua".
• Fixed a few other bugs in WIN CONDITIONS introduced in the last version.

1.2.0
• BENTUSI ROULETTE now uses probability values to determine grants and re-
  strictions much like CRATES do.
• Updated DEFINED ROLES to use the new, simpler method I developed for HWU.
• Updated most scripts to be compatible with HWU's race system.
• Display names for build/research items are now posted to the screen instead 
  of just the identifier strings used within the actual code.

1.1.2
• Fixed bug in map code that was causing spheres to only be drawn as hemi-
  spheres.

1.1.1
• SPECIAL FLEETS and CARRIER ONLY modes no longer conflict each other.
• Tweaked the SPECIAL FLEETS awards and updated the descriptions in the help 
  file.
• Reduced the size of all maps by 1/4 since there IMO were too many huge maps.

1.1.0
• Fixed the bug causing the CPU AI not to collect resources on most HW1 
  converted maps.
• Added the additional HWC converted maps. The number of available maps should 
  now be in the hundreds.
• Packaged the mod in a BIG file.
• The TEAM PROGRESS METER now shows all items being built, not just the first.
• Renamed the mod from "Gameplay Rebalanced" to "Homeworld Classic Enhanced".
• Fixed the bug preventing the WIN CONDITION rule to execute properly. Games 
  were not ending properly.
• The lowest-level asteroid had RUs but no latch points. I removed the RUs.
• Fixed some bugs in the Vaygr CARRIER ONLY research script.
• CARRIER ONLY mode was partially but not fully disabled in the previous 
  release, resulting in a conflict. It has been re-enabled.
• Fixed the bug in SPECIAL FLEETS that was causing the starting fleets to crash 
  the game. The script now points correctly to the externalized object list.
• The SPECIAL FLEETS script now tries to determine the proper ship type before 
  giving the player a subsystem.
• Restored the two missing WIN CONDITION rules from HWC.
• Changed the CRATE award probabilities for destroyers and frigates.

1.0.0
• Combined the HW Classic Rebalance and Gameplay Enhanced mods into one, single 
  mod.
• Added the in-game timer and clock.
• Added the "...every" rule for crates.
• Fixed the bug preventing crates from dropping rewards.
• Combined all the ATI scripts into a single file.
• Set asteroid RU values to fixed amounts regardless of how many of them there 
  are in a map. Prior to this, RU values adjusted themselves to better match 
  the total amount of RUs in the original HW1 maps, but this proved unworkable.
• Added a "crate spawned" message to the screen and made it possible to right-
  click on a crate and automatically select it as a movement destination.
• Fixed the bug preventing research from being awarded to Hiigarans by crates.
• Replaced the broken DEFINED ROLES on-screen ATI text with a TEAM PROGRESS 
  METER that can be toggled on/off in the game settings.
