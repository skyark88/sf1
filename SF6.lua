print("Loading...");
Invisfunc = function()
	local removeNametags = false;
	local plr = game:GetService("Players").LocalPlayer;
	local character = plr.Character;
	local hrp = character.HumanoidRootPart;
	local old = hrp.CFrame;
	if (not character:FindFirstChild("LowerTorso") or (character.PrimaryPart ~= hrp)) then
		return print("unsupported");
	end
	if removeNametags then
		local tag = hrp:FindFirstChildOfClass("BillboardGui");
		if tag then
			tag:Destroy();
		end
		hrp.ChildAdded:Connect(function(item)
			if item:IsA("BillboardGui") then
				task.wait();
				item:Destroy();
			end
		end);
	end
	local newroot = character.LowerTorso:Clone();
	hrp.Parent = workspace;
	character.PrimaryPart = hrp;
	character:MoveTo(Vector3.new(old.X, 8999999488, old.Z));
	hrp.Parent = character;
	task.wait(0.5);
	newroot.Parent = hrp;
	hrp.CFrame = old;
end;
if ((#game.Players:GetPlayers() > 1) and isfile("SFS Sript/set") and (readfile("SFS Sript/set") == "true")) then
	Invisfunc();
end
local ConfigurationName = "SFS";
local closest = nil;
local selectedEgg = "Molten Egg";
local SelectedRelic = "";
local selecetWeaponGroup = "";
local ExpRelicList = {};
local Secret = {};
local RarityWl = {};
local DisRarityWl = {};
local Eggs = {};
local DisplayEggs = {};
local AreaMobsList = {};
local RelicLabelList = {};
local RelicButtonList = {};
local RelicPresetSetting = {Selected=nil,Default=nil,Dungeon=nil,BloodMoon=nil,Ngiht=nil};
local MobBlackList = {};
local MobWhiteList = {};
local SelectMobList = {};
local WeaponLabelList = {};
local WeaponButtonList = {};
local RollList = {};
local EnchantsRefuse = {};
local PetEnchantsRefuse = {};
local SelectedEnchant;
local SelectedPetEnchant;
local InfiniteJump = false;
local isBloodMoon = false;
local isServerBoss = false;
local isKillServerBoss = false;
local isNight = false;
local hasUsed = false;
local nhasUsed = false;
local InDungeon = false;
local BMing = false;
local Nighting = false;
local KillingGlobalBoss = false;
local ActiveRaid = nil;
local ContinueButtonUID = false;
local DungeonContinueButton = false;
local AreaMaps = {"Server Boss","Area 1","Area 2","Area 3","Area 4","Area 5","Area 6","Area 7","Area 8","Area 9","Area 10","Area 11","Area 12","Area 13","Area 14","Area 15","Area 16","Area 17"};
local Buy_Egg_Args = {eggName="Egg 25",auto=false,amount=4};
local AllMobs = {["Server Boss"]={"Water Drop OverLord","Kal'zim the Exiled Demon","Cherry Blossom Warrior"},["Area 1"]={"Goblin","Orc","Dark Knight","Dark Commander","Sea Emperor"},["Area 2"]={"Skeleton","Pirate Thief","Pirate Captain","Pirate Admiral"},["Area 3"]={"Ninja","Samurai","Samurai Master","Oni"},["Area 4"]={"Penguin","Snow Warrior","Yeti","Ice King"},["Area 5"]={"Monk","Angel","Guardian","Zeus the God"},["Area 6"]={"Imp","Demon","Lava Golem","Red Devil"},["Area 7"]={"Mummy","Royal Warrior","Desert Beast","King Pharaoh"},["Area 8"]={"Satyr","Cyclops","Purple Dragon","Adurite Warden","Lost Soul"},["Area 9"]={"Mushy","Zombie Miner","Golem","Necromancer","Blood Zombie","Blood Vampire"},["Area 10"]={"Power Force","Paladin","Warlock","Spirit Lord","Brown Insect","Green Insect","Mutant Insect"},["Area 11"]={"Marine","Barbarian Pirate","Madman","Skye Knight","Malevolent Spirit","Lost Titan","Blood Knight","Marine Castle"},["Area 12"]={"Feathered Warrior","Cthulhu","Centaur King","Celestial Gatekeeper","Skywatcher","Stormbringer","Vulcanus Maximus","Demonic Altar","High Havens"},["Area 13"]={"Dune Critter","Reptilian Beast","Sandstone Golem","Scorpion Queen","Haunted Witch","Haunted Reaper","Nightstalker","Forsaken Hunter","Cracked Canyons"},["Area 14"]={"Small Titan","Cart Titan","Beast Titan","Colossus Titan","Founding Titan","Warhammer Titan","Jaw Titan","Colossus Meadows"},["Area 15"]={"Poseidon's Warrior","Undertides Bounty Hunter","Seaborn","Unknown Deep Sea Diver","Abyssal Hunter","Amaia","Gawain the Half Shark Man","Underwater"},["Area 16"]={"Magma Monster","Underwold Dealer","Undead Knight","Lucifer","Corrupted Demon","Scarlet Fiend","Hell's Warrior","Muay Thai Demon","Blazing Abyss"},["Area 17"]={"Hapkido Grandmaster","Black Tiger","Crimson Phoenix","Dragon Whisperer","Korean Wind","Korean Sunrise","Seoul Shogun","Muay Thai Demon","Hangug Hollows"}};
local BloodMoonMobs = {"Nightstalker","Warhammer Titan","Jaw Titan","Amaia","Gawain the Half Shark Man","Hell's Warrior","Muay Thai Demon","Seoul Shogun","Muay Thai Demon"};
local ServerBossList = {"Water Drop Overlord","Kal'zim the Exiled Demon","Cherry Blossom Warrior"};
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local KnitService = game:GetService("ReplicatedStorage").Packages.Knit.Services;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Workspace = game:GetService("Workspace");
local Knit_Pkg = require(game:GetService("ReplicatedStorage").Packages.Knit);
local PlayerData = Knit_Pkg.GetController("DataController"):GetData("PlayerData");
local SwordDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Weapons");
local EggsDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Eggs");
local PetsDatabase = Knit_Pkg.GetController("DatabaseController"):GetDatabase("Pets");
local GlobalBoss = Knit_Pkg.GetController("DatabaseController"):GetDatabase("GlobalBoss");
local UIController = Knit_Pkg.GetController("UIController");
local TPController = Knit_Pkg.GetController("TeleportController");
local WController = Knit_Pkg.GetController("WheelController");
local NPCController = Knit_Pkg.GetController("NPCController");
local IllusionistService = Knit_Pkg.GetService("IllusionistService");
local SkillService = Knit_Pkg.GetService("SkillService");
local Dungeon_Service = Knit_Pkg.GetService("DungeonService");
local NPCService = Knit_Pkg.GetService("NPCService");
local LimitedController = Knit_Pkg.GetController("LimitedShopsController");
local Util = require(Knit_Pkg.Util.Utility);
local MyGui = Instance.new("ScreenGui");
task.spawn(function()
	local Foot = game:GetService("Players").LocalPlayer.Character:FindFirstChild("RightFoot");
	local Hrp = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
	local oldPos = Hrp.CFrame;
	local dConnection = false;
	task.spawn(function()
		task.wait(1);
		getgenv().Connection = Foot.Touched:Connect(function()
			dConnection = true;
		end);
	end);
	repeat
		task.wait();
		Hrp.CFrame = CFrame.new(Workspace:GetAttribute("DungeonSpawn"));
		wait(2);
	until dConnection == true 
	getgenv().Connection:Disconnect();
	wait(0.5);
	Hrp.CFrame = oldPos;
end);
wait(1);
TPController:Teleport({pos=GlobalBoss.spawnPos,areaName=nil,regionName="Global Boss",leaveGamemode=true});
wait(1);
local Rayfield = loadstring(game:HttpGet("https://toscode.gitee.com/zzZ_39/script/raw/master/UILib.lua"))()
if Rayfield == nil then
	Rayfield = loadstring(game:HttpGet("https://pastebin.com/raw/DEsxsuKK"))()
end
local repo = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/";
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))();
local SaveManager = loadstring(game:HttpGet(repo .. "SaveManager.lua"))();
SaveManager:SetFolder("SFSConfiguration");
SaveManager:SetLibrary(Library);
local Window = Library:CreateWindow({Title="SFS Sript",Center=true,AutoShow=true});
Library:CreateUserData("UDatas");
local Tabs = {MainTab=Window:AddTab("Main-Dungeon"),RelicTab=Window:AddTab("Relic-Event"),Farm=Window:AddTab("Farm-Egg-Misc"),MiscTab=Window:AddTab("Filter"),EnchantTab=Window:AddTab("Enchant")};
local AutoClick = Tabs.MainTab:AddLeftGroupbox("AutoClick");
local Pet = Tabs.MainTab:AddLeftGroupbox("Pet");
local Weapon = Tabs.MainTab:AddLeftGroupbox("Weapon");
local Dungeon = Tabs.MainTab:AddRightGroupbox("Dungeon");
local Tower = Tabs.MainTab:AddRightGroupbox("Tower");
local Raid = Tabs.MainTab:AddRightGroupbox("Raid");
local BloodMoonEvent = Tabs.RelicTab:AddLeftGroupbox("Blood Moon Event");
local HightEvent = Tabs.RelicTab:AddLeftGroupbox("Hight Event");
local Upgrade = Tabs.RelicTab:AddRightGroupbox("Upgrade");
local UpgradeList = Tabs.RelicTab:AddRightGroupbox("UpgradeList");
local AutoFarmBox = Tabs.Farm:AddLeftGroupbox("Auto Farm");
local BlackList = Tabs.Farm:AddLeftGroupbox("BlackList");
local WhiteListList = Tabs.Farm:AddLeftGroupbox("WhiteListList");
local Egg = Tabs.Farm:AddRightGroupbox("Egg");
local Misc = Tabs.Farm:AddRightGroupbox("Misc");
local Filter = Tabs.MiscTab:AddLeftGroupbox("WeaponFilter");
local FilterList = Tabs.MiscTab:AddLeftGroupbox("WeaponFilterList");
local PetFilter = Tabs.MiscTab:AddRightGroupbox("PetFilter");
local PetFilterList = Tabs.MiscTab:AddRightGroupbox("PetFilterList");
local Enchant = Tabs.EnchantTab:AddLeftGroupbox("Enchant");
local RollList = Tabs.EnchantTab:AddRightGroupbox("RollList");
Library:OnUnload(function()
	MyGui:Destroy();
end);
AutoClick:AddToggle("AutoPower", {Text="Auto Power",Default=false,Tooltip="Auto Power"});
AutoClick:AddSlider("AuraDistance", {Text="Aura Distance",Default=40,Min=0,Max=50,Rounding=0,Compact=false});
AutoClick:AddSlider("ClickSpeed", {Text="Click Speed",Default=4,Min=0,Max=100,Rounding=0,Compact=false});
Pet:AddToggle("AutoDismantle", {Text="Auto Dismantle",Default=false,Tooltip="Auto Dismantle"});
Pet:AddSlider("DismantleDelay", {Text="Dismantle Delay",Default=60,Min=0,Max=100,Rounding=0,Compact=false});
Pet:AddToggle("DisRarityCheck", {Text="Rarity Check",Default=false,Tooltip="Rarity Check"});
Pet:AddDropdown("PetAddToWhitelist", {Values={"Common","Rare","Epic","Legendary","Mythic","Secret"},Default=0,Multi=true,Text="Add to Whitelist",Tooltip="Add to Whitelist"});
Weapon:AddToggle("AutoSell", {Text="Auto Sell",Default=false,Tooltip="Auto Sell"});
Weapon:AddSlider("SWordSellDelay", {Text="SWord Sell Delay",Default=30,Min=0,Max=100,Rounding=0,Compact=false});
Weapon:AddToggle("WeaponRarityCheck", {Text="Rarity Check",Default=false,Tooltip="Rarity Check"});
Weapon:AddDropdown("WeaponAddtoWhitelist", {Values={"Common","Rare","Epic","Legendary","Mythic","Secret"},Default=0,Multi=true,Text="Add to Whitelist",Tooltip="Add to Whitelist"});
Egg:AddToggle("AutoOpenEggs", {Text="Auto Open Eggs",Default=false,Tooltip="Auto Open Eggs"});
Egg:AddToggle("IgnoreOpneAmination", {Text="Ignore Opne Amination",Default=false,Tooltip="Ignore Opne Amination"});
Egg:AddDropdown("EggsSelected", {Values={},Default=0,Multi=false,Text="Eggs Selected",Tooltip="Eggs Selected"});
Egg:AddDropdown("EggsAmounts", {Values={1,2,3,4},Default=0,Multi=false,Text="Eggs Amounts",Tooltip="Eggs Amounts"});
Egg:AddButton("TP to Selected Eggs", function()
	LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
end);
Dungeon:AddToggle("AutoEasy", {Text="Auto Easy",Default=false,Tooltip="Auto Easy Dungeon"});
Dungeon:AddSlider("EasyRoom", {Text="Leave at Room",Default=30,Min=0,Max=50,Rounding=0,Compact=false});
Dungeon:AddToggle("AutoHard", {Text="Auto Hard",Default=false,Tooltip="Auto Hard Dungeon"});
Dungeon:AddSlider("HardRoom", {Text="Leave at Room",Default=30,Min=0,Max=50,Rounding=0,Compact=false});
Dungeon:AddToggle("AutoInsane", {Text="Auto Insane",Default=false,Tooltip="Auto Insane Dungeon"});
Dungeon:AddSlider("InsaneRoom", {Text="Leave at Room",Default=30,Min=0,Max=50,Rounding=0,Compact=false});
Dungeon:AddSlider("WaitTime", {Text="WaitTime",Default=0,Min=0,Max=1,Rounding=2,Compact=false});
Dungeon:AddInput("UseDamageRooms", {Default="0",Numeric=true,Finished=false,Text="Use Hard Damage Rooms",Tooltip="This is a tooltip",Placeholder="Placeholder text"});
Dungeon:AddInput("UseInsaneDamageRooms", {Default="0",Numeric=true,Finished=false,Text="Use Insane Damage Rooms",Tooltip="This is a tooltip",Placeholder="Placeholder text"});
Dungeon:AddDropdown("DungeonWeapon", {Values={},Default=0,Multi=false,Text="Dungeon Weapon",Tooltip="Selected Dungeon Weapon"});
Dungeon:AddButton("Reset Dungeon Status", function()
	InDungeon = false;
end);
Tower:AddToggle("AutoTower", {Text="Auto Tower",Default=false,Tooltip="Auto Tower"});
Raid:AddToggle("AutoRaid", {Text="Auto Raid",Default=false,Tooltip="Auto Raid"});
UpgradeList:AddLabel("UpgradeId", "", true);
UpgradeList:AddLabel("UpgradeName", "", true);
UpgradeList:AddLabel("UpgradeExp", "", true);
Upgrade:AddToggle("AutoUpgradeRelic", {Text="Auto Upgrade Relic",Default=false,Tooltip="Auto Upgrade Relic"});
Upgrade:AddLabel("BlackList", "20/25");
Upgrade:AddButton("All BlackList", function()
	for i, v in pairs(PlayerData.RelicAutoDelete) do
		if not v then
			KnitService.RelicInvService.RF.ToggleAutoDelete:InvokeServer(i);
			wait();
		end
	end
end);
Upgrade:AddButton("Add BlackList", function()
	ExpRelicList = {};
	for i, v in pairs(PlayerData.RelicAutoDelete) do
		if v then
			table.insert(ExpRelicList, i);
			KnitService.RelicInvService.RF.ToggleAutoDelete:InvokeServer(i);
			wait();
		end
	end
	UserDatas.UDatas:SetValue("ExpRelicList", ExpRelicList);
	Labels.BlackList:SetText("All:" .. #ExpRelicList);
end):AddButton("Add Up Relic", function()
	local selec = nil;
	for i, v in pairs(LocalPlayer.PlayerGui.Inventory.Background.ImageFrame.Window.Frames.ItemsFrame.ItemsHolder.ItemsScrolling:GetChildren()) do
		if (v:IsA("Frame") and (v.Frame.Selected.Visible == true)) then
			selec = v.Name;
		end
	end
	if selec then
		SelectedRelic = selec;
		Labels.UpgradeId:SetText(selec);
		UserDatas.UDatas:SetValue("UpgradeId", selec);
		Labels.UpgradeName:SetText(PlayerData.RelicInv[selec].name);
		UserDatas.UDatas:SetValue("UpgradeName", PlayerData.RelicInv[selec].name);
		Labels.UpgradeExp:SetText(PlayerData.RelicInv[selec].exp);
		UserDatas.UDatas:SetValue("UpgradeExp", PlayerData.RelicInv[selec].exp);
	else
		Labels.UpgradeId:SetText("NULL");
	end
end);
Upgrade:AddDropdown("Relic_DefaultWeaponGroup", {Values={},Default=0,Multi=false,Text="Default Weapon Group",Tooltip="Selected Default Weapon Group"});
AutoFarmBox:AddToggle("autoFarm", {Text="Auto Farm",Default=false,Tooltip="Auto Farm"});
AutoFarmBox:AddToggle("FarmAllMap", {Text="Farm All Map",Default=false,Tooltip="Farm All Map"});
AutoFarmBox:AddToggle("FarmSelectedMobs", {Text="Farm Selected Mobs",Default=false,Tooltip="Farm Selected Mobs"});
AutoFarmBox:AddLabel("MonstersLabel", "list");
AutoFarmBox:AddDropdown("SelectedArea", {Values=AreaMaps,Default=0,Multi=false,Text="Selected Area",Tooltip="Selected Area"});
AutoFarmBox:AddDropdown("SelectedMob", {Values={},Default=0,Multi=true,Text="Black List Mob",Tooltip="Black List Mob"});
BlackList:AddLabel("BlackListLabel", "", true);
WhiteListList:AddLabel("WhiteListLabel", "", true);
AutoFarmBox:AddDropdown("OtherMob", {Values={},Default=0,Multi=true,Text="White List Mob",Tooltip="White List Mob"});
AutoFarmBox:AddButton("Add BlackList", function()
	Labels.BlackListLabel:SetText("");
	local MobBlackListStr = "";
	for key, value in next, Options.SelectedMob.Value do
		if not table.find(MobBlackList, key) then
			table.insert(MobBlackList, key);
		end
	end
	for key, value in next, MobBlackList do
		MobBlackListStr = MobBlackListStr .. value .. "\n";
	end
	if (#MobBlackList == 0) then
		MobBlackListStr = MobBlackListStr .. "is NULL";
	end
	Labels.BlackListLabel:SetText(MobBlackListStr);
	UserDatas.UDatas:SetValue("MobBlackList", MobBlackList);
end):AddButton("Add WhiteList", function()
	Labels.WhiteListLabel:SetText("");
	local MobWhiteListStr = "";
	for key, value in next, Options.OtherMob.Value do
		if not table.find(MobWhiteList, key) then
			table.insert(MobWhiteList, key);
		end
	end
	for key, value in next, MobWhiteList do
		MobWhiteListStr = MobWhiteListStr .. value .. "\n";
	end
	if (#MobWhiteList == 0) then
		MobWhiteListStr = MobWhiteListStr .. "is NULL";
	end
	Labels.WhiteListLabel:SetText(MobWhiteListStr);
	UserDatas.UDatas:SetValue("MobWhiteList", MobWhiteList);
end);
AutoFarmBox:AddButton("Clean BlackList", function()
	Labels.BlackListLabel:SetText("");
	MobBlackList = {};
	UserDatas.UDatas:SetValue("MobBlackList", MobBlackList);
end):AddButton("Clean WhiteList", function()
	Labels.WhiteListLabel:SetText("");
	MobWhiteList = {};
	UserDatas.UDatas:SetValue("MobWhiteList", MobWhiteList);
end);
BloodMoonEvent:AddToggle("BloodMoonCheck", {Text="Blood Moon Check",Default=false,Tooltip="Blood Moon Check"});
BloodMoonEvent:AddToggle("CorruptEventCheck", {Text="Corrupt Event Check",Default=false,Tooltip="Corrupt Event Check"});
BloodMoonEvent:AddLabel("BTips", "Auto Use Boosts", false);
BloodMoonEvent:AddToggle("AutoUseLuck", {Text="Auto Use Luck",Default=false,Tooltip="Auto Use Luck"});
BloodMoonEvent:AddToggle("AutoUseSecretLuck", {Text="Auto Use Secret Luck",Default=false,Tooltip="Auto Use Secret Luck"});
BloodMoonEvent:AddToggle("AutoUseCoin", {Text="Auto Use Coin",Default=false,Tooltip="Auto Use Coin"});
BloodMoonEvent:AddToggle("AutoUsePower", {Text="Auto Use Power",Default=false,Tooltip="Auto Use Power"});
BloodMoonEvent:AddToggle("AutoUseDmg", {Text="Auto Use Dmg",Default=false,Tooltip="Auto Use Dmg"});
BloodMoonEvent:AddDropdown("SelectMob", {Values=BloodMoonMobs,Default=BloodMoonMobs,Multi=true,Text="Select Mob",Tooltip="Select Mob"});
BloodMoonEvent:AddDropdown("SetWeaponGroup", {Values={},Default=0,Multi=false,Text="Set Weapon Group",Tooltip="Set Weapon Group"});
HightEvent:AddToggle("EggNight", {Text="Egg Night",Default=false,Tooltip="Egg Night"});
HightEvent:AddLabel("Auto Use Boosts");
HightEvent:AddToggle("hAutoUseLuck", {Text="Auto Use Luck",Default=false,Tooltip="Auto Use Luck"});
HightEvent:AddToggle("hAutoUseSecretLuck", {Text="Auto Use Secret Luck",Default=false,Tooltip="Auto Use Secret Luck"});
HightEvent:AddToggle("hAutoUsePower", {Text="Auto Use Power",Default=false,Tooltip="Auto Use Power"});
HightEvent:AddDropdown("hSetWeaponGroup", {Values={},Default=0,Multi=false,Text="Set Weapon Group",Tooltip="Set Weapon Group"});
HightEvent:AddLabel("BTips", "Boss Use Hard Dungeon Weapon Group", false);
HightEvent:AddToggle("hServerBossCheck", {Text="Server Boss Check",Default=false,Tooltip="Server Boss Check"});
Misc:AddLabel("Auto Buy");
Misc:AddToggle("DungeonItems", {Text="Dungeon Items",Default=false,Tooltip="Dungeon Items"});
Misc:AddToggle("TravellingMerchantItems", {Text="Travelling Merchant Items",Default=false,Tooltip="Travelling Merchant Items"});
Misc:AddToggle("AutoClaimChests", {Text="Auto Claim Chests",Default=false,Tooltip="Auto Claim Chests"});
Misc:AddToggle("InfiniteJump", {Text="Infinite Jump",Default=false,Tooltip="Infinite Jump"});
Misc:AddInput("PickUpRange", {Default="",Numeric=true,Finished=true,Text="PickUp Range",Tooltip="PickUp Range",Placeholder="PickUp Range"});
Misc:AddButton("Claim Quests", function()
	for i, v in pairs(Knit_Pkg.GetController("DatabaseController"):GetDatabase("Questlines")) do
		task.spawn(function()
			KnitService.QuestService.RF.ActionQuest:InvokeServer(tostring(i));
		end);
		wait(0.5);
	end
end);
Misc:AddButton("Open Traits UI", function()
	UIController:OpenScreen("Traits");
end):AddButton("Open Enchant UI", function()
	UIController:OpenScreen("Enchant");
end);
Misc:AddButton("LimitedShops", function()
	if Workspace:GetAttribute("CORRUPT_EVENT") then
		LimitedController:LoadElements("LurkingShadow");
		LimitedController:Open();
	else
		Library:Notify("NO CORRUPT EVENT", 5);
	end
end);
Misc:AddToggle("UnlockTP", {Text="Unlock TP",Default=false,Tooltip="Unlock TP"});
Misc:AddToggle("UnlockAutoSwing", {Text="Unlock Auto Swing",Default=false,Tooltip="Unlock Auto Swing"});
Misc:AddToggle("Invisibility", {Text="Invisibility",Default=false,Tooltip="Invisibility"});
Filter:AddToggle("UseFilterForAutoShell", {Text="Use Filter For Auto Shell?",Default=false,Tooltip="Use Filter For Auto Shell?"});
Filter:AddToggle("UseFilterForAutoRoll", {Text="Use Filter For Auto Roll?",Default=false,Tooltip="Use Filter For Auto Roll?"});
Filter:AddDropdown("Enchant", {Values={},Default=0,Multi=false,Text="Enchant",Tooltip="Enchant"});
Filter:AddDropdown("Tiers", {Values={0,1,2,3,4,5},Default=0,Multi=false,Text="Tiers",Tooltip="Tiers"});
FilterList:AddLabel("FList", "", true);
PetFilter:AddToggle("UsePetFilterForAutoShell", {Text="Use Filter For Auto Shell?",Default=false,Tooltip="Use Filter For Auto Shell?"});
PetFilter:AddDropdown("PetEnchant", {Values={},Default=0,Multi=false,Text="Enchant",Tooltip="Enchant"});
PetFilter:AddDropdown("PetTiers", {Values={0,1,2,3,4,5},Default=0,Multi=false,Text="Tiers",Tooltip="Tiers"});
PetFilterList:AddLabel("PetFList", "", true);
Enchant:AddToggle("AutoRoll", {Text="Auto Roll",Default=false,Tooltip="Auto Roll"});
Enchant:AddToggle("CloseRollAnimation", {Text="Close Roll Animation",Default=false,Tooltip="Close Roll Animation"});
RollList:AddLabel("RList", "", true);
Enchant:AddButton("Add", function()
end);
Enchant:AddButton("Lock", function()
end):AddButton("Clear", function()
end);
getgenv()._MAIN = true;
getgenv()._POWER = false;
getgenv().AutoFarm = false;
getgenv().FarmAllMap = false;
getgenv().FarmSelected = false;
getgenv().BloodMoonCheck = false;
getgenv().ServerBossCheck = false;
getgenv().CorruptEventCheck = false;
getgenv().isCorruptEvent = false;
getgenv().PetDis = false;
getgenv().SwordSell = false;
getgenv().OpEgg = false;
getgenv().ignoreAmin = false;
getgenv().UpRelic = false;
getgenv().DungeonAutoBuy = false;
getgenv().TravellingMerchantAutoBuy = false;
getgenv().AutoClaimChests = false;
getgenv().EasyDungeon = false;
getgenv().HardDungeon = false;
getgenv().InsaneDungeon = false;
getgenv().HardDungeonUseDamage = 0;
getgenv().InsaneDungeonUseDamage = 0;
getgenv().AutoTower = false;
getgenv().AutoRaid = false;
getgenv().bAutoUseLuckBoost = false;
getgenv().bAutoUseSecretLuckBoost = false;
getgenv().bAutoUseCoinBoost = false;
getgenv().bAutoUsePowerBoost = false;
getgenv().bAutoUseDmgBoost = false;
getgenv().nAutoUseLuckBoost = false;
getgenv().nAutoUseSecretLuckBoost = false;
getgenv().nAutoUsePowerBoost = false;
getgenv().RarityCheck = false;
getgenv().DisRarityCheck = false;
getgenv().UseFilter = false;
getgenv().UsePetFilter = false;
getgenv().Distance = 45;
getgenv().ClickSpeed = 5;
getgenv().SwordSellDelay = 40;
getgenv().DismantleDelay = 60;
getgenv().EasyReach = 50;
getgenv().HardReach = 40;
getgenv().InsaneReach = 10;
getgenv().DungeonWaitTime = 0;
getgenv().TowerReach = 62;
getgenv().lastOpenTime = 0;
getgenv().beforePos = LocalPlayer.Character.HumanoidRootPart.CFrame;
getgenv().RollResult = {};
getgenv().AutoRoll = false;
getgenv().IgnRollAmin = false;
getgenv().RollUseFilter = false;
getgenv().enchantsLevel = {"I","II","III","IV","V"};
for i, v in next, EggsDatabase do
	Eggs[v.name] = i;
	table.insert(DisplayEggs, v.name);
end
Options.EggsSelected.Values = DisplayEggs;
Options.EggsSelected:SetValues();
local EnchantTables = Knit_Pkg.GetController("DatabaseController"):GetDatabase("EnchantTables");
local WeaponEnchantTable = {};
local PetEnchantTable = {};
for i, v in pairs(EnchantTables) do
	for i, v2 in pairs(v) do
		local Ratestable = Knit_Pkg.GetController("DatabaseController"):GetDatabase(v2);
		if not Ratestable then
			continue;
		end
		for i, v3 in pairs(Ratestable) do
			if not v3 then
				continue;
			end
			if (v2 == "EnchantRates") then
				table.insert(WeaponEnchantTable, v3.name);
				EnchantsRefuse[v3.name] = 0;
			end
			if (v2 == "PetEnchantRates") then
				table.insert(PetEnchantTable, v3.name);
				PetEnchantsRefuse[v3.name] = 0;
			end
		end
	end
end
Options.Enchant.Values = WeaponEnchantTable;
Options.Enchant:SetValues();
Options.PetEnchant.Values = PetEnchantTable;
Options.PetEnchant:SetValues();
local WeaponGroups = {};
local loadWeaponGroup = function()
	local Loadouts = PlayerData.Loadouts;
	local WeaponGroupOptions = {};
	for addressId, WeaponGroup in Loadouts, nil do
		WeaponGroups[WeaponGroup.Name] = addressId;
		table.insert(WeaponGroupOptions, WeaponGroup.Name);
	end
	Options.Relic_DefaultWeaponGroup.Values = WeaponGroupOptions;
	Options.Relic_DefaultWeaponGroup:SetValues();
	Options.DungeonWeapon.Values = WeaponGroupOptions;
	Options.DungeonWeapon:SetValues();
	Options.SetWeaponGroup.Values = WeaponGroupOptions;
	Options.SetWeaponGroup:SetValues();
	Options.hSetWeaponGroup.Values = WeaponGroupOptions;
	Options.hSetWeaponGroup:SetValues();
end;
local EquipRelics = function(Preset)
	print("EquipRelics");
	task.spawn(function()
		Knit_Pkg.GetService("LoadoutService").EquipLoadout:Fire(WeaponGroups[Preset]);
		wait(2);
		Knit_Pkg.GetService("LoadoutService").EquipLoadout:Fire(WeaponGroups[Preset]);
	end);
	Knit_Pkg.GetService("LoadoutService").EquipLoadout:Fire(WeaponGroups[Preset]);
end;
loadWeaponGroup();
Upgrade:AddButton("Use Weapon", function()
	if (selecetWeaponGroup ~= nil) then
		EquipRelics(selecetWeaponGroup);
		Knit_Pkg.GetController("NotificationController"):Notification({message=("Use Weapon Group " .. selecetWeaponGroup),color="Red",multipleAllowed=false});
	end
end):AddButton("ReLoad Weapon", function()
	loadWeaponGroup();
end);
local useBoost = function(Name)
	local useBoostsTask = task.spawn(function()
		local timeleft = (20 * 60) - PlayerData.Boosts[Name].timeLeft;
		while timeleft > 300 do
			if ((Name == "SecretLuck") and (timeleft > 1200) and PlayerData.Boosts[Name].remaining[1200] and (PlayerData.Boosts[Name].remaining[1200] == 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "1800");
				break;
			end
			if ((timeleft > 1200) and PlayerData.Boosts[Name].remaining["1200"] and (PlayerData.Boosts[Name].remaining["1200"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "1200");
			elseif ((timeleft > 900) and PlayerData.Boosts[Name].remaining["900"] and (PlayerData.Boosts[Name].remaining["900"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "900");
			elseif ((timeleft > 600) and PlayerData.Boosts[Name].remaining["600"] and (PlayerData.Boosts[Name].remaining["600"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "600");
			elseif ((timeleft > 300) and PlayerData.Boosts[Name].remaining["300"] and (PlayerData.Boosts[Name].remaining["300"] > 0)) then
				KnitService.BoostService.RF.UseBoost:InvokeServer(Name, "300");
			end
			wait(1);
			timeleft = (21 * 60) - PlayerData.Boosts[Name].timeLeft;
		end
	end);
end;
local Closest_NPC = function(AutoFarmMode)
	local Closest = nil;
	local Dist = Distance;
	if AutoFarmMode then
		Dist = 900000000;
	end
	if (BloodMoonCheck and isBloodMoon and next(SelectMobList) and AutoFarmMode) then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if v:IsA("Part") then
				if table.find(SelectMobList, v:GetAttribute("Name")) then
					if (v:GetAttribute("Health") == 0) then
						continue;
					end
					return v;
				end
			end
		end
		return nil;
	end
	if (ServerBossCheck and isServerBoss) then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if (v:IsA("Part") and table.find(ServerBossList, v:GetAttribute("Name"))) then
				if isKillServerBoss then
					return nil;
				end
				return v;
			end
		end
		print("No ServerBoss");
		isServerBoss = false;
		task.spawn(function()
			if (typeof(RelicPresetSetting.Default) == "string") then
				EquipRelics(RelicPresetSetting.Default);
			end
			wait(2);
			LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
		end);
	end
	if (FarmAllMap and not InDungeon) then
		for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
			if v:IsA("Part") then
				local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if not Root then
					continue;
				end
				if (not InDungeon and FarmSelected and next(MobWhiteList) and not table.find(MobWhiteList, v:GetAttribute("Name"))) then
					continue;
				end
				if (table.find(MobBlackList, v:GetAttribute("Name")) and not KillingGlobalBoss) then
					continue;
				end
				if (v:GetAttribute("Health") == 0) then
					continue;
				end
				local Magnitude = (Root.Position - v.Position).Magnitude;
				if (Magnitude < Dist) then
					Closest = v;
					Dist = Magnitude;
				end
			end
		end
		return Closest;
	end
	if (((InDungeon == 2) or (InDungeon == 3)) and (DungeonWaitTime > 0)) then
		wait(DungeonWaitTime);
	end
	for i, v in next, Workspace.Live.NPCs.Client:GetChildren() do
		if v:IsA("Model") then
			local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			local DstRoot = v:FindFirstChild("HumanoidRootPart");
			if (not Root or not DstRoot) then
				continue;
			end
			if (not InDungeon and AutoFarm and not LocalPlayer:GetAttribute("Raid") and FarmSelected and next(MobWhiteList)) then
				local NPCTag = DstRoot:FindFirstChild("NPCTag");
				if (NPCTag and not table.find(MobWhiteList, NPCTag:FindFirstChild("NameLabel").Text)) then
					continue;
				end
			end
			local Magnitude = (Root.Position - DstRoot.Position).Magnitude;
			if (Magnitude < Dist) then
				Closest = v;
				Dist = Magnitude;
			end
		end
	end
	return Closest;
end;
local CheckBMSpawn = function()
	for i, v in next, Workspace.Live.NPCs.Server:GetChildren() do
		if v:IsA("Part") then
			if table.find(SelectMobList, v:GetAttribute("Name")) then
				print("Founded!");
				return v;
			end
		end
	end
	print("Not Found!");
	return false;
end;
local CheckAccept = function(v, mode)
	local TierAccepts = PlayerData.AutoRerollTierAccepts;
	local Accept = PlayerData.AutoRerollAccept;
	local isDelete = true;
	if (#v.enchants == 0) then
		return false;
	end
	if mode then
		for i = 1, EnchantsRefuse[v.enchants[1].name] do
			if (enchantsLevel[i] == v.enchants[1].tier) then
				isDelete = false;
				break;
			end
		end
		return isDelete;
	elseif (Accept[v.enchants[1].name] and TierAccepts[v.enchants[1].tier]) then
		return true;
	end
	if (#v.enchants == 1) then
		return false;
	end
	if mode then
		if (EnchantsRefuse[v.enchants[2].name] and table.find(EnchantsRefuse[v.enchants[2].name], v.enchants[2].tier)) then
			return false;
		end
	elseif ((Accept[v.enchants[2].name] == false) or (TierAccepts[v.enchants[2].tier] == false)) then
		return false;
	end
end;
local CheckPet = function(v, mode)
	local TierLevel = PlayerData.AutoRerollTierAccepts;
	local Accept = PlayerData.AutoRerollAccept;
	local isDelete = true;
	if (#v.enchants == 0) then
		return false;
	end
	if mode then
		for i = 1, PetEnchantsRefuse[v.enchants[1].name] do
			if (enchantsLevel[i] == v.enchants[1].tier) then
				isDelete = false;
				break;
			end
		end
		return isDelete;
	elseif (Accept[v.enchants[1].name] and TierLevel[v.enchants[1].tier]) then
		return true;
	end
end;
local vu = game:GetService("VirtualUser");
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame);
	wait(1);
	vu:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame);
end);
Workspace:SetAttribute("PICKUP_RANGE", 1000);
for i, v in next, SwordDatabase do
	if (v.rarity == "Secret") then
		table.insert(Secret, v.name);
	end
end
coroutine.wrap(function()
	while wait() do
		closest = nil;
		closest = Closest_NPC();
	end
end)();
coroutine.wrap(function()
	while wait(0.2) do
		if (LocalPlayer:GetAttribute("NPC") ~= nil) then
			local Skills = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SkillsBottom"):WaitForChild("Skills");
			local u2 = {Skills:WaitForChild("Template"),Skills:WaitForChild("Template2"),Skills:WaitForChild("Template3")};
			for v48, v49 in u2, nil do
				SkillService:CastSpell(LocalPlayer:GetAttribute("NPC"), v49:GetAttribute("Skill"));
			end
		end
	end
end)();
game:GetService("ReplicatedStorage").ActiveRaids.ChildAdded:Connect(function()
	if AutoRaid then
		wait(3);
		getgenv().lastOpenTime = Workspace:GetAttribute("CURRENT_TIME");
		print("Raid Opened");
		Knit_Pkg.GetController("NotificationController"):Notification({message="Raid Opened",color="RobuxColor",multipleAllowed=false});
		Knit_Pkg.GetController("NotificationController"):Notification({message="Will join after 170s...",color="Orange",multipleAllowed=false});
	end
end);
coroutine.wrap(function()
	while wait(4) do
		if BloodMoonCheck then
			isBloodMoon = Workspace:GetAttribute("BLOOD_MOON_EVENT");
			if (isBloodMoon and not BMing) then
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = beforePos;
				local BMSpawn = CheckBMSpawn();
				if not BMSpawn then
					continue;
				end
				print("BloodMoon Event On");
				if (bAutoUseLuckBoost or bAutoUseSecretLuckBoost or bAutoUseCoinBoost or bAutoUsePowerBoost or (bAutoUseDmgBoost and not hasUsed)) then
					hasUsed = true;
					if bAutoUseLuckBoost then
						print("Blood moon event use Luck boosts");
						useBoost("Luck");
					end
					if bAutoUseSecretLuckBoost then
						print("Blood moon event use SecretLuck boosts");
						useBoost("SecretLuck");
					end
					if bAutoUseCoinBoost then
						print("Blood moon event use Coins boosts");
						useBoost("Coins");
					end
					if bAutoUsePowerBoost then
						print("Blood moon event use Power boosts");
						useBoost("Power");
					end
					if bAutoUseDmgBoost then
						print("Blood moon event use Damage boosts");
						useBoost("Damage");
					end
				end
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = BMSpawn.CFrame * CFrame.new(0, 6, -2.5);
				if (typeof(RelicPresetSetting.BloodMoon) == "string") then
					EquipRelics(RelicPresetSetting.BloodMoon);
				end
				BMing = true;
			end
			if (not isBloodMoon and BMing) then
				if (typeof(RelicPresetSetting.Default) == "string") then
					EquipRelics(RelicPresetSetting.Default);
				end
				BMing = false;
				hasUsed = false;
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (Root and beforePos) then
					Root.CFrame = beforePos;
				end
				print("BloodMoon Event Off");
				isCorruptEvent = true;
			end
		end
		if (CorruptEventCheck and Workspace:GetAttribute("CORRUPT_EVENT") and isCorruptEvent) then
			isCorruptEvent = false;
			local autoFarmStart = Toggles.autoFarm.Value;
			Toggles.autoFarm:SetValue(false);
			TPController:TeleportArea(Workspace:GetAttribute("CORRUPT_EVENT"));
			wait(0.5);
			Toggles.autoFarm:SetValue(true);
			task.spawn(function()
				wait(10);
				Toggles.autoFarm:SetValue(autoFarmStart);
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
			end);
		else
			isCorruptEvent = false;
		end
		if NightCheck then
			isNight = Workspace:GetAttribute("NIGHT_EVENT");
			if (isNight and not Nighting) then
				print("Night Event On");
				if (typeof(RelicPresetSetting.Night) == "string") then
					EquipRelics(RelicPresetSetting.Night);
				end
				if (nAutoUseLuckBoost or nAutoUseSecretLuckBoost or (nAutoUsePowerBoost and not nhasUsed)) then
					hasUsed = true;
					if nAutoUseLuckBoost then
						print("Night event use Luck boosts");
						useBoost("Luck");
					end
					if nAutoUseSecretLuckBoost then
						print("Night event use SecretLuck boosts");
						useBoost("SecretLuck");
					end
					if nAutoUsePowerBoost then
						print("Night event use Power boosts");
						useBoost("Power");
					end
				end
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
				wait();
				Toggles.EggNight:SetValue(true);
				Nighting = true;
				wait();
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
				wait();
				LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 4, -3.5);
			end
			if (not isNight and Nighting) then
				Nighting = false;
				nhasUsed = false;
				if (typeof(RelicPresetSetting.Default) == "string") then
					EquipRelics(RelicPresetSetting.Default);
				end
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (Root and beforePos) then
					Root.CFrame = beforePos;
				end
				print("Night Event Off");
			end
		end
		if next(Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins:GetChildren()) then
			local currentTime = Workspace:GetAttribute("CURRENT_TIME") % 1800;
			if (not BMing and not Nighting and (currentTime > (51 + (15 * 60))) and (currentTime < (58 + (15 * 60)))) then
				print("Hard Dungeon Open");
				ContinueButtonUID = nil;
				DungeonContinueButton = false;
				if (HardDungeon and not LocalPlayer:GetAttribute("Raid")) then
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
					if Root then
						_MAIN = false;
						local Dst = Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins["Dungeon 2"].CFrame * CFrame.new(0, 6, 0);
						LocalPlayer:RequestStreamAroundAsync(Dst.Position);
						LocalPlayer.Character:SetPrimaryPartCFrame(Dst);
						wait(1);
						local Dungeon_Parts = Workspace.Resources.Gamemodes.DungeonLobby.JoinParts;
						for _, DungeonJoinPart in pairs(Dungeon_Parts:GetChildren()) do
							DungeonUID = DungeonJoinPart:GetAttribute("UID") or DungeonUID;
							local Join_Res = Dungeon_Service:JoinDungeon(DungeonUID);
							if Join_Res then
								TPController:Teleport({pos=Join_Res,areaName=nil,regionName="Dungeon",leaveGamemode=false});
								InDungeon = 2;
								print("Join Hard Dungeon");
								if (typeof(RelicPresetSetting.Dungeon) == "string") then
									EquipRelics(RelicPresetSetting.Dungeon);
								end
								break;
							end
						end
						wait(3);
						_MAIN = true;
					end
				end
			end
			if (not BMing and not Nighting and (currentTime > 51) and (currentTime < 58)) then
				print("Easy And Insane Dungeon Open");
				ContinueButtonUID = nil;
				DungeonContinueButton = false;
				if ((EasyDungeon or InsaneDungeon) and not LocalPlayer:GetAttribute("Raid")) then
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
					if Root then
						_MAIN = false;
						local selectedDungeon = "Dungeon 1";
						if InsaneDungeon then
							selectedDungeon = "Dungeon 3";
						end
						local Dst = Workspace.Resources.Gamemodes.DungeonLobby.ZoneAutoJoins[selectedDungeon].CFrame * CFrame.new(0, 6, 0);
						LocalPlayer:RequestStreamAroundAsync(Dst.Position);
						LocalPlayer.Character:SetPrimaryPartCFrame(Dst);
						wait(1);
						local Dungeon_Parts = Workspace.Resources.Gamemodes.DungeonLobby.JoinParts;
						for _, DungeonJoinPart in pairs(Dungeon_Parts:GetChildren()) do
							if (EasyDungeon and (DungeonJoinPart.name == "Dungeon 1")) then
								local Join_Res = Dungeon_Service:JoinDungeon(DungeonJoinPart:GetAttribute("UID"));
								if Join_Res then
									TPController:Teleport({pos=Join_Res,areaName=nil,regionName="Dungeon",leaveGamemode=false});
									InDungeon = 1;
									print("Join Easy Dungeon");
									break;
								end
							end
							if (InsaneDungeon and (DungeonJoinPart.name == "Dungeon 3")) then
								local Join_Res = Dungeon_Service:JoinDungeon(DungeonJoinPart:GetAttribute("UID"));
								if Join_Res then
									TPController:Teleport({pos=Join_Res,areaName=nil,regionName="Dungeon",leaveGamemode=false});
									InDungeon = 3;
									print("Join Insane Dungeon");
									if (typeof(RelicPresetSetting.Dungeon) == "string") then
										EquipRelics(RelicPresetSetting.Dungeon);
									end
									break;
								end
							end
						end
						wait(3);
						_MAIN = true;
					end
				end
			end
		end
		ActiveRaid = game:GetService("ReplicatedStorage").ActiveRaids:FindFirstChildWhichIsA("BoolValue");
		if not (BMing or Nighting or InDungeon) then
			if (AutoRaid and ActiveRaid and not LocalPlayer:GetAttribute("Raid")) then
				local diffTime = Workspace:GetAttribute("CURRENT_TIME") - lastOpenTime;
				if ((diffTime >= 168) and (diffTime < 178)) then
					if not Workspace.Resources.Gamemodes.RaidJoins:FindFirstChild(ActiveRaid.Name) then
						_MAIN = false;
						wait();
						TPController:TeleportArea("Area " .. string.match(ActiveRaid.Name, "%d+"));
						wait();
						_MAIN = true;
					end
					if Workspace.Resources.Gamemodes.RaidJoins:FindFirstChild(ActiveRaid.Name) then
						uid = Workspace.Resources.Gamemodes.RaidJoins[ActiveRaid.Name]:GetAttribute("UID");
						if uid then
							_MAIN = false;
							wait(1);
							local res = KnitService.RaidService.RF.JoinRaid:InvokeServer(uid);
							print("Join " .. ActiveRaid.Name .. " ," .. PlayerData.RaidTickets .. " tickets remain");
							wait(2);
							_MAIN = true;
						end
					end
				end
			end
		end
		local RoomLabel = LocalPlayer.PlayerGui.Dungeon:FindFirstChild("Background"):FindFirstChild("Active"):FindFirstChild("RoomLabel");
		local Room = nil;
		local TimeChec = (((Workspace:GetAttribute("CURRENT_TIME") % 1800) > 120) and ((Workspace:GetAttribute("CURRENT_TIME") % 1800) < 900)) or (((Workspace:GetAttribute("CURRENT_TIME") % 1800) > (17 * 60)) and ((Workspace:GetAttribute("CURRENT_TIME") % 1800) < (30 * 60)));
		if RoomLabel then
			Room = tonumber(string.match(RoomLabel.Text, "%d+"));
		end
		if (((InDungeon == 2) and Room and (HardDungeonUseDamage > 0) and (Room >= HardDungeonUseDamage)) or ((InDungeon == 3) and Room and (InsaneDungeonUseDamage > 0) and (Room >= InsaneDungeonUseDamage))) then
			task.spawn(function()
				local boostsName = "Damage";
				local timeleft = PlayerData.Boosts[boostsName].timeLeft;
				while timeleft < 200 do
					if ((timeleft < 200) and PlayerData.Boosts[boostsName].remaining["300"] and (PlayerData.Boosts[boostsName].remaining["300"] > 0)) then
						KnitService.BoostService.RF.UseBoost:InvokeServer(boostsName, "300");
					elseif ((timeleft < 200) and PlayerData.Boosts[boostsName].remaining["600"] and (PlayerData.Boosts[boostsName].remaining["600"] > 0)) then
						KnitService.BoostService.RF.UseBoost:InvokeServer(boostsName, "600");
					end
					wait(1);
					timeleft = PlayerData.Boosts[boostsName].timeLeft;
				end
			end);
		end
		if (InDungeon and not LocalPlayer:GetAttribute("InDungeon") and (EasyDungeon or HardDungeon or InsaneDungeon) and TimeChec) then
			print("Error Leave");
			print(InDungeon);
			print(TimeChec);
			InDungeon = false;
			if (typeof(RelicPresetSetting.Default) == "string") then
				EquipRelics(RelicPresetSetting.Default);
			end
			KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
		else
			if ((InDungeon == 1) and EasyDungeon and Room and (Room > EasyReach) and TimeChec) then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
				print("Reached and Leave EasyDungeon at Room " .. Room);
				wait(1);
			end
			if ((InDungeon == 2) and HardDungeon and Room and (Room > HardReach) and TimeChec) then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
				print("Reached and Leave HardDungeon at Room " .. Room);
				wait(1);
			end
			if ((InDungeon == 3) and InsaneDungeon and Room and (Room > InsaneReach) and TimeChec) then
				KnitService.DungeonService.RF.LeaveDungeon:InvokeServer();
				print("Reached and Leave InsaneDungeon at Room " .. Room);
				wait(1);
			end
		end
	end
end)();
task.spawn(function()
	local Dungeon3 = false;
	local Tower2 = false;
	local Tower3 = false;
	local Raid2 = false;
	local Raid3 = false;
	task.spawn(function()
		RunService.Stepped:Connect(function()
			if not _MAIN then
				return;
			end
			if (AutoTower and LocalPlayer:GetAttribute("InTower") and (Tower2 == false) and not closest) then
				local Button = Workspace.Live.Towers:FindFirstChild("ContinueButton", true);
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (Button and next(Button:GetAttributes())) then
					coroutine.wrap(function()
						Tower2 = true;
						task.wait(0.2);
						if not Root then
							return;
						end
						Root.CFrame = Button.CFrame * CFrame.new(0, 6.75, 0);
						task.wait(0.2);
						KnitService.TowerService.RF.ContinueTower:InvokeServer(Button:GetAttribute("UID"));
						task.wait(0.2);
						Tower2 = false;
					end)();
				end
			end
			if (AutoRaid and ActiveRaid and LocalPlayer:GetAttribute("Raid") and (Raid2 == false)) then
				local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
				local Background = PlayerGui:WaitForChild("Raid"):WaitForChild("Background");
				local Active = Background:WaitForChild("Active");
				local TimerLabel = Background:WaitForChild("TimerLabel");
				local EnemiesLeft = Active:WaitForChild("EnemiesLeft");
				local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if (EnemiesLeft and Root and (TimerLabel.Text == "STARTS IN 00:00") and Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].Boss:FindFirstChild("Spawn")) then
					EnemiesLeft = tonumber(EnemiesLeft.TextLabel.Text);
					coroutine.wrap(function()
						Raid2 = true;
						if (EnemiesLeft == 0) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].Boss.Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						if (EnemiesLeft == 3) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[1].Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						if (EnemiesLeft == 2) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[2].Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						if (EnemiesLeft == 1) then
							Root.CFrame = Workspace.Resources.Gamemodes.Raids[ActiveRaid.Name].NPCs:GetChildren()[3].Spawn.CFrame * CFrame.new(0, 3, -5.5);
							wait(1);
						end
						Raid2 = false;
					end)();
				end
			end
		end);
	end);
	task.spawn(function()
		RunService.Stepped:Connect(function()
			if (_MAIN and InDungeon and (EasyDungeon or HardDungeon or InsaneDungeon) and (Dungeon3 == false)) then
				coroutine.wrap(function()
					Dungeon3 = true;
					repeat
						wait();
					until LocalPlayer.PlayerGui.DungeonResult.Background.AbsolutePosition == Vector2.new(0, -36) 
					InDungeon = false;
					print("Finished and Leave");
					if (typeof(RelicPresetSetting.Default) == "string") then
						EquipRelics(RelicPresetSetting.Default);
					end
					_MAIN = false;
					task.wait(2);
					firesignal(LocalPlayer.PlayerGui.DungeonResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(1);
					LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = beforePos;
					task.wait(1);
					_MAIN = true;
					Dungeon3 = false;
				end)();
			end
			if (false and _MAIN and AutoTower and (Tower3 == false)) then
				coroutine.wrap(function()
					Tower3 = true;
					repeat
						wait();
					until LocalPlayer.PlayerGui.TowerResult.Background.AbsolutePosition == Vector2.new(0, -36) 
					task.wait(3);
					firesignal(LocalPlayer.PlayerGui.TowerResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(2);
					Tower3 = false;
				end)();
			end
			if (_MAIN and AutoRaid and (Raid3 == false)) then
				coroutine.wrap(function()
					Raid3 = true;
					repeat
						wait();
					until LocalPlayer.PlayerGui.RaidResult.Background.AbsolutePosition == Vector2.new(0, -36) 
					print("Leave Raid");
					_MAIN = false;
					task.wait(1);
					firesignal(LocalPlayer.PlayerGui.RaidResult.Background.Frame.Continue.Button.MouseButton1Click);
					task.wait(3);
					LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = beforePos;
					_MAIN = true;
					Raid3 = false;
				end)();
			end
		end);
	end);
end);
task.spawn(function()
	local Connection;
	local Force;
	local Attachment;
	if not Force then
		Force = Instance.new("VectorForce");
		Attachment = Instance.new("Attachment");
	end
	local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart");
	Force.ApplyAtCenterOfMass = true;
	Force.Attachment0 = Attachment;
	Force.Force = Util.GetMass(LocalPlayer.Character) * Vector3.new(0, workspace.Gravity, 0);
	Force.Parent = Root;
	Attachment.Parent = Root;
	Force.Enabled = false;
	local function Float(Character)
		if Connection then
			Connection:Disconnect();
			Connection = nil;
		end
		local stoptick = 0;
		local flag = true;
		Connection = game:GetService("RunService").Stepped:Connect(function()
			if (_MAIN and (AutoFarm or InDungeon)) then
				Root.Velocity = Vector3.new(Root.Velocity.X, 0, Root.Velocity.Z);
				Force.Enabled = true;
				if not closest then
					Force.Enabled = false;
				end
			else
				Force.Enabled = false;
			end
		end);
	end
	if LocalPlayer.Character then
		Float(LocalPlayer.Character);
	end
	LocalPlayer.CharacterAdded:Connect(Float);
end);
local zero = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (zero == false) then
			zero = true;
			coroutine.wrap(function()
				while _MAIN and (AutoFarm or InDungeon or (BloodMoonCheck and isBloodMoon) or (ServerBossCheck and isServerBoss)) and not Nighting and not LocalPlayer:GetAttribute("Raid") do
					local currentClosest = Closest_NPC(true);
					local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					if (currentClosest and Root) then
						if ((FarmAllMap and not InDungeon) or (BloodMoonCheck and isBloodMoon and next(SelectMobList)) or (ServerBossCheck and isServerBoss)) then
							local OldErr, OldMsg = pcall(function()
								return currentClosest.CFrame;
							end);
							if not OldErr then
								print("No currentClosest");
								continue;
							end
							Root.CFrame = currentClosest.CFrame * CFrame.new(0, 6, -2.5);
							local count = 0;
							repeat
								task.wait();
								coroutine.wrap(function()
									KnitService.ClickService.RF.Click:InvokeServer(tostring(currentClosest));
								end)();
								count = count + 1;
							until not _MAIN or not AutoFarm or (currentClosest:GetAttribute("Health") == 0) or (count > 20) 
							continue;
						else
							Root.CFrame = currentClosest:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 6, -2.5);
							KnitService.ClickService.RF.Click:InvokeServer(tostring(currentClosest));
							while _MAIN and LocalPlayer:GetAttribute("NPC") do
								task.wait();
							end
						end
					end
					task.wait();
				end
				zero = false;
			end)();
		end
	end);
end);
local one = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (one == false) then
			one = true;
			while task.wait() and _POWER do
				for i = 1, ClickSpeed do
					coroutine.wrap(function()
						KnitService.ClickService.RF.Click:InvokeServer(tostring(closest));
					end)();
				end
			end
			one = false;
		end
	end);
end);
local two = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (two == false) then
			two = true;
			while getgenv().PetDis and wait(2) do
				local dPetFound = false;
				local dPets = {};
				for i, v in next, Knit_Pkg.GetController("DataController"):GetData("PlayerData").PetInv do
					if (DisRarityCheck and table.find(DisRarityWl, PetsDatabase[v.name].rarity)) then
						continue;
					end
					if CheckPet(v, UsePetFilter) then
						continue;
					end
					if ((v.locked ~= true) and (v.equipped ~= true)) then
						dPetFound = true;
						table.insert(dPets, v.uid);
					end
				end
				if (dPetFound == true) then
					KnitService.PetLevelingService.RF.Dismantle:InvokeServer(dPets);
					dPetFound = false;
					UIController:CloseScreen("PetLeveling");
				end
				wait(DismantleDelay);
			end
			two = false;
		end
	end);
end);
local three = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (three == false) then
			three = true;
			while getgenv().SwordSell and wait(2) do
				local SwordFound = false;
				local Swords = {};
				local Equipped = {};
				table.insert(Equipped, PlayerData.EquippedWeapon.Left);
				table.insert(Equipped, PlayerData.EquippedWeapon.Right);
				for i, v in next, PlayerData.WeaponInv do
					if (RarityCheck and table.find(RarityWl, SwordDatabase[v.name].rarity)) then
						continue;
					end
					if table.find(Secret, v.name) then
						continue;
					end
					if (v.locked or table.find(Equipped, v.uid)) then
						continue;
					end
					if not v.enchants then
						continue;
					end
					if not next(v.enchants) then
						SwordFound = true;
						Swords[tostring(v.uid)] = true;
						continue;
					end
					if CheckAccept(v, UseFilter) then
						continue;
					end
					SwordFound = true;
					Swords[tostring(v.uid)] = true;
					continue;
				end
				if (SwordFound == true) then
					KnitService.WeaponInvService.RF.MultiSell:InvokeServer(Swords);
					SwordFound = false;
				end
				wait(SwordSellDelay);
			end
			three = false;
		end
	end);
end);
local four = false;
local fou = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (four == false) then
			four = true;
			coroutine.wrap(function()
				while getgenv().OpEgg do
					local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
					if not Root then
						continue;
					end
					local EggMagnitude = (Root.Position - Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.Position).Magnitude;
					if (EggMagnitude <= 60) then
						KnitService.EggService.RF.BuyEgg:InvokeServer(Buy_Egg_Args);
						if ignoreAmin then
							Knit_Pkg.GetController("EggOpenController"):Reset();
						else
							UIController:AlwaysOnTop(true);
							UIController:CloseScreen("EggEffect");
						end
					else
						wait(5);
					end
					wait(0.05);
				end
				four = false;
			end)();
		end
		if (AutoRoll and not fou) then
			fou = true;
			coroutine.wrap(function()
				while AutoRoll and next(RollList) do
					KnitService.EnchantService.RF.RequestRoll:InvokeServer({modeType="Weapons",weaponUID=RollList[1],enchantTableName="Normal",rollType="Shard",auto=false});
					wait(4);
					if (next(RollResult) and CheckAccept(RollResult, RollUseFilter)) then
						table.remove(RollList, 1);
						RollListDispaly:Set({Title="RollList :",Content=table.concat(RollList, "\n")});
						if not next(RollList) then
							AutoRollToggle:Set(false);
							print("Roll Finished");
							Knit_Pkg.GetController("NotificationController"):Notification({message="Roll Finished!",color="Orange",multipleAllowed=false});
							break;
						end
					end
					RollResult = {};
				end
				fou = false;
			end)();
		end
	end);
end);
local five = false;
task.spawn(function()
	RunService.Heartbeat:Connect(function()
		if (five == false) then
			five = true;
			local expRelicFound = false;
			if (UpRelic or DungeonAutoBuy or TravellingMerchantAutoBuy or AutoClaimChests) then
				if (UpRelic and (string.len(SelectedRelic) > 0) and PlayerData.RelicInv[SelectedRelic]) then
					local RelicExp = {};
					for i, v in next, PlayerData.RelicInv do
						if (v.equipped or v.locked) then
							continue;
						end
						if table.find(ExpRelicList, v.name) then
							table.insert(RelicExp, v.uid);
							expRelicFound = true;
						end
					end
					if expRelicFound then
						KnitService.RelicLevelingService.RF.LevelUp:InvokeServer(SelectedRelic, RelicExp);
						UIController:CloseScreen("RelicLeveling");
						Labels.UpgradeExp:SetText(PlayerData.RelicInv[SelectedRelic].exp);
						UserDatas.UDatas:SetValue("UpgradeExp", PlayerData.RelicInv[SelectedRelic].exp);
					end
				end
				if DungeonAutoBuy then
					for j = 1, 3 do
						for i = 1, 5 do
							KnitService.LimitedShopsService.RF.BuyItem:InvokeServer("DungeonShop", i);
							wait(0.8);
						end
					end
				end
				if TravellingMerchantAutoBuy then
					for j = 1, 3 do
						for i = 1, 5 do
							KnitService.LimitedShopsService.RF.BuyItem:InvokeServer("TravellingMerchant", i);
							wait(0.8);
						end
					end
				end
				if AutoClaimChests then
					for i, v in {"Chest 1","Chest 2","Chest 3","Free Ticket 1","Free Ticket 2","Free Ticket 3"} do
						KnitService.ChestService.RF.ClaimChest:InvokeServer(v);
						wait(0.8);
					end
				end
				local WheelTime = 86400 - (os.time() - PlayerData.WheelStamp);
				if (WheelTime <= 0) then
					WController:SpinWheel(true);
				end
				local IllusionistTime = 172800 - (os.time() - PlayerData.IllusionistTicketStamp);
				if (WheelTime <= 0) then
					IllusionistService:ClaimTicket();
				end
				wait(10);
			end
			wait(3);
			five = false;
		end
	end);
end);
local Loadouts = PlayerData.Loadouts;
local WeaponGroups = {};
local WeaponGroupOptions = {};
for addressId, WeaponGroup in Loadouts, nil do
	WeaponGroups[WeaponGroup.Name] = addressId;
	table.insert(WeaponGroupOptions, WeaponGroup.Name);
end
local Target = Knit_Pkg.GetController("EnchantRollController");
oldRoll = hookfunction(Target['Roll'], function(this, result)
	RollResult = result;
	if not (AutoRoll and IgnRollAmin) then
		return oldRoll(this, result);
	end
end);
local cButton;
local cRoot;
Dungeon_Service.DungeonReplicate:Connect(function(DungeonData)
	if (DungeonData and (DungeonData.roomReached > 0) and ((DungeonData.roomReached % 4) == 0)) then
		if (InDungeon and (EasyDungeon or HardDungeon or InsaneDungeon) and (DungeonContinueButton == false) and not closest) then
			DungeonContinueButton = true;
			coroutine.wrap(function()
				cButton = Workspace.Live.Dungeons:FindFirstChild("ContinueButton", true);
				cRoot = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1);
				if ContinueButtonUID then
					if (DungeonData.roomReached > 4) then
						task.wait(0.3);
						if (not cRoot or not cRoot.CFrame) then
							return;
						end
						cRoot.CFrame = CFrame.new(cRoot.CFrame.x - 200, cRoot.CFrame.y, cRoot.CFrame.z, 1, 0, 0, 0, 1, 0, -4, 0, 1);
					end
					task.wait(0.2);
					KnitService.DungeonService.RF.ContinueDungeon:InvokeServer(ContinueButtonUID);
				else
					task.wait(0.2);
					if (not cRoot or not cRoot.CFrame or not cButton or not cButton.CFrame) then
						return;
					end
					cRoot.CFrame = cButton.CFrame * CFrame.new(0, 7, -4);
				end
				DungeonContinueButton = false;
			end)();
		end
	end
end);
game:GetService("CollectionService"):GetInstanceAddedSignal("ServerNPC"):Connect(function(p9)
	task.wait();
	if (p9 and table.find(ServerBossList, p9:GetAttribute("Name"))) then
		print("Server Boss");
		wait(6);
		if (typeof(RelicPresetSetting.Dungeon) == "string") then
			EquipRelics(RelicPresetSetting.Dungeon);
		end
		isServerBoss = true;
		isKillServerBoss = false;
	end
end);
game:GetService("CollectionService"):GetInstanceAddedSignal("SkillCrate"):Connect(function(p13)
	print("kkkkk");
	wait(0.5);
	Knit_Pkg.GetService("ServerBossService"):OpenCrate();
	isKillServerBoss = true;
end);
game:GetService("CollectionService"):GetInstanceRemovedSignal("SkillCrate"):Connect(function(p14)
	print("next");
	wait(4);
	isKillServerBoss = false;
end);
game:GetService("CollectionService"):GetInstanceRemovedSignal("DungeonContinueButton"):Connect(function(Button)
	if (not ContinueButtonUID and Button:GetAttribute("UID")) then
		ContinueButtonUID = Button:GetAttribute("UID");
	end
end);
local DungeonController = Knit_Pkg.GetController("DungeonController");
local DCActivate;
DCActivate = hookfunction(DungeonController['Activate'], function(this, result)
	wait(0.2);
	if (result ~= nil) then
		if (not ContinueButtonUID and result:GetAttribute("UID")) then
			ContinueButtonUID = result:GetAttribute("UID");
		end
	end
	return DCActivate(this, result);
end);
hookfunction(require(game:GetService("ReplicatedStorage").ClientModules.Controllers.AfterLoad.ItemDropController.ItemDropNode)['Pickup'], function(this)
	return this:Claim();
end);
game.NetworkClient.ChildRemoved:Connect(function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer);
end);
print("Done!");
Toggles.AutoPower:OnChanged(function()
	getgenv()._POWER = Toggles.AutoPower.Value;
end);
Options.AuraDistance:OnChanged(function()
	getgenv().Distance = Options.AuraDistance.Value;
end);
Options.ClickSpeed:OnChanged(function()
	getgenv().ClickSpeed = Options.ClickSpeed.Value;
end);
Toggles.AutoDismantle:OnChanged(function()
	getgenv().PetDis = Toggles.AutoDismantle.Value;
end);
Options.AuraDistance:OnChanged(function()
	getgenv().Distance = Options.AuraDistance.Value;
end);
Options.DismantleDelay:OnChanged(function()
	getgenv().DismantleDelay = Options.DismantleDelay.Value;
end);
Toggles.DisRarityCheck:OnChanged(function()
	getgenv().DisRarityCheck = Toggles.DisRarityCheck.Value;
end);
Options.PetAddToWhitelist:OnChanged(function()
	DisRarityWl = {};
	for key, value in next, Options.PetAddToWhitelist.Value do
		if not table.find(DisRarityWl, key) then
			table.insert(DisRarityWl, key);
		end
	end
end);
Toggles.AutoSell:OnChanged(function()
	getgenv().SwordSell = Toggles.AutoSell.Value;
end);
Options.SWordSellDelay:OnChanged(function()
	SwordSellDelay = Options.SWordSellDelay.Value;
end);
Toggles.WeaponRarityCheck:OnChanged(function()
	getgenv().RarityCheck = Toggles.WeaponRarityCheck.Value;
end);
Options.WeaponAddtoWhitelist:OnChanged(function()
	RarityWl = {};
	for key, value in next, Options.WeaponAddtoWhitelist.Value do
		if not table.find(RarityWl, key) then
			table.insert(RarityWl, key);
		end
	end
end);
Toggles.AutoOpenEggs:OnChanged(function()
	getgenv().OpEgg = Toggles.AutoOpenEggs.Value;
end);
Toggles.IgnoreOpneAmination:OnChanged(function()
	getgenv().ignoreAmin = Toggles.IgnoreOpneAmination.Value;
end);
Options.EggsSelected:OnChanged(function()
	if not Options.EggsSelected.Value then
		return;
	end
	selectedEgg = Options.EggsSelected.Value;
	Buy_Egg_Args.eggName = Eggs[selectedEgg];
	beforePos = Workspace.Live.FloatingEggs[selectedEgg].HumanoidRootPart.CFrame * CFrame.new(0, 6, -3.5);
end);
Options.EggsAmounts:OnChanged(function()
	Buy_Egg_Args.amount = Options.EggsAmounts.Value;
end);
Toggles.AutoUpgradeRelic:OnChanged(function()
	getgenv().UpRelic = Toggles.AutoUpgradeRelic.Value;
end);
Options.Relic_DefaultWeaponGroup:OnChanged(function()
	RelicPresetSetting.Default = Options.Relic_DefaultWeaponGroup.Value;
	selecetWeaponGroup = Options.Relic_DefaultWeaponGroup.Value;
end);
Toggles.AutoEasy:OnChanged(function()
	getgenv().EasyDungeon = Toggles.AutoEasy.Value;
	if Toggles.AutoEasy.Value then
		Toggles.AutoInsane:SetValue(false);
	end
end);
Options.EasyRoom:OnChanged(function()
	getgenv().EasyReach = Options.EasyRoom.Value;
end);
Toggles.AutoHard:OnChanged(function()
	getgenv().HardDungeon = Toggles.AutoHard.Value;
end);
Options.HardRoom:OnChanged(function()
	getgenv().HardReach = Options.HardRoom.Value;
end);
Toggles.AutoInsane:OnChanged(function()
	getgenv().InsaneDungeon = Toggles.AutoInsane.Value;
	if Toggles.AutoInsane.Value then
		Toggles.AutoEasy:SetValue(false);
	end
end);
Options.InsaneRoom:OnChanged(function()
	getgenv().InsaneReach = Options.InsaneRoom.Value;
end);
Options.WaitTime:OnChanged(function()
	getgenv().DungeonWaitTime = Options.WaitTime.Value;
end);
Options.DungeonWeapon:OnChanged(function()
	RelicPresetSetting.Dungeon = Options.DungeonWeapon.Value;
end);
Options.UseDamageRooms:OnChanged(function()
	HardDungeonUseDamage = tonumber(Options.UseDamageRooms.Value);
end);
Options.UseInsaneDamageRooms:OnChanged(function()
	InsaneDungeonUseDamage = tonumber(Options.UseInsaneDamageRooms.Value);
end);
Toggles.AutoTower:OnChanged(function()
	getgenv().AutoTower = Toggles.AutoTower.Value;
end);
Toggles.AutoRaid:OnChanged(function()
	getgenv().AutoRaid = Toggles.AutoRaid.Value;
end);
Toggles.autoFarm:OnChanged(function()
	getgenv().AutoFarm = Toggles.autoFarm.Value;
end);
Toggles.FarmAllMap:OnChanged(function()
	getgenv().FarmAllMap = Toggles.FarmAllMap.Value;
end);
Toggles.FarmSelectedMobs:OnChanged(function()
	getgenv().FarmSelected = Toggles.FarmSelectedMobs.Value;
end);
Options.SelectedArea:OnChanged(function()
	if not Options.SelectedArea.Value then
		return;
	end
	Options.SelectedMob.Values = AllMobs[Options.SelectedArea.Value];
	Options.OtherMob.Values = AllMobs[Options.SelectedArea.Value];
	Options.SelectedMob:SetValues();
	Options.OtherMob:SetValues();
	local B_List = {};
	local M_List = {};
	for k, v in AllMobs[Options.SelectedArea.Value] do
		if table.find(MobBlackList, v) then
			B_List[v] = true;
		end
		if table.find(MobWhiteList, v) then
			M_List[v] = true;
		end
	end
	Options.SelectedMob:SetValue(B_List);
	Options.OtherMob:SetValue(M_List);
end);
Toggles.BloodMoonCheck:OnChanged(function()
	getgenv().BloodMoonCheck = Toggles.BloodMoonCheck.Value;
end);
Toggles.CorruptEventCheck:OnChanged(function()
	getgenv().CorruptEventCheck = Toggles.CorruptEventCheck.Value;
end);
Toggles.AutoUseLuck:OnChanged(function()
	getgenv().bAutoUseLuckBoost = Toggles.AutoUseLuck.Value;
end);
Toggles.AutoUseSecretLuck:OnChanged(function()
	getgenv().bAutoUseSecretLuckBoost = Toggles.AutoUseSecretLuck.Value;
end);
Toggles.AutoUseCoin:OnChanged(function()
	getgenv().bAutoUseCoinBoost = Toggles.AutoUseCoin.Value;
end);
Toggles.AutoUsePower:OnChanged(function()
	getgenv().bAutoUsePowerBoost = Toggles.AutoUsePower.Value;
end);
Toggles.AutoUseDmg:OnChanged(function()
	getgenv().bAutoUseDmgBoost = Toggles.AutoUseDmg.Value;
end);
Options.SelectMob:OnChanged(function()
	SelectMobList = {};
	for key, value in next, Options.SelectMob.Value do
		if not table.find(SelectMobList, key) then
			table.insert(SelectMobList, key);
		end
	end
end);
Options.SetWeaponGroup:OnChanged(function()
	RelicPresetSetting.BloodMoon = Options.SetWeaponGroup.Value;
end);
Toggles.EggNight:OnChanged(function()
	getgenv().NightCheck = Toggles.EggNight.Value;
end);
Toggles.hAutoUseLuck:OnChanged(function()
	getgenv().nAutoUseLuckBoost = Toggles.hAutoUseLuck.Value;
end);
Toggles.hAutoUseSecretLuck:OnChanged(function()
	getgenv().nAutoUseSecretLuckBoost = Toggles.hAutoUseSecretLuck.Value;
end);
Toggles.hAutoUsePower:OnChanged(function()
	getgenv().nAutoUsePowerBoost = Toggles.hAutoUsePower.Value;
end);
Options.hSetWeaponGroup:OnChanged(function()
	RelicPresetSetting.Night = Options.hSetWeaponGroup.Value;
end);
Toggles.hServerBossCheck:OnChanged(function()
	getgenv().ServerBossCheck = Toggles.hServerBossCheck.Value;
end);
Toggles.DungeonItems:OnChanged(function()
	getgenv().DungeonAutoBuy = Toggles.DungeonItems.Value;
end);
Toggles.TravellingMerchantItems:OnChanged(function()
	getgenv().TravellingMerchantAutoBuy = Toggles.TravellingMerchantItems.Value;
end);
Toggles.AutoClaimChests:OnChanged(function()
	getgenv().AutoClaimChests = Toggles.AutoClaimChests.Value;
end);
Toggles.InfiniteJump:OnChanged(function()
	InfiniteJump = Toggles.InfiniteJump.Value;
	game:GetService("UserInputService").JumpRequest:connect(function()
		if InfiniteJump then
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping");
		end
	end);
end);
Options.PickUpRange:OnChanged(function()
	Text = tonumber(Options.PickUpRange.Value);
	if Text then
		Workspace:SetAttribute("PICKUP_RANGE", Text);
	end
end);
Toggles.UnlockTP:OnChanged(function()
	if Toggles.UnlockTP.Value then
		local Button = LocalPlayer.PlayerGui.LeftSidebar.Background.Frame.MinorButtons.Teleport.Button;
		local ButtonC = Button:Clone();
		ButtonC.Parent = Button.Parent;
		Button:Remove();
		ButtonC.Activated:Connect(function()
			UIController:OpenScreen("Teleport");
		end);
	end
end);
Toggles.UnlockAutoSwing:OnChanged(function()
	if Toggles.UnlockAutoSwing.Value then
		local Button = LocalPlayer.PlayerGui.RightSidebar.Background.Frame.Window.Items.AutoSwing.Button;
		local ButtonC = Button:Clone();
		ButtonC.Parent = Button.Parent;
		Button:Remove();
		ButtonC.Activated:Connect(function()
			Knit_Pkg.GetService("SettingsService"):ToggleAuto();
		end);
	end
end);
Toggles.Invisibility:OnChanged(function()
	if Toggles.Invisibility.Value then
		Invisfunc();
		writefile("SFS Sript/set", "true");
	else
		writefile("SFS Sript/set", "false");
	end
end);
Toggles.UseFilterForAutoShell:OnChanged(function()
	UseFilter = Toggles.UseFilterForAutoShell.Value;
end);
Toggles.UseFilterForAutoRoll:OnChanged(function()
	RollUseFilter = Toggles.UseFilterForAutoRoll.Value;
end);
Options.Enchant:OnChanged(function()
	SelectedEnchant = Options.Enchant.Value;
	Options.Tiers:SetValue(0);
end);
Options.Tiers:OnChanged(function()
	if not SelectedEnchant then
		return;
	end
	if not EnchantsRefuse[SelectedEnchant] then
		EnchantsRefuse[SelectedEnchant] = 0;
	end
	EnchantsRefuse[SelectedEnchant] = Options.Tiers.Value;
	Labels.FList:SetText("");
	local TiersStr = "";
	for key, value in EnchantsRefuse do
		TiersStr = TiersStr .. key .. ":" .. value .. "\n";
	end
	Labels.FList:SetText(TiersStr);
end);
Toggles.UsePetFilterForAutoShell:OnChanged(function()
	UsePetFilter = Toggles.UsePetFilterForAutoShell.Value;
end);
Options.PetEnchant:OnChanged(function()
	SelectedPetEnchant = Options.PetEnchant.Value;
	Options.PetTiers:SetValue(0);
end);
Options.PetTiers:OnChanged(function()
	if not SelectedPetEnchant then
		return;
	end
	if not PetEnchantsRefuse[SelectedPetEnchant] then
		PetEnchantsRefuse[SelectedPetEnchant] = 0;
	end
	PetEnchantsRefuse[SelectedPetEnchant] = Options.PetTiers.Value;
	Labels.PetFList:SetText("");
	local TiersStr = "";
	for key, value in PetEnchantsRefuse do
		TiersStr = TiersStr .. key .. ":" .. value .. "\n";
	end
	Labels.PetFList:SetText(TiersStr);
end);
local MyButton = Instance.new("ImageButton");
MyGui.Parent = game.CoreGui;
MyGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
MyButton.Parent = MyGui;
MyButton.Position = UDim2.new(0, 50, 0, 20);
MyButton.Size = UDim2.new(0, 35, 0, 35);
MyButton.Image = "rbxassetid://5198838744";
MyButton.BackgroundTransparency = 1;
local dragging;
local dragInput;
local dragStart;
local startPos;
local function update(input)
	local delta = input.Position - dragStart;
	MyButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
end
MyButton.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		dragging = true;
		dragStart = input.Position;
		startPos = MyButton.Position;
		input.Changed:Connect(function()
			if (input.UserInputState == Enum.UserInputState.End) then
				dragging = false;
			end
		end);
	end
end);
MyButton.InputChanged:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch)) then
		dragInput = input;
	end
end);
game:GetService("UserInputService").InputChanged:Connect(function(input)
	if ((input == dragInput) and dragging) then
		update(input);
	end
end);
MyButton.MouseButton1Click:connect(function()
	if Debounce then
		return;
	end
	Library.Toggle();
	UserDatas.UDatas:SetValue("EnchantsRefuse", EnchantsRefuse);
	UserDatas.UDatas:SetValue("PetEnchantsRefuse", PetEnchantsRefuse);
	SaveManager:Save(ConfigurationName);
end);
local loadData = function()
	local uData = UserDatas.UDatas.Value;
	if uData.UpgradeId then
		Labels.UpgradeId:SetText(uData.UpgradeId);
		SelectedRelic = uData.UpgradeId;
		Labels.UpgradeName:SetText(uData.UpgradeName);
		Labels.UpgradeExp:SetText(uData.UpgradeExp);
	end
	local MobBlackListStr = "";
	MobBlackList = uData.MobBlackList;
	MobWhiteList = uData.MobWhiteList;
	EnchantsRefuse = uData.EnchantsRefuse;
	PetEnchantsRefuse = uData.PetEnchantsRefuse;
	ExpRelicList = uData.ExpRelicList;
	if (MobBlackList ~= nil) then
		for key, value in next, MobBlackList do
			MobBlackListStr = MobBlackListStr .. value .. "\n";
		end
		if (#MobBlackList == 0) then
			MobBlackListStr = MobBlackListStr .. "is NULL";
		end
		Labels.BlackListLabel:SetText(MobBlackListStr);
	else
		MobBlackList = {};
	end
	MobBlackListStr = "";
	if (MobWhiteList ~= nil) then
		for key, value in next, MobWhiteList do
			MobBlackListStr = MobBlackListStr .. value .. "\n";
		end
		if (#MobWhiteList == 0) then
			MobBlackListStr = MobBlackListStr .. "is NULL";
		end
		Labels.WhiteListLabel:SetText(MobBlackListStr);
	else
		MobWhiteList = {};
	end
	if (EnchantsRefuse ~= nil) then
		local TiersStr = "";
		for key, value in EnchantsRefuse do
			TiersStr = TiersStr .. key .. ":" .. value .. "\n";
		end
		Labels.FList:SetText(TiersStr);
	end
	if (PetEnchantsRefuse ~= nil) then
		local TiersStr = "";
		for key, value in PetEnchantsRefuse do
			TiersStr = TiersStr .. key .. ":" .. value .. "\n";
		end
		Labels.PetFList:SetText(TiersStr);
	end
	if ExpRelicList then
		Labels.BlackList:SetText("All:" .. #ExpRelicList);
	end
end;
if SaveManager:Load(ConfigurationName) then
	wait(1.5);
	loadData();
end
print("End");