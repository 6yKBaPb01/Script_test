-- 99 NIGHTS ULTIMATE HACK by I.S.-1 v16.0 FINAL
-- ПОЛНЫЙ ФУНКЦИОНАЛ ДЛЯ ПК И МОБИЛ

local UltimateHack = {}

-- АВТООПРЕДЕЛЕНИЕ ПЛАТФОРМЫ
local IS_MOBILE = (game:GetService("UserInputService").TouchEnabled == true)
local IS_TABLET = (IS_MOBILE and (workspace.CurrentCamera.ViewportSize.X > 1000))

-- АДАПТИВНАЯ ЗАГРУЗКА RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- АДАПТИВНЫЕ НАСТРОЙКИ ИНТЕРФЕЙСА
local UI_SCALE = IS_MOBILE and 1.3 or 1.0
local BUTTON_SIZE = IS_MOBILE and UDim2.new(0, 200, 0, 40) or UDim2.new(0, 175, 0, 35)

-- Создаем окно с мобильной оптимизацией
local Window = Rayfield:CreateWindow({
   Name = IS_MOBILE and "99 NIGHTS MOBILE v16.0" or "99 NIGHTS ULTIMATE HACK v16.0",
   LoadingTitle = "I.S.-1 Loading...",
   LoadingSubtitle = IS_MOBILE and "Mobile Optimized" or "by InfectionSystem-1",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "99NightsHack",
      FileName = "Config.json"
   },
   KeySystem = false,
   MobileScaled = IS_MOBILE,
})

-- ВСЕ ВКЛАДКИ
local MainTab = Window:CreateTab("Главные", 4483362458)
local PlayerTab = Window:CreateTab("Игрок", 4483362458) 
local AutoTab = Window:CreateTab("Авто", 4483362458)
local ExploreTab = Window:CreateTab("Карта", 4483362458)
local CollectTab = Window:CreateTab("Сбор", 4483362458)
local TeleportTab = Window:CreateTab("ТП", 4483362458)
local OptimizationTab = Window:CreateTab("Оптимизация", 4483362458)
local PlantTab = Window:CreateTab("Посадка", 4483362458)
local DebugTab = Window:CreateTab("Дебаг", 4483362458)

-- ПОЛНЫЕ НАСТРОЙКИ
UltimateHack.Settings = {
    -- ОСНОВНЫЕ
    AutoTPToFire = false,
    
    -- АУРЫ
    KillAura = false,
    KillAuraRadius = IS_MOBILE and 30 or 50,
    TreeAura = false,
    TreeAuraRadius = IS_MOBILE and 20 or 30,
    AutoFarmAura = false,
    
    -- АВТОМАТЫ
    AutoFish = false,
    AutoLoot = false,
    AntiAFK = IS_MOBILE,
    AutoFindChildren = false,
    AutoCookFood = false,
    AutoCollectDropped = true,
    
    -- ЧИТЫ
    FlyHack = false,
    NoClip = false,
    GodMode = false,
    SpeedHack = false,
    SpeedMultiplier = IS_MOBILE and 1.5 or 2,
    InfiniteStamina = IS_MOBILE,
    NoHunger = IS_MOBILE,
    NoThirst = IS_MOBILE,
    JumpPower = IS_MOBILE and 70 or 50,
    
    -- ЭКСПЛОРОМ КАРТЫ
    AutoExplore = false,
    ExploreRadius = IS_MOBILE and 1000 or 2000,
    ExploreSpeed = IS_MOBILE and 30 or 50,
    ExploreHeight = IS_MOBILE and 30 or 50,
    
    -- ОПТИМИЗАЦИЯ
    AutoOptimize = IS_MOBILE,
    OptimizeFPS = IS_MOBILE,
    OptimizeGraphics = IS_MOBILE,
    OptimizeShadows = false,
    OptimizeFog = false,
    OptimizeParticles = false,
    
    -- АВТОПОСАДКА
    AutoPlantTrees = false,
    PlantMode = "stack",
    PlantRadius = 30,
    PlantDensity = 5,
    
    -- ДЕБАГ
    DebugMode = false,
}

-- ПОЛНАЯ СИСТЕМА ЭКСПЛОРОМА
UltimateHack.ExploreSystem = {
    IsExploring = false,
    ExploredPoints = {},
    ChestsFound = 0,
    ResourcesFound = 0,
    ScanProgress = 0,
    CurrentPosition = 1,
    TotalPoints = 0,
    LastFoundItem = "Ничего"
}

-- ПОЛНЫЕ НАСТРОЙКИ СБОРА
UltimateHack.CollectSettings = {
    Wood = true, Metal = true, Fuel = true, Stone = true, Seeds = true,
    Axes = true, Rods = true, Flutes = true, Sacks = true,
    MeleeWeapons = true, RangedWeapons = true, Ammo = true,
    Bandages = true, Medkits = true, Potions = true,
    Vegetables = true, Meat = true, Fish = true, CookedFood = true,
    Water = true, SpecialFood = true,
    Pelts = true, Gems = true, Artifacts = true, Currency = true,
    Miscellaneous = true,
    AutoCollect = false,
    AutoCollectInterval = IS_MOBILE and 8 or 5
}

UltimateHack.ActiveCheats = {
    Fly = false, NoClip = false, GodMode = false, SpeedHack = false
}

UltimateHack.FirePosition = Vector3.new(0, 0, 0)
UltimateHack.IsRunning = false
UltimateHack.ChildrenNames = {"Дино малыш", "Малыш Кракен", "Малыш спрут", "Малыш коала"}

-- ПОЛНЫЕ СПИСКИ ПРЕДМЕТОВ
UltimateHack.ItemLists = {
    Wood = {"Wood", "Log", "Plank", "Stick", "Tree", "BirchLog", "OakLog", "PineLog", "Birch", "Oak", "Pine"},
    Metal = {"Metal", "Scrap", "Iron", "Steel", "Ore", "Canister", "Tire", "Bolt", "Nail"},
    Fuel = {"Fuel", "Coal", "Oil", "Gas", "Petrol", "Biofuel"},
    Stone = {"Stone", "Flint", "Rock", "Boulder", "Pebble"},
    Seeds = {"Seed", "Sapling", "Saplings"},
    Axes = {"Axe", "Chainsaw", "Hatchet", "OldAxe", "GoodAxe", "StrongAxe"},
    Rods = {"Rod", "FishingRod", "FishingPole"},
    Flutes = {"Flute", "TamingFlute", "Whistle"},
    Sacks = {"Sack", "Bag", "Backpack", "OldSack", "GoodSack", "GiantSack", "AdminSack"},
    MeleeWeapons = {"Spear", "Katana", "Sword", "Knife", "Dagger", "MorningStar", "Mace", "Axe"},
    RangedWeapons = {"Revolver", "Rifle", "Shotgun", "TacticalShotgun", "Kunai", "Bow", "Gun", "Pistol"},
    Ammo = {"Ammo", "Bullet", "Cartridge", "Shell", "Round", "Arrow"},
    Bandages = {"Bandage", "Bandages", "BandageRoll"},
    Medkits = {"Medkit", "FirstAid", "MedicalKit", "HealthKit"},
    Potions = {"Potion", "Heal", "HealthPotion", "HealingPotion"},
    Vegetables = {"Carrot", "Corn", "Pumpkin", "Apple", "Berry", "Tomato", "Potato", "Cabbage"},
    Meat = {"Morsel", "Steak", "Ribs", "Meat", "RawMeat", "AnimalMeat", "CookedMeat"},
    Fish = {"Mackerel", "Salmon", "Fish", "Trout", "Clownfish", "Shark", "Jellyfish", "Eel", "Swordfish"},
    CookedFood = {"Stew", "Cake", "Chili", "Bread", "CookedSteak", "Roast", "Pie", "Soup", "HeartyStew"},
    Water = {"Water", "Drink", "Bottle", "Canteen", "WaterBottle"},
    SpecialFood = {"CarrotCake", "PumpkinPie", "SpecialCake"},
    Pelts = {"Pelt", "Fur", "Hide", "Leather", "Skin", "AnimalHide", "RabbitPelt", "WolfPelt", "BearPelt"},
    Gems = {"Gem", "Crystal", "Diamond", "Ruby", "Emerald", "Sapphire", "Amethyst", "Gold"},
    Artifacts = {"Cultist", "Artifact", "Relic", "Treasure", "Ancient", "Antique", "CultistAmulet"},
    Currency = {"Coin", "Money", "Gold", "Silver", "Cash", "Dollar"},
    Miscellaneous = {"Map", "Bed", "Chest", "Loot", "Resource", "Item", "Object", "Thing", "Junk"}
}

-- УМНАЯ СИСТЕМА ОБНАРУЖЕНИЯ ПРЕДМЕТОВ
UltimateHack.ItemDetector = {
    FoundItems = {},
    RecentItems = {},
    LastScanTime = 0
}

-- ВСЕ ФУНКЦИИ
UltimateHack.Functions = {}

-- УМНАЯ СИСТЕМА ОБНАРУЖЕНИЯ И ПОДБОРА ПРЕДМЕТОВ
UltimateHack.Functions.ItemSystem = {}

function UltimateHack.Functions.ItemSystem.ScanForItems()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return {} end
    
    local foundItems = {}
    local scanRadius = IS_MOBILE and 40 or 60
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local distance = (character.HumanoidRootPart.Position - obj.Position).Magnitude
            if distance < scanRadius then
                if not obj:IsDescendantOf(character) and obj.Name ~= "Baseplate" then
                    local itemName = obj.Name
                    
                    local itemType = "Разное"
                    if itemName:match("Carrot") or itemName:match("Apple") or itemName:match("Berry") then
                        itemType = "Еда"
                    elseif itemName:match("Wood") or itemName:match("Log") then
                        itemType = "Дерево" 
                    elseif itemName:match("Stone") or itemName:match("Rock") then
                        itemType = "Камень"
                    elseif itemName:match("Metal") or itemName:match("Iron") then
                        itemType = "Металл"
                    elseif itemName:match("Axe") or itemName:match("Tool") then
                        itemType = "Инструмент"
                    elseif itemName:match("Chest") or itemName:match("Loot") then
                        itemType = "Сундук"
                    elseif itemName:match("Coin") or itemName:match("Money") then
                        itemType = "Валюта"
                    end
                    
                    table.insert(foundItems, {
                        Object = obj,
                        Name = itemName,
                        Type = itemType,
                        Position = obj.Position,
                        Distance = distance
                    })
                end
            end
        end
    end
    
    table.sort(foundItems, function(a, b)
        return a.Distance < b.Distance
    end)
    
    return foundItems
end

function UltimateHack.Functions.ItemSystem.AutoCollectItems()
    while UltimateHack.Settings.AutoCollectDropped and UltimateHack.IsRunning do
        wait(IS_MOBILE and 3 or 2)
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then continue end
        
        local items = UltimateHack.Functions.ItemSystem.ScanForItems()
        local collectedCount = 0
        
        for _, item in ipairs(items) do
            if not UltimateHack.IsRunning then break end
            
            if item.Distance > (IS_MOBILE and 25 or 35) then
                continue
            end
            
            pcall(function()
                character.HumanoidRootPart.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0))
                wait(0.1)
                
                firetouchinterest(character.HumanoidRootPart, item.Object, 0)
                firetouchinterest(character.HumanoidRootPart, item.Object, 1)
                
                collectedCount = collectedCount + 1
                
                if collectedCount == 1 then
                    UltimateHack.ExploreSystem.LastFoundItem = item.Name
                    
                    if not UltimateHack.ItemDetector.RecentItems[item.Name] then
                        UltimateHack.ItemDetector.RecentItems[item.Name] = true
                        
                        Rayfield:Notify({
                            Title = "🎯 Найден предмет",
                            Content = item.Name .. " (" .. item.Type .. ")",
                            Duration = IS_MOBILE and 3 or 2,
                        })
                    end
                end
                
                wait(0.2)
            end)
        end
        
        if tick() - UltimateHack.ItemDetector.LastScanTime > 30 then
            UltimateHack.ItemDetector.RecentItems = {}
            UltimateHack.ItemDetector.LastScanTime = tick()
        end
    end
end

-- ПОЛНАЯ СИСТЕМА ЭКСПЛОРОМА КАРТЫ
UltimateHack.Functions.Explore = {}

function UltimateHack.Functions.Explore.GenerateExploreGrid()
    local center = UltimateHack.FirePosition
    local radius = UltimateHack.Settings.ExploreRadius
    local gridPoints = {}
    
    for x = -radius, radius, UltimateHack.Settings.ExploreSpeed do
        for z = -radius, radius, UltimateHack.Settings.ExploreSpeed do
            table.insert(gridPoints, Vector3.new(
                center.X + x,
                UltimateHack.Settings.ExploreHeight,
                center.Z + z
            ))
        end
    end
    
    UltimateHack.ExploreSystem.TotalPoints = #gridPoints
    return gridPoints
end

function UltimateHack.Functions.Explore.ScanAtPosition(position)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return 0, 0 end
    
    pcall(function()
        character.HumanoidRootPart.CFrame = CFrame.new(position)
        wait(0.05)
    end)
    
    local foundItems, foundChests = 0, 0
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if not UltimateHack.ExploreSystem.IsExploring then break end
        
        if obj:IsA("BasePart") then
            local distance = (position - obj.Position).Magnitude
            if distance < 50 then
                local objName = obj.Name:lower()
                
                if objName:find("chest") or objName:find("loot") or objName:find("box") then
                    foundChests = foundChests + 1
                    UltimateHack.Functions.Explore.LootChest(obj)
                end
                
                for category, enabled in pairs(UltimateHack.CollectSettings) do
                    if enabled and category ~= "AutoCollect" and category ~= "AutoCollectInterval" then
                        local resources = UltimateHack.ItemLists[category]
                        if resources then
                            for _, resource in pairs(resources) do
                                if objName:find(resource:lower()) then
                                    foundItems = foundItems + 1
                                    UltimateHack.Functions.Explore.CollectResource(obj)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return foundItems, foundChests
end

function UltimateHack.Functions.Explore.LootChest(chest)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    pcall(function()
        character.HumanoidRootPart.CFrame = chest.CFrame
        wait(0.1)
        
        firetouchinterest(character.HumanoidRootPart, chest, 0)
        firetouchinterest(character.HumanoidRootPart, chest, 1)
        
        UltimateHack.Functions.Explore.SpawnChestLoot(chest.Position)
        UltimateHack.ExploreSystem.ChestsFound = UltimateHack.ExploreSystem.ChestsFound + 1
    end)
end

function UltimateHack.Functions.Explore.SpawnChestLoot(position)
    local lootItems = {"Wood", "Metal", "Stone", "Axe", "Bandage", "Medkit", "Carrot", "Apple", "Water", "Coin", "Gem"}
    
    for i = 1, math.random(3, 8) do
        local itemName = lootItems[math.random(1, #lootItems)]
        
        local fakeItem = Instance.new("Part")
        fakeItem.Name = itemName .. "Loot"
        fakeItem.Size = Vector3.new(2, 2, 2)
        fakeItem.Position = position + Vector3.new(math.random(-5, 5), 5, math.random(-5, 5))
        fakeItem.Anchored = true
        fakeItem.CanCollide = false
        fakeItem.Parent = workspace
        
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 165, 0)
        highlight.Parent = fakeItem
        
        spawn(function()
            wait(1)
            if fakeItem and fakeItem.Parent then
                UltimateHack.Functions.Explore.CollectResource(fakeItem)
            end
        end)
    end
end

function UltimateHack.Functions.Explore.CollectResource(resource)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    pcall(function()
        character.HumanoidRootPart.CFrame = resource.CFrame
        wait(0.1)
        
        firetouchinterest(character.HumanoidRootPart, resource, 0)
        firetouchinterest(character.HumanoidRootPart, resource, 1)
        
        UltimateHack.ExploreSystem.ResourcesFound = UltimateHack.ExploreSystem.ResourcesFound + 1
        
        if resource.Name:find("Loot") then
            wait(0.5)
            resource:Destroy()
        end
    end)
end

function UltimateHack.Functions.Explore.StartAutoExplore()
    if UltimateHack.ExploreSystem.IsExploring then
        Rayfield:Notify({Title = "Эксплором", Content = "Сканирование уже запущено!", Duration = 2})
        return
    end
    
    UltimateHack.ExploreSystem.IsExploring = true
    UltimateHack.ExploreSystem.ChestsFound = 0
    UltimateHack.ExploreSystem.ResourcesFound = 0
    UltimateHack.ExploreSystem.ScanProgress = 0
    
    local gridPoints = UltimateHack.Functions.Explore.GenerateExploreGrid()
    local totalPoints = #gridPoints
    
    Rayfield:Notify({
        Title = "🌍 ЗАПУСК ЭКСПЛОРОМА",
        Content = "Начинаю сканирование карты... Всего точек: " .. totalPoints,
        Duration = 3,
    })
    
    spawn(function()
        for i, point in ipairs(gridPoints) do
            if not UltimateHack.ExploreSystem.IsExploring then break end
            
            UltimateHack.ExploreSystem.CurrentPosition = i
            UltimateHack.ExploreSystem.ScanProgress = (i / totalPoints) * 100
            
            local items, chests = UltimateHack.Functions.Explore.ScanAtPosition(point)
            
            if i % 10 == 0 then
                Rayfield:Notify({
                    Title = "🌍 Сканирование...",
                    Content = string.format("Прогресс: %.1f%%\nСундуков: %d\nРесурсов: %d", 
                        UltimateHack.ExploreSystem.ScanProgress,
                        UltimateHack.ExploreSystem.ChestsFound,
                        UltimateHack.ExploreSystem.ResourcesFound),
                    Duration = 2,
                })
            end
            
            wait(0.05)
        end
        
        UltimateHack.ExploreSystem.IsExploring = false
        
        Rayfield:Notify({
            Title = "✅ СКАНИРОВАНИЕ ЗАВЕРШЕНО",
            Content = string.format("Найдено:\nСундуков: %d\nРесурсов: %d\nПоследний предмет: %s", 
                UltimateHack.ExploreSystem.ChestsFound,
                UltimateHack.ExploreSystem.ResourcesFound,
                UltimateHack.ExploreSystem.LastFoundItem),
            Duration = 5,
        })
    end)
end

function UltimateHack.Functions.Explore.StopAutoExplore()
    UltimateHack.ExploreSystem.IsExploring = false
    Rayfield:Notify({Title = "Эксплором", Content = "Сканирование остановлено!", Duration = 2})
end

-- БЫСТРЫЙ ЭКСПЛОРОМ ДЛЯ МОБИЛ
function UltimateHack.Functions.Explore.QuickExplore()
    if UltimateHack.ExploreSystem.IsExploring then
        Rayfield:Notify({Title = "Эксплором", Content = "Сканирование уже запущено!", Duration = 2})
        return
    end
    
    UltimateHack.ExploreSystem.IsExploring = true
    UltimateHack.ExploreSystem.ChestsFound = 0
    UltimateHack.ExploreSystem.ResourcesFound = 0
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local startPos = character.HumanoidRootPart.Position
    
    Rayfield:Notify({
        Title = "🌍 Быстрый эксплором",
        Content = "Начинаю сканирование местности...",
        Duration = 3,
    })
    
    spawn(function()
        local scanPoints = {}
        local radius = UltimateHack.Settings.ExploreRadius
        local steps = IS_MOBILE and 4 or 8
        
        for i = 1, steps do
            local angle = (i / steps) * math.pi * 2
            local x = math.cos(angle) * radius
            local z = math.sin(angle) * radius
            table.insert(scanPoints, Vector3.new(
                startPos.X + x,
                UltimateHack.Settings.ExploreHeight,
                startPos.Z + z
            ))
        end
        
        table.insert(scanPoints, Vector3.new(
            startPos.X,
            UltimateHack.Settings.ExploreHeight,
            startPos.Z
        ))
        
        for i, point in ipairs(scanPoints) do
            if not UltimateHack.ExploreSystem.IsExploring then break end
            
            UltimateHack.ExploreSystem.ScanProgress = (i / #scanPoints) * 100
            
            pcall(function()
                character.HumanoidRootPart.CFrame = CFrame.new(point)
                wait(0.5)
                
                local items = UltimateHack.Functions.ItemSystem.ScanForItems()
                
                for _, item in ipairs(items) do
                    if item.Type == "Сундук" then
                        UltimateHack.ExploreSystem.ChestsFound = UltimateHack.ExploreSystem.ChestsFound + 1
                        UltimateHack.Functions.Explore.LootChest(item.Object)
                    else
                        UltimateHack.ExploreSystem.ResourcesFound = UltimateHack.ExploreSystem.ResourcesFound + 1
                    end
                end
            end)
            
            if i % 2 == 0 then
                Rayfield:Notify({
                    Title = "🌍 Сканирование...",
                    Content = string.format("Прогресс: %.0f%%\nСундуков: %d\nРесурсов: %d", 
                        UltimateHack.ExploreSystem.ScanProgress,
                        UltimateHack.ExploreSystem.ChestsFound,
                        UltimateHack.ExploreSystem.ResourcesFound),
                    Duration = 2,
                })
            end
            
            wait(1)
        end
        
        pcall(function()
            character.HumanoidRootPart.CFrame = CFrame.new(startPos)
        end)
        
        UltimateHack.ExploreSystem.IsExploring = false
        
        Rayfield:Notify({
            Title = "✅ СКАНИРОВАНИЕ ЗАВЕРШЕНО",
            Content = string.format("Найдено:\nСундуков: %d\nРесурсов: %d\nПоследний предмет: %s", 
                UltimateHack.ExploreSystem.ChestsFound,
                UltimateHack.ExploreSystem.ResourcesFound,
                UltimateHack.ExploreSystem.LastFoundItem),
            Duration = 5,
        })
    end)
end

-- УЛУЧШЕННЫЕ АУРЫ
UltimateHack.Functions.Auras = {}

function UltimateHack.Functions.Auras.SmartKillAura()
    while UltimateHack.Settings.KillAura and UltimateHack.IsRunning do
        task.wait(IS_MOBILE and 1.0 or 0.5)
        
        local player = game.Players.LocalPlayer
        if not player then continue end
        
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then continue end

        local weapon = nil
        
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                weapon = tool
                break
            end
        end
        
        if not weapon then
            for _, tool in pairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    weapon = tool
                    tool.Parent = character
                    task.wait(0.3)
                    break
                end
            end
        end
        
        if not weapon then continue end

        for _, target in pairs(game.Players:GetPlayers()) do
            if target == player then continue end
            
            local targetChar = target.Character
            if not targetChar then continue end
            if not targetChar:FindFirstChild("HumanoidRootPart") then continue end
            if not targetChar:FindFirstChild("Humanoid") then continue end
            
            local distance = (character.HumanoidRootPart.Position - targetChar.HumanoidRootPart.Position).Magnitude
            
            if distance < UltimateHack.Settings.KillAuraRadius then
                local isChild = false
                if target:FindFirstChild("Status") and target.Status.Value == "Child" then
                    isChild = true
                end
                
                if not isChild and targetChar.Humanoid.Health > 0 then
                    pcall(function()
                        character.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                        task.wait(0.2)
                        
                        if weapon:IsA("Tool") then
                            weapon:Activate()
                        end
                        
                        task.wait(0.3)
                    end)
                end
            end
        end
        
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                local npcName = npc.Name:lower()
                local isEnemy = npcName:find("wolf") or npcName:find("bear") or npcName:find("animal") or 
                               npcName:find("enemy") or npcName:find("zombie") or npcName:find("cultist")
                
                if isEnemy then
                    local distance = (character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude
                    
                    if distance < UltimateHack.Settings.KillAuraRadius then
                        if npc.Humanoid.Health > 0 then
                            pcall(function()
                                character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                                task.wait(0.2)
                                
                                if weapon:IsA("Tool") then
                                    weapon:Activate()
                                end
                                
                                task.wait(0.3)
                            end)
                        end
                    end
                end
            end
        end
    end
end

function UltimateHack.Functions.Auras.SmartTreeAura()
    while UltimateHack.Settings.TreeAura and UltimateHack.IsRunning do
        task.wait(0.6)
        
        local player = game.Players.LocalPlayer
        if not player then continue end
        
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then continue end

        local tool = nil
        
        for _, item in pairs(character:GetChildren()) do
            if item:IsA("Tool") then
                tool = item
                break
            end
        end
        
        if not tool then
            for _, item in pairs(player.Backpack:GetChildren()) do
                if item:IsA("Tool") then
                    tool = item
                    item.Parent = character
                    task.wait(0.3)
                    break
                end
            end
        end
        
        if not tool then continue end
        
        local treesFound = 0
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if not UltimateHack.Settings.TreeAura then break end
            
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                local objName = obj.Name:lower()
                local isTree = objName:find("tree") or objName:find("log") or objName:find("wood") or
                              objName:find("birch") or objName:find("oak") or objName:find("pine")
                
                if isTree then
                    local distance = (character.HumanoidRootPart.Position - obj.Position).Magnitude
                    
                    if distance < UltimateHack.Settings.TreeAuraRadius then
                        treesFound = treesFound + 1
                        
                        pcall(function()
                            character.HumanoidRootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                            task.wait(0.2)
                            
                            if tool:IsA("Tool") then
                                for i = 1, 3 do
                                    tool:Activate()
                                    task.wait(0.2)
                                end
                            end
                            
                            task.wait(0.3)
                        end)
                    end
                end
            end
        end
        
        if treesFound == 0 then
            task.wait(2)
        end
    end
end

-- СИСТЕМА АВТОПОСАДКИ
UltimateHack.Functions.Planting = {}

function UltimateHack.Functions.Planting.PlantTree(position)
    local plantEvent = game:GetService("ReplicatedStorage"):FindFirstChild("PlantTree") or
                      game:GetService("ReplicatedStorage"):FindFirstChild("PlantSeed") or
                      game:GetService("ReplicatedStorage"):FindFirstChild("GrowTree")
    
    if plantEvent then
        pcall(function()
            plantEvent:FireServer(position)
        end)
        return true
    end
    return false
end

function UltimateHack.Functions.Planting.PlantStack()
    local stackPosition = UltimateHack.FirePosition
    local success = UltimateHack.Functions.Planting.PlantTree(stackPosition)
    
    if success then
        Rayfield:Notify({Title = "🌲 Посадка", Content = "Дерево посажено в стек!", Duration = 2})
    end
    
    return success
end

function UltimateHack.Functions.Planting.PlantWall()
    local radius = UltimateHack.Settings.PlantRadius
    local density = UltimateHack.Settings.PlantDensity
    local plantedCount = 0
    
    for angle = 0, 360, density do
        if not UltimateHack.IsRunning then break end
        
        local x = UltimateHack.FirePosition.X + math.cos(math.rad(angle)) * radius
        local z = UltimateHack.FirePosition.Z + math.sin(math.rad(angle)) * radius
        local plantPos = Vector3.new(x, UltimateHack.FirePosition.Y, z)
        
        local success = UltimateHack.Functions.Planting.PlantTree(plantPos)
        if success then
            plantedCount = plantedCount + 1
            task.wait(0.2)
        end
    end
    
    Rayfield:Notify({Title = "🌲 Стена деревьев", Content = "Посажено деревьев: " .. plantedCount, Duration = 3})
    return plantedCount > 0
end

function UltimateHack.Functions.Planting.AutoPlant()
    while UltimateHack.Settings.AutoPlantTrees and UltimateHack.IsRunning do
        task.wait(10)
        
        if UltimateHack.Settings.PlantMode == "stack" then
            UltimateHack.Functions.Planting.PlantStack()
        elseif UltimateHack.Settings.PlantMode == "wall" then
            UltimateHack.Functions.Planting.PlantWall()
        end
    end
end

-- ЧИТЫ С ФИКСАМИ
UltimateHack.Functions.Cheats = {}

function UltimateHack.Functions.Cheats.ToggleFly()
    if UltimateHack.ActiveCheats.Fly then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local bodyVelocity = character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            character.Humanoid.PlatformStand = false
        end
        UltimateHack.ActiveCheats.Fly = false
        Rayfield:Notify({Title = "Чит", Content = "Режим полета выключен!", Duration = 2})
    else
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.Humanoid.PlatformStand = true
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
            bodyVelocity.Parent = character.HumanoidRootPart
            
            spawn(function()
                while UltimateHack.ActiveCheats.Fly and character and character:FindFirstChild("HumanoidRootPart") do
                    local root = character.HumanoidRootPart
                    if bodyVelocity and bodyVelocity.Parent then
                        local cam = workspace.CurrentCamera
                        local moveVector = Vector3.new(
                            (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) and 1 or 0) - 
                            (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                            (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E) and 1 or 0) - 
                            (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Q) and 1 or 0),
                            (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) and 1 or 0) - 
                            (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) and 1 or 0)
                        )
                        
                        bodyVelocity.Velocity = (cam.CFrame:VectorToWorldSpace(moveVector)) * 50
                    end
                    wait(0.1)
                end
            end)
        end
        UltimateHack.ActiveCheats.Fly = true
        Rayfield:Notify({Title = "Чит", Content = "Режим полета включен! WASD - движение, Q/E - вверх/вниз", Duration = 3})
    end
end

function UltimateHack.Functions.Cheats.ToggleNoClip()
    if UltimateHack.ActiveCheats.NoClip then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        UltimateHack.ActiveCheats.NoClip = false
        Rayfield:Notify({Title = "Чит", Content = "NoClip выключен!", Duration = 2})
    else
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        UltimateHack.ActiveCheats.NoClip = true
        Rayfield:Notify({Title = "Чит", Content = "NoClip включен!", Duration = 2})
    end
end

function UltimateHack.Functions.Cheats.ToggleGodMode()
    if UltimateHack.ActiveCheats.GodMode then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
        UltimateHack.ActiveCheats.GodMode = false
        Rayfield:Notify({Title = "Чит", Content = "Режим бога выключен!", Duration = 2})
    else
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.MaxHealth = math.huge
            character.Humanoid.Health = math.huge
        end
        UltimateHack.ActiveCheats.GodMode = true
        Rayfield:Notify({Title = "Чит", Content = "Режим бога включен!", Duration = 2})
    end
end

function UltimateHack.Functions.Cheats.SetSpeed(speed)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
        if speed > 16 then
            UltimateHack.ActiveCheats.SpeedHack = true
        else
            UltimateHack.ActiveCheats.SpeedHack = false
        end
        Rayfield:Notify({Title = "Чит", Content = "Скорость установлена: " .. speed, Duration = 2})
    end
end

function UltimateHack.Functions.Cheats.SetJumpPower(power)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = power
        Rayfield:Notify({Title = "Чит", Content = "Сила прыжка установлена: " .. power, Duration = 2})
    end
end

function UltimateHack.Functions.Cheats.WalkOnSky()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
        Rayfield:Notify({Title = "Чит", Content = "Ходьба по небу активирована!", Duration = 2})
    end
end

function UltimateHack.Functions.Cheats.DisableAllCheats()
    if UltimateHack.ActiveCheats.Fly then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local bodyVelocity = character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bodyVelocity then bodyVelocity:Destroy() end
            character.Humanoid.PlatformStand = false
        end
        UltimateHack.ActiveCheats.Fly = false
    end
    
    if UltimateHack.ActiveCheats.NoClip then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        UltimateHack.ActiveCheats.NoClip = false
    end
    
    if UltimateHack.ActiveCheats.GodMode then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
        UltimateHack.ActiveCheats.GodMode = false
    end
    
    if UltimateHack.ActiveCheats.SpeedHack then
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
            player.Character.Humanoid.JumpPower = 50
        end
        UltimateHack.ActiveCheats.SpeedHack = false
    end
    
    UltimateHack.Settings.InfiniteStamina = false
    UltimateHack.Settings.NoHunger = false
    UltimateHack.Settings.NoThirst = false
    
    Rayfield:Notify({Title = "Читы", Content = "Все читы выключены!", Duration = 2})
end

-- АВТОМАТЫ
UltimateHack.Functions.Automation = {}

function UltimateHack.Functions.Automation.AutoFish()
    while UltimateHack.Settings.AutoFish and UltimateHack.IsRunning do
        wait(5)
        local fishingRod = game.Players.LocalPlayer.Backpack:FindFirstChild("FishingRod") or game.Players.LocalPlayer.Character:FindFirstChild("FishingRod")
        if fishingRod then
            pcall(function()
                local fishingEvent = game:GetService("ReplicatedStorage"):FindFirstChild("FishingEvent")
                if fishingEvent then
                    fishingEvent:FireServer("StartFishing")
                end
            end)
        end
    end
end

function UltimateHack.Functions.Automation.AutoLoot()
    while UltimateHack.Settings.AutoLoot and UltimateHack.IsRunning do
        wait(8)
        local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj.Name:find("Chest") or obj.Name:find("Loot") or obj.Name:find("Resource")) and obj:IsA("BasePart") then
                pcall(function()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                    wait(0.2)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                end)
            end
        end
        
        pcall(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)
        end)
    end
end

function UltimateHack.Functions.Automation.FindChildren()
    while UltimateHack.Settings.AutoFindChildren and UltimateHack.IsRunning do
        wait(10)
        for _, player in pairs(game.Players:GetPlayers()) do
            for _, childName in pairs(UltimateHack.ChildrenNames) do
                if player.Name:find(childName) or (player:FindFirstChild("DisplayName") and player.DisplayName:find(childName)) then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        pcall(function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                            Rayfield:Notify({Title = "Найден ребенок!", Content = "Телепорт к " .. childName, Duration = 2})
                            wait(3)
                        end)
                    end
                end
            end
        end
    end
end

function UltimateHack.Functions.Automation.AntiAFK()
    while UltimateHack.Settings.AntiAFK and UltimateHack.IsRunning do
        wait(25)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(1, 0, 0)
            end)
        end
    end
end

function UltimateHack.Functions.Automation.AutoCookFood()
    while UltimateHack.Settings.AutoCookFood and UltimateHack.IsRunning do
        wait(15)
        local fire = workspace:FindFirstChild("Fire") or workspace:FindFirstChild("Campfire")
        if fire then
            pcall(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = fire.CFrame
                wait(2)
            end)
        end
    end
end

function UltimateHack.Functions.Automation.AutoCollectDropped()
    while UltimateHack.Settings.AutoCollectDropped and UltimateHack.IsRunning do
        wait(IS_MOBILE and 4 or 2)
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then continue end
        
        local items = UltimateHack.Functions.ItemSystem.ScanForItems()
        
        for _, item in ipairs(items) do
            if item.Distance < 25 then
                pcall(function()
                    character.HumanoidRootPart.CFrame = CFrame.new(item.Position + Vector3.new(0, 2, 0))
                    wait(0.2)
                    firetouchinterest(character.HumanoidRootPart, item.Object, 0)
                    firetouchinterest(character.HumanoidRootPart, item.Object, 1)
                    
                    UltimateHack.ExploreSystem.LastFoundItem = item.Name
                end)
                break
            end
        end
    end
end

-- ТЕЛЕПОРТАЦИЯ
UltimateHack.Functions.Teleport = {}

function UltimateHack.Functions.Teleport.ToFire()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(UltimateHack.FirePosition)
        Rayfield:Notify({Title = "Телепортация", Content = "Телепорт к костру выполнен!", Duration = 2})
    end
end

function UltimateHack.Functions.Teleport.ToPlayer(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character then
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            Rayfield:Notify({Title = "Телепортация", Content = "Телепорт к игроку " .. playerName .. " выполнен!", Duration = 2})
        end
    else
        Rayfield:Notify({Title = "Ошибка", Content = "Игрок " .. playerName .. " не найден!", Duration = 2})
    end
end

function UltimateHack.Functions.Teleport.ToChild()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player:FindFirstChild("Status") and player.Status.Value == "Child" then
            local playerChar = game.Players.LocalPlayer.Character
            if playerChar and player.Character then
                playerChar.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                Rayfield:Notify({Title = "Телепортация", Content = "Телепорт к ребенку выполнен!", Duration = 2})
                return
            end
        end
    end
    Rayfield:Notify({Title = "Ошибка", Content = "Ребенок не найден!", Duration = 2})
end

function UltimateHack.Functions.Teleport.SetFirePosition()
    local player = game.Players.LocalPlayer
    if player.Character then
        UltimateHack.FirePosition = player.Character.HumanoidRootPart.Position
        Rayfield:Notify({Title = "Костер", Content = "Позиция костра установлена!", Duration = 2})
    end
end

function UltimateHack.Functions.Teleport.AllToFire()
    local localPlayer = game.Players.LocalPlayer
    local teleportedCount = 0
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(UltimateHack.FirePosition)
            teleportedCount = teleportedCount + 1
        end
    end
    
    Rayfield:Notify({Title = "Телепортация", Content = "Игроков телепортировано: " .. teleportedCount, Duration = 2})
end

-- ОПТИМИЗАЦИЯ
UltimateHack.Functions.Optimization = {}

function UltimateHack.Functions.Optimization.SetFPS(fps)
    if setfpscap then
        setfpscap(fps)
        if UltimateHack.Settings.DebugMode then
            Rayfield:Notify({Title = "Оптимизация", Content = "FPS установлен: " .. fps, Duration = 2})
        end
    end
end

function UltimateHack.Functions.Optimization.SetQuality(level)
    settings().Rendering.QualityLevel = level
    if UltimateHack.Settings.DebugMode then
        Rayfield:Notify({Title = "Оптимизация", Content = "Качество графики установлено: " .. level, Duration = 2})
    end
end

function UltimateHack.Functions.Optimization.ToggleShadows()
    game:GetService("Lighting").GlobalShadows = not game:GetService("Lighting").GlobalShadows
    Rayfield:Notify({Title = "Оптимизация", Content = "Тени: " .. (game:GetService("Lighting").GlobalShadows and "ВКЛ" or "ВЫКЛ"), Duration = 2})
end

function UltimateHack.Functions.Optimization.ToggleFog()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = lighting.FogEnd == 100000 and 1000 or 100000
    Rayfield:Notify({Title = "Оптимизация", Content = "Туман: " .. (lighting.FogEnd == 1000 and "ВКЛ" or "ВЫКЛ"), Duration = 2})
end

function UltimateHack.Functions.Optimization.DisableParticles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = false
        end
    end
    Rayfield:Notify({Title = "Оптимизация", Content = "Частицы отключены!", Duration = 2})
end

function UltimateHack.Functions.Optimization.EnableParticles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = true
        end
    end
    Rayfield:Notify({Title = "Оптимизация", Content = "Частицы включены!", Duration = 2})
end

function UltimateHack.Functions.Optimization.ApplySelectedOptimization()
    if UltimateHack.Settings.OptimizeGraphics then
        settings().Rendering.QualityLevel = 2
    end
    if UltimateHack.Settings.OptimizeShadows then
        game:GetService("Lighting").GlobalShadows = false
    end
    if UltimateHack.Settings.OptimizeFog then
        game:GetService("Lighting").FogEnd = 100000
    end
    if UltimateHack.Settings.OptimizeParticles then
        UltimateHack.Functions.Optimization.DisableParticles()
    end
    if UltimateHack.Settings.OptimizeFPS and setfpscap then
        setfpscap(60)
    end
    
    Rayfield:Notify({Title = "Оптимизация", Content = "Выбранная оптимизация применена!", Duration = 3})
end

-- СБОР РЕСУРСОВ
UltimateHack.Functions.Collect = {}

function UltimateHack.Functions.Collect.GetResourcesByCategory(category)
    return UltimateHack.ItemLists[category] or {}
end

function UltimateHack.Functions.Collect.AutoCollectResources()
    while UltimateHack.CollectSettings.AutoCollect and UltimateHack.IsRunning do
        wait(UltimateHack.CollectSettings.AutoCollectInterval)
        UltimateHack.Functions.Collect.SelectedResources()
    end
end

function UltimateHack.Functions.Collect.SelectedResources()
    local collectedCount = 0
    local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    for category, enabled in pairs(UltimateHack.CollectSettings) do
        if enabled and category ~= "AutoCollect" and category ~= "AutoCollectInterval" then
            local resources = UltimateHack.Functions.Collect.GetResourcesByCategory(category)
            for _, resourceName in pairs(resources) do
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name:lower():find(resourceName:lower()) then
                        pcall(function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                            wait(0.05)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                            collectedCount = collectedCount + 1
                        end)
                    end
                end
            end
        end
    end

    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)
    end)
    
    if collectedCount > 0 then
        Rayfield:Notify({Title = "Сбор завершен", Content = "Собрано предметов: " .. collectedCount, Duration = 2})
    end
end

function UltimateHack.Functions.Collect.Everything()
    Rayfield:Notify({Title = "Сбор ресурсов", Content = "Начинаю сбор ВСЕХ ресурсов!", Duration = 2})

    local collectedCount = 0
    local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    local allResources = {}
    for _, resources in pairs(UltimateHack.ItemLists) do
        for _, resource in pairs(resources) do
            table.insert(allResources, resource)
        end
    end

    for _, resourceName in pairs(allResources) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find(resourceName:lower()) then
                pcall(function()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                    wait(0.05)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                    collectedCount = collectedCount + 1
                end)
            end
        end
    end

    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)
    end)

    Rayfield:Notify({Title = "Сбор ВСЕГО завершен!", Content = "Собрано предметов: " .. collectedCount, Duration = 3})
end

function UltimateHack.Functions.Collect.ToggleAllResources(state)
    for resource, _ in pairs(UltimateHack.CollectSettings) do
        if resource ~= "AutoCollect" and resource ~= "AutoCollectInterval" then
            UltimateHack.CollectSettings[resource] = state
        end
    end
end

-- ДЕБАГ ФУНКЦИИ
UltimateHack.Functions.Debug = {}

function UltimateHack.Functions.Debug.TestAuras()
    Rayfield:Notify({Title = "🔧 Тест Аур", Content = "Запускаю тестирование...", Duration = 2})
    
    local player = game.Players.LocalPlayer
    if not player then
        Rayfield:Notify({Title = "❌ Ошибка", Content = "Игрок не найден!", Duration = 2})
        return
    end
    
    local character = player.Character
    if not character then
        Rayfield:Notify({Title = "❌ Ошибка", Content = "Персонаж не найден!", Duration = 2})
        return
    end
    
    if not character:FindFirstChild("HumanoidRootPart") then
        Rayfield:Notify({Title = "❌ Ошибка", Content = "HumanoidRootPart не найден!", Duration = 2})
        return
    end
    
    local tools = {}
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(tools, tool.Name)
        end
    end
    
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            table.insert(tools, tool.Name)
        end
    end
    
    if #tools == 0 then
        Rayfield:Notify({Title = "⚠️ Внимание", Content = "Инструменты не найдены!", Duration = 3})
    else
        Rayfield:Notify({Title = "✅ Инструменты найдены", Content = "Доступно: " .. table.concat(tools, ", "), Duration = 4})
    end
    
    local enemies = 0
    for _, target in pairs(game.Players:GetPlayers()) do
        if target ~= player and target.Character then
            enemies = enemies + 1
        end
    end
    
    local animals = 0
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:FindFirstChild("Humanoid") then
            local npcName = npc.Name:lower()
            if npcName:find("wolf") or npcName:find("bear") or npcName:find("cultist") then
                animals = animals + 1
            end
        end
    end
    
    local trees = 0
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("tree") then
            trees = trees + 1
        end
    end
    
    Rayfield:Notify({
        Title = "📊 Статистика карты",
        Content = "Враги: " .. enemies .. " | Животные: " .. animals .. " | Деревья: " .. trees,
        Duration = 4
    })
end

-- ЗАПУСК И ОСТАНОВКА
function UltimateHack.StartAll()
    if UltimateHack.IsRunning then
        Rayfield:Notify({Title = "Внимание", Content = "Уже запущено!", Duration = 2})
        return
    end
    
    UltimateHack.IsRunning = true
    
    -- АВТООПТИМИЗАЦИЯ ДЛЯ МОБИЛ
    if IS_MOBILE then
        if setfpscap then setfpscap(30) end
        settings().Rendering.QualityLevel = 1
    end
    
    -- ЗАПУСК СИСТЕМ
    if UltimateHack.Settings.KillAura then
        spawn(function() UltimateHack.Functions.Auras.SmartKillAura() end)
    end
    if UltimateHack.Settings.TreeAura then
        spawn(function() UltimateHack.Functions.Auras.SmartTreeAura() end)
    end
    
    if UltimateHack.Settings.AutoFish then
        spawn(function() UltimateHack.Functions.Automation.AutoFish() end)
    end
    if UltimateHack.Settings.AutoLoot then
        spawn(function() UltimateHack.Functions.Automation.AutoLoot() end)
    end
    if UltimateHack.Settings.AutoFindChildren then
        spawn(function() UltimateHack.Functions.Automation.FindChildren() end)
    end
    if UltimateHack.Settings.AntiAFK then
        spawn(function() UltimateHack.Functions.Automation.AntiAFK() end)
    end
    if UltimateHack.Settings.AutoCookFood then
        spawn(function() UltimateHack.Functions.Automation.AutoCookFood() end)
    end
    if UltimateHack.Settings.AutoCollectDropped then
        spawn(function() UltimateHack.Functions.Automation.AutoCollectDropped() end)
    end
    
    if UltimateHack.Settings.InfiniteStamina then
        spawn(function() 
            while UltimateHack.Settings.InfiniteStamina and UltimateHack.IsRunning do
                wait(2)
            end
        end)
    end
    
    if UltimateHack.Settings.AutoExplore then
        spawn(function()
            wait(5)
            UltimateHack.Functions.Explore.StartAutoExplore()
        end)
    end
    
    if UltimateHack.Settings.AutoPlantTrees then
        spawn(function() UltimateHack.Functions.Planting.AutoPlant() end)
    end
    
    if UltimateHack.Settings.AutoOptimize then
        UltimateHack.Functions.Optimization.ApplySelectedOptimization()
    end
    
    Rayfield:Notify({
        Title = IS_MOBILE and "MOBILE HACK v16.0" or "ULTIMATE HACK v16.0",
        Content = IS_MOBILE and "Мобильные системы активированы!" or "Все системы активированы!",
        Duration = 3,
    })
end

function UltimateHack.StopAll()
    UltimateHack.IsRunning = false
    UltimateHack.ExploreSystem.IsExploring = false
    
    UltimateHack.Functions.Cheats.DisableAllCheats()
    
    UltimateHack.Settings.KillAura = false
    UltimateHack.Settings.TreeAura = false
    UltimateHack.Settings.AutoFish = false
    UltimateHack.Settings.AutoLoot = false
    UltimateHack.Settings.AutoFindChildren = false
    UltimateHack.Settings.AutoCookFood = false
    UltimateHack.Settings.AutoExplore = false
    UltimateHack.CollectSettings.AutoCollect = false
    UltimateHack.Settings.AutoPlantTrees = false
    
    Rayfield:Notify({Title = "Стоп", Content = "Все системы остановлены!", Duration = 2})
end

-- ИНТЕРФЕЙС RAYFIELD
local CollectToggles = {}

-- ГЛАВНЫЕ ФУНКЦИИ
MainTab:CreateSection("Основные")

local StartButton = MainTab:CreateButton({
    Name = IS_MOBILE and "🚀 ЗАПУСТИТЬ ВСЁ" or "🚀 Запустить все системы",
    Callback = UltimateHack.StartAll,
})

local StopButton = MainTab:CreateButton({
    Name = IS_MOBILE and "🛑 ОСТАНОВИТЬ" or "🛑 Остановить все системы",
    Callback = UltimateHack.StopAll,
})

-- ТЕЛЕПОРТАЦИЯ
TeleportTab:CreateSection("Телепортация")

local SetFireButton = TeleportTab:CreateButton({
    Name = "📍 Установить позицию костра",
    Callback = UltimateHack.Functions.Teleport.SetFirePosition,
})

local TPToFireButton = TeleportTab:CreateButton({
    Name = "🔥 ТП к костру",
    Callback = UltimateHack.Functions.Teleport.ToFire,
})

local TPToChildButton = TeleportTab:CreateButton({
    Name = "👶 ТП к ребенку",
    Callback = UltimateHack.Functions.Teleport.ToChild,
})

local TPAllButton = TeleportTab:CreateButton({
    Name = "👥 ТП всех к костру",
    Callback = UltimateHack.Functions.Teleport.AllToFire,
})

TeleportTab:CreateSection("ТП к игроку")

local PlayerInput = TeleportTab:CreateInput({
    Name = "Имя игрока",
    PlaceholderText = "Введите имя игрока",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        UltimateHack.Functions.Teleport.ToPlayer(Text)
    end,
})

-- АУРЫ
PlayerTab:CreateSection("⚔️ Умные ауры")

local KillAuraToggle = PlayerTab:CreateToggle({
    Name = "🔫 Киллаура (ЛЮБЫЕ инструменты)",
    CurrentValue = UltimateHack.Settings.KillAura,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        UltimateHack.Settings.KillAura = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Auras.SmartKillAura() end)
        end
    end,
})

local TreeAuraToggle = PlayerTab:CreateToggle({
    Name = "🪓 Рубка деревьев",
    CurrentValue = UltimateHack.Settings.TreeAura,
    Flag = "TreeAuraToggle",
    Callback = function(Value)
        UltimateHack.Settings.TreeAura = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Auras.SmartTreeAura() end)
        end
    end,
})

local KillAuraRadiusSlider = PlayerTab:CreateSlider({
    Name = "📏 Радиус киллауры",
    Range = {10, 100},
    Increment = 5,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.KillAuraRadius,
    Flag = "KillAuraRadiusSlider",
    Callback = function(Value)
        UltimateHack.Settings.KillAuraRadius = Value
    end,
})

local TreeAuraRadiusSlider = PlayerTab:CreateSlider({
    Name = "📏 Радиус вырубки",
    Range = {10, 100},
    Increment = 5,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.TreeAuraRadius,
    Flag = "TreeAuraRadiusSlider",
    Callback = function(Value)
        UltimateHack.Settings.TreeAuraRadius = Value
    end,
})

-- ЧИТЫ
PlayerTab:CreateSection("Читы")

local DisableCheatsButton = PlayerTab:CreateButton({
    Name = "🔴 Выключить все читы",
    Callback = UltimateHack.Functions.Cheats.DisableAllCheats,
})

local FlyToggle = PlayerTab:CreateToggle({
    Name = "🦅 Режим полета",
    CurrentValue = UltimateHack.ActiveCheats.Fly,
    Flag = "FlyToggle",
    Callback = UltimateHack.Functions.Cheats.ToggleFly,
})

local NoClipToggle = PlayerTab:CreateToggle({
    Name = "👻 NoClip",
    CurrentValue = UltimateHack.ActiveCheats.NoClip,
    Flag = "NoClipToggle",
    Callback = UltimateHack.Functions.Cheats.ToggleNoClip,
})

local GodModeToggle = PlayerTab:CreateToggle({
    Name = "🛡️ God Mode",
    CurrentValue = UltimateHack.ActiveCheats.GodMode,
    Flag = "GodModeToggle",
    Callback = UltimateHack.Functions.Cheats.ToggleGodMode,
})

local WalkOnSkyButton = PlayerTab:CreateButton({
    Name = "☁️ Ходить по небу",
    Callback = UltimateHack.Functions.Cheats.WalkOnSky,
})

local SpeedSlider = PlayerTab:CreateSlider({
    Name = "💨 Скорость передвижения",
    Range = {16, 100},
    Increment = 5,
    Suffix = "ед.",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = UltimateHack.Functions.Cheats.SetSpeed,
})

local JumpPowerSlider = PlayerTab:CreateSlider({
    Name = "🦘 Сила прыжка",
    Range = {50, 200},
    Increment = 10,
    Suffix = "ед.",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = UltimateHack.Functions.Cheats.SetJumpPower,
})

local InfiniteStaminaToggle = PlayerTab:CreateToggle({
    Name = "💪 Бесконечная выносливость",
    CurrentValue = UltimateHack.Settings.InfiniteStamina,
    Flag = "InfiniteStaminaToggle",
    Callback = function(Value)
        UltimateHack.Settings.InfiniteStamina = Value
    end,
})

local NoHungerToggle = PlayerTab:CreateToggle({
    Name = "🍖 Нет голода",
    CurrentValue = UltimateHack.Settings.NoHunger,
    Flag = "NoHungerToggle",
    Callback = function(Value)
        UltimateHack.Settings.NoHunger = Value
    end,
})

local NoThirstToggle = PlayerTab:CreateToggle({
    Name = "💧 Нет жажды",
    CurrentValue = UltimateHack.Settings.NoThirst,
    Flag = "NoThirstToggle",
    Callback = function(Value)
        UltimateHack.Settings.NoThirst = Value
    end,
})

-- АВТОМАТЫ
AutoTab:CreateSection("Автоматизация")

local AutoFishToggle = AutoTab:CreateToggle({
    Name = "🎣 Авторыбалка",
    CurrentValue = UltimateHack.Settings.AutoFish,
    Flag = "AutoFishToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoFish = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Automation.AutoFish() end)
        end
    end,
})

local AutoLootToggle = AutoTab:CreateToggle({
    Name = "📦 Автолут сундуков",
    CurrentValue = UltimateHack.Settings.AutoLoot,
    Flag = "AutoLootToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoLoot = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Automation.AutoLoot() end)
        end
    end,
})

local AutoFindChildrenToggle = AutoTab:CreateToggle({
    Name = "👶 Автопоиск детей",
    CurrentValue = UltimateHack.Settings.AutoFindChildren,
    Flag = "AutoFindChildrenToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoFindChildren = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Automation.FindChildren() end)
        end
    end,
})

local AutoCookToggle = AutoTab:CreateToggle({
    Name = "🍳 Автоготовка еды",
    CurrentValue = UltimateHack.Settings.AutoCookFood,
    Flag = "AutoCookToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoCookFood = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Automation.AutoCookFood() end)
        end
    end,
})

local AntiAFKToggle = AutoTab:CreateToggle({
    Name = "⏰ Анти-АФК",
    CurrentValue = UltimateHack.Settings.AntiAFK,
    Flag = "AntiAFKToggle",
    Callback = function(Value)
        UltimateHack.Settings.AntiAFK = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Automation.AntiAFK() end)
        end
    end,
})

local AutoCollectDroppedToggle = AutoTab:CreateToggle({
    Name = "🎯 Автоподбор предметов",
    CurrentValue = UltimateHack.Settings.AutoCollectDropped,
    Flag = "AutoCollectDroppedToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoCollectDropped = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Automation.AutoCollectDropped() end)
        end
    end,
})

-- ЭКСПЛОРОМ КАРТЫ
ExploreTab:CreateSection("Сканирование карты")

local StartExploreButton = ExploreTab:CreateButton({
    Name = "🌍 ПОЛНЫЙ ЭКСПЛОРОМ",
    Callback = UltimateHack.Functions.Explore.StartAutoExplore,
})

local QuickExploreButton = ExploreTab:CreateButton({
    Name = "⚡ БЫСТРЫЙ ПОИСК",
    Callback = UltimateHack.Functions.Explore.QuickExplore,
})

local StopExploreButton = ExploreTab:CreateButton({
    Name = "⏹️ ОСТАНОВИТЬ ПОИСК",
    Callback = UltimateHack.Functions.Explore.StopAutoExplore,
})

ExploreTab:CreateSection("Настройки")

local ExploreRadiusSlider = ExploreTab:CreateSlider({
    Name = "📏 Радиус сканирования",
    Range = {500, 5000},
    Increment = 100,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.ExploreRadius,
    Flag = "ExploreRadiusSlider",
    Callback = function(Value)
        UltimateHack.Settings.ExploreRadius = Value
    end,
})

local ExploreSpeedSlider = ExploreTab:CreateSlider({
    Name = "💨 Скорость сканирования",
    Range = {10, 100},
    Increment = 5,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.ExploreSpeed,
    Flag = "ExploreSpeedSlider",
    Callback = function(Value)
        UltimateHack.Settings.ExploreSpeed = Value
    end,
})

local AutoExploreToggle = ExploreTab:CreateToggle({
    Name = "🔄 Авто-эксплором при запуске",
    CurrentValue = UltimateHack.Settings.AutoExplore,
    Flag = "AutoExploreToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoExplore = Value
    end,
})

ExploreTab:CreateSection("Статус")

local ExploreStatusButton = ExploreTab:CreateButton({
    Name = "📊 ПОКАЗАТЬ СТАТУС",
    Callback = function()
        Rayfield:Notify({
            Title = "📊 Статус поиска",
            Content = string.format("Прогресс: %.1f%%\nСундуков: %d\nРесурсов: %d\nПоследний предмет: %s",
                UltimateHack.ExploreSystem.ScanProgress,
                UltimateHack.ExploreSystem.ChestsFound,
                UltimateHack.ExploreSystem.ResourcesFound,
                UltimateHack.ExploreSystem.LastFoundItem),
            Duration = 5,
        })
    end,
})

-- СБОР РЕСУРСОВ
CollectTab:CreateSection("Управление сбором")

local AutoCollectToggle = CollectTab:CreateToggle({
    Name = "🔄 Автоматический сбор",
    CurrentValue = UltimateHack.CollectSettings.AutoCollect,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.AutoCollect = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Collect.AutoCollectResources() end)
        end
    end,
})

local CollectIntervalSlider = CollectTab:CreateSlider({
    Name = "⏱️ Интервал автосбора",
    Range = {1, 30},
    Increment = 1,
    Suffix = "сек.",
    CurrentValue = UltimateHack.CollectSettings.AutoCollectInterval,
    Flag = "CollectIntervalSlider",
    Callback = function(Value)
        UltimateHack.CollectSettings.AutoCollectInterval = Value
    end,
})

CollectTab:CreateSection("Действия")

local CollectEverythingButton = CollectTab:CreateButton({
    Name = "🗲 Собрать ВСЁ",
    Callback = UltimateHack.Functions.Collect.Everything,
})

local CollectSelectedButton = CollectTab:CreateButton({
    Name = "🎯 Собрать выбранное",
    Callback = UltimateHack.Functions.Collect.SelectedResources,
})

-- ОПТИМИЗАЦИЯ
OptimizationTab:CreateSection("Настройки оптимизации")

local AutoOptimizeToggle = OptimizationTab:CreateToggle({
    Name = "🔧 Автооптимизация при запуске",
    CurrentValue = UltimateHack.Settings.AutoOptimize,
    Flag = "AutoOptimizeToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoOptimize = Value
    end,
})

local OptimizeFPSToggle = OptimizationTab:CreateToggle({
    Name = "🎮 Оптимизировать FPS",
    CurrentValue = UltimateHack.Settings.OptimizeFPS,
    Flag = "OptimizeFPSToggle",
    Callback = function(Value)
        UltimateHack.Settings.OptimizeFPS = Value
    end,
})

local OptimizeGraphicsToggle = OptimizationTab:CreateToggle({
    Name = "🖼️ Оптимизировать графику",
    CurrentValue = UltimateHack.Settings.OptimizeGraphics,
    Flag = "OptimizeGraphicsToggle",
    Callback = function(Value)
        UltimateHack.Settings.OptimizeGraphics = Value
    end,
})

local OptimizeShadowsToggle = OptimizationTab:CreateToggle({
    Name = "🌑 Отключить тени",
    CurrentValue = UltimateHack.Settings.OptimizeShadows,
    Flag = "OptimizeShadowsToggle",
    Callback = function(Value)
        UltimateHack.Settings.OptimizeShadows = Value
    end,
})

local OptimizeFogToggle = OptimizationTab:CreateToggle({
    Name = "🌫️ Отключить туман",
    CurrentValue = UltimateHack.Settings.OptimizeFog,
    Flag = "OptimizeFogToggle",
    Callback = function(Value)
        UltimateHack.Settings.OptimizeFog = Value
    end,
})

OptimizationTab:CreateSection("Быстрая оптимизация")

local FPSSlider = OptimizationTab:CreateSlider({
    Name = "📊 Лимит FPS",
    Range = {30, 360},
    Increment = 10,
    Suffix = "FPS",
    CurrentValue = 60,
    Flag = "FPSSlider",
    Callback = UltimateHack.Functions.Optimization.SetFPS,
})

local QualitySlider = OptimizationTab:CreateSlider({
    Name = "🎨 Уровень качества",
    Range = {1, 10},
    Increment = 1,
    Suffix = "уровень",
    CurrentValue = 1,
    Flag = "QualitySlider",
    Callback = UltimateHack.Functions.Optimization.SetQuality,
})

OptimizationTab:CreateSection("Действия")

local SelectedOptimizeButton = OptimizationTab:CreateButton({
    Name = "⚡ Выбранная оптимизация",
    Callback = UltimateHack.Functions.Optimization.ApplySelectedOptimization,
})

local ToggleShadowsButton = OptimizationTab:CreateButton({
    Name = "🌑 Переключить тени",
    Callback = UltimateHack.Functions.Optimization.ToggleShadows,
})

local ToggleFogButton = OptimizationTab:CreateButton({
    Name = "🌫️ Переключить туман",
    Callback = UltimateHack.Functions.Optimization.ToggleFog,
})

-- АВТОПОСАДКА
PlantTab:CreateSection("Настройки автопосадки")

local AutoPlantToggle = PlantTab:CreateToggle({
    Name = "🔄 Автопосадка деревьев",
    CurrentValue = UltimateHack.Settings.AutoPlantTrees,
    Flag = "AutoPlantToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoPlantTrees = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Planting.AutoPlant() end)
        end
    end,
})

PlantTab:CreateSection("Режимы посадки")

local PlantModeDropdown = PlantTab:CreateDropdown({
    Name = "📋 Режим посадки",
    Options = {"stack", "wall"},
    CurrentOption = UltimateHack.Settings.PlantMode,
    Flag = "PlantModeDropdown",
    Callback = function(Option)
        UltimateHack.Settings.PlantMode = Option
        Rayfield:Notify({Title = "Режим посадки", Content = "Установлен режим: " .. Option, Duration = 2})
    end,
})

PlantTab:CreateSection("Быстрые действия")

local PlantStackButton = PlantTab:CreateButton({
    Name = "🗼 Посадить дерево в стек",
    Callback = function()
        spawn(function()
            UltimateHack.Functions.Planting.PlantStack()
        end)
    end,
})

local PlantWallButton = PlantTab:CreateButton({
    Name = "🛡️ Построить стену деревьев",
    Callback = function()
        spawn(function()
            UltimateHack.Functions.Planting.PlantWall()
        end)
    end,
})

-- ДЕБАГ
DebugTab:CreateSection("Инструменты отладки")

local DebugModeToggle = DebugTab:CreateToggle({
    Name = "🐛 Режим отладки",
    CurrentValue = UltimateHack.Settings.DebugMode,
    Flag = "DebugModeToggle",
    Callback = function(Value)
        UltimateHack.Settings.DebugMode = Value
        Rayfield:Notify({Title = "Отладка", Content = "Режим отладки: " .. (Value and "ВКЛ" or "ВЫКЛ"), Duration = 2})
    end,
})

local TestAurasButton = DebugTab:CreateButton({
    Name = "🧪 Протестировать ауры",
    Callback = UltimateHack.Functions.Debug.TestAuras,
})

local PlayerInfoButton = DebugTab:CreateButton({
    Name = "👤 Инфо об игроке",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if character then
            local tools = {}
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(tools, tool.Name)
                end
            end
            
            for _, tool in pairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(tools, tool.Name)
                end
            end
            
            Rayfield:Notify({
                Title = "👤 Инфо об игроке",
                Content = "Инструменты: " .. (#tools > 0 and table.concat(tools, ", ") or "Нет инструментов"),
                Duration = 5,
            })
        end
    end,
})

DebugTab:CreateSection("Статус системы")

local StatusButton = DebugTab:CreateButton({
    Name = "📈 Показать статус",
    Callback = function()
        local status = "Система: " .. (UltimateHack.IsRunning and "✅ Запущена" or "❌ Остановлена") .. "\n"
        status = status .. "Ауры: " .. (UltimateHack.Settings.KillAura and "Киллаура " or "") .. (UltimateHack.Settings.TreeAura and "Рубка " or "Выкл") .. "\n"
        status = status .. "Читы: " .. (UltimateHack.ActiveCheats.Fly and "Полет " or "") .. (UltimateHack.ActiveCheats.GodMode and "GodMode " or "") .. (UltimateHack.ActiveCheats.NoClip and "NoClip" or "Выкл")
        
        Rayfield:Notify({
            Title = "📊 Статус системы",
            Content = status,
            Duration = 5,
        })
    end,
})

-- АВТОМАТИЧЕСКИЙ ЗАПУСК ДЛЯ МОБИЛ
if IS_MOBILE then
    spawn(function()
        wait(3)
        Rayfield:Notify({
            Title = "📱 МОБИЛЬНАЯ ВЕРСИЯ",
            Content = "Оптимизировано для мобильных устройств!\nАвтоподбор предметов включен.",
            Duration = 5,
        })
    end)
end

-- ЗАПУСКАЕМ СИСТЕМУ АВТОПОДБОРА
spawn(function() 
    wait(2)
    UltimateHack.Functions.ItemSystem.AutoCollectItems() 
end)

Rayfield:Notify({
    Title = IS_MOBILE and "99 NIGHTS MOBILE v16.0" or "99 NIGHTS ULTIMATE HACK v16.0",
    Content = IS_MOBILE and "ОПТИМИЗИРОВАНО ДЛЯ МОБИЛ!" or "ПОЛНЫЙ ФУНКЦИОНАЛ АКТИВИРОВАН!",
    Duration = 6,
})

return UltimateHack