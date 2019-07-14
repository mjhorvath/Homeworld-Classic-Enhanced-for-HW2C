-- Pretty-Printed using HW2 Pretty-Printer 1.27 by Mikail.
-- this script manages the AI military. This includes group sizes, attack times, attack defend percentages, 																													
aitrace("LOADING CPU MILITARY")

function CpuMilitary_Init()	
	cp_attackPercent = 100
	if (g_LOD == 0) then	
		cp_attackPercent = 50
	end
	-- number of ships in group needed before it attacks OR value (if either exceed this number the ships will become active to attack defend)
	-- this is also overridden by other factors (or should be)
	cp_minSquadGroupSize = 5
	cp_minSquadGroupValue = 200
	cp_maxGroupSize = 14
	cp_maxGroupValue = 200
	-- number of units a group will have before it will always attack - even if enemy has more/ better units
	cp_forceAttackGroupSize = 14
	if (g_LOD == 1) then	
		cp_forceAttackGroupSize = 12
	end
	if (g_LOD == 0) then	
		cp_forceAttackGroupSize = 8
	end
	-- what percentage modifier is used by the attackgroup when evaluating a target - so 70% means the enemy is reduced to 70% value increasing the chance of an attack
	cp_initThreatModifier = 0.95
	-- if easy attack even at 55% of value - making the AI attack more often - but hopefully with less dudes (so they die more often)
	if (g_LOD == 0) then	
		cp_initThreatModifier = 0.5
	elseif (g_LOD == 1) then	
		cp_initThreatModifier = 0.75
	end
	-- init so there is always some value here
	sg_moreEnemies = 0
	-- random number used for sending wave attacks
	sg_militaryRand = Rand(100)
	if (Override_MilitaryInit) then	
		Override_MilitaryInit()
	end
end

function CpuMilitary_Process()	
	-- calculate how many more enemies then allies there are
	local numEnemies = PlayersAlive(player_enemy)
	local numAllies = PlayersAlive(player_ally)
	sg_moreEnemies = numEnemies - numAllies
	-- modify group vars (like minsize, etc) dynamically
	Logic_military_groupvars()
	-- run rules that take the current state into consideration (underattack, losing, winning,...) and deal with military
	Logic_military_attackrules()
	-- deals with 'when' we should attack and how often
	Logic_military_setattacktimer()
	-- set attack percentages - based on number of enemies and allies, distances, winning vs losing
end

function Logic_military_groupvars()	
	cp_minSquadGroupSize = 4
	cp_minSquadGroupValue = 150
	if (sg_moreEnemies > 0 and s_selfTotalValue < s_enemyTotalValue * 2) then	
		cp_minSquadGroupSize = cp_minSquadGroupSize + 2
		cp_minSquadGroupValue = cp_minSquadGroupValue + 75
	else
		-- if we are winning, meaning we have quite a bit more military then the enemy then reduce minsize and value
		--aitrace("playerthreat:"..playercompare)
		if (s_militaryStrength > 120) then	
			cp_minSquadGroupSize = 3
			cp_minSquadGroupValue = 120
		end
	end
end

function Logic_military_attackrules()	
	-- if on easy and we are the AI is winning after 20 minutes put military on full attack
	if (g_LOD == 0) then	
		if (gameTime() > 20 * 60 and s_militaryStrength > 0) then	
			cp_attackPercent = 100
		end
		-- if we are under attack move more dudes over to defence
		-- if enemy has twice as much military as the AI does then go on defence
		if (s_selfTotalValue * 2 < s_enemyTotalValue and s_selfTotalValue > 150) then	
			-- take a defensive stance
			cp_attackPercent = 0
			aitrace("I'm Losing!! Go on defence")
		end
	end
end

-- function that gets called on a timer

function attack_now_timer()	
	aitrace("Script:calling attack_now_timer")
	-- 
	AttackNow()
	Rule_Remove("attack_now_timer")
end

-- functions that begin with Logic_ are replaceable chunks

function Logic_military_setattacktimer()	
	-- when does the AI start attacking
	local timedelay = 600
	-- based on map size and other factors
	-- how often does it send another wave
	local wavedelay = 240 + sg_militaryRand * 0.6
	if (g_LOD == 1) then	
		timedelay = 400
		wavedelay = 160 + sg_militaryRand * 0.4
	end
	if (g_LOD >= 2) then	
		timedelay = 0
		wavedelay = 45 + sg_militaryRand * 0.3
	end
	-- INSERT HERE ANY LOGIC MODIFACTIONS TO timedelay or wavedelay
	local gametime = gameTime()
	-- has the start time gone by or have we received a certain level of damage
-- issue: CPU can't determine if teammates have been attacked
	if (gametime >= timedelay or HaveBeenAttacked() == 1) then	
		-- insert other logic that would issue an attack
		if (Rule_Exists("attack_now_timer") == 0) then	
			aitrace("Script: Attacktimer added")
			-- this will also call attacknow instantly
			Rule_AddInterval("attack_now_timer", wavedelay)
		end
	end
end

