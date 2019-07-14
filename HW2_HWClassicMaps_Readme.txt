Homeworld Classic Maps v1.3.1 by Mikail
Created: 01/24/06
Updated: 12/18/10
Homepage: http://isometricland.com
Discussion: http://forums.relicnews.com/showthread.php?t=81821

================================================================================

INTRODUCTION
A collection of Homeworld maps converted to work with Homeworld 2's Homeworld 
Classic Mod Rebalance.

INSTALLATION
1) Install the Homeworld 2 1.1 patch.
2) Install the Homeworld Classic Rebalance mod.
3) Extract the level files into your 
   "Data\LevelData\Multiplayer\HomeworldClassic\" folder. If the folder does not 
   already exist, it must be created.

INSTRUCTIONS
When playing using the "Start With" option set to "HW1 Map Default", make sure 
to select the same race as is set for your position within the level file. You 
can see which race is set for your position by looking along the bottom row of 
the thumbnail image in game setup. You can also refer to the "Default Player 
Race" HTML chart included with the HW Classic Maps archive. The player races are 
listed in order from left to right. When you see "R1" it means you should pick 
the Hiigaran race. When you see "R2" it means you should pick the Vaygr race.


================================================================================

CHANGE LOG

1.3.1
• Tweaked asteroid numbers so that hopefully there aren't any more maps with too 
  few (slow resourcing) or too many (lag and stuck collectors).
• Derelicts and non-player ships are now stored in separate tables.
• Level descriptions are now stored in a table.
• Non-player AI-owned ships contained in maps are no longer spawned. In HW1 
  these ships would respond intelligently to your presence by turning around and 
  attacking you. In HW2 all they do is sit there and cause additional lag. ;)
• Squadron formation settings are now exported, though I haven't taken advantage 
  of them yet.

1.3.0
• Added 250 new maps!
• Some changes to map variables, meaning the previous version is no longer 
  compatible with HWC 1.6.0.
• Added support for Cata crystals.
• Fixed typos in background and music file names. Level script now also 
  recognizes Cata backgrounds and music.

1.2.0
• Updated all maps to use the latest versions of my map functions. Some internal 
  paths have also changed, but you won't notice this. Maps should be compatible 
  with version 1.6.0 of Homeworld Classic Rebalance. (They will as a result no 
  longer function with older versions of the mod.)

1.1.1
• I forgot. Re-converted all the maps using a later version of my map converter 
  most likely.

1.0.2
• All level files must now be located in the 
  "Data\LevelData\Multiplayer\HomeworldClassic\" folder.

1.0.1
• Renamed "HW1_CalculationError3.level" to "HW1_CalculationError4.level".
• Renamed "HW1_Front2.level" to "HW1_Frontier2.level".
• Removed "HW1_2DHelo2.level".
• Listed the default player races for each map in the level thumbnails.
• Included the default player race reference HTML file.
• Edited "BungleintheJungle2" to use R2 instead of R1.
• Edited "DRUNKEN PIRATES2" to use R2 instead of R1.
• Edited "EvolvedProteus4" to use R2 instead of R1.
• Edited "KadeshDuel2" to use R1 instead of R2.
• Edited "VortexBattle5" to use R2 instead of R1.

1.0.0
• Added 17 new maps that I had missed earlier.
• Reoved "Coliseum of the Ancients" and added it to the HW Classic Mod 
  Rebalance.
• Level thumbnails! With descriptions!

0.9.0
• All maps have been tested and are working (except for two, which will be 
  updated at some point in the future).
• Laggy maps and maps with overlapping resources have been tweaked so that this 
  does not occur any longer.
• Increased the default value of RUsRatio from 4 to 8.
• PebMulti is now set to RUsRatio / 4 by default.

0.8.2
• Removed ampersands from level names and descriptions.
• The archive now contains a "data" directory which must be copied into the 
  "Homeworld2" directory. This directory now contains the files 
  "IncFunctions.lua" and "IncVariables.lua" that were causing the game to crash 
  due to their being missing.

0.8.1
• "DragonDenII4", "Starpoint6", "Teelan's Ghost6" called for too many players.

0.8.0
• Initial release.


----------------------------------------------------------------

KNOWN ISSUES
• There may be performance issues with some maps.
• Level thumbnails are hard to read at screen resolutions other than 1600x800. 
  Can't be fixed AFAIK, other than by maybe tweaking the UI itself, and even 
  that may not be successful.
• Converted 8 player maps may not have starting positions configured properly 
  for 6 players.
• "p1mothership" and "p2mothership" can't build anything, so maps with those 
  ships as starting fleets are unplayable with the HW1 Map Default rule. (They 
  work fine otherwise.)
