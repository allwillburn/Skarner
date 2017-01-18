local ver = "0.01"

if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end

if GetObjectName(GetMyHero()) ~= "Skarner" then return end

require("DamageLib")

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat('<font color = "#00FFFF">New version found! ' .. data)
        PrintChat('<font color = "#00FFFF">Downloading update, please wait...')
        DownloadFileAsync('https://raw.githubusercontent.com/allwillburn/Skarner/master/Skarner.lua', SCRIPT_PATH .. 'Skarner.lua', function() PrintChat('<font color = "#00FFFF">Skarner Update Complete, please 2x F6!') return end)
    else
        PrintChat('<font color = "#00FFFF">No updates found!')
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/allwillburn/Skarner/master/Skarner.version", AutoUpdate)


GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

local SkarnerMenu = Menu("Skarner", "Skarner")

SkarnerMenu:SubMenu("Combo", "Combo")

SkarnerMenu.Combo:Boolean("Q", "Use Q in combo", true)
SkarnerMenu.Combo:Boolean("W", "Use W in combo", true)
SkarnerMenu.Combo:Boolean("E", "Use E in combo", true)
SkarnerMenu.Combo:Boolean("R", "Use R in combo", true)
SkarnerMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
SkarnerMenu.Combo:Boolean("BOTRK", "Use BOTRK", true)
SkarnerMenu.Combo:Boolean("RHydra", "Use RHydra", true)
SkarnerMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
SkarnerMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)

SkarnerMenu:SubMenu("AutoMode", "AutoMode")
SkarnerMenu.AutoMode:Boolean("Level", "Auto level spells", false)
SkarnerMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
SkarnerMenu.AutoMode:Boolean("Q", "Auto Q", false)
SkarnerMenu.AutoMode:Boolean("W", "Auto W", false)
SkarnerMenu.AutoMode:Boolean("E", "Auto E", false)
SkarnerMenu.AutoMode:Boolean("R", "Auto R", false)

SkarnerMenu:SubMenu("LaneClear", "LaneClear")
SkarnerMenu.LaneClear:Boolean("Q", "Use Q", true)
SkarnerMenu.LaneClear:Boolean("W", "Use W", true)
SkarnerMenu.LaneClear:Boolean("E", "Use E", true)
SkarnerMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)


SkarnerMenu:SubMenu("Harass", "Harass")
SkarnerMenu.Harass:Boolean("Q", "Use Q", true)
SkarnerMenu.Harass:Boolean("E", "Use E", true)

SkarnerMenu:SubMenu("KillSteal", "KillSteal")
SkarnerMenu.KillSteal:Boolean("Q", "KS w Q", true)
SkarnerMenu.KillSteal:Boolean("E", "KS w E", true)
SkarnerMenu.KillSteal:Boolean("R", "KS w R", true)

SkarnerMenu:SubMenu("AutoIgnite", "AutoIgnite")
SkarnerMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

SkarnerMenu:SubMenu("Drawings", "Drawings")
SkarnerMenu.Drawings:Boolean("DQ", "Draw Q Range", false)
SkarnerMenu.Drawings:Boolean("DE", "Draw E Range", false)
SkarnerMenu.Drawings:Boolean("DR", "Draw R Range", false)

SkarnerMenu:SubMenu("SkinChanger", "SkinChanger")
SkarnerMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
SkarnerMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3150)

	--AUTO LEVEL UP
	if SkarnerMenu.AutoMode.Level:Value() then

			spellorder = {_E, _W, _Q, _E, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
           if Mix:Mode() == "Harass" then
            if SkarnerMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 350) then				 
                                CastSpell(_Q)                               
            end

            if SkarnerMenu.Harass.E:Value() and Ready(_E) then
				CastSkillShot(_E, target.pos)
            end     
           end

	--COMBO
           if Mix:Mode() == "Combo" then
            if SkarnerMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 700) then
			CastSpell(YGB)
            end

            if SkarnerMenu.Combo.BOTRK:Value() and BOTRK > 0 and Ready(BOTRK) and ValidTarget(target, 700) then
			CastTargetSpell(target, BOTRK)            
            end

            if SkarnerMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 350) then
			CastSpell(_Q)
            end 

            if SkarnerMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end

            if SkarnerMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 700) then
			CastTargetSpell(target, Gunblade)
            end

            if SkarnerMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end

	    if SkarnerMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 700) then
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

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, 350) and SkarnerMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		                     CastSpell(_Q)		         
                end 

                if IsReady(_E) and ValidTarget(enemy, 1000) and SkarnerMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                     CastSkillShot(_E, target.pos)
                end

                if IsReady(_R) and ValidTarget(enemy, 350) and SkarnerMenu.KillSteal.R:Value() and GetHP(enemy) < getdmg("R",enemy) then
		                    CastTargetSpell(target, _R)
                end
      end

      if Mix:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if SkarnerMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 350) then
	        	CastSpell(_Q)
                end

                if SkarnerMenu.LaneClear.W:Value() and Ready(_W) and ValidTarget(closeminion, 700) then
	        	CastSpell(_W)
	        end

                if SkarnerMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 1000) then
	        	CastSkillShot(_E, target.pos)
	        end

	
		if SkarnerMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastSpell(RHydra)
      	        end
          end
      end
        --AutoMode
        if SkarnerMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, 350) then
		      CastSpell(_Q)
          end
        end 
        if SkarnerMenu.AutoMode.W:Value() and Ready(_W) then
	  	       CastSpell(_W)
        end

        if SkarnerMenu.AutoMode.E:Value() then        
	  if Ready(_E) and ValidTarget(target, 1000) then
		      CastSkillShot(_E, target.pos)
	  end
        end
        if SkarnerMenu.AutoMode.R:Value() then        
	  if Ready(_R) and ValidTarget(target, 350) then
		      CastTargetSpell(target, _R)
	  end
        end
                
	--AUTO GHOST
	if SkarnerMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)

OnDraw(function (myHero)
        
         if SkarnerMenu.Drawings.DQ:Value() then
		DrawCircle(GetOrigin(myHero), 350, 0, 200, GoS.Red)
	 end

         if SkarnerMenu.Drawings.DE:Value() then
		DrawCircle(GetOrigin(myHero), 1000, 0, 200, GoS.Red)
	 end

         if SkarnerMenu.Drawings.DR:Value() then
		DrawCircle(GetOrigin(myHero), 350, 0, 200, GoS.Red)
	 end    
 
end)


OnProcessSpell(function(unit, spell)
	local target = GetCurrentTarget()

        if unit.isMe and spell.name:lower():find("skarnervirulentslash") then 
		Mix:ResetAA()	
	end

        if unit.isMe and spell.name:lower():find("skarnerfracture") then 
		Mix:ResetAA()	
	end

        if unit.isMe and spell.name:lower():find("skarnerimpale") then 
		Mix:ResetAA()	
	end

        if unit.isMe and spell.name:lower():find("skarnerexoskeleton") then 
		Mix:ResetAA()	
	end

        if unit.isMe and spell.name:lower():find("itemtiamatcleave") then
		Mix:ResetAA()
	end	

end) 


local function SkinChanger()
	if SkarnerMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>Skarner</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')

