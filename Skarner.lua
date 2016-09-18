if GetObjectName(GetMyHero()) ~= "Skarner" then return end

local SkarnerMenu = Menu("Skarner", "Skarner")

SkarnerMenu:SubMenu("Combo", "Combo")

SkarnerMenu.Combo:Boolean("Q", "Use Q in combo", true)
SkarnerMenu.Combo:Boolean("W", "Use W in combo", true)
SkarnerMenu.Combo:Boolean("E", "Use E in combo", true)
SkarnerMenu.Combo:Boolean("R", "Use R in combo", true)

SkarnerMenu:SubMenu("Misc", "Misc")
SkarnerMenu.Misc:Boolean("Level", "Auto level spells", false)
SkarnerMenu.Misc:Boolean("Ghost", "Auto Ghost", false)
SkarnerMenu.Misc:Boolean("W", "Auto W", false)
SkarnerMenu.Misc:Boolean("Q", "Auto Q", false)
SkarnerMenu.Misc:Boolean("E", "Auto E", false)
SkarnerMenu.Misc:Boolean("Ignite", "Auto Ignite", true)

OnTick(function (myHero)

	local target = GetCurrentTarget()

	--AUTO LEVEL UP
	if SkarnerMenu.Misc.Level:Value() then

			spellorder = {_Q, _W, _E, _Q, _W, _R, _Q, _W, _W, _Q, _R, _Q, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end

	end

	--COMBO
	if IOW:Mode() == "Combo" then

		if SkarnerMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 350) then
			CastSpell(_Q)
		end

		if SkarnerMenu.Combo.W:Value() and Ready(_W) then
			CastSpell(_W)
		end

		if SkarnerMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 1000) then
			CastSkillShot(_E, target.pos)
		end

		if SkarnerMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 350) then
			CastTargetSpell(target, _R)
		end

	end

          --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        --AUTO QW
        if SkarnerMenu.Misc.W:Value() then
            
                if Ready(_W) then
		        CastSpell(_W)
	        end

        end

        if SkarnerMenu.Misc.Q:Value() then

                if Ready(_Q) and ValidTarget(target, 350) then
                        CastSpell(_Q)
                end

        end

        if SkarnerMenu.Misc.E:Value() then

                if Ready(_E) and ValidTarget(target, 1180) then
                        CastSkillShot(_E, target.pos)
                end

        end

	--AUTO IGNITE
	if SkarnerMenu.Misc.Ghost:Value() then

		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end

	end

end)

print('<font color = "#01DF01"><b>Skarner</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')

