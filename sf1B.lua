print("Loading...")
--------------
function Invisfunc()
	local removeNametags = false
	local plr = game:GetService("Players").LocalPlayer
	local character = plr.Character
	local hrp = character.HumanoidRootPart
	local old = hrp.CFrame

	if not character:FindFirstChild("LowerTorso") or character.PrimaryPart ~= hrp then
		return print("unsupported")
	end

	if removeNametags then
		local tag = hrp:FindFirstChildOfClass("BillboardGui")
		if tag then tag:Destroy() end

		hrp.ChildAdded:Connect(function(item)
			if item:IsA("BillboardGui") then
				task.wait()
				item:Destroy()
			end
		end)
	end

	local newroot = character.LowerTorso:Clone()
	hrp.Parent = workspace
	character.PrimaryPart = hrp
	character:MoveTo(Vector3.new(old.X,9e9,old.Z))
	hrp.Parent = character
	task.wait(0.5)
	newroot.Parent = hrp
	hrp.CFrame = old
end

if #game.Players:GetPlayers() > 1 and isfile("SFS Sript/set") and readfile("SFS Sript/set") == "true" then
	Invisfunc()
end

task.spawn(function()
        local Foot = game:GetService("Players").LocalPlayer.Character:FindFirstChild("RightFoot");
        local Hrp = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
        local oldPos = Hrp.CFrame
        local dConnection = false;
        
        task.spawn(function()
            task.wait(1);
            getgenv().Connection = Foot.Touched:Connect(function()
                dConnection = true;
            end)
        end)
        
        repeat task.wait(); Hrp.CFrame = CFrame.new(Workspace:GetAttribute("DungeonSpawn")) wait(1.5) until dConnection == true;
        getgenv().Connection:Disconnect();
        wait(0.5)
        Hrp.CFrame = oldPos
end)

local Rayfield = loadstring(game:HttpGet("https://toscode.gitee.com/zzZ_39/script/raw/master/UILib.lua"))()
if Rayfield == nil then
	Rayfield = loadstring(game:HttpGet("https://pastebin.com/raw/DEsxsuKK"))()
end

local closest = nil;
local selectedEgg = "Volcano Egg";
local SelectedRelic = "";
local ExpRelicList = {};
local Secret = {};
local RarityWl = {};
local DisRarityWl = {};
local Eggs = {};
local DisplayEggs = {};
local Buy_Egg_Args = {
	["eggName"] = "Egg 25",
	["auto"] = false,
	["amount"] = 4
};
local AllMobs = {
   ["Area 1"] = {
        "Goblin",
        "Orc",
        "Dark Knight",
        "Dark Commander",
    },
    ["Area 2"] = {
        "Skeleton",
        "Pirate Thief",
        "Pirate Captain",
        "Pirate Admiral",
    },
    ["Area 3"] = {
        "Ninja",
        "Samurai",
        "Samurai Master",
        "Oni",
    },
    ["Area 4"] = {
        "Penguin",
        "Snow Warrior",
        "Yeti",
        "Ice King",
    },
    ["Area 5"] = {
        "Monk",
        "Angel",
        "Guardian",
        "Zeus the God",
    },
    ["Area 6"] = {
        "Imp",
        "Demon",
        "Lava Golem",
        "Red Devil",
    },
    ["Area 7"] = {
        "Mummy",
        "Royal Warrior",
        "Desert Beast",
        "King Pharaoh",
    },
    ["Area 8"] = {
        "Satyr",
        "Cyclops",
        "Purple Dragon",
        "Adurite Warden",
        "Lost Soul",
    },
    ["Area 9"] = {
        "Mushy",
        "Zombie Miner",
        "Golem",
        "Necromancer",
        "Blood Zombie",
        "Blood Vampire",
    },
    ["Area 10"] = {
        "Power Force",
        "Paladin",
        "Warlock",
        "Spirit Lord",
        "Brown Insect",
        "Green Insect",
        "Mutant Insect",
    },
    ["Area 11"] = {
        "Marine",
        "Barbarian Pirate",
        "Madman",
        "Skye Knight",
        "Malevolent Spirit",
        "Lost Titan",
        "Blood Knight",
    },
    ["Area 12"] = {
        "Feathered Warrior",
        "Cthulhu",
        "Centaur King",
        "Celestial Gatekeeper",
        "Skywatcher",
        "Stormbringer",
        "Vulcanus Maximus",
        "Demonic Altar",
    },
    ["Area 13"] = {
        "Dune Critter",
        "Reptilian Beast",
        "Sandstone Golem",
        "Scorpion Queen",
        "Haunted Witch",
        "Haunted Reaper",
        "Nightstalker",
        "Forsaken Hunter",
    },
	["Area 14"] = {
		"Small Titan",
		"Cart Titan",
		"Beast Titan",
		"Colossus Titan",
		"Founding Titan",
		"Warhammer Titan",
		"Jaw Titan",
	},
    ["Area 15"] = {
		"Poseidon's Warrior",
		"Undertides Bounty Hunter",
		"Seaborn",
		"Unknown Deep Sea Diver",
		"Abyssal Hunter",
		"Amaia",
		"Gawain the Half Shark Man",
	},
};
local MobSelectedList = {};
local AreaMobsList = {};
local BloodMoonMobs = {"Nightstalker","Warhammer Titan","Jaw Titan","Amaia","Gawain the Half Shark Man"};

local RelicLabelList = {}
local RelicButtonList = {}
local RelicPresets ={{},{},{}}
local RelicPresetSetting = {
	Selected = nil,
	Default = nil,
	Dungeon = nil,
	BloodMoon = nil,
	Ngiht = nil,
}

local WeaponLabelList = {}
local WeaponButtonList = {}
local WeaponPresets ={{},{},{}}
local WeaponPresetSetting = {
	Selected = nil,
	Default = nil,
	Dungeon = nil,
	BloodMoon = nil,
	Ngiht = nil,
}

local RollList = {}
local EnchantsRefuse  = {}
local SelectedEnchant

local InfiniteJump = false;
local isBloodMoon = false;
local isNight = false;
local hasUsed = false;
local nhasUsed = false;
local InDungeon = false;
local BMing = false;
local Nighting = false;
local ActiveRaid = nil;


local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService")
local KnitService = game:GetService("ReplicatedStorage").Packages.Knit.Services;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Workspace = game:GetService("Workspace")
local Knit_Pkg = require(game:GetService("ReplicatedStorage").Packages.Knit)
local PlayerData = Knit_Pkg.GetController("DataController"):GetData("PlayerData")
local SwordDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Weapons")
local EggsDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Eggs")
local PetsDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Pets")
local UIController = Knit_Pkg.GetController("UIController")
local TPController = Knit_Pkg.GetController("TeleportController")
local Util = require(Knit_Pkg.Util.Utility)

getgenv()._MAIN = true
getgenv()._POWER = false
getgenv().AutoFarm = false
getgenv().FarmAllMap = false
getgenv().FarmSelected = false
getgenv().BloodMoonCheck = false
getgenv().PetDis = false
getgenv().SwordSell = false
getgenv().OpEgg = false
getgenv().ignoreAmin =false
getgenv().UpRelic = false
getgenv().DungeonAutoBuy = false
getgenv().TravellingMerchantAutoBuy = false
getgenv().AutoClaimChests = false
getgenv().EasyDungeon = false
getgenv().HardDungeon = false
getgenv().AutoTower = false
getgenv().AutoRaid = false
getgenv().bAutoUseLuckBoost = false
getgenv().bAutoUseSecretLuckBoost = false
getgenv().bAutoUseCoinBoost = false
getgenv().bAutoUsePowerBoost = false
getgenv().bAutoUseDmgBoost = false
getgenv().nAutoUseLuckBoost = false
getgenv().nAutoUseSecretLuckBoost = false
getgenv().nAutoUsePowerBoost = false
getgenv().RarityCheck = false
getgenv().DisRarityCheck = false
getgenv().UseFilter = false
getgenv().Distance = 45
getgenv().ClickSpeed = 5
getgenv().SwordSellDelay = 40
getgenv().DismantleDelay = 60
getgenv().EasyReach = 50
getgenv().HardReach = 40
getgenv().TowerReach = 62
getgenv().lastOpenTime = 0;
getgenv().beforePos = LocalPlayer.Character.HumanoidRootPart.CFrame;
getgenv().RollResult = {}
getgenv().AutoRoll = false
getgenv().IgnRollAmin = false
getgenv().RollUseFilter = false

--Get Egg List
for i ,v in next, EggsDatabase do
	Eggs[v.name] = i
	table.insert(DisplayEggs,v.name)
end


--Get Enchant Table
local EnchantTables = Knit_Pkg.GetController("DatabaseController"):GetDatabase("EnchantTables")
local EnchantTable = {}
for i,v in pairs(EnchantTables) do
	for i,v2 in pairs(v) do
        local Ratestable = Knit_Pkg.GetController("DatabaseController"):GetDatabase("EnchantRates")
		for i,v3 in pairs(Ratestable) do
			--print(v3.name)
            if not v3 then continue end
			table.insert(EnchantTable,v3.name)
			EnchantsRefuse[v3.name] = {}
		end
	end
end

local EquipRelics = function(Preset)
	if not (RelicPresets[Preset] and next(RelicPresets[Preset])) then return end
	local Relics = RelicPresets[Preset]
	for i,v in pairs(PlayerData.RelicInv) do
		if v.equipped then
			KnitService.RelicInvService.RF.EquipRelic:InvokeServer(v.uid)
			wait()
		end
	end
	for i,v in pairs(Relics) do
		KnitService.RelicInvService.RF.EquipRelic:InvokeServer(v)
		wait()
	end
	print("Relic Preset "..Preset.." Equipped")
	Knit_Pkg.GetController("NotificationController"):Notification({
		message = "Relic Preset "..Preset.." Equipped", 
		color = "Pink", 
		multipleAllowed = false
	});
end

local EquipWeapons = function(Preset)
	if not (WeaponPresets[Preset] and next(WeaponPresets[Preset])) then return end
	local Weapons = WeaponPresets[Preset]
	KnitService.WeaponInvService.RF.EquipWeapon:InvokeServer(PlayerData.EquippedWeapon.Left)
	wait()
	if PlayerData.EquippedWeapon.Right then
		KnitService.WeaponInvService.RF.EquipWeapon:InvokeServer(PlayerData.EquippedWeapon.Right)
		wait()
	end
	for i,v in pairs(Weapons) do
		KnitService.WeaponInvService.RF.EquipWeapon:InvokeServer(v)
		wait()
	end
	print("Weapon Preset "..Preset.." Equipped")
	Knit_Pkg.GetController("NotificationController"):Notification({
		message = "Weapon Preset "..Preset.." Equipped", 
		color = "CoinColor", 
		multipleAllowed = false
	});
end

local useBoost = function(Name)
	for i =1,4 do
		local timeleft = 21*60 - os.time()%3600 - PlayerData.Boosts[Name].timeLeft
		if Name == "SecretLuck" and timeleft > 1200 and PlayerData.Boosts[Name].remaining[1200] and PlayerData.Boosts[Name].remaining[1200] == 0 then
			KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "1800")
			break
		end
		if timeleft > 1200 and PlayerData.Boosts[Name].remaining["1200"] and PlayerData.Boosts[Name].remaining["1200"] > 0 then
			KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "1200")
		elseif timeleft > 900 and PlayerData.Boosts[Name].remaining["900"] and PlayerData.Boosts[Name].remaining["900"] > 0 then
			KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "900")
		elseif timeleft > 600 and PlayerData.Boosts[Name].remaining["600"] and PlayerData.Boosts[Name].remaining["600"] > 0 then
			KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "600")
		elseif	timeleft > 300 and PlayerData.Boosts[Name].remaining["300"] and PlayerData.Boosts[Name].remaining["300"] > 0 then
			KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "300")
		else
			break
		end
		wait()
	end
end

local Closest_NPC = function(AutoFarmMode)
	local Closest = nil;
	local Dist = Distance;
	if AutoFarmMode then
		Dist = 9e8;
	end
	if BloodMoonCheck and isBloodMoon and next(BloodMoonMobs) and AutoFarmMode then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if v:IsA("Part") then
				if table.find(BloodMoonMobs,v:GetAttribute("Name")) then
					if v:GetAttribute("Health") == 0 then
						continue
					end
					return v;
				end
			end
		end
        return nil
	end
	if FarmAllMap and not InDungeon then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if v:IsA("Part") then
				local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if not Root then
					continue
				end
				if not InDungeon and FarmSelected and next(MobSelectedList) and not table.find(MobSelectedList,v:GetAttribute("Name")) then
					continue
				end
				if v:GetAttribute("Health") == 0 then
					continue
				end
				local Magnitude = (Root.Position - v.Position).Magnitude;
				if Magnitude < Dist then
					Closest = v;
					Dist = Magnitude;
				end
			end
		end
		return Closest
	end
	for i, v in next, Workspace.Live.NPCs.Client:GetChildren() do
		if v:IsA("Model") then
			local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			local DstRoot = v:FindFirstChild("HumanoidRootPart")
			if not Root or not DstRoot then
				continue
			end
			if not InDungeon and AutoFarm and not LocalPlayer:GetAttribute("Raid") and FarmSelected and next(MobSelectedList) then
				local NPCTag = DstRoot:FindFirstChild("NPCTag")
				if NPCTag and not table.find(MobSelectedList,NPCTag:FindFirstChild("NameLabel").Text) then
					continue
				end
			end
			local Magnitude = (Root.Position - DstRoot.Position).Magnitude;
			if Magnitude < Dist then
				Closest = v;
				Dist = Magnitude;
			end
		end
	end
	return Closest;
end

local CheckBMSpawn = function()
	for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
		if v:IsA("Part") then
			if table.find(BloodMoonMobs,v:GetAttribute("Name")) then
				print("Founded!")
				return v;
			end
		end
	end
	print("Not Found!")
	return false
end

local CheckAccept = function(v,mode)
	local TierAccepts = PlayerData.AutoRerollTierAccepts;
	local Accept = PlayerData.AutoRerollAccept;
	if mode then
		if not EnchantsRefuse[v.enchants[1].name] or not table.find(EnchantsRefuse[v.enchants[1].name],v.enchants[1].tier) then
			return true;
		end
	else
		if Accept[v.enchants[1].name] and TierAccepts[v.enchants[1].tier] then	
			return true;
		end
	end
	if #v.enchants == 1 then
		return false;
	end
	if mode then
		if EnchantsRefuse[v.enchants[2].name] and table.find(EnchantsRefuse[v.enchants[2].name],v.enchants[2].tier) then
			return false;
		end
	else
		if Accept[v.enchants[2].name] == false or TierAccepts[v.enchants[2].tier] ==false then
			return false;
		end
	end
end


local Window = Rayfield:CreateWindow({
    Name = "SFS Helper",
    LoadingTitle = "SFS Helper",
    LoadingSubtitle = "",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "SFS Sript", -- Create a custom folder for your hub/game
       FileName = "SFScfg"
    },
    KeySystem = false -- Set this to true to use our key system
 })

local Tab = Window:CreateTab("Main")
local Section = Tab:CreateSection("Click")

local EggTab = Window:CreateTab("Egg")

local RelicTab = Window:CreateTab("Relic")

local GameMode = Window:CreateTab("GModes")
local Section = GameMode:CreateSection("Dungeon")

local BetaTab = Window:CreateTab("Beta")

local EventTab = Window:CreateTab("Event")
local Section = EventTab:CreateSection("Blood Moon Event")

local MiscTab = Window:CreateTab("Misc")

local WeaponTab = Window:CreateTab("Weapon")

local Filter = Window:CreateTab("Filter")

local Enchant = Window:CreateTab("Enchant")
	
local AutoClickToggle = Tab:CreateToggle({
    Name = "Auto Power",
    Info = "Toggles Auto Click",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(Value)
        getgenv()._POWER = Value
    end,
})

local DistanceSlider = Tab:CreateSlider({
   Name = "Aura Distance",
   Range = {0, 50},
   Increment = 1,
   Suffix = "Distance",
   CurrentValue = 45,
   Flag = "DistanceSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(s)
      getgenv().Distance = s
   end,
})

local ClickSpeedSlider = Tab:CreateSlider({
   Name = "Click Speed",
   Range = {0, 150},
   Increment = 1,
   Suffix = "Click",
   CurrentValue = 5,
   Flag = "ClickSpeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(s)
      getgenv().ClickSpeed = s
   end,
})
local Section = Tab:CreateSection("Pet")
local AutoDismantleToggle = Tab:CreateToggle({
    Name = "Auto Dismantle",
    Info = "Toggles Auto Dismantle",
    CurrentValue = false,
    Flag = "AutoDismantle",
    Callback = function(Value)
        getgenv().PetDis = Value
    end,
})

local DisDelaySlider = Tab:CreateSlider({
   Name = "Dismantle Delay",
   Range = {0, 100},
   Increment = 1,
   Suffix = "s",
   CurrentValue = 60,
   Flag = "DisDelaySlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(s)
      getgenv().DismantleDelay = s
   end,
})

local DisRarityCheckToggle = Tab:CreateToggle({
    Name = "Rarity Check",
    Info = "Toggles Dismantle Rarity Check",
    CurrentValue = false,
    Flag = "DismantleRarityCheck",
    Callback = function(Value)
        getgenv().DisRarityCheck = Value
    end,
})

local DisRarityWlLabel = Tab:CreateLabel({
CurrentValue = "Rarity Whitelist",
Flag = "DisRarityWhitelist"
})

local DisRarityWhitelistDropdown = Tab:CreateDropdown({
	Name = "Add to Whitelist",
	Options = {"Common","Rare","Epic","Legendary","Mythic"},
	CurrentOption = "",
	Callback = function(Option)
		if Option and not table.find(DisRarityWl,Option) then
			table.insert(DisRarityWl,Option);
			DisRarityWlLabel:Set(table.concat(DisRarityWl,'; '))
		end
	end,
})

local DisClrWlButton = Tab:CreateButton({
	Name = "Reset List",
	Callback = function()
		DisRarityWl = {};
		DisRarityWlLabel:Set(table.concat(DisRarityWl,'; '))
	end,
})

local Section = Tab:CreateSection("Weapon")

local AutoSellToggle = Tab:CreateToggle({
    Name = "Auto Sell",
    Info = "Toggles Auto Sell",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(Value)
        getgenv().SwordSell = Value
    end,
})

local SellDelaySlider = Tab:CreateSlider({
   Name = "Sword Sell Delay",
   Range = {0, 100},
   Increment = 1,
   Suffix = "s",
   CurrentValue = 40,
   Flag = "SellDelaySlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(s)
      SwordSellDelay = s
   end,
})

local RarityCheckToggle = Tab:CreateToggle({
    Name = "Rarity Check",
    Info = "Toggles Rarity Check",
    CurrentValue = false,
    Flag = "RarityCheck",
    Callback = function(Value)
        getgenv().RarityCheck = Value
    end,
})

local RarityWlLabel = Tab:CreateLabel({
CurrentValue = "Rarity Whitelist",
Flag = "RarityWhitelist"
})

local RarityWhitelistDropdown = Tab:CreateDropdown({
	Name = "Add to Whitelist",
	Options = {"Common","Rare","Epic","Legendary","Mythic"},
	CurrentOption = "",
	Callback = function(Option)
		if Option and not table.find(RarityWl,Option) then
			table.insert(RarityWl,Option);
			RarityWlLabel:Set(table.concat(RarityWl,'; '))
		end
	end,
})

local ClrWlButton = Tab:CreateButton({
	Name = "Reset List",
	Callback = function()
		RarityWl = {};
		RarityWlLabel:Set(table.concat(RarityWl,'; '))
	end,
})

--EggTab
local AutoOpenEggsToggle = EggTab:CreateToggle({
    Name = "Auto Open Eggs",
    Info = "Toggles Auto Open Eggs",
    CurrentValue = false,
    Flag = "AutoOpenEggs",
    Callback = function(Value)
        getgenv().OpEgg = Value
    end,
})

local IgnoreAminToggle = EggTab:CreateToggle({
    Name = "Ignore Open Amination",
    Info = "Toggles Ignore Open Amination",
    CurrentValue = false,
    Flag = "ignoreAmin",
    Callback = function(Value)
        getgenv().ignoreAmin = Value
    end,
})

local EggsListDropdown = EggTab:CreateDropdown({
	Name = "Eggs Selected",
	Options = DisplayEggs,
	CurrentOption = "Volcano Egg",
	Flag = "EggsListDropdown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Option)
		selectedEgg = Option
		Buy_Egg_Args.eggName = Eggs[Option]
		beforePos = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame*CFrame.new(0,6,-3.5)
	end,
})

local EggsAmountsDropdown = EggTab:CreateDropdown({
	Name = "Eggs Amounts",
	Options = {1,2,3,4},
	CurrentOption = 4,
	Flag = "EggsAmountsDropdown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Option)
		Buy_Egg_Args.amount = Option
	end,
})

local TPEggsButton = EggTab:CreateButton({
	Name = "TP to Selected Eggs",
	Callback = function()
		LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame*CFrame.new(0,4,-3.5)
		-- The function that takes place when the button is pressed
	end,
})

--RelicTab
local UpgradeSelectedRelicToggle = RelicTab:CreateToggle({
    Name = "Auto Upgrade Selected Relic",
    Info = "Toggles Upgrade Selected Relic",
    CurrentValue = false,
    Flag = "UpgradeSelectedRelic",
    Callback = function(Value)
		getgenv().UpRelic = Value
	end,
})
local ExpRelicListLabel = RelicTab:CreateLabel({
	CurrentValue = "",
	Flag = "ExpRelicListLabel"
})
local ExpRelicListButton = RelicTab:CreateButton({
	Name = "Generate Exp Relic List",
	Callback = function()
		ExpRelicList = {}
		for i,v in pairs(PlayerData.RelicAutoDelete) do
			if v then 
				table.insert(ExpRelicList,i)
				KnitService.RelicInvService.RF.ToggleAutoDelete:InvokeServer(i)
				wait()
			end
		end
		ExpRelicListLabel:Set(table.concat(ExpRelicList,";"))
	end,
})

local SelectedRelicLabel = RelicTab:CreateLabel({
	CurrentValue = "",
	Flag = "Select2UpRelic"
})

local SelectedRelicDisplayLabel = RelicTab:CreateLabel({
	CurrentValue = "Selected Relic",
	Flag = "Select2UpDisplayRelic"
})

local SelectRelicButton = RelicTab:CreateButton({
	Name = "Select a Relic From Inventory",
	Callback = function()
		local selec = nil
		for i,v in pairs(LocalPlayer.PlayerGui.Inventory.Background.ImageFrame.Window.Frames.ItemsFrame.ItemsHolder.ItemsScrolling:GetChildren()) do
			if v:IsA("Frame") and v.Frame.Selected.Visible == true then
				selec = v.Name
			end
		end
		if selec then
			SelectedRelicLabel:Set(selec)
			SelectedRelicDisplayLabel:Set(PlayerData.RelicInv[selec].name.." | Exp:"..PlayerData.RelicInv[selec].exp)
			SelectedRelic = selec
		else
			SelectedRelicDisplayLabel:Set("")
		end
	end,
})

local Section = RelicTab:CreateSection("Relic Presets")

local RelicPresetLabel1 = RelicTab:CreateLabel({
	CurrentValue = "",
	Flag = "RelicPreset1"
})

local RelicPresetLabel2 = RelicTab:CreateLabel({
	CurrentValue = "",
	Flag = "RelicPreset2"
})

local RelicPresetLabel3 = RelicTab:CreateLabel({
	CurrentValue = "",
	Flag = "RelicPreset3"
})

local RelicPresetDisplayButton1 = RelicTab:CreateButton({
	Name = "Equipment",
	Callback = function()
		if next(RelicPresets[1]) then
			EquipRelics(1)
		end
	end,
})

local RelicPresetDisplayButton2 = RelicTab:CreateButton({
	Name = "Equipment",
	Callback = function()
		if next(RelicPresets[2]) then
			EquipRelics(2)
		end
	end,
})

local RelicPresetDisplayButton3 = RelicTab:CreateButton({
	Name = "Equipment",
	Callback = function()
		if next(RelicPresets[3]) then
			EquipRelics(3)
		end
	end,
})

local Section = RelicTab:CreateSection("Relic Preset Setting")
local RelicPresetListDropdown = RelicTab:CreateDropdown({
	Name = "Relic Preset :",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "RelicPresetListDropdown",
	Callback = function(Option)
		RelicPresetSetting.Selected = Option
	end,
})

local AddRelic2SelectPresetButton = RelicTab:CreateButton({
	Name = "Add",
	Callback = function()
		if typeof(RelicPresetSetting.Selected) ~= "number" then
			Knit_Pkg.GetController("NotificationController"):Notification({
				message = "Invalid Preset Id!", 
				color = "Red", 
				multipleAllowed = false
			});
			return
		end
		local selec = nil
		for i,v in pairs(LocalPlayer.PlayerGui.Inventory.Background.ImageFrame.Window.Frames.ItemsFrame.ItemsHolder.ItemsScrolling:GetChildren()) do
			if v:IsA("Frame") and v.Frame.Selected.Visible == true then
				selec = v.Name
			end
		end
		if not selec then
			Knit_Pkg.GetController("NotificationController"):Notification({
				message = "Please Open Your Item Inventory and Select one!", 
				color = "Red", 
				multipleAllowed = false
			});
			return
		end
		if selec and not table.find(RelicPresets[RelicPresetSetting.Selected],selec) and #RelicPresets[RelicPresetSetting.Selected] <=1 then
			table.insert(RelicPresets[RelicPresetSetting.Selected],selec);
			RelicLabelList[RelicPresetSetting.Selected]:Set(table.concat(RelicPresets[RelicPresetSetting.Selected],'; '))
		end
		local str = {}
		for i,v in pairs(RelicPresets[RelicPresetSetting.Selected]) do
			table.insert(str,PlayerData.RelicInv[v].name.." | Exp:"..PlayerData.RelicInv[v].exp)
		end
		RelicButtonList[RelicPresetSetting.Selected]:Set(table.concat(str,' & '))
	end,
})

local RelicPresetRstButton = RelicTab:CreateButton({
	Name = "Reset Preset",
	Callback = function()
		RelicPresets[RelicPresetSetting.Selected] = {}
		RelicLabelList[RelicPresetSetting.Selected]:Set("")
		RelicButtonList[RelicPresetSetting.Selected]:Set("")
	end,
})

local RelicDefaultPresetDropdown = RelicTab:CreateDropdown({
	Name = "Default Relic Preset :",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "RelicDefaultPresetDropdown",
	Callback = function(Option)
		RelicPresetSetting.Default = Option
	end,
})



--WeaponTab
local Section = WeaponTab:CreateSection("Weapon Presets")
local WeaponPresetLabel1 = WeaponTab:CreateLabel({
	CurrentValue = "",
	Flag = "WeaponPreset1"
})

local WeaponPresetLabel2 = WeaponTab:CreateLabel({
	CurrentValue = "",
	Flag = "WeaponPreset2"
})

local WeaponPresetLabel3 = WeaponTab:CreateLabel({
	CurrentValue = "",
	Flag = "WeaponPreset3"
})

local WeaponPresetDisplayButton1 = WeaponTab:CreateButton({
	Name = "Equipment",
	Callback = function()
		if next(WeaponPresets[1]) then
			EquipWeapons(1)
		end
	end,
})

local WeaponPresetDisplayButton2 = WeaponTab:CreateButton({
	Name = "Equipment",
	Callback = function()
		if next(WeaponPresets[2]) then
			EquipWeapons(2)
		end
	end,
})

local WeaponPresetDisplayButton3 = WeaponTab:CreateButton({
	Name = "Equipment",
	Callback = function()
		if next(WeaponPresets[3]) then
			EquipWeapons(3)
		end
	end,
})
local Section = WeaponTab:CreateSection("Weapon Preset Setting")
local WeaponPresetListDropdown = WeaponTab:CreateDropdown({
	Name = "Weapon Preset :",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "WeaponPresetListDropdown",
	Callback = function(Option)
		WeaponPresetSetting.Selected = Option
	end,
})

local AddWeapon2SelectPresetButton = WeaponTab:CreateButton({
	Name = "Add",
	Callback = function()
		if typeof(WeaponPresetSetting.Selected) ~= "number" then
			Knit_Pkg.GetController("NotificationController"):Notification({
				message = "Invalid Preset Id!", 
				color = "Red", 
				multipleAllowed = false
			});
			return
		end
		local selec = nil
		for i,v in pairs(LocalPlayer.PlayerGui.WeaponInv.Background.ImageFrame.Window.WeaponHolder.WeaponScrolling:GetChildren()) do
			if v:IsA("Frame") and v.Frame.Selected.Visible == true then
				selec = v.Name
			end
		end
		if not selec then
			Knit_Pkg.GetController("NotificationController"):Notification({
				message = "Please Open Your Weapon Inventory and Select one!", 
				color = "Red", 
				multipleAllowed = false
			});
			return
		end
		if selec and not table.find(WeaponPresets[WeaponPresetSetting.Selected],selec) and #WeaponPresets[WeaponPresetSetting.Selected] <=1 then
			table.insert(WeaponPresets[WeaponPresetSetting.Selected],selec);
			WeaponLabelList[WeaponPresetSetting.Selected]:Set(table.concat(WeaponPresets[WeaponPresetSetting.Selected],'; '))
		end
		local str = {}
		for i,v in pairs(WeaponPresets[WeaponPresetSetting.Selected]) do
			table.insert(str,PlayerData.WeaponInv[v].name)
		end
		WeaponButtonList[WeaponPresetSetting.Selected]:Set(table.concat(str,' & '))
	end,
})

local WeaponPresetRstButton = WeaponTab:CreateButton({
	Name = "Reset Preset",
	Callback = function()
		WeaponPresets[WeaponPresetSetting.Selected] = {}
		WeaponLabelList[WeaponPresetSetting.Selected]:Set("")
		WeaponButtonList[WeaponPresetSetting.Selected]:Set("")
	end,
})

local WeaponDefaultPresetDropdown = WeaponTab:CreateDropdown({
	Name = "Default Weapon Preset :",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "WeaponDefaultPresetDropdown",
	Callback = function(Option)
		WeaponPresetSetting.Default = Option
	end,
})





--BetaTab
local AutoFarmToggle = BetaTab:CreateToggle({
    Name = "Auto Farm",
    Info = "Toggles Auto Farm Area",
    CurrentValue = false,
    Flag = "AutoFarmArea",
    Callback = function(Value)
		getgenv().AutoFarm = Value
	end,
})

local FarmAllMapToggle = BetaTab:CreateToggle({
    Name = "Farm All Map",
    Info = "Toggles Farm All Map",
    CurrentValue = false,
    Flag = "FarmAllMap",
    Callback = function(Value)
		getgenv().FarmAllMap = Value
	end,
})

local FarmSelectedToggle = BetaTab:CreateToggle({
    Name = "Farm Selected Mobs",
    Info = "Toggles Farm Selected Mobs",
    CurrentValue = false,
    Flag = "FarmSelected",
    Callback = function(Value)
		getgenv().FarmSelected = Value
	end,
})

local FarmListLabel = BetaTab:CreateLabel({
	CurrentValue = "Fram List",
	Flag = "FarmList"
})



local AreaListDropdown = BetaTab:CreateDropdown({
	Name = "Select Area",
	Options = {"Area 1","Area 2","Area 3","Area 4","Area 5","Area 6","Area 7","Area 8","Area 9","Area 10","Area 11","Area 12","Area 13","Area 14","Area 15"},
	CurrentOption = "",
	Flag = "AreaListDropdown",
	Callback = function(Option)
		AreaMobsList = AllMobs[Option]
		if game:GetService("CoreGui").Rayfield.Main.Elements.Beta:FindFirstChild("Add Mob to List") then
			game:GetService("CoreGui").Rayfield.Main.Elements.Beta:FindFirstChild("Add Mob to List"):Destroy();
		end
		local AreaMobsListDropdown = BetaTab:CreateDropdown({
			Name = "Add Mob to List",
			Options = AreaMobsList,
			CurrentOption = "",
			Callback = function(Option)
				if Option and not table.find(MobSelectedList,Option) then
					table.insert(MobSelectedList,Option);
					FarmListLabel:Set(table.concat(MobSelectedList,'; '))
				end
			end,
		})
	end,
})

local ClrButton = BetaTab:CreateButton({
	Name = "Reset List",
	Callback = function()
		MobSelectedList = {};
		FarmListLabel:Set(table.concat(MobSelectedList,';'))
	end,
})

--Dungeons
local AutoEasyDungeonToggle = GameMode:CreateToggle({
    Name = "Auto Easy Dungeon",
    Info = "Toggles Auto Easy Dungeon",
    CurrentValue = false,
    Flag = "AutoEasyDungeon",
    Callback = function(Value)
		getgenv().EasyDungeon = Value
	end,
})

local EasyReachSlider = GameMode:CreateSlider({
   Name = "Leave at Room",
   Range = {1, 80},
   Increment = 1,
   Suffix = "",
   CurrentValue = 50,
   Flag = "EasyReachSlider",
   Callback = function(s)
      getgenv().EasyReach = s
   end,
})

local AutoHardDungeonToggle = GameMode:CreateToggle({
    Name = "Auto Hard Dungeon",
    Info = "Toggles Auto Hard Dungeon",
    CurrentValue = false,
    Flag = "AutoHardDungeon",
    Callback = function(Value)
		getgenv().HardDungeon = Value
	end,
})

local HardReachSlider = GameMode:CreateSlider({
   Name = "Leave at Room",
   Range = {1, 60},
   Increment = 1,
   Suffix = "",
   CurrentValue = 50,
   Flag = "HardReachSlider",
   Callback = function(s)
      getgenv().HardReach = s
   end,
})

local DungeonRelicPresetDropdown = GameMode:CreateDropdown({
	Name = "Equip Relic Preset : ",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "DungeonRelicPresetDropdown",
	Callback = function(Option)
		RelicPresetSetting.Dungeon = Option
	end,
})

local DungeonWeaponPresetDropdown = GameMode:CreateDropdown({
	Name = "Equip Weapon Preset : ",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "DungeonWeaponPresetDropdown",
	Callback = function(Option)
		WeaponPresetSetting.Dungeon = Option
	end,
})

local RstButton = GameMode:CreateButton({
	Name = "Reset Dungeon Status",
	Callback = function()
		InDungeon = false;
	end,
})
local Section = GameMode:CreateSection("Tower")
local AutoTowerToggle = GameMode:CreateToggle({
    Name = "Auto Tower",
    Info = "Toggles Auto Tower",
    CurrentValue = false,
    Flag = "AutoTower",
    Callback = function(Value)
		getgenv().AutoTower = Value
	end,
})
--[[local TowerReachSlider = GameMode:CreateSlider({
   Name = "Leave at Floor",
   Range = {1, 62},
   Increment = 1,
   Suffix = "",
   CurrentValue = 62,
   Flag = "TowerReachSlider",
   Callback = function(s)
      getgenv().TowerReach = s
   end,
})
]]
local Section = GameMode:CreateSection("Raid BETA")
local AutoRaidToggle = GameMode:CreateToggle({
    Name = "Auto Raid",
    Info = "Toggles Auto Raid",
    CurrentValue = false,
    Flag = "AutoRaid",
    Callback = function(Value)
		getgenv().AutoRaid = Value
	end,
})
--EventTAB
local BloodMoonCheckToggle = EventTab:CreateToggle({
    Name = "Blood Moon Check",
    Info = "Toggles Blood Moon Check",
    CurrentValue = false,
    Flag = "BloodMoonCheck",
    Callback = function(Value)
		getgenv().BloodMoonCheck = Value
	end,
})

local BloodMoonAutoUseLuckBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Luck Boosts",
    Info = "Toggles Auto Use Luck Boosts at BloodMoon Event",
    CurrentValue = false,
    Flag = "BloodMoonAutoUseLuckBoosts",
    Callback = function(Value)
		getgenv().bAutoUseLuckBoost = Value
	end,
})

local BloodMoonAutoUseSecretLuckBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Secret Luck Boosts",
    Info = "Toggles Auto Use Secret Luck Boosts at BloodMoon Event",
    CurrentValue = false,
    Flag = "BloodMoonAutoUseSecretLuckBoosts",
    Callback = function(Value)
		getgenv().bAutoUseSecretLuckBoost = Value
	end,
})

local BloodMoonAutoUseCoinBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Coin Boosts",
    Info = "Toggles Auto Use Coin Boosts at BloodMoon Event",
    CurrentValue = false,
    Flag = "BloodMoonAutoUseCoinBoosts",
    Callback = function(Value)
		getgenv().bAutoUseCoinBoost = Value
	end,
})

local BloodMoonAutoUsePowerBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Power Boosts",
    Info = "Toggles Auto Use Power Boosts at BloodMoon Event",
    CurrentValue = false,
    Flag = "BloodMoonAutoUsePowerBoosts",
    Callback = function(Value)
		getgenv().bAutoUsePowerBoost = Value
	end,
})

local BloodMoonAutoUseDmgBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Dmg Boosts",
    Info = "Toggles Auto Use Dmg Boosts at BloodMoon Event",
    CurrentValue = false,
    Flag = "BloodMoonAutoUseDmgBoosts",
    Callback = function(Value)
		getgenv().bAutoUseDmgBoost = Value
	end,
})

local BloodMoonRelicPresetDropdown = EventTab:CreateDropdown({
	Name = "Equip Relic Group ",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "BloodMoonRelicPresetDropdown",
	Callback = function(Option)
		RelicPresetSetting.BloodMoon = Option
	end,
})

local BloodMoonWeaponPresetDropdown = EventTab:CreateDropdown({
	Name = "Equip Weapon Group ",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "BloodMoonWeaponPresetDropdown",
	Callback = function(Option)
		WeaponPresetSetting.BloodMoon = Option
	end,
})

local Section = EventTab:CreateSection("Night Event")
local NightCheckToggle = EventTab:CreateToggle({
    Name = "Egg Night",
    Info = "Toggles Egg Night",
    CurrentValue = false,
    Flag = "EggNight",
    Callback = function(Value)
		getgenv().NightCheck = Value
	end,
})

local NightAutoUseLuckBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Luck Boosts",
    Info = "Toggles Auto Use Luck Boosts at Night Event",
    CurrentValue = false,
    Flag = "NightAutoUseLuckBoosts",
    Callback = function(Value)
		getgenv().nAutoUseLuckBoost = Value
	end,
})

local NightAutoUseSecretLuckBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Secret Luck Boosts",
    Info = "Toggles Auto Use Secret Luck Boosts at Night Event",
    CurrentValue = false,
    Flag = "NightAutoUseSecretLuckBoosts",
    Callback = function(Value)
		getgenv().nAutoUseSecretLuckBoost = Value
	end,
})

local NightAutoUsePowerBoostsToggle = EventTab:CreateToggle({
    Name = "Auto Use Power Boosts",
    Info = "Toggles Auto Use Power Boosts at Night Event",
    CurrentValue = false,
    Flag = "NightAutoUsePowerBoosts",
    Callback = function(Value)
		getgenv().nAutoUsePowerBoost = Value
	end,
})

local NgihtRelicPresetDropdown = EventTab:CreateDropdown({
	Name = "Equip Relic Group ",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "NgihtRelicPresetDropdown",
	Callback = function(Option)
		RelicPresetSetting.Night = Option
	end,
})

local NightWeaponPresetDropdown = EventTab:CreateDropdown({
	Name = "Equip Weapon Group ",
	Options = {1,2,3},
	CurrentOption = "",
	Flag = "NightWeaponPresetDropdown",
	Callback = function(Option)
		WeaponPresetSetting.Night = Option
	end,
})

--[[local HideMobButton = SettTab:CreateButton({
	Name = "Show/Hide Button",
	Callback = function()
		
		if MyButton.Visible then
			MyButton.Visible = false;
		else
			MyButton.Visible = true;
		end
	end,
})
]]




local AutoRollToggle = Enchant:CreateToggle({
    Name = "Auto Roll",
    Info = "Toggles Auto Roll",
    CurrentValue = false,
    Callback = function(Value)
		getgenv().AutoRoll = Value
	end,
})

local RollAminToggle = Enchant:CreateToggle({
    Name = "Close Roll Amination",
    Info = "Toggles Roll Amin",
    CurrentValue = false,
    Callback = function(Value)
		getgenv().IgnRollAmin = Value
	end,
})

local RollListDispaly = Enchant:CreateParagraph({
	Title = "RollList :",
	Content = "\n\n\n\n\n\n\n\n\n\n"
})

local TstButton = Enchant:CreateButton({
	Name = "Add",
	Callback = function()
		local selec = nil
		for i,v in pairs(LocalPlayer.PlayerGui.WeaponInv.Background.ImageFrame.Window.WeaponHolder.WeaponScrolling:GetChildren()) do
			if v:IsA("Frame") and v.Frame.Selected.Visible == true then
				selec = v.Name
			end
		end
		if selec and not table.find(RollList,selec) then
			table.insert(RollList,selec)
			RollListDispaly:Set({
				Title = "RollList :",
				Content = table.concat(RollList,"\n")
			})
		end
	end,
})
local LockButton = Enchant:CreateButton({
	Name = "Lock",
	Callback = function()
		if not next(RollList) then return end
		for _,v in pairs(RollList) do
			if not PlayerData.WeaponInv[v].locked then
				KnitService.WeaponInvService.RF.LockWeapon:InvokeServer(v)
			end
		end
	end,
})

local RollListClrButton = Enchant:CreateButton({
	Name = "Clear",
	Callback = function()
		RollList = {}
		RollListDispaly:Set({
			Title = "RollList :",
			Content = ""
		})
	end,
})


--MiscTab
local DungeonAutoBuyToggle = MiscTab:CreateToggle({
    Name = "Auto Buy Dungeon Iteams",
    Info = "Toggles Auto Buy Dungeon  Iteams",
    CurrentValue = false,
    Flag = "DungeonAutoBuy",
    Callback = function(Value)
		getgenv().DungeonAutoBuy = Value
	end,
})

local TravellingMerchantAutoBuyToggle = MiscTab:CreateToggle({
    Name = "Auto Buy Travelling Merchant Iteams",
    Info = "Toggles Auto Buy Travelling Merchant Iteams",
    CurrentValue = false,
    Flag = "TravellingMerchantAutoBuyToggle",
    Callback = function(Value)
		getgenv().TravellingMerchantAutoBuy = Value
	end,
})

local AutoClaimChestsToggle = MiscTab:CreateToggle({
    Name = "Auto Claim Chests",
    Info = "Toggles Auto Claim Chests",
    CurrentValue = false,
    Flag = "AutoClaimChestsToggle",
    Callback = function(Value)
		getgenv().AutoClaimChests = Value
	end,
})

local InfiniteJumpToggle = MiscTab:CreateToggle({
    Name = "Infinite Jump",
    Info = "Toggles Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
		InfiniteJump = Value
		game:GetService("UserInputService").JumpRequest:connect(function()
			if InfiniteJump then
				LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
    end,
})

local PickRangeInput = MiscTab:CreateInput({
	Name = "PickUp Range",
	PlaceholderText = "Input a Num",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		Text = tonumber(Text)
		if Text then
			Workspace:SetAttribute("PICKUP_RANGE",Text)
		end
	end,
})

local ClaimQButton = MiscTab:CreateButton({
	Name = "Claim Quests",
	Callback = function()
        for i,v in pairs(Knit_Pkg.GetController("DatabaseController"):GetDatabase("Questlines")) do
            task.spawn(function()
				KnitService.QuestService.RF.ActionQuest:InvokeServer(tostring(i))
			end)
            wait(0.5)
        end
	end,
})

local ClaimBPButton = MiscTab:CreateButton({
	Name = "Claim All BP Rewards",
	Callback = function()
		if PlayerData.SeasonPassXP < 350 then
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Error!",
				Text = "战令等级至少为2级90经验",
			})
			return
		end
		KnitService.SeasonPassService.RE.RedeemAll:FireServer()
		for i,v in next,Knit_Pkg.GetController("DatabaseController"):GetDatabase("Tiers") do
			if not PlayerData.ClaimedSeasonPassTiers["Free"][i] then
				KnitService.SeasonPassService.RE.RedeemTier:FireServer(i, true)
				wait()
			end
			if not table.find(PlayerData.SeasonPassPremium, Knit_Pkg.GetController("DatabaseController"):GetDatabase("SeasonData").CurrentSeason) then continue end
			if not PlayerData.ClaimedSeasonPassTiers["Premium"][i] then
				KnitService.SeasonPassService.RE.RedeemTier:FireServer(i, false)
				wait()
			end
		end
		KnitService.SeasonPassService.RE.RedeemAll:FireServer()
		for i,v in next,Knit_Pkg.GetController("DatabaseController"):GetDatabase("Tiers") do
			if not PlayerData.ClaimedSeasonPassTiers["Free"][i] then
				KnitService.SeasonPassService.RE.RedeemTier:FireServer(i, true)
				wait()
			end
			if not table.find(PlayerData.SeasonPassPremium, Knit_Pkg.GetController("DatabaseController"):GetDatabase("SeasonData").CurrentSeason) then continue end
			if not PlayerData.ClaimedSeasonPassTiers["Premium"][i] then
				KnitService.SeasonPassService.RE.RedeemTier:FireServer(i, false)
				wait()
			end
		end
		if PlayerData.SeasonPassXP < 620 then
			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = "Error!",
				Text = "战令等级至少为3级155经验解锁全部",
			})
			return
		end
		PlayerData.SeasonPassXP = 7000
	end,
})

local EnchantUIButton = MiscTab:CreateButton({
	Name = "Open Enchant UI",
	Callback = function()
		UIController:OpenScreen("Enchant")
	end,
})

local UnlockTPToggle = MiscTab:CreateToggle({
    Name = "Unlock TP",
    Info = "Toggles Unlock TP",
    CurrentValue = false,
    Flag = "UnlockTP",
    Callback = function(Value)
		if Value then 
			local Button = LocalPlayer.PlayerGui.LeftSidebar.Background.Frame.MinorButtons.Teleport.Button
			local ButtonC = Button:Clone()
			ButtonC.Parent = Button.Parent
			Button:Remove()
			ButtonC.Activated:Connect(function()
				UIController:OpenScreen("Teleport")
			end)
		end
    end,
})

local UnlockSwingToggle = MiscTab:CreateToggle({
    Name = "Unlock Auto Swing",
    Info = "Toggles Unlock Auto Swing",
    CurrentValue = false,
    Flag = "UnlockAutoSwing",
    Callback = function(Value)
		if Value then 
			local Button = LocalPlayer.PlayerGui.RightSidebar.Background.Frame.Window.Items.AutoSwing.Button
			local ButtonC = Button:Clone()
			ButtonC.Parent = Button.Parent
			Button:Remove()
			ButtonC.Activated:Connect(function()
				Knit_Pkg.GetService("SettingsService"):ToggleAuto()
			end)
		end
    end,
})

local InvisiToggle = MiscTab:CreateToggle({
    Name = "Invisibility",
    Info = "Toggles Invisibility",
    CurrentValue = false,
    Flag = "invisibility",
    Callback = function(Value)
		if Value then 
			Invisfunc()
			writefile("SFS Sript/set","true")
		else
			writefile("SFS Sript/set","false")
		end
    end,
})
-----Filter
local Section = Filter:CreateSection("Enchants Refuse Filter")
local EnchantsRefuseJson = Filter:CreateLabel({
	CurrentValue = "",
	Flag = "EnchantsRefuseJson"
})

local UseFilterToggle = Filter:CreateToggle({
    Name = "Use Filter For Auto Sell?",
    Info = "Toggles Use Filter",
    CurrentValue = false,
    Flag = "UseFilter",
    Callback = function(Value)
		UseFilter = Value
    end,
})

local RollUseFilterToggle = Filter:CreateToggle({
    Name = "Use Filter For Auto Roll?",
    Info = "Toggles Roll Use Filter",
    CurrentValue = false,
    Flag = "RollUseFilter",
    Callback = function(Value)
		RollUseFilter = Value
    end,
})

local EnchantRefuseDispaly = Filter:CreateParagraph({
	Title = "Enchants Refuse:",
	Content = ""
})

local EnchantRefuseAddDropdown

local EnchantsDropdown = Filter:CreateDropdown({
	Name = "Enchant :",
	Options = EnchantTable, 
	CurrentOption = "",
	Flag = "EnchantsDropdown",
	Callback = function(Option)
		SelectedEnchant = Option
		if not EnchantsRefuse[SelectedEnchant] then EnchantsRefuse[SelectedEnchant] = {} end
		EnchantRefuseDispaly:Set({Title = SelectedEnchant, Content = table.concat(EnchantsRefuse[SelectedEnchant],", ")})
	end,
})

local EnchantRefuseAddDropdown = Filter:CreateDropdown({
	Name = "Tiers :",
	Options = {"","I","II","III","IV","V"}, 
	CurrentOption = "",
	Flag = "EnchantRefuseAddDropdown",
	Callback = function(Option)
		if Option == "" then return end
		if not SelectedEnchant then return end
		if not EnchantsRefuse[SelectedEnchant] then
			EnchantsRefuse[SelectedEnchant] = {}
		end
		if not table.find(EnchantsRefuse[SelectedEnchant],Option) then
			table.insert(EnchantsRefuse[SelectedEnchant],Option)
			table.sort(EnchantsRefuse[SelectedEnchant])
			EnchantRefuseDispaly:Set({Title = SelectedEnchant, Content = table.concat(EnchantsRefuse[SelectedEnchant],", ")})
			EnchantsRefuseJson:Set(HttpService:JSONEncode(EnchantsRefuse))
		end
	end,
})

local EnchantRstButton = Filter:CreateButton({
	Name = "Reset Selected",
	Callback = function()
		EnchantsRefuse[SelectedEnchant] = {}
		EnchantRefuseDispaly:Set({Title = SelectedEnchant, Content = table.concat(EnchantsRefuse[SelectedEnchant],", ")})
		EnchantsRefuseJson:Set(HttpService:JSONEncode(EnchantsRefuse))
	end,
})

local EnchantsRefuseDispalyButton = Filter:CreateButton({
	Name = "Dispaly All In Console",
	Callback = function()
		local tmp = {"\nEnchants Refuse:"}
		for i,v in pairs(EnchantTable) do
			if not EnchantsRefuse[v] then continue end
			table.insert(tmp,v..':'..table.concat(EnchantsRefuse[v],', '))
		end
		print(table.concat(tmp,"\n").."\n")
	end,
})


--加载配置并等待读取完毕
wait()
Rayfield:LoadConfiguration()
wait(1)
table.insert(RelicLabelList,RelicPresetLabel1)
table.insert(RelicLabelList,RelicPresetLabel2)
table.insert(RelicLabelList,RelicPresetLabel3)
table.insert(RelicButtonList,RelicPresetDisplayButton1)
table.insert(RelicButtonList,RelicPresetDisplayButton2)
table.insert(RelicButtonList,RelicPresetDisplayButton3)
table.insert(WeaponLabelList,WeaponPresetLabel1)
table.insert(WeaponLabelList,WeaponPresetLabel2)
table.insert(WeaponLabelList,WeaponPresetLabel3)
table.insert(WeaponButtonList,WeaponPresetDisplayButton1)
table.insert(WeaponButtonList,WeaponPresetDisplayButton2)
table.insert(WeaponButtonList,WeaponPresetDisplayButton3)

if SelectedRelicLabel and SelectedRelicLabel.CurrentValue ~= "" then
	print("Loading Last upgrade relic")
	SelectedRelic = SelectedRelicLabel.CurrentValue
end
if DisRarityWlLabel.CurrentValue ~= "" then
	print("Loading Dismantle rarities whitelist")
	DisRarityWl = string.split(DisRarityWlLabel.CurrentValue,"; ")
end
if RarityWlLabel.CurrentValue ~= "" then
	print("Loading Weapons sell rarities whitelist")
	RarityWl = string.split(RarityWlLabel.CurrentValue,"; ")
end
if FarmListLabel.CurrentValue ~= "" then
	print("Loading Farm List ")
	MobSelectedList = string.split(FarmListLabel.CurrentValue,"; ")
end
if ExpRelicListLabel.CurrentValue ~= "" then
	print("Loading Exp Relic List")
	ExpRelicList = string.split(ExpRelicListLabel.CurrentValue,";")
end

if EnchantsRefuseJson and EnchantsRefuseJson.CurrentValue ~= "" then
	print("Loading EnchantsRefuse Table")
	EnchantsRefuse = HttpService:JSONDecode(EnchantsRefuseJson.CurrentValue)
	if SelectedEnchant and SelectedEnchant ~= "" then
		EnchantRefuseDispaly:Set({Title = SelectedEnchant, Content = table.concat(EnchantsRefuse[SelectedEnchant],", ")})
	end
end

for i,v in pairs(RelicLabelList) do
	if v and v.CurrentValue ~= "" then
		print("Loading Relic Preset "..tostring(i))
		RelicPresets[i] = string.split(RelicLabelList[i].CurrentValue,"; ")
		local str = {}
		for i,v in pairs(RelicPresets[i]) do
			if not PlayerData.RelicInv[v] then continue end
			table.insert(str,PlayerData.RelicInv[v].name.." | Exp:"..PlayerData.RelicInv[v].exp)
		end
		RelicButtonList[i]:Set(table.concat(str,' & '))
	end
end

for i,v in pairs(WeaponLabelList) do
	if v and v.CurrentValue ~= "" then
		print("Loading Weapon Preset "..tostring(i))
		WeaponPresets[i] = string.split(v.CurrentValue,"; ")
		local str = {}
		for i,v in pairs(WeaponPresets[i]) do
			if not PlayerData.WeaponInv[v] then continue end
			table.insert(str,PlayerData.WeaponInv[v].name)
		end
		WeaponButtonList[i]:Set(table.concat(str,' & '))
	end
end
wait(1)
------------------------------------Main---------------------------------

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),Workspace.CurrentCamera.CFrame)
end)

Workspace:SetAttribute("PICKUP_RANGE",1000)

--Get Secret Sword List	
for i, v in next,SwordDatabase do
	if v.rarity == "Secret" then
		table.insert(Secret,v.name)
	end
end

--Get Closest mobs
coroutine.wrap(function()
	while wait() do
		closest = Closest_NPC();
	end
end)()

--Raid Listen
game:GetService("ReplicatedStorage").ActiveRaids.ChildAdded:Connect(function()
	if AutoRaid then
		wait(3)
		getgenv().lastOpenTime = Workspace:GetAttribute("CURRENT_TIME")
		print("Raid Opened")
		Knit_Pkg.GetController("NotificationController"):Notification({
			message = "Raid Opened", 
			color = "RobuxColor", 
			multipleAllowed = false
		});
		Knit_Pkg.GetController("NotificationController"):Notification({
			message = "Will join after 170s...", 
			color = "Orange", 
			multipleAllowed = false
		});
	end
end)


--Listen
coroutine.wrap(function()
	while wait(4) do
		if BloodMoonCheck then
			isBloodMoon = Workspace:GetAttribute("BLOOD_MOON_EVENT")
			if isBloodMoon and not BMing then
				LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = beforePos
				local BMSpawn = CheckBMSpawn()
				if not BMSpawn then continue end
				print("BloodMoon Event On")
				--beforePos = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame
				if bAutoUseLuckBoost or bAutoUseSecretLuckBoost or bAutoUseCoinBoost or bAutoUsePowerBoost or bAutoUseDmgBoost and not hasUsed then
					hasUsed = true
					if bAutoUseLuckBoost then
						print("Blood moon event use Luck boosts")
						useBoost("Luck")
					end
					if bAutoUseSecretLuckBoost then
						print("Blood moon event use SecretLuck boosts")
						useBoost("SecretLuck")
					end
					if bAutoUseCoinBoost then
						print("Blood moon event use Coins boosts")
						useBoost("Coins")
					end
					if bAutoUsePowerBoost then
						print("Blood moon event use Power boosts")
						useBoost("Power")
					end
					if bAutoUseDmgBoost then
						print("Blood moon event use Damage boosts")
						useBoost("Damage")
					end
				end
				LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = BMSpawn.CFrame*CFrame.new(0,6,-2.5)
				if typeof(RelicPresetSetting.BloodMoon) == "number" then
					EquipRelics(RelicPresetSetting.BloodMoon)
				end
				if typeof(WeaponPresetSetting.BloodMoon) == "number" then
					EquipWeapons(WeaponPresetSetting.BloodMoon)
				end
				BMing = true
			end
			if not isBloodMoon and BMing then
				if typeof(RelicPresetSetting.Default) == "number" then
					EquipRelics(RelicPresetSetting.Default)
				end
				if typeof(WeaponPresetSetting.Default) == "number" then
					EquipWeapons(WeaponPresetSetting.Default)
				end
				BMing = false
				hasUsed = false
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
				if Root and beforePos then
					Root.CFrame = beforePos
				end
				print("BloodMoon Event Off")
			end
		end
		if NightCheck then
			isNight = Workspace:GetAttribute("NIGHT_EVENT")
			if isNight and not Nighting then
				print("Night Event On")
				--beforePos = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame
				if typeof(RelicPresetSetting.Night) == "number" then
					EquipRelics(RelicPresetSetting.Night)
				end
				if typeof(WeaponPresetSetting.Night) == "number" then
					EquipWeapons(WeaponPresetSetting.Night)
				end
				if nAutoUseLuckBoost or nAutoUseSecretLuckBoost or nAutoUsePowerBoost and not nhasUsed then
					hasUsed = true
					if nAutoUseLuckBoost then
						print("Night event use Luck boosts")
						useBoost("Luck")
					end
					if nAutoUseSecretLuckBoost then
						print("Night event use SecretLuck boosts")
						useBoost("SecretLuck")
					end
					if nAutoUsePowerBoost then
						print("Night event use Power boosts")
						useBoost("Power")
					end
				end
				LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame*CFrame.new(0,4,-3.5)
				wait()
				AutoOpenEggsToggle:Set(true)
				Nighting = true
				wait()
				LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame*CFrame.new(0,4,-3.5)
				wait()
				LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame*CFrame.new(0,4,-3.5)
			end
			if not isNight and Nighting then
				Nighting = false
				nhasUsed = false
				if typeof(RelicPresetSetting.Default) == "number" then
					EquipRelics(RelicPresetSetting.Default)
				end
				if typeof(WeaponPresetSetting.Default) == "number" then
					EquipWeapons(WeaponPresetSetting.Default)
				end
				--AutoOpenEggsToggle:Set(false)
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
				if Root and beforePos then
					Root.CFrame = beforePos
				end
				print("Night Event Off")
			end
		end
		if next(Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins:GetChildren()) then
			local currentTime = Workspace:GetAttribute("CURRENT_TIME")%1800
			if not BMing and not Nighting and currentTime > 51+15*60 and currentTime < 58+15*60 then
				print("Hard Dungeon Open")
				if HardDungeon and not LocalPlayer:GetAttribute("Raid") then
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
					if Root then
						--beforePos = Root.CFrame
						_MAIN = false
						local Dst = Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins["Dungeon 2"].CFrame*CFrame.new(0,6,0)
						LocalPlayer:RequestStreamAroundAsync(Dst.Position)
						LocalPlayer.Character:SetPrimaryPartCFrame(Dst)
						wait(1)
						local Dungeon_Parts = Workspace.Resources.Gamemodes.DungeonLobby.JoinParts
						for _, DungeonJoinPart in pairs(Dungeon_Parts:GetChildren()) do
							DungeonUID = DungeonJoinPart:GetAttribute("UID") or DungeonUID
							local Join_Res = Knit_Pkg.GetService("DungeonService"):JoinDungeon(DungeonUID)
							if Join_Res then
								TPController:Teleport({
									pos = Join_Res, 
									areaName = nil, 
									regionName = "Dungeon", 
									leaveGamemode = false
								});
								InDungeon = 2
								print("Join Hard Dungeon")
								if typeof(RelicPresetSetting.Dungeon) == "number" then
									EquipRelics(RelicPresetSetting.Dungeon)
								end
								if typeof(WeaponPresetSetting.Dungeon) == "number" then
									EquipWeapons(WeaponPresetSetting.Dungeon)
								end
								break
							end;
						end
						wait(3)
						_MAIN = true
					end
				end
			end
			if not BMing and not Nighting and currentTime > 51 and currentTime < 58 then
				print("Easy Dungeon Open")
				if EasyDungeon and not LocalPlayer:GetAttribute("Raid") then
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
					if Root then					
						--beforePos = Root.CFrame
						_MAIN = false
						local Dst = Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins["Dungeon 1"].CFrame*CFrame.new(0,6,0)
						LocalPlayer:RequestStreamAroundAsync(Dst.Position)
						LocalPlayer.Character:SetPrimaryPartCFrame(Dst)
						wait(1)
						local Dungeon_Parts = Workspace.Resources.Gamemodes.DungeonLobby.JoinParts
						for _, DungeonJoinPart in pairs(Dungeon_Parts:GetChildren()) do
							DungeonUID = DungeonJoinPart:GetAttribute("UID") or DungeonUID
							local Join_Res = Knit_Pkg.GetService("DungeonService"):JoinDungeon(DungeonUID)
							if Join_Res then
								TPController:Teleport({
									pos = Join_Res, 
									areaName = nil, 
									regionName = "Dungeon", 
									leaveGamemode = false
								});
								InDungeon = 1
								print("Join Easy Dungeon")
								break
							end;
						end
						wait(3)
						_MAIN = true
					end
				end
			end
		end
		
		ActiveRaid = game:GetService("ReplicatedStorage").ActiveRaids:FindFirstChildWhichIsA("BoolValue")
		if not (BMing or Nighting or InDungeon) then
			if AutoRaid and ActiveRaid and not LocalPlayer:GetAttribute("Raid") then
				local diffTime = Workspace:GetAttribute("CURRENT_TIME") - lastOpenTime
				--print(InDungeon)
				if diffTime >= 168 and diffTime < 178 then
					--beforePos = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame
					if not Workspace.Resources.Gamemodes.RaidJoins:FindFirstChild(ActiveRaid.Name) then
						_MAIN = false
						wait()
						TPController:TeleportArea("Area "..string.match(ActiveRaid.Name,"%d+"))
						wait()
						_MAIN = true
					end
					if Workspace.Resources.Gamemodes.RaidJoins:FindFirstChild(ActiveRaid.Name) then
						uid = Workspace.Resources.Gamemodes.RaidJoins[ActiveRaid.Name]:GetAttribute("UID")
						if uid then
							_MAIN = false
							wait(1)
							local res = KnitService.RaidService.RF.JoinRaid:InvokeServer(uid)
							print("Join "..ActiveRaid.Name.." ,"..PlayerData.RaidTickets.." tickets remain")
							wait(2)
							_MAIN = true
						end
					end
				end
			end
		end
		
		local RoomLabel = LocalPlayer.PlayerGui.Dungeon:FindFirstChild("Background"):FindFirstChild("Active"):FindFirstChild("RoomLabel")
		local Room = nil
		local TimeChec = (Workspace:GetAttribute("CURRENT_TIME")%1800 > 120 and Workspace:GetAttribute("CURRENT_TIME")%1800 < 900) or (Workspace:GetAttribute("CURRENT_TIME")%1800 > 17*60 and Workspace:GetAttribute("CURRENT_TIME")%1800 < 30*60)
		if RoomLabel then
			Room = tonumber(string.match(RoomLabel.Text,"%d+"))
		end
		if InDungeon and not LocalPlayer:GetAttribute("InDungeon") and (EasyDungeon or HardDungeon) and TimeChec then
			print("Error Leave")
			print(InDungeon)
			print(TimeChec)
			InDungeon = false
			if typeof(RelicPresetSetting.Default) == "number" then
				EquipRelics(RelicPresetSetting.Default)
			end
			if typeof(WeaponPresetSetting.Default) == "number" then
				EquipWeapons(WeaponPresetSetting.Default)
			end
			KnitService.DungeonService.RF.LeaveDungeon:InvokeServer()
		else
			if InDungeon == 1 and EasyDungeon and Room and Room > EasyReach and TimeChec then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer()
				print("Reached and Leave EasyDungeon at Room "..Room)
				wait(1)
			end
			if InDungeon == 2 and HardDungeon and Room and Room > HardReach and TimeChec then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer()
				print("Reached and Leave HardDungeon at Room "..Room)
				wait(1)
			end
		end

	end
end)()

--Auto Dungeon/Tower
task.spawn(function()
	local Dungeon2 = false;
	local Dungeon3 = false;
	local Tower2 = false;
	local Tower3 = false;
	local Raid2 = false;
	local Raid3 =false;
	task.spawn(function()
		RunService.Stepped:Connect(function()
			if not _MAIN then return end
			if InDungeon and ( EasyDungeon or HardDungeon ) and Dungeon2 == false and not closest then
				local Button = Workspace.Live.Dungeons:FindFirstChild("ContinueButton", true);
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
				if Button and next(Button:GetAttributes()) then
					coroutine.wrap(function()
						Dungeon2 = true;
						task.wait(.2);
						if not Root then return end
						Root.CFrame = Button.CFrame * CFrame.new(0, 6.75, -5);
						task.wait(.2);
						--firesignal(LocalPlayer.PlayerGui.DungeoNContinueButton.Frame.Button.Button.MouseButton1Click);
						KnitService.DungeonService.RF.ContinueDungeon:InvokeServer(Button:GetAttribute("UID"))
						task.wait(.2);
						Dungeon2 = false;
					end)()
				end
			end
			if AutoTower and LocalPlayer:GetAttribute("InTower") and Tower2 == false and not closest then
				local Button = Workspace.Live.Towers:FindFirstChild("ContinueButton", true);
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
				if Button and next(Button:GetAttributes()) then
					coroutine.wrap(function()
						Tower2 = true;
						task.wait(.2);
						if not Root then return end
						Root.CFrame = Button.CFrame * CFrame.new(0, 6.75, 0);
						task.wait(.2);
						--firesignal(LocalPlayer.PlayerGui.DungeoNContinueButton.Frame.Button.Button.MouseButton1Click);
						KnitService.TowerService.RF.ContinueTower:InvokeServer(Button:GetAttribute("UID"))
						task.wait(.2);
						Tower2 = false;
					end)()
				end
			end
			if AutoRaid and ActiveRaid and LocalPlayer:GetAttribute("Raid") and Raid2 == false then
				local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
				local Background = PlayerGui:WaitForChild("Raid"):WaitForChild("Background");
				local Active = Background:WaitForChild("Active");
				local TimerLabel = Background:WaitForChild("TimerLabel");
				local EnemiesLeft = Active:WaitForChild("EnemiesLeft")
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
				if EnemiesLeft and Root and TimerLabel.Text == "STARTS IN 00:00" and Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].Boss:FindFirstChild("Spawn") then
					EnemiesLeft = tonumber(EnemiesLeft.TextLabel.Text)
					coroutine.wrap(function()
						Raid2 = true
						if EnemiesLeft == 0 then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].Boss.Spawn.CFrame*CFrame.new(0,3,-5.5)
							wait(1)
						end
						if EnemiesLeft == 3 then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[1].Spawn.CFrame*CFrame.new(0,3,-5.5)
							wait(1)
						end
						if EnemiesLeft == 2 then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[2].Spawn.CFrame*CFrame.new(0,3,-5.5)
							wait(1)
						end
						if EnemiesLeft == 1 then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[3].Spawn.CFrame*CFrame.new(0,3,-5.5)
							wait(1)
						end
						Raid2 = false
					end)()
				end
			end
		end)
	end)
	
	task.spawn(function()
		RunService.Stepped:Connect(function()
			if _MAIN and InDungeon and ( EasyDungeon or HardDungeon ) and Dungeon3 == false then
				coroutine.wrap(function()
					Dungeon3 = true;
					repeat wait() until LocalPlayer.PlayerGui.DungeonResult.Background.AbsolutePosition == Vector2.new(0, -36)
					InDungeon = false
					print("Finished and Leave")
					if typeof(RelicPresetSetting.Default) == "number" then
						EquipRelics(RelicPresetSetting.Default)
					end
					if typeof(WeaponPresetSetting.Default) == "number" then
						EquipWeapons(WeaponPresetSetting.Default)
					end
					_MAIN = false
					task.wait(2);
					firesignal(LocalPlayer.PlayerGui.DungeonResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(1)
					LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = beforePos
					task.wait(1)
					_MAIN = true
					Dungeon3 = false;
				end)()
			end
			if false and _MAIN and AutoTower and Tower3 == false then
				coroutine.wrap(function()
					Tower3 = true;
					repeat wait() until LocalPlayer.PlayerGui.TowerResult.Background.AbsolutePosition == Vector2.new(0, -36)
					task.wait(3);
					firesignal(LocalPlayer.PlayerGui.TowerResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(2)
					--LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = beforePos
					Tower3 = false;
				end)()
			end
			if _MAIN and AutoRaid and Raid3 == false then
				coroutine.wrap(function()
					Raid3 = true;
					repeat wait() until LocalPlayer.PlayerGui.RaidResult.Background.AbsolutePosition == Vector2.new(0, -36)
					print("Leave Raid")
					_MAIN = false
					task.wait(1);
					firesignal(LocalPlayer.PlayerGui.RaidResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(3)
					LocalPlayer.Character:WaitForChild("HumanoidRootPart",1).CFrame = beforePos
					_MAIN = true
					Raid3 = false;
				end)()
			end
		end)
	end)
end)
		
--Gravity
task.spawn(function()
	local Connection;
	local Force;
	local Attachment;
	if not Force then
		Force = Instance.new("VectorForce")
		Attachment = Instance.new("Attachment");
	end
	local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart");
    Force.ApplyAtCenterOfMass = true;
	Force.Attachment0 = Attachment;
    Force.Force = Util.GetMass(LocalPlayer.Character) * Vector3.new(0,workspace.Gravity,0)
    Force.Parent = Root
    Attachment.Parent = Root
	Force.Enabled = false
	local function Float(Character)
		if Connection then
			Connection:Disconnect();
			Connection = nil;
		end
		local stoptick = 0
		local flag = true
		--print("float")
		Connection = game:GetService("RunService").Stepped:Connect(function()
			if _MAIN and (AutoFarm or InDungeon) then
				Root.Velocity = Vector3.new(Root.Velocity.X, 0, Root.Velocity.Z);
				Force.Enabled = true
				if not closest then
					Force.Enabled = false
				end
			else		
				Force.Enabled = false
			end
		end)
	end
	if LocalPlayer.Character then Float(LocalPlayer.Character) end
	LocalPlayer.CharacterAdded:Connect(Float);
end)

local zero =false
--Auto Farm
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if zero == false then
			zero =true
			coroutine.wrap(function()
				while _MAIN and (AutoFarm or InDungeon or (BloodMoonCheck and isBloodMoon)) and not Nighting and not LocalPlayer:GetAttribute("Raid") do
					local currentClosest = Closest_NPC(true)
					local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					if currentClosest and Root then
						if (FarmAllMap and not InDungeon) or (BloodMoonCheck and isBloodMoon and next(BloodMoonMobs)) then 
							Root.CFrame = currentClosest.CFrame*CFrame.new(0,6,-2.5)
							local count = 0
							repeat
								task.wait()
								coroutine.wrap(function()
									KnitService.ClickService.RF.Click:InvokeServer(tostring(currentClosest))
								end)()
								count = count + 1
							until not _MAIN or not AutoFarm or currentClosest:GetAttribute("Health") == 0 or count > 20
							continue
						else
							Root.CFrame = currentClosest:FindFirstChild("HumanoidRootPart").CFrame*CFrame.new(0,6,-2.5)
							KnitService.ClickService.RF.Click:InvokeServer(tostring(currentClosest))
							while _MAIN and LocalPlayer:GetAttribute("NPC") do
								task.wait()
							end
						end
					end
					task.wait()
				end
				zero = false
			end)()
		end
	end)
end)

local one = false
--Auto Click
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if one == false then
			one =true
			while task.wait() and _POWER do
				for i= 1, ClickSpeed do
					coroutine.wrap(function()
						KnitService.ClickService.RF.Click:InvokeServer(tostring(closest))
					end)()
				end
			end
			one = false
		end
	end)
end)

local two = false

--Auto Dismantle
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if two == false then
			two = true
			while getgenv().PetDis and wait(2) do
				local dPetFound = false;
				local dPets = {};
				for i, v in next, Knit_Pkg.GetController("DataController"):GetData("PlayerData").PetInv do
					if DisRarityCheck and table.find(DisRarityWl,PetsDatabase[v.name].rarity) then
						continue
					end
					if v.locked ~= true and v.equipped ~= true then	
						dPetFound = true;
						table.insert(dPets, v.uid);	
					end
				end
				if dPetFound == true then
					KnitService.PetLevelingService.RF.Dismantle:InvokeServer(dPets);
					dPetFound = false;
					--getconnections(LocalPlayer.PlayerGui.PetLeveling.Background.Exit.Button.MouseButton1Click)[1]:Fire();
					UIController:CloseScreen("PetLeveling");
				end
				wait(DismantleDelay) 
			end
			two = false
		end
	end)
end)

local three = false
--Auto Sell
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if three == false then
			three = true
			while getgenv().SwordSell and wait(2) do
				local SwordFound = false;
				local Swords = {};
				local Equipped = {};
				table.insert(Equipped,PlayerData.EquippedWeapon.Left);
				table.insert(Equipped,PlayerData.EquippedWeapon.Right);
				for i, v in next, PlayerData.WeaponInv do
					if RarityCheck and table.find(RarityWl,SwordDatabase[v.name].rarity) then
						continue
					end
					if table.find(Secret,v.name) then
						continue;
					end
					if v.locked or table.find(Equipped,v.uid) then
						continue;
					end
					if not v.enchants then
						continue
					end
					if not next(v.enchants) then
						SwordFound = true;
						Swords[tostring(v.uid)] = true;
						continue;
					end
					if CheckAccept(v,UseFilter) then continue end
					SwordFound = true;
					Swords[tostring(v.uid)] = true;
					continue;
				end
				if SwordFound == true then
					KnitService.WeaponInvService.RF.MultiSell:InvokeServer(Swords);
					SwordFound = false;
				end
				wait(SwordSellDelay);
			end
			three = false
		end
	end)
end)

local four = false
local fou = false
--Auto Egg/Auto Roll
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if four == false then
			four = true		
			coroutine.wrap(function()
				while getgenv().OpEgg do
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart",1)
					if not Root then continue end
					local EggMagnitude = (Root.Position - Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.Position).Magnitude
					if EggMagnitude <= 60 then
						KnitService.EggService.RF.BuyEgg:InvokeServer(Buy_Egg_Args)
						if ignoreAmin then
							Knit_Pkg.GetController("EggOpenController"):Reset()
						else
							UIController:AlwaysOnTop(true);
							UIController:CloseScreen("EggEffect");
						end
					else
						wait(5)
					end
					wait(0.05)
				end
				four = false
			end)()
		end
		if AutoRoll and not fou then
			fou =true
			coroutine.wrap(function()
				while AutoRoll and next(RollList) do
					KnitService.EnchantService.RF.RequestRoll:InvokeServer({
						["modeType"] = "Weapons",
						["weaponUID"] = RollList[1],
						["enchantTableName"] = "Normal",
						["rollType"] = "Shard",
						["auto"] = false
					})
					wait(4)
					if next(RollResult) and CheckAccept(RollResult,RollUseFilter) then
						table.remove(RollList,1)
						RollListDispaly:Set({
							Title = "RollList :",
							Content = table.concat(RollList,"\n")
						})
						if not next(RollList) then
							AutoRollToggle:Set(false)
							print("Roll Finished")
							Knit_Pkg.GetController("NotificationController"):Notification({
								message = "Roll Finished!", 
								color = "Orange", 
								multipleAllowed = false
							});
							break;
						end
					end
					RollResult = {}
				end
				fou = false
			end)()
		end
	end)
end)

local five = false

task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if five == false then
			five = true
			local expRelicFound = false
			if UpRelic or DungeonAutoBuy or TravellingMerchantAutoBuy or AutoClaimChests then
				if UpRelic and string.len(SelectedRelic) > 0 and PlayerData.RelicInv[SelectedRelic] then
					local RelicExp = {}
					for i, v in next, PlayerData.RelicInv do
						if v.equipped or v.locked then
							continue;
						end
						if table.find(ExpRelicList,v.name) then
							table.insert(RelicExp,v.uid)
							expRelicFound = true
						end

					end
					if expRelicFound then
						KnitService.RelicLevelingService.RF.LevelUp:InvokeServer(SelectedRelic, RelicExp)
						print("Leveling "..SelectedRelic.." with "..#RelicExp.." relics")
						UIController:CloseScreen("RelicLeveling")
						SelectedRelicDisplayLabel:Set(PlayerData.RelicInv[SelectedRelic].name.." | Exp:"..PlayerData.RelicInv[SelectedRelic].exp)
					end
				end
				if DungeonAutoBuy then
					for j=1,3 do
						for i=1,5 do
							KnitService.LimitedShopsService.RF.BuyItem:InvokeServer("DungeonShop", i);
							wait(0.8)
						end
					end
				end
				if TravellingMerchantAutoBuy then
					for j=1,3 do
						for i=1,5 do
							--if i == 4 then continue end
							KnitService.LimitedShopsService.RF.BuyItem:InvokeServer("TravellingMerchant", i);
							wait(0.8)
						end
					end
				end
				if AutoClaimChests then
					for i,v in {"Chest 1","Chest 2","Chest 3","Free Ticket 1","Free Ticket 2","Free Ticket 3"} do
						KnitService.ChestService.RF.ClaimChest:InvokeServer(v)
						wait(0.8)
					end
				end
				wait(10)
			end
			wait(3)
			five = false
		end
	end)
end)

----Button for Mobile
local MyGui = Instance.new("ScreenGui")
local MyButton = Instance.new("ImageButton")
MyGui.Parent = game.CoreGui
MyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
MyButton.Parent = MyGui
MyButton.Position = UDim2.new(0, 50, 0, 20)
MyButton.Size = UDim2.new(0, 35, 0, 35)
MyButton.Image="rbxassetid://5198838744"
MyButton.BackgroundTransparency = 1

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	MyButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MyButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MyButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MyButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
MyButton.MouseButton1Click:connect(function()
	if Debounce then return end
		if Hidden then
			Hidden = false
			Unhide()
		else
			Hidden = true
			Hide()
		end
end)

local RelicLabelUI = game:GetService("CoreGui").Rayfield.Main.Elements.Relic:GetChildren()
RelicLabelUI[6].Visible = false
RelicLabelUI[10].Visible = false
RelicLabelUI[11].Visible = false
RelicLabelUI[12].Visible = false
local WeaponLabelUI = game:GetService("CoreGui").Rayfield.Main.Elements.Weapon:GetChildren()
WeaponLabelUI[4].Visible = false
WeaponLabelUI[5].Visible = false
WeaponLabelUI[6].Visible = false
local FilterLabelUI = game:GetService("CoreGui").Rayfield.Main.Elements.Filter:GetChildren()
FilterLabelUI[4].Visible = false
--hookfunction
local Target = Knit_Pkg.GetController("EnchantRollController")
--local Target = require(game:GetService("ReplicatedStorage").ClientModules.Controllers.AfterLoad.EnchantRollController)
oldRoll = hookfunction(Target["Roll"],
function(this,result)
	RollResult = result
	if not (AutoRoll and IgnRollAmin) then
		return oldRoll(this,result)
	end
end)
--Target = require(game:GetService("ReplicatedStorage").ClientModules.Controllers.AfterLoad.ItemDropController.ItemDropNode)
hookfunction(require(game:GetService("ReplicatedStorage").ClientModules.Controllers.AfterLoad.ItemDropController.ItemDropNode)["Pickup"],
function(this)
	return this:Claim();
end)

--Anti Crash
game.NetworkClient.ChildRemoved:Connect(function()
   game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)
print("Done!")