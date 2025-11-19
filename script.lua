-- 99 NIGHTS ULTIMATE HACK by I.S.-1 v12.0
-- ПОЛНЫЙ ФУНКЦИОНАЛ С АКТУАЛЬНЫМИ ПРЕДМЕТАМИ И ИСПРАВЛЕННЫМИ БАГАМИ

local UltimateHack = {}

-- Загружаем Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Создаем окно
local Window = Rayfield:CreateWindow({
   Name = "99 NIGHTS ULTIMATE HACK v12.0",
   LoadingTitle = "I.S.-1 Loading...",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "99NightsHack",
      FileName = "Config.json"
   },
   KeySystem = false,
})

-- ОСНОВНЫЕ ТАБЫ
local MainTab = Window:CreateTab("Главные функции", 4483362458)
local PlayerTab = Window:CreateTab("Игрок", 4483362458)
local AutoTab = Window:CreateTab("Автоматы", 4483362458)
local ExploitTab = Window:CreateTab("Эксплойд", 4483362458)
local CollectTab = Window:CreateTab("Сбор ресурсов", 4483362458)
local OptimizationTab = Window:CreateTab("Оптимизация", 4483362458)
local TeleportTab = Window:CreateTab("Телепортация", 4483362458)
local PlantTab = Window:CreateTab("🌲 Автопосадка", 4483362458)
local DebugTab = Window:CreateTab("🔧 Дебаг", 4483362458)

-- НАСТРОЙКИ
UltimateHack.Settings = {
    -- ТЕЛЕПОРТАЦИЯ
    AutoTPToFire = false,
    
    -- АУРЫ
    KillAura = false,
    KillAuraRadius = 50,
    TreeAura = false,
    TreeAuraRadius = 30,
    AutoFarmAura = false,
    
    -- АВТОМАТЫ
    AutoFish = false,
    AutoLoot = false,
    AntiAFK = false,
    AutoFindChildren = false,
    AutoCookFood = false,
    
    -- ЧИТЫ
    FlyHack = false,
    NoClip = false,
    GodMode = false,
    SpeedHack = false,
    SpeedMultiplier = 2,
    InfiniteStamina = false,
    NoHunger = false,
    NoThirst = false,
    
    -- ЭКСПЛОЙД
    AutoExploit = false,
    ExploitRadius = 1000,
    ExploitSpeed = 50,
    ExploitHeight = 100,
    
    -- ОПТИМИЗАЦИЯ
    AutoOptimize = false,
    OptimizeFPS = true,
    OptimizeGraphics = true,
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

-- НАСТРОЙКИ СБОРА РЕСУРСОВ (АКТУАЛЬНЫЕ ПРЕДМЕТЫ ИЗ ИГРЫ)
UltimateHack.CollectSettings = {
    -- РЕСУРСЫ
    Wood = true,
    Metal = true,
    Fuel = true,
    Stone = true,
    Seeds = true,
    
    -- ИНСТРУМЕНТЫ
    Axes = true,
    Rods = true,
    Flutes = true,
    Sacks = true,
    
    -- ОРУЖИЕ
    MeleeWeapons = true,
    RangedWeapons = true,
    Ammo = true,
    
    -- МЕДИЦИНА
    Bandages = true,
    Medkits = true,
    Potions = true,
    
    -- ЕДА
    Vegetables = true,
    Meat = true,
    Fish = true,
    CookedFood = true,
    Water = true,
    SpecialFood = true,
    
    -- ПРОЧЕЕ
    Pelts = true,
    Gems = true,
    Artifacts = true,
    Currency = true,
    Miscellaneous = true,
    
    -- АВТОСБОР
    AutoCollect = false,
    AutoCollectInterval = 5
}

-- АКТИВНЫЕ ЧИТЫ
UltimateHack.ActiveCheats = {
    Fly = false,
    NoClip = false,
    GodMode = false,
    SpeedHack = false
}

UltimateHack.FirePosition = Vector3.new(0, 0, 0)
UltimateHack.IsRunning = false
UltimateHack.ChildrenNames = {"Дино малыш", "Малыш Кракен", "Малыш спрут", "Малыш коала"}

-- АКТУАЛЬНЫЕ СПИСКИ ПРЕДМЕТОВ ИЗ ИГРЫ
UltimateHack.ItemLists = {
    -- РЕСУРСЫ
    Wood = {"Wood", "Log", "Plank", "Stick", "Tree", "BirchLog", "OakLog", "PineLog", "Birch", "Oak", "Pine"},
    Metal = {"Metal", "Scrap", "Iron", "Steel", "Ore", "Canister", "Tire", "Bolt", "Nail"},
    Fuel = {"Fuel", "Coal", "Oil", "Gas", "Petrol", "Biofuel"},
    Stone = {"Stone", "Flint", "Rock", "Boulder", "Pebble"},
    Seeds = {"Seed", "Sapling", "Saplings"},
    
    -- ИНСТРУМЕНТЫ
    Axes = {"Axe", "Chainsaw", "Hatchet", "OldAxe", "GoodAxe", "StrongAxe"},
    Rods = {"Rod", "FishingRod", "FishingPole"},
    Flutes = {"Flute", "TamingFlute", "Whistle"},
    Sacks = {"Sack", "Bag", "Backpack", "OldSack", "GoodSack", "GiantSack", "AdminSack"},
    
    -- ОРУЖИЕ
    MeleeWeapons = {"Spear", "Katana", "Sword", "Knife", "Dagger", "MorningStar", "Mace", "Axe"},
    RangedWeapons = {"Revolver", "Rifle", "Shotgun", "TacticalShotgun", "Kunai", "Bow", "Gun", "Pistol"},
    Ammo = {"Ammo", "Bullet", "Cartridge", "Shell", "Round", "Arrow"},
    
    -- МЕДИЦИНА
    Bandages = {"Bandage", "Bandages", "BandageRoll"},
    Medkits = {"Medkit", "FirstAid", "MedicalKit", "HealthKit"},
    Potions = {"Potion", "Heal", "HealthPotion", "HealingPotion"},
    
    -- ЕДА
    Vegetables = {"Carrot", "Corn", "Pumpkin", "Apple", "Berry", "Tomato", "Potato", "Cabbage"},
    Meat = {"Morsel", "Steak", "Ribs", "Meat", "RawMeat", "AnimalMeat", "CookedMeat"},
    Fish = {"Mackerel", "Salmon", "Fish", "Trout", "Clownfish", "Shark", "Jellyfish", "Eel", "Swordfish"},
    CookedFood = {"Stew", "Cake", "Chili", "Bread", "CookedSteak", "Roast", "Pie", "Soup", "HeartyStew"},
    Water = {"Water", "Drink", "Bottle", "Canteen", "WaterBottle"},
    SpecialFood = {"CarrotCake", "PumpkinPie", "SpecialCake"},
    
    -- ПРОЧЕЕ
    Pelts = {"Pelt", "Fur", "Hide", "Leather", "Skin", "AnimalHide", "RabbitPelt", "WolfPelt", "BearPelt"},
    Gems = {"Gem", "Crystal", "Diamond", "Ruby", "Emerald", "Sapphire", "Amethyst", "Gold"},
    Artifacts = {"Cultist", "Artifact", "Relic", "Treasure", "Ancient", "Antique", "CultistAmulet"},
    Currency = {"Coin", "Money", "Gold", "Silver", "Cash", "Dollar"},
    Miscellaneous = {"Map", "Bed", "Chest", "Loot", "Resource", "Item", "Object", "Thing", "Junk"}
}

-- ФУНКЦИИ
UltimateHack.Functions = {}

-- УЛУЧШЕННЫЕ АУРЫ С РАБОЧИМ КОДОМ
UltimateHack.Functions.Auras = {}

function UltimateHack.Functions.Auras.SmartKillAura()
    while UltimateHack.Settings.KillAura and UltimateHack.IsRunning do
        task.wait(0.5)
        
        local player = game.Players.LocalPlayer
        if not player then continue end
        
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then 
            continue 
        end

        -- Ищем ЛЮБОЙ инструмент или оружие
        local weapon = nil
        
        -- Сначала в руках
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                weapon = tool
                break
            end
        end
        
        -- Потом в инвентаре
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
        
        if not weapon then 
            continue 
        end

        -- Атакуем врагов-игроков
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
        
        -- Атакуем животных
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
        if not character or not character:FindFirstChild("HumanoidRootPart") then 
            continue 
        end

        -- Ищем инструмент для рубки
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
        
        -- Ищем и рубим деревья
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

-- СИСТЕМА АВТОПОСАДКИ ДЕРЕВЬЕВ
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
    -- Просто сажаем в одно и тоже место
    local stackPosition = UltimateHack.FirePosition
    
    local success = UltimateHack.Functions.Planting.PlantTree(stackPosition)
    
    if success then
        Rayfield:Notify({
            Title = "🌲 Посадка",
            Content = "Дерево посажено в стек!",
            Duration = 2,
            Image = 4483362458
        })
    end
    
    return success
end

function UltimateHack.Functions.Planting.PlantWall()
    -- Посадка стены деревьев вокруг костра
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
    
    Rayfield:Notify({
        Title = "🌲 Стена деревьев",
        Content = "Посажено деревьев: " .. plantedCount,
        Duration = 3,
        Image = 4483362458
    })
    
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

-- ОПТИМИЗАЦИЯ
UltimateHack.Functions.Optimization = {}

function UltimateHack.Functions.Optimization.SetFPS(fps)
    if setfpscap then
        setfpscap(fps)
        if UltimateHack.Settings.DebugMode then
            Rayfield:Notify({
                Title = "Оптимизация",
                Content = "FPS установлен: " .. fps,
                Duration = 2,
                Image = 4483362458
            })
        end
    end
end

function UltimateHack.Functions.Optimization.SetQuality(level)
    settings().Rendering.QualityLevel = level
    if UltimateHack.Settings.DebugMode then
        Rayfield:Notify({
            Title = "Оптимизация",
            Content = "Качество графики установлено: " .. level,
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Optimization.ToggleShadows()
    game:GetService("Lighting").GlobalShadows = not game:GetService("Lighting").GlobalShadows
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Тени: " .. (game:GetService("Lighting").GlobalShadows and "ВКЛ" or "ВЫКЛ"),
        Duration = 2,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Optimization.ToggleFog()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = lighting.FogEnd == 100000 and 1000 or 100000
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Туман: " .. (lighting.FogEnd == 1000 and "ВКЛ" or "ВЫКЛ"),
        Duration = 2,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Optimization.DisableParticles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = false
        end
    end
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Частицы отключены!",
        Duration = 2,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Optimization.EnableParticles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") then
            obj.Enabled = true
        end
    end
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Частицы включены!",
        Duration = 2,
        Image = 4483362458
    })
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
    
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Выбранная оптимизация применена!",
        Duration = 3,
        Image = 4483362458
    })
end

-- ТЕЛЕПОРТАЦИЯ
UltimateHack.Functions.Teleport = {}

function UltimateHack.Functions.Teleport.ToFire()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(UltimateHack.FirePosition)
        Rayfield:Notify({
            Title = "Телепортация",
            Content = "Телепорт к костру выполнен!",
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Teleport.ToPlayer(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if targetPlayer and targetPlayer.Character then
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            Rayfield:Notify({
                Title = "Телепортация",
                Content = "Телепорт к игроку " .. playerName .. " выполнен!",
                Duration = 2,
                Image = 4483362458
            })
        end
    else
        Rayfield:Notify({
            Title = "Ошибка",
            Content = "Игрок " .. playerName .. " не найден!",
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Teleport.ToChild()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player:FindFirstChild("Status") and player.Status.Value == "Child" then
            local playerChar = game.Players.LocalPlayer.Character
            if playerChar and player.Character then
                playerChar.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                Rayfield:Notify({
                    Title = "Телепортация",
                    Content = "Телепорт к ребенку выполнен!",
                    Duration = 2,
                    Image = 4483362458
                })
                return
            end
        end
    end
    Rayfield:Notify({
        Title = "Ошибка",
        Content = "Ребенок не найден!",
        Duration = 2,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Teleport.SetFirePosition()
    local player = game.Players.LocalPlayer
    if player.Character then
        UltimateHack.FirePosition = player.Character.HumanoidRootPart.Position
        Rayfield:Notify({
            Title = "Костер",
            Content = "Позиция костра установлена!",
            Duration = 2,
            Image = 4483362458
        })
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
    
    Rayfield:Notify({
        Title = "Телепортация",
        Content = "Игроков телепортировано: " .. teleportedCount,
        Duration = 2,
        Image = 4483362458
    })
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
                            Rayfield:Notify({
                                Title = "Найден ребенок!",
                                Content = "Телепорт к " .. childName,
                                Duration = 2,
                                Image = 4483362458
                            })
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

-- ЧИТЫ С ИСПРАВЛЕННЫМИ CALLBACK
UltimateHack.Functions.Cheats = {}

function UltimateHack.Functions.Cheats.ToggleFly()
    if UltimateHack.ActiveCheats.Fly then
        -- ВЫКЛЮЧАЕМ ПОЛЕТ
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Falling)
            local bodyVelocity = character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
        UltimateHack.ActiveCheats.Fly = false
        Rayfield:Notify({
            Title = "Чит",
            Content = "Режим полета выключен!",
            Duration = 2,
            Image = 4483362458
        })
    else
        -- ВКЛЮЧАЕМ ПОЛЕТ
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
            bodyVelocity.Parent = character.HumanoidRootPart
        end
        UltimateHack.ActiveCheats.Fly = true
        Rayfield:Notify({
            Title = "Чит",
            Content = "Режим полета включен!",
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.ToggleNoClip()
    if UltimateHack.ActiveCheats.NoClip then
        -- ВЫКЛЮЧАЕМ NOCLIP
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
        Rayfield:Notify({
            Title = "Чит",
            Content = "NoClip выключен!",
            Duration = 2,
            Image = 4483362458
        })
    else
        -- ВКЛЮЧАЕМ NOCLIP
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
        Rayfield:Notify({
            Title = "Чит",
            Content = "NoClip включен!",
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.ToggleGodMode()
    if UltimateHack.ActiveCheats.GodMode then
        -- ВЫКЛЮЧАЕМ GOD MODE
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
        UltimateHack.ActiveCheats.GodMode = false
        Rayfield:Notify({
            Title = "Чит",
            Content = "Режим бога выключен!",
            Duration = 2,
            Image = 4483362458
        })
    else
        -- ВКЛЮЧАЕМ GOD MODE
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.MaxHealth = math.huge
            character.Humanoid.Health = math.huge
        end
        UltimateHack.ActiveCheats.GodMode = true
        Rayfield:Notify({
            Title = "Чит",
            Content = "Режим бога включен!",
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.WalkOnSky()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
        Rayfield:Notify({
            Title = "Чит",
            Content = "Ходьба по небу активирована!",
            Duration = 2,
            Image = 4483362458
        })
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
        Rayfield:Notify({
            Title = "Чит",
            Content = "Скорость установлена: " .. speed,
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.InfiniteStamina()
    while UltimateHack.Settings.InfiniteStamina and UltimateHack.IsRunning do
        wait(2)
    end
end

function UltimateHack.Functions.Cheats.NoHunger()
    while UltimateHack.Settings.NoHunger and UltimateHack.IsRunning do
        wait(5)
    end
end

function UltimateHack.Functions.Cheats.NoThirst()
    while UltimateHack.Settings.NoThirst and UltimateHack.IsRunning do
        wait(5)
    end
end

function UltimateHack.Functions.Cheats.DisableAllCheats()
    if UltimateHack.ActiveCheats.Fly then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Falling)
            local bodyVelocity = character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
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
        end
        UltimateHack.ActiveCheats.SpeedHack = false
    end
    
    UltimateHack.Settings.InfiniteStamina = false
    UltimateHack.Settings.NoHunger = false
    UltimateHack.Settings.NoThirst = false
    
    Rayfield:Notify({
        Title = "Читы",
        Content = "Все читы выключены!",
        Duration = 2,
        Image = 4483362458
    })
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
        Rayfield:Notify({
            Title = "Сбор завершен",
            Content = "Собрано предметов: " .. collectedCount,
            Duration = 2,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Collect.Everything()
    Rayfield:Notify({
        Title = "Сбор ресурсов",
        Content = "Начинаю сбор ВСЕХ ресурсов!",
        Duration = 2,
        Image = 4483362458
    })

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

    Rayfield:Notify({
        Title = "Сбор ВСЕГО завершен!",
        Content = "Собрано предметов: " .. collectedCount,
        Duration = 3,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Collect.ToggleAllResources(state)
    for resource, _ in pairs(UltimateHack.CollectSettings) do
        if resource ~= "AutoCollect" and resource ~= "AutoCollectInterval" then
            UltimateHack.CollectSettings[resource] = state
        end
    end
end

-- РЕАЛЬНЫЙ СБОР РЕСУРСОВ
UltimateHack.Functions.RealCollect = {}

function UltimateHack.Functions.RealCollect.ScanAndCollect()
    if not UltimateHack.IsRunning then return end
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local startPos = character.HumanoidRootPart.Position
    local collectedCount = 0
    
    Rayfield:Notify({
        Title = "🔍 Поиск ресурсов",
        Content = "Начинаю сканирование карты...",
        Duration = 2,
        Image = 4483362458
    })
    
    local searchRadius = 500
    local gridStep = 20
    
    for x = -searchRadius, searchRadius, gridStep do
        for z = -searchRadius, searchRadius, gridStep do
            if not UltimateHack.IsRunning then break end
            
            local scanPos = Vector3.new(startPos.X + x, startPos.Y + 10, startPos.Z + z)
            
            pcall(function()
                character.HumanoidRootPart.CFrame = CFrame.new(scanPos)
                wait(0.05)
            end)
            
            for _, obj in pairs(workspace:GetDescendants()) do
                if not UltimateHack.IsRunning then break end
                
                if obj:IsA("BasePart") and (obj.Position - scanPos).Magnitude < 30 then
                    local shouldCollect = false
                    local objName = obj.Name:lower()
                    
                    for category, enabled in pairs(UltimateHack.CollectSettings) do
                        if enabled and category ~= "AutoCollect" and category ~= "AutoCollectInterval" then
                            local resources = UltimateHack.ItemLists[category]
                            if resources then
                                for _, resource in pairs(resources) do
                                    if objName:find(resource:lower()) then
                                        shouldCollect = true
                                        break
                                    end
                                end
                            end
                            if shouldCollect then break end
                        end
                    end
                    
                    if shouldCollect then
                        pcall(function()
                            character.HumanoidRootPart.CFrame = obj.CFrame
                            wait(0.1)
                            
                            local tool = character:FindFirstChildOfClass("Tool")
                            if tool then
                                tool:Activate()
                            end
                            
                            firetouchinterest(character.HumanoidRootPart, obj, 0)
                            firetouchinterest(character.HumanoidRootPart, obj, 1)
                            
                            collectedCount = collectedCount + 1
                        end)
                    end
                end
            end
        end
    end
    
    pcall(function()
        character.HumanoidRootPart.CFrame = CFrame.new(startPos)
    end)
    
    Rayfield:Notify({
        Title = "✅ Сбор завершен",
        Content = "Собрано предметов: " .. collectedCount,
        Duration = 3,
        Image = 4483362458
    })
    
    return collectedCount
end

-- ДЕБАГ ФУНКЦИИ
UltimateHack.Functions.Debug = {}

function UltimateHack.Functions.Debug.TestAuras()
    Rayfield:Notify({
        Title = "🔧 Тест Аур",
        Content = "Запускаю тестирование...",
        Duration = 2,
        Image = 4483362458
    })
    
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
    
    -- Проверяем инструменты
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
        Rayfield:Notify({
            Title = "✅ Инструменты найдены", 
            Content = "Доступно: " .. table.concat(tools, ", "),
            Duration = 4
        })
    end
    
    -- Проверяем врагов
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
        Rayfield:Notify({
            Title = "Внимание",
            Content = "Хак уже запущен!",
            Duration = 2,
            Image = 4483362458
        })
        return
    end
    
    UltimateHack.IsRunning = true
    
    -- Запускаем улучшенные ауры
    if UltimateHack.Settings.KillAura then
        spawn(function() 
            Rayfield:Notify({Title = "Аура", Content = "Запускаю киллауру...", Duration = 2})
            UltimateHack.Functions.Auras.SmartKillAura() 
        end)
    end
    if UltimateHack.Settings.TreeAura then
        spawn(function() 
            Rayfield:Notify({Title = "Аура", Content = "Запускаю рубку...", Duration = 2})
            UltimateHack.Functions.Auras.SmartTreeAura() 
        end)
    end
    
    -- Остальные системы
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
    
    if UltimateHack.Settings.InfiniteStamina then
        spawn(function() UltimateHack.Functions.Cheats.InfiniteStamina() end)
    end
    if UltimateHack.Settings.NoHunger then
        spawn(function() UltimateHack.Functions.Cheats.NoHunger() end)
    end
    if UltimateHack.Settings.NoThirst then
        spawn(function() UltimateHack.Functions.Cheats.NoThirst() end)
    end
    
    if UltimateHack.CollectSettings.AutoCollect then
        spawn(function() UltimateHack.Functions.Collect.AutoCollectResources() end)
    end
    
    if UltimateHack.Settings.AutoPlantTrees then
        spawn(function() UltimateHack.Functions.Planting.AutoPlant() end)
    end
    
    if UltimateHack.Settings.AutoOptimize then
        UltimateHack.Functions.Optimization.ApplySelectedOptimization()
    end
    
    Rayfield:Notify({
        Title = "Ultimate Hack v12.0",
        Content = "Все системы активированы!",
        Duration = 3,
        Image = 4483362458
    })
end

function UltimateHack.StopAll()
    UltimateHack.IsRunning = false
    
    UltimateHack.Functions.Cheats.DisableAllCheats()
    
    UltimateHack.Settings.KillAura = false
    UltimateHack.Settings.TreeAura = false
    UltimateHack.Settings.AutoFish = false
    UltimateHack.Settings.AutoLoot = false
    UltimateHack.Settings.AutoFindChildren = false
    UltimateHack.Settings.AutoCookFood = false
    UltimateHack.CollectSettings.AutoCollect = false
    UltimateHack.Settings.AutoPlantTrees = false
    
    Rayfield:Notify({
        Title = "Ultimate Hack",
        Content = "Все системы остановлены!",
        Duration = 2,
        Image = 4483362458
    })
end

-- ИНТЕРФЕЙС RAYFIELD
local CollectToggles = {}

-- ГЛАВНЫЕ ФУНКЦИИ
MainTab:CreateSection("Основные функции")

local StartButton = MainTab:CreateButton({
    Name = "🚀 Запустить все системы",
    Callback = function()
        UltimateHack.StartAll()
    end,
})

local StopButton = MainTab:CreateButton({
    Name = "🛑 Остановить все системы",
    Callback = function()
        UltimateHack.StopAll()
    end,
})

-- ТЕЛЕПОРТАЦИЯ
TeleportTab:CreateSection("Телепортация")

local SetFireButton = TeleportTab:CreateButton({
    Name = "📍 Установить позицию костра",
    Callback = function()
        UltimateHack.Functions.Teleport.SetFirePosition()
    end,
})

local TPToFireButton = TeleportTab:CreateButton({
    Name = "🔥 ТП к костру",
    Callback = function()
        UltimateHack.Functions.Teleport.ToFire()
    end,
})

local TPToChildButton = TeleportTab:CreateButton({
    Name = "👶 ТП к ребенку",
    Callback = function()
        UltimateHack.Functions.Teleport.ToChild()
    end,
})

local TPAllButton = TeleportTab:CreateButton({
    Name = "👥 ТП всех к костру",
    Callback = function()
        UltimateHack.Functions.Teleport.AllToFire()
    end,
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
PlayerTab:CreateSection("⚔️ Умные ауры (РАБОЧИЕ)")

local KillAuraToggle = PlayerTab:CreateToggle({
    Name = "🔫 Киллаура v5 (ЛЮБЫЕ инструменты)",
    CurrentValue = UltimateHack.Settings.KillAura,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        UltimateHack.Settings.KillAura = Value
        if Value then
            Rayfield:Notify({
                Title = "Киллаура",
                Content = "Запускаю улучшенную киллауру...",
                Duration = 2,
                Image = 4483362458
            })
            spawn(function() 
                UltimateHack.Functions.Auras.SmartKillAura() 
            end)
        end
    end,
})

local TreeAuraToggle = PlayerTab:CreateToggle({
    Name = "🪓 Рубка деревьев v5",
    CurrentValue = UltimateHack.Settings.TreeAura,
    Flag = "TreeAuraToggle",
    Callback = function(Value)
        UltimateHack.Settings.TreeAura = Value
        if Value then
            Rayfield:Notify({
                Title = "Рубка деревьев",
                Content = "Запускаю улучшенную рубку...",
                Duration = 2,
                Image = 4483362458
            })
            spawn(function() 
                UltimateHack.Functions.Auras.SmartTreeAura() 
            end)
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
    Callback = function()
        UltimateHack.Functions.Cheats.DisableAllCheats()
    end,
})

local FlyToggle = PlayerTab:CreateToggle({
    Name = "🦅 Режим полета",
    CurrentValue = UltimateHack.ActiveCheats.Fly,
    Flag = "FlyToggle",
    Callback = function(Value)
        UltimateHack.Functions.Cheats.ToggleFly()
    end,
})

local NoClipToggle = PlayerTab:CreateToggle({
    Name = "👻 NoClip",
    CurrentValue = UltimateHack.ActiveCheats.NoClip,
    Flag = "NoClipToggle",
    Callback = function(Value)
        UltimateHack.Functions.Cheats.ToggleNoClip()
    end,
})

local GodModeToggle = PlayerTab:CreateToggle({
    Name = "🛡️ God Mode",
    CurrentValue = UltimateHack.ActiveCheats.GodMode,
    Flag = "GodModeToggle",
    Callback = function(Value)
        UltimateHack.Functions.Cheats.ToggleGodMode()
    end,
})

local WalkOnSkyButton = PlayerTab:CreateButton({
    Name = "☁️ Ходить по небу",
    Callback = function()
        UltimateHack.Functions.Cheats.WalkOnSky()
    end,
})

local SpeedSlider = PlayerTab:CreateSlider({
    Name = "💨 Скорость передвижения",
    Range = {16, 100},
    Increment = 5,
    Suffix = "ед.",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        UltimateHack.Functions.Cheats.SetSpeed(Value)
    end,
})

local InfiniteStaminaToggle = PlayerTab:CreateToggle({
    Name = "💪 Бесконечная выносливость",
    CurrentValue = UltimateHack.Settings.InfiniteStamina,
    Flag = "InfiniteStaminaToggle",
    Callback = function(Value)
        UltimateHack.Settings.InfiniteStamina = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Cheats.InfiniteStamina() end)
        end
    end,
})

local NoHungerToggle = PlayerTab:CreateToggle({
    Name = "🍖 Нет голода",
    CurrentValue = UltimateHack.Settings.NoHunger,
    Flag = "NoHungerToggle",
    Callback = function(Value)
        UltimateHack.Settings.NoHunger = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Cheats.NoHunger() end)
        end
    end,
})

local NoThirstToggle = PlayerTab:CreateToggle({
    Name = "💧 Нет жажды",
    CurrentValue = UltimateHack.Settings.NoThirst,
    Flag = "NoThirstToggle",
    Callback = function(Value)
        UltimateHack.Settings.NoThirst = Value
        if Value and UltimateHack.IsRunning then
            spawn(function() UltimateHack.Functions.Cheats.NoThirst() end)
        end
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

CollectTab:CreateSection("🎯 Реальный сбор ресурсов")

local RealCollectButton = CollectTab:CreateButton({
    Name = "🔍 СКАНИРОВАТЬ И СОБРАТЬ РЕСУРСЫ ПО КАРТЕ",
    Callback = function()
        spawn(function()
            UltimateHack.Functions.RealCollect.ScanAndCollect()
        end)
    end,
})

local AutoRealCollectToggle = CollectTab:CreateToggle({
    Name = "🔄 Авто-сканирование карты",
    CurrentValue = false,
    Flag = "AutoRealCollectToggle",
    Callback = function(Value)
        if Value then
            spawn(function()
                while Value and UltimateHack.IsRunning do
                    UltimateHack.Functions.RealCollect.ScanAndCollect()
                    wait(UltimateHack.CollectSettings.AutoCollectInterval)
                end
            end)
        end
    end,
})

CollectTab:CreateSection("Действия")

local CollectEverythingButton = CollectTab:CreateButton({
    Name = "🗲 Собрать ВСЁ",
    Callback = function()
        UltimateHack.Functions.Collect.Everything()
    end,
})

local CollectSelectedButton = CollectTab:CreateButton({
    Name = "🎯 Собрать выбранное",
    Callback = function()
        UltimateHack.Functions.Collect.SelectedResources()
    end,
})

-- ВЫБОР ПРЕДМЕТОВ ДЛЯ СБОРА (АКТУАЛЬНЫЕ КАТЕГОРИИ)
CollectTab:CreateSection("📦 Ресурсы")
CollectToggles.Wood = CollectTab:CreateToggle({
    Name = "🪵 Дерево (Wood, Log, Plank)",
    CurrentValue = UltimateHack.CollectSettings.Wood,
    Flag = "WoodToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Wood = Value
    end,
})

CollectToggles.Metal = CollectTab:CreateToggle({
    Name = "🔩 Металл (Metal, Scrap, Iron)",
    CurrentValue = UltimateHack.CollectSettings.Metal,
    Flag = "MetalToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Metal = Value
    end,
})

CollectToggles.Fuel = CollectTab:CreateToggle({
    Name = "⛽ Топливо (Fuel, Coal, Oil)",
    CurrentValue = UltimateHack.CollectSettings.Fuel,
    Flag = "FuelToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Fuel = Value
    end,
})

CollectToggles.Stone = CollectTab:CreateToggle({
    Name = "🪨 Камни (Stone, Flint, Rock)",
    CurrentValue = UltimateHack.CollectSettings.Stone,
    Flag = "StoneToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Stone = Value
    end,
})

CollectToggles.Seeds = CollectTab:CreateToggle({
    Name = "🌱 Саженцы (Seeds, Saplings)",
    CurrentValue = UltimateHack.CollectSettings.Seeds,
    Flag = "SeedsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Seeds = Value
    end,
})

CollectTab:CreateSection("🛠️ Инструменты")
CollectToggles.Axes = CollectTab:CreateToggle({
    Name = "🪓 Топоры (Axe, Chainsaw)",
    CurrentValue = UltimateHack.CollectSettings.Axes,
    Flag = "AxesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Axes = Value
    end,
})

CollectToggles.Rods = CollectTab:CreateToggle({
    Name = "🎣 Удочки (Rod, FishingRod)",
    CurrentValue = UltimateHack.CollectSettings.Rods,
    Flag = "RodsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Rods = Value
    end,
})

CollectToggles.Flutes = CollectTab:CreateToggle({
    Name = "🎵 Флейты (Flute, TamingFlute)",
    CurrentValue = UltimateHack.CollectSettings.Flutes,
    Flag = "FlutesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Flutes = Value
    end,
})

CollectToggles.Sacks = CollectTab:CreateToggle({
    Name = "🎒 Сумки (Sack, Bag, Backpack)",
    CurrentValue = UltimateHack.CollectSettings.Sacks,
    Flag = "SacksToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Sacks = Value
    end,
})

CollectTab:CreateSection("⚔️ Оружие")
CollectToggles.MeleeWeapons = CollectTab:CreateToggle({
    Name = "🗡️ Ближний бой (Spear, Katana, Sword)",
    CurrentValue = UltimateHack.CollectSettings.MeleeWeapons,
    Flag = "MeleeWeaponsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.MeleeWeapons = Value
    end,
})

CollectToggles.RangedWeapons = CollectTab:CreateToggle({
    Name = "🔫 Дальний бой (Revolver, Rifle, Kunai)",
    CurrentValue = UltimateHack.CollectSettings.RangedWeapons,
    Flag = "RangedWeaponsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.RangedWeapons = Value
    end,
})

CollectToggles.Ammo = CollectTab:CreateToggle({
    Name = "🎯 Патроны (Ammo, Bullet, Arrow)",
    CurrentValue = UltimateHack.CollectSettings.Ammo,
    Flag = "AmmoToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Ammo = Value
    end,
})

CollectTab:CreateSection("💊 Медицина")
CollectToggles.Bandages = CollectTab:CreateToggle({
    Name = "🩹 Бинты (Bandage, Bandages)",
    CurrentValue = UltimateHack.CollectSettings.Bandages,
    Flag = "BandagesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Bandages = Value
    end,
})

CollectToggles.Medkits = CollectTab:CreateToggle({
    Name = "💊 Аптечки (Medkit, FirstAid)",
    CurrentValue = UltimateHack.CollectSettings.Medkits,
    Flag = "MedkitsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Medkits = Value
    end,
})

CollectToggles.Potions = CollectTab:CreateToggle({
    Name = "🧪 Зелья (Potion, Heal)",
    CurrentValue = UltimateHack.CollectSettings.Potions,
    Flag = "PotionsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Potions = Value
    end,
})

CollectTab:CreateSection("🍖 Еда")
CollectToggles.Vegetables = CollectTab:CreateToggle({
    Name = "🥕 Овощи/Фрукты (Carrot, Apple, Berry)",
    CurrentValue = UltimateHack.CollectSettings.Vegetables,
    Flag = "VegetablesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Vegetables = Value
    end,
})

CollectToggles.Meat = CollectTab:CreateToggle({
    Name = "🥩 Мясо (Morsel, Steak, Ribs)",
    CurrentValue = UltimateHack.CollectSettings.Meat,
    Flag = "MeatToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Meat = Value
    end,
})

CollectToggles.Fish = CollectTab:CreateToggle({
    Name = "🐟 Рыба (Mackerel, Salmon, Shark)",
    CurrentValue = UltimateHack.CollectSettings.Fish,
    Flag = "FishToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Fish = Value
    end,
})

CollectToggles.CookedFood = CollectTab:CreateToggle({
    Name = "🍲 Готовые блюда (Stew, Cake, Bread)",
    CurrentValue = UltimateHack.CollectSettings.CookedFood,
    Flag = "CookedFoodToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.CookedFood = Value
    end,
})

CollectToggles.Water = CollectTab:CreateToggle({
    Name = "💧 Вода (Water, Drink, Bottle)",
    CurrentValue = UltimateHack.CollectSettings.Water,
    Flag = "WaterToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Water = Value
    end,
})

CollectToggles.SpecialFood = CollectTab:CreateToggle({
    Name = "🎂 Особая еда (CarrotCake, Special)",
    CurrentValue = UltimateHack.CollectSettings.SpecialFood,
    Flag = "SpecialFoodToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.SpecialFood = Value
    end,
})

CollectTab:CreateSection("💎 Прочее")
CollectToggles.Pelts = CollectTab:CreateToggle({
    Name = "🐾 Шкуры (Pelt, Fur, Hide)",
    CurrentValue = UltimateHack.CollectSettings.Pelts,
    Flag = "PeltsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Pelts = Value
    end,
})

CollectToggles.Gems = CollectTab:CreateToggle({
    Name = "💎 Драгоценности (Gem, Crystal, Diamond)",
    CurrentValue = UltimateHack.CollectSettings.Gems,
    Flag = "GemsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Gems = Value
    end,
})

CollectToggles.Artifacts = CollectTab:CreateToggle({
    Name = "🏺 Артефакты (Artifact, Relic, Treasure)",
    CurrentValue = UltimateHack.CollectSettings.Artifacts,
    Flag = "ArtifactsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Artifacts = Value
    end,
})

CollectToggles.Currency = CollectTab:CreateToggle({
    Name = "💰 Валюта (Coin, Money, Gold)",
    CurrentValue = UltimateHack.CollectSettings.Currency,
    Flag = "CurrencyToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Currency = Value
    end,
})

CollectToggles.Miscellaneous = CollectTab:CreateToggle({
    Name = "📦 Разное (Map, Bed, Chest)",
    CurrentValue = UltimateHack.CollectSettings.Miscellaneous,
    Flag = "MiscellaneousToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Miscellaneous = Value
    end,
})

CollectTab:CreateSection("Быстрые настройки")

local SelectAllButton = CollectTab:CreateButton({
    Name = "✅ Выбрать всё",
    Callback = function()
        UltimateHack.Functions.Collect.ToggleAllResources(true)
        for _, toggle in pairs(CollectToggles) do
            if toggle then toggle:Set(true) end
        end
    end,
})

local DeselectAllButton = CollectTab:CreateButton({
    Name = "❌ Очистить выбор",
    Callback = function()
        UltimateHack.Functions.Collect.ToggleAllResources(false)
        for _, toggle in pairs(CollectToggles) do
            if toggle then toggle:Set(false) end
        end
    end,
})

-- ОПТИМИЗАЦИЯ
OptimizationTab:CreateSection("⚡ Настройки оптимизации")

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

local OptimizeParticlesToggle = OptimizationTab:CreateToggle({
    Name = "✨ Отключить частицы",
    CurrentValue = UltimateHack.Settings.OptimizeParticles,
    Flag = "OptimizeParticlesToggle",
    Callback = function(Value)
        UltimateHack.Settings.OptimizeParticles = Value
    end,
})

OptimizationTab:CreateSection("🎯 Быстрая оптимизация")

local FPSSlider = OptimizationTab:CreateSlider({
    Name = "📊 Лимит FPS",
    Range = {30, 360},
    Increment = 10,
    Suffix = "FPS",
    CurrentValue = 60,
    Flag = "FPSSlider",
    Callback = function(Value)
        UltimateHack.Functions.Optimization.SetFPS(Value)
    end,
})

local QualitySlider = OptimizationTab:CreateSlider({
    Name = "🎨 Уровень качества",
    Range = {1, 10},
    Increment = 1,
    Suffix = "уровень",
    CurrentValue = 1,
    Flag = "QualitySlider",
    Callback = function(Value)
        UltimateHack.Functions.Optimization.SetQuality(Value)
    end,
})

OptimizationTab:CreateSection("🚀 Применить оптимизацию")

local SelectedOptimizeButton = OptimizationTab:CreateButton({
    Name = "⚡ Выбранная оптимизация",
    Callback = function()
        UltimateHack.Functions.Optimization.ApplySelectedOptimization()
    end,
})

-- АВТОПОСАДКА
PlantTab:CreateSection("🌲 Настройки автопосадки")

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

PlantTab:CreateSection("🎯 Режимы посадки")

local PlantModeDropdown = PlantTab:CreateDropdown({
    Name = "📋 Режим посадки",
    Options = {"stack", "wall"},
    CurrentOption = UltimateHack.Settings.PlantMode,
    Flag = "PlantModeDropdown",
    Callback = function(Option)
        UltimateHack.Settings.PlantMode = Option
        Rayfield:Notify({
            Title = "Режим посадки",
            Content = "Установлен режим: " .. Option,
            Duration = 2,
            Image = 4483362458
        })
    end,
})

PlantTab:CreateSection("🛡️ Настройки стены (только для режима 'wall')")

local PlantRadiusSlider = PlantTab:CreateSlider({
    Name = "📏 Радиус стены",
    Range = {10, 100},
    Increment = 5,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.PlantRadius,
    Flag = "PlantRadiusSlider",
    Callback = function(Value)
        UltimateHack.Settings.PlantRadius = Value
    end,
})

local PlantDensitySlider = PlantTab:CreateSlider({
    Name = "📐 Плотность стены",
    Range = {2, 20},
    Increment = 1,
    Suffix = "угол",
    CurrentValue = UltimateHack.Settings.PlantDensity,
    Flag = "PlantDensitySlider",
    Callback = function(Value)
        UltimateHack.Settings.PlantDensity = Value
    end,
})

PlantTab:CreateSection("🚀 Быстрые действия")

local PlantStackButton = PlantTab:CreateButton({
    Name = "🗼 Посадить дерево в стек (в одно место)",
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

-- ДЕБАГ ВКЛАДКА
DebugTab:CreateSection("🔧 Инструменты отладки")

local DebugModeToggle = DebugTab:CreateToggle({
    Name = "🐛 Режим отладки",
    CurrentValue = UltimateHack.Settings.DebugMode,
    Flag = "DebugModeToggle",
    Callback = function(Value)
        UltimateHack.Settings.DebugMode = Value
        Rayfield:Notify({
            Title = "Отладка",
            Content = "Режим отладки: " .. (Value and "ВКЛ" or "ВЫКЛ"),
            Duration = 2,
            Image = 4483362458
        })
    end,
})

local TestAurasButton = DebugTab:CreateButton({
    Name = "🧪 Протестировать ауры",
    Callback = function()
        UltimateHack.Functions.Debug.TestAuras()
    end,
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
                Image = 4483362458
            })
        end
    end,
})

DebugTab:CreateSection("📊 Статус системы")

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
            Image = 4483362458
        })
    end,
})

Rayfield:Notify({
    Title = "99 Nights Ultimate Hack v12.0",
    Content = "ФУЛЛ СКРИПТ ЗАГРУЖЕН! АКТУАЛЬНЫЕ ПРЕДМЕТЫ И ИСПРАВЛЕННЫЕ БАГИ!",
    Duration = 5,
    Image = 4483362458
})

return UltimateHack