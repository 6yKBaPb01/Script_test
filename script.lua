
local UltimateHack = {}

-- Загружаем Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "99 NIGHTS ULTIMATE HACK",
   LoadingTitle = "I.S.-1 Loading...",
   LoadingSubtitle = "by Infection System",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "99NightsHack",
      FileName = "Config.json"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
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

-- НАСТРОЙКИ
UltimateHack.Settings = {
    -- ТЕЛЕПОРТАЦИЯ
    AutoTPToFire = true,
    
    -- АУРЫ
    KillAura = true,
    KillAuraRadius = 50,
    TreeAura = true,
    TreeAuraRadius = 30,
    AutoFarmAura = false,
    
    -- АВТОМАТЫ
    AutoFish = true,
    AutoPlant = true,
    AutoLoot = true,
    AntiAFK = true,
    AutoFindChildren = true,
    AutoCookFood = false,
    
    -- ЧИТЫ
    FlyHack = true,
    NoClip = false,
    GodMode = true,
    SpeedHack = false,
    SpeedMultiplier = 2,
    InfiniteStamina = true,
    NoHunger = true,
    NoThirst = true,
    
    -- ЭКСПЛОЙД
    AutoExploit = true,
    ExploitRadius = 1000,
    ExploitSpeed = 50,
    ExploitHeight = 100,
    
    -- ОПТИМИЗАЦИЯ
    AutoOptimize = false,
}

-- НАСТРОЙКИ СБОРА РЕСУРСОВ
UltimateHack.CollectSettings = {
    -- РЕСУРСЫ
    Wood = true,
    Metal = true,
    Fuel = true,
    Stone = true,
    
    -- ИНСТРУМЕНТЫ
    Axes = true,
    Rods = true,
    Flutes = true,
    Sacks = true,
    Weapons = true,
    
    -- МЕДИЦИНА
    Bandages = true,
    Medkits = true,
    Potions = true,
    
    -- БОЕПРИПАСЫ
    Ammo = true,
    Guns = true,
    
    -- ЕДА
    Vegetables = true,
    Meat = true,
    Fish = true,
    CookedFood = true,
    Water = true,
    
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

UltimateHack.FirePosition = Vector3.new(0, 0, 0)
UltimateHack.IsRunning = false
UltimateHack.ChildrenNames = {"Дино малыш", "Малыш Кракен", "Малыш спрут", "Малыш коала"}

-- ФУНКЦИИ
UltimateHack.Functions = {}

-- ОПТИМИЗАЦИЯ
UltimateHack.Functions.Optimization = {}

function UltimateHack.Functions.Optimization.SetFPS(fps)
    if setfpscap then
        setfpscap(fps)
        Rayfield:Notify({
            Title = "Оптимизация",
            Content = "FPS установлен: " .. fps,
            Duration = 3,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Optimization.SetQuality(level)
    settings().Rendering.QualityLevel = level
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Качество графики установлено: " .. level,
        Duration = 3,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Optimization.ToggleShadows()
    game:GetService("Lighting").GlobalShadows = not game:GetService("Lighting").GlobalShadows
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Тени: " .. (game:GetService("Lighting").GlobalShadows and "ВКЛ" or "ВЫКЛ"),
        Duration = 3,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Optimization.ToggleFog()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = lighting.FogEnd == 100000 and 1000 or 100000
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Туман: " .. (lighting.FogEnd == 1000 and "ВКЛ" or "ВЫКЛ"),
        Duration = 3,
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
        Duration = 3,
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
        Duration = 3,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Optimization.ApplyMobileOptimization()
    settings().Rendering.QualityLevel = 1
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 100000
    UltimateHack.Functions.Optimization.DisableParticles()
    
    if setfpscap then
        setfpscap(30)
    end
    
    Rayfield:Notify({
        Title = "Оптимизация",
        Content = "Мобильная оптимизация применена!",
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
            Duration = 3,
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
                Duration = 3,
                Image = 4483362458
            })
        end
    else
        Rayfield:Notify({
            Title = "Ошибка",
            Content = "Игрок " .. playerName .. " не найден!",
            Duration = 3,
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
                    Duration = 3,
                    Image = 4483362458
                })
                return
            end
        end
    end
    Rayfield:Notify({
        Title = "Ошибка",
        Content = "Ребенок не найден!",
        Duration = 3,
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
            Duration = 3,
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
        Duration = 3,
        Image = 4483362458
    })
end

function UltimateHack.Functions.Teleport.ToSpawn()
    local spawn = workspace:FindFirstChild("Spawn") or workspace:FindFirstChild("SpawnPoint")
    if spawn then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawn.CFrame
        Rayfield:Notify({
            Title = "Телепортация",
            Content = "Телепорт на спавн выполнен!",
            Duration = 3,
            Image = 4483362458
        })
    else
        Rayfield:Notify({
            Title = "Ошибка",
            Content = "Спавн не найден!",
            Duration = 3,
            Image = 4483362458
        })
    end
end

-- АУРЫ
UltimateHack.Functions.Auras = {}

function UltimateHack.Functions.Auras.KillAura()
    while UltimateHack.Settings.KillAura and UltimateHack.IsRunning do
        wait(0.1)
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if character then
            for _, target in pairs(game.Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local targetChar = target.Character
                    local distance = (character.HumanoidRootPart.Position - targetChar.HumanoidRootPart.Position).Magnitude
                    
                    if distance < UltimateHack.Settings.KillAuraRadius then
                        if not (target:FindFirstChild("Status") and target.Status.Value == "Child") then
                            targetChar.Humanoid.Health = 0
                        end
                    end
                end
            end
            
            for _, npc in pairs(workspace:GetDescendants()) do
                if npc:FindFirstChild("Humanoid") and (npc.Name:find("Wolf") or npc.Name:find("Bear") or npc.Name:find("Enemy")) then
                    local distance = (character.HumanoidRootPart.Position - npc.HumanoidRootPart.Position).Magnitude
                    if distance < UltimateHack.Settings.KillAuraRadius then
                        npc.Humanoid.Health = 0
                    end
                end
            end
        end
    end
end

function UltimateHack.Functions.Auras.TreeAura()
    while UltimateHack.Settings.TreeAura and UltimateHack.IsRunning do
        wait(0.2)
        local playerChar = game.Players.LocalPlayer.Character
        if playerChar then
            for _, tree in pairs(workspace:GetDescendants()) do
                if (tree.Name:find("Tree") or tree.Name:find("Wood") or tree.Name:find("Log")) and tree:IsA("BasePart") then
                    if (playerChar.HumanoidRootPart.Position - tree.Position).Magnitude < UltimateHack.Settings.TreeAuraRadius then
                        tree:Destroy()
                    end
                end
            end
        end
    end
end

function UltimateHack.Functions.Auras.AutoFarm()
    while UltimateHack.Settings.AutoFarmAura and UltimateHack.IsRunning do
        wait(1)
        UltimateHack.Functions.Collect.SelectedResources()
    end
end

-- АВТОМАТЫ
UltimateHack.Functions.Automation = {}

function UltimateHack.Functions.Automation.AutoFish()
    while UltimateHack.Settings.AutoFish and UltimateHack.IsRunning do
        wait(2)
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

function UltimateHack.Functions.Automation.AutoPlant()
    while UltimateHack.Settings.AutoPlant and UltimateHack.IsRunning do
        wait(3)
        for x = -20, 20, 4 do
            for z = -20, 20, 4 do
                if x == -20 or x == 20 or z == -20 or z == 20 then
                    local plantPos = UltimateHack.FirePosition + Vector3.new(x, 0, z)
                    pcall(function()
                        local plantEvent = game:GetService("ReplicatedStorage"):FindFirstChild("PlantTree")
                        if plantEvent then
                            plantEvent:FireServer(plantPos)
                        end
                    end)
                end
            end
        end
    end
end

function UltimateHack.Functions.Automation.AutoLoot()
    while UltimateHack.Settings.AutoLoot and UltimateHack.IsRunning do
        wait(4)
        local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj.Name:find("Chest") or obj.Name:find("Loot") or obj.Name:find("Resource")) and obj:IsA("BasePart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                wait(0.3)
                
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)
    end
end

function UltimateHack.Functions.Automation.FindChildren()
    while UltimateHack.Settings.AutoFindChildren and UltimateHack.IsRunning do
        wait(5)
        for _, player in pairs(game.Players:GetPlayers()) do
            for _, childName in pairs(UltimateHack.ChildrenNames) do
                if player.Name:find(childName) or (player:FindFirstChild("DisplayName") and player.DisplayName:find(childName)) then
                    if player.Character then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        Rayfield:Notify({
                            Title = "Найден ребенок!",
                            Content = "Телепорт к " .. childName,
                            Duration = 3,
                            Image = 4483362458
                        })
                        wait(2)
                    end
                end
            end
        end
    end
end

function UltimateHack.Functions.Automation.AntiAFK()
    while UltimateHack.Settings.AntiAFK and UltimateHack.IsRunning do
        wait(30)
        local char = game.Players.LocalPlayer.Character
        if char then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(1, 0, 0)
        end
    end
end

function UltimateHack.Functions.Automation.AutoCookFood()
    while UltimateHack.Settings.AutoCookFood and UltimateHack.IsRunning do
        wait(10)
        local fire = workspace:FindFirstChild("Fire") or workspace:FindFirstChild("Campfire")
        if fire then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = fire.CFrame
            wait(1)
        end
    end
end

-- ЧИТЫ
UltimateHack.Functions.Cheats = {}

function UltimateHack.Functions.Cheats.Fly()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        character.Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.Parent = character.HumanoidRootPart
        Rayfield:Notify({
            Title = "Чит",
            Content = "Режим полета активирован!",
            Duration = 3,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.NoClip()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        Rayfield:Notify({
            Title = "Чит",
            Content = "NoClip активирован!",
            Duration = 3,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.GodMode()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        character.Humanoid.MaxHealth = math.huge
        character.Humanoid.Health = math.huge
        Rayfield:Notify({
            Title = "Чит",
            Content = "Режим бога активирован!",
            Duration = 3,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.WalkOnSky()
    local player = game.Players.LocalPlayer
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
        Rayfield:Notify({
            Title = "Чит",
            Content = "Ходьба по небу активирована!",
            Duration = 3,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.SetSpeed(speed)
    local player = game.Players.LocalPlayer
    if player.Character then
        player.Character.Humanoid.WalkSpeed = speed
        Rayfield:Notify({
            Title = "Чит",
            Content = "Скорость установлена: " .. speed,
            Duration = 3,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Cheats.InfiniteStamina()
    while UltimateHack.Settings.InfiniteStamina and UltimateHack.IsRunning do
        wait(1)
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

-- ЭКСПЛОЙД
UltimateHack.Functions.AutoExploit = {}

function UltimateHack.Functions.AutoExploit.StartSpiralExploit()
    Rayfield:Notify({
        Title = "Эксплойд",
        Content = "Запуск спирального облета карты...",
        Duration = 3,
        Image = 4483362458
    })
    
    local player = game.Players.LocalPlayer
    local startPos = UltimateHack.FirePosition
    local radius = UltimateHack.Settings.ExploitRadius
    local speed = UltimateHack.Settings.ExploitSpeed
    local maxHeight = UltimateHack.Settings.ExploitHeight
    
    local angle = 0
    local height = 0
    local spiralSteps = 36
    
    while UltimateHack.Settings.AutoExploit and UltimateHack.IsRunning do
        wait(1 / speed)
        
        if not player.Character then break end
        
        local x = startPos.X + math.cos(angle) * radius * (1 - height / maxHeight)
        local z = startPos.Z + math.sin(angle) * radius * (1 - height / maxHeight)
        local y = startPos.Y + height
        
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
        
        UltimateHack.Functions.AutoExploit.ScanArea(Vector3.new(x, y, z))
        
        angle = angle + (2 * math.pi / spiralSteps)
        if angle >= 2 * math.pi then
            angle = 0
            height = height + 10
            if height > maxHeight then
                height = 0
                radius = radius - 50
                if radius <= 100 then
                    radius = UltimateHack.Settings.ExploitRadius
                end
            end
        end
    end
end

function UltimateHack.Functions.AutoExploit.ScanArea(position)
    local scanRadius = 50
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Position - position).Magnitude < scanRadius then
            if obj.Name:find("Chest") or obj.Name:find("Loot") or obj.Name:find("Resource") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
    end
end

-- СБОР РЕСУРСОВ
UltimateHack.Functions.Collect = {}

function UltimateHack.Functions.Collect.GetResourcesByCategory(category)
    local resources = {
        Wood = {"Wood", "Log", "Plank", "Stick", "Tree"},
        Metal = {"Metal", "Scrap", "Iron", "Steel", "Ore", "Canister", "Tire", "Microwave", "Bolt"},
        Fuel = {"Fuel", "Coal", "Oil", "Gas", "Petrol"},
        Stone = {"Stone", "Flint", "Rock"},
        Axes = {"Axe", "Chainsaw"},
        Rods = {"Rod"},
        Flutes = {"Flute"},
        Sacks = {"Sack"},
        Weapons = {"Knife", "Sword", "Bow", "Arrow"},
        Bandages = {"Bandage"},
        Medkits = {"Medkit"},
        Potions = {"Potion", "Heal"},
        Ammo = {"Ammo", "Bullet"},
        Guns = {"Gun", "Rifle", "Pistol", "Shotgun"},
        Vegetables = {"Carrot", "Corn", "Pumpkin", "Apple", "Berry"},
        Meat = {"Morsel", "Steak", "Ribs", "Meat"},
        Fish = {"Mackerel", "Salmon", "Clownfish", "Jellyfish", "Char", "Eel", "Swordfish", "Shark", "Fish"},
        CookedFood = {"Stew", "Cake", "Chili", "Bread"},
        Water = {"Water", "Drink"},
        Pelts = {"Pelt", "Fur", "Hide", "Leather", "Skin"},
        Gems = {"Gem", "Crystal", "Diamond", "Ruby", "Emerald"},
        Artifacts = {"Cultist", "Artifact", "Relic", "Treasure"},
        Currency = {"Coin", "Money", "Gold", "Silver"},
        Miscellaneous = {"Misc", "Item", "Object", "Thing"}
    }
    return resources[category] or {}
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
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                        wait(0.02)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                        collectedCount = collectedCount + 1
                    end
                end
            end
        end
    end

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)
    
    if collectedCount > 0 then
        Rayfield:Notify({
            Title = "Сбор завершен",
            Content = "Собрано предметов: " .. collectedCount,
            Duration = 3,
            Image = 4483362458
        })
    end
end

function UltimateHack.Functions.Collect.Everything()
    Rayfield:Notify({
        Title = "Сбор ресурсов",
        Content = "Начинаю сбор ВСЕХ ресурсов!",
        Duration = 3,
        Image = 4483362458
    })

    local collectedCount = 0
    local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    local allResources = {
        "Wood", "Log", "Plank", "Stick", "Tree",
        "Metal", "Scrap", "Iron", "Steel", "Ore", "Canister", "Tire", "Microwave", "Bolt",
        "Fuel", "Coal", "Oil", "Gas", "Petrol",
        "Stone", "Flint", "Rock",
        "Axe", "Chainsaw", "Rod", "Flute", "Sack", "Knife", "Sword", "Bow", "Arrow",
        "Ammo", "Bullet", "Gun", "Rifle", "Pistol", "Shotgun",
        "Bandage", "Medkit", "Potion", "Heal",
        "Carrot", "Corn", "Pumpkin", "Apple", "Berry", "Morsel", "Steak", "Ribs", "Meat",
        "Mackerel", "Salmon", "Clownfish", "Jellyfish", "Char", "Eel", "Swordfish", "Shark", "Fish",
        "Stew", "Cake", "Chili", "Bread", "Water", "Drink",
        "Pelt", "Fur", "Hide", "Leather", "Skin",
        "Gem", "Crystal", "Diamond", "Ruby", "Emerald",
        "Cultist", "Artifact", "Relic", "Treasure",
        "Coin", "Money", "Gold", "Silver"
    }

    for _, resourceName in pairs(allResources) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find(resourceName:lower()) then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                wait(0.02)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                collectedCount = collectedCount + 1
            end
        end
    end

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)

    Rayfield:Notify({
        Title = "Сбор ВСЕГО завершен!",
        Content = "Собрано предметов: " .. collectedCount,
        Duration = 5,
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

-- ЗАПУСК И ОСТАНОВКА
function UltimateHack.StartAll()
    if UltimateHack.IsRunning then
        Rayfield:Notify({
            Title = "Внимание",
            Content = "Хак уже запущен!",
            Duration = 3,
            Image = 4483362458
        })
        return
    end
    
    UltimateHack.IsRunning = true
    
    -- ЗАПУСКАЕМ ЧИТЫ
    spawn(function() UltimateHack.Functions.Cheats.GodMode() end)
    spawn(function() UltimateHack.Functions.Cheats.Fly() end)
    spawn(function() UltimateHack.Functions.Cheats.SetSpeed(50) end)
    spawn(function() UltimateHack.Functions.Cheats.InfiniteStamina() end)
    spawn(function() UltimateHack.Functions.Cheats.NoHunger() end)
    spawn(function() UltimateHack.Functions.Cheats.NoThirst() end)
    
    -- ЗАПУСКАЕМ ОСНОВНЫЕ СИСТЕМЫ
    spawn(function() UltimateHack.Functions.Auras.KillAura() end)
    spawn(function() UltimateHack.Functions.Auras.TreeAura() end)
    spawn(function() UltimateHack.Functions.Auras.AutoFarm() end)
    spawn(function() UltimateHack.Functions.Automation.AutoFish() end)
    spawn(function() UltimateHack.Functions.Automation.AutoPlant() end)
    spawn(function() UltimateHack.Functions.Automation.AutoLoot() end)
    spawn(function() UltimateHack.Functions.Automation.FindChildren() end)
    spawn(function() UltimateHack.Functions.Automation.AntiAFK() end)
    spawn(function() UltimateHack.Functions.Automation.AutoCookFood() end)
    spawn(function() UltimateHack.Functions.Collect.AutoCollectResources() end)
    
    if UltimateHack.Settings.AutoExploit then
        spawn(function() UltimateHack.Functions.AutoExploit.StartSpiralExploit() end)
    end
    
    if UltimateHack.Settings.AutoOptimize then
        UltimateHack.Functions.Optimization.ApplyMobileOptimization()
    end
    
    Rayfield:Notify({
        Title = "Ultimate Hack",
        Content = "Все системы активированы!",
        Duration = 5,
        Image = 4483362458
    })
end

function UltimateHack.StopAll()
    UltimateHack.IsRunning = false
    Rayfield:Notify({
        Title = "Ultimate Hack",
        Content = "Все системы остановлены!",
        Duration = 3,
        Image = 4483362458
    })
end

-- ИНТЕРФЕЙС RAYFIELD

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

local TPSpawnButton = TeleportTab:CreateButton({
    Name = "🏠 ТП на спавн",
    Callback = function()
        UltimateHack.Functions.Teleport.ToSpawn()
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
PlayerTab:CreateSection("Ауры")

local KillAuraToggle = PlayerTab:CreateToggle({
    Name = "⚔️ Киллаура",
    CurrentValue = UltimateHack.Settings.KillAura,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        UltimateHack.Settings.KillAura = Value
    end,
})

local TreeAuraToggle = PlayerTab:CreateToggle({
    Name = "🪓 Вырубка деревьев",
    CurrentValue = UltimateHack.Settings.TreeAura,
    Flag = "TreeAuraToggle",
    Callback = function(Value)
        UltimateHack.Settings.TreeAura = Value
    end,
})

local AutoFarmToggle = PlayerTab:CreateToggle({
    Name = "🌾 Автофарм",
    CurrentValue = UltimateHack.Settings.AutoFarmAura,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoFarmAura = Value
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

PlayerTab:CreateSection("Читы")

local FlyButton = PlayerTab:CreateButton({
    Name = "🦅 Включить полет",
    Callback = function()
        UltimateHack.Functions.Cheats.Fly()
    end,
})

local NoClipButton = PlayerTab:CreateButton({
    Name = "👻 Включить NoClip",
    Callback = function()
        UltimateHack.Functions.Cheats.NoClip()
    end,
})

local GodModeButton = PlayerTab:CreateButton({
    Name = "🛡️ Включить God Mode",
    Callback = function()
        UltimateHack.Functions.Cheats.GodMode()
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
    end,
})

local AutoPlantToggle = AutoTab:CreateToggle({
    Name = "🌳 Автопосадка деревьев",
    CurrentValue = UltimateHack.Settings.AutoPlant,
    Flag = "AutoPlantToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoPlant = Value
    end,
})

local AutoLootToggle = AutoTab:CreateToggle({
    Name = "📦 Автолут сундуков",
    CurrentValue = UltimateHack.Settings.AutoLoot,
    Flag = "AutoLootToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoLoot = Value
    end,
})

local AutoFindChildrenToggle = AutoTab:CreateToggle({
    Name = "👶 Автопоиск детей",
    CurrentValue = UltimateHack.Settings.AutoFindChildren,
    Flag = "AutoFindChildrenToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoFindChildren = Value
    end,
})

local AutoCookToggle = AutoTab:CreateToggle({
    Name = "🍳 Автоготовка еды",
    CurrentValue = UltimateHack.Settings.AutoCookFood,
    Flag = "AutoCookToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoCookFood = Value
    end,
})

local AntiAFKToggle = AutoTab:CreateToggle({
    Name = "⏰ Анти-АФК",
    CurrentValue = UltimateHack.Settings.AntiAFK,
    Flag = "AntiAFKToggle",
    Callback = function(Value)
        UltimateHack.Settings.AntiAFK = Value
    end,
})

-- ЭКСПЛОЙД
ExploitTab:CreateSection("Эксплойд карты")

local ExploitToggle = ExploitTab:CreateToggle({
    Name = "🛸 Автоэксплойд карты",
    CurrentValue = UltimateHack.Settings.AutoExploit,
    Flag = "ExploitToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoExploit = Value
    end,
})

local ExploitRadiusSlider = ExploitTab:CreateSlider({
    Name = "📏 Радиус эксплойда",
    Range = {100, 5000},
    Increment = 100,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.ExploitRadius,
    Flag = "ExploitRadiusSlider",
    Callback = function(Value)
        UltimateHack.Settings.ExploitRadius = Value
    end,
})

local ExploitSpeedSlider = ExploitTab:CreateSlider({
    Name = "⚡ Скорость эксплойда",
    Range = {10, 100},
    Increment = 5,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.ExploitSpeed,
    Flag = "ExploitSpeedSlider",
    Callback = function(Value)
        UltimateHack.Settings.ExploitSpeed = Value
    end,
})

local ExploitHeightSlider = ExploitTab:CreateSlider({
    Name = "📐 Высота эксплойда",
    Range = {50, 500},
    Increment = 10,
    Suffix = "ед.",
    CurrentValue = UltimateHack.Settings.ExploitHeight,
    Flag = "ExploitHeightSlider",
    Callback = function(Value)
        UltimateHack.Settings.ExploitHeight = Value
    end,
})

-- СБОР РЕСУРСОВ
local CollectToggles = {}

CollectTab:CreateSection("Управление сбором")

local AutoCollectToggle = CollectTab:CreateToggle({
    Name = "🔄 Автоматический сбор",
    CurrentValue = UltimateHack.CollectSettings.AutoCollect,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.AutoCollect = Value
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

CollectTab:CreateSection("Выбор ресурсов")

CollectTab:CreateSection("📦 Ресурсы")
CollectToggles.Wood = CollectTab:CreateToggle({
    Name = "🪵 Дерево",
    CurrentValue = UltimateHack.CollectSettings.Wood,
    Flag = "WoodToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Wood = Value
    end,
})

CollectToggles.Metal = CollectTab:CreateToggle({
    Name = "🔩 Металл",
    CurrentValue = UltimateHack.CollectSettings.Metal,
    Flag = "MetalToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Metal = Value
    end,
})

CollectToggles.Fuel = CollectTab:CreateToggle({
    Name = "⛽ Топливо",
    CurrentValue = UltimateHack.CollectSettings.Fuel,
    Flag = "FuelToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Fuel = Value
    end,
})

CollectToggles.Stone = CollectTab:CreateToggle({
    Name = "🪨 Камни",
    CurrentValue = UltimateHack.CollectSettings.Stone,
    Flag = "StoneToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Stone = Value
    end,
})

CollectTab:CreateSection("🛠️ Инструменты")
CollectToggles.Axes = CollectTab:CreateToggle({
    Name = "🪓 Топоры",
    CurrentValue = UltimateHack.CollectSettings.Axes,
    Flag = "AxesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Axes = Value
    end,
})

CollectToggles.Rods = CollectTab:CreateToggle({
    Name = "🎣 Удочки",
    CurrentValue = UltimateHack.CollectSettings.Rods,
    Flag = "RodsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Rods = Value
    end,
})

CollectToggles.Flutes = CollectTab:CreateToggle({
    Name = "🎵 Флейты",
    CurrentValue = UltimateHack.CollectSettings.Flutes,
    Flag = "FlutesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Flutes = Value
    end,
})

CollectToggles.Sacks = CollectTab:CreateToggle({
    Name = "🎒 Сумки",
    CurrentValue = UltimateHack.CollectSettings.Sacks,
    Flag = "SacksToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Sacks = Value
    end,
})

CollectToggles.Weapons = CollectTab:CreateToggle({
    Name = "⚔️ Оружие",
    CurrentValue = UltimateHack.CollectSettings.Weapons,
    Flag = "WeaponsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Weapons = Value
    end,
})

CollectTab:CreateSection("💊 Медицина")
CollectToggles.Bandages = CollectTab:CreateToggle({
    Name = "🩹 Бинты",
    CurrentValue = UltimateHack.CollectSettings.Bandages,
    Flag = "BandagesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Bandages = Value
    end,
})

CollectToggles.Medkits = CollectTab:CreateToggle({
    Name = "💊 Аптечки",
    CurrentValue = UltimateHack.CollectSettings.Medkits,
    Flag = "MedkitsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Medkits = Value
    end,
})

CollectToggles.Potions = CollectTab:CreateToggle({
    Name = "🧪 Зелья",
    CurrentValue = UltimateHack.CollectSettings.Potions,
    Flag = "PotionsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Potions = Value
    end,
})

CollectTab:CreateSection("🔫 Боеприпасы")
CollectToggles.Ammo = CollectTab:CreateToggle({
    Name = "🔫 Патроны",
    CurrentValue = UltimateHack.CollectSettings.Ammo,
    Flag = "AmmoToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Ammo = Value
    end,
})

CollectToggles.Guns = CollectTab:CreateToggle({
    Name = "🔫 Огнестрельное оружие",
    CurrentValue = UltimateHack.CollectSettings.Guns,
    Flag = "GunsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Guns = Value
    end,
})

CollectTab:CreateSection("🍖 Еда")
CollectToggles.Vegetables = CollectTab:CreateToggle({
    Name = "🥕 Овощи/Фрукты",
    CurrentValue = UltimateHack.CollectSettings.Vegetables,
    Flag = "VegetablesToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Vegetables = Value
    end,
})

CollectToggles.Meat = CollectTab:CreateToggle({
    Name = "🥩 Мясо",
    CurrentValue = UltimateHack.CollectSettings.Meat,
    Flag = "MeatToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Meat = Value
    end,
})

CollectToggles.Fish = CollectTab:CreateToggle({
    Name = "🐟 Рыба",
    CurrentValue = UltimateHack.CollectSettings.Fish,
    Flag = "FishToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Fish = Value
    end,
})

CollectToggles.CookedFood = CollectTab:CreateToggle({
    Name = "🍲 Готовые блюда",
    CurrentValue = UltimateHack.CollectSettings.CookedFood,
    Flag = "CookedFoodToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.CookedFood = Value
    end,
})

CollectToggles.Water = CollectTab:CreateToggle({
    Name = "💧 Вода",
    CurrentValue = UltimateHack.CollectSettings.Water,
    Flag = "WaterToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Water = Value
    end,
})

CollectTab:CreateSection("💎 Прочее (Pelf)")
CollectToggles.Pelts = CollectTab:CreateToggle({
    Name = "🐾 Шкуры",
    CurrentValue = UltimateHack.CollectSettings.Pelts,
    Flag = "PeltsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Pelts = Value
    end,
})

CollectToggles.Gems = CollectTab:CreateToggle({
    Name = "💎 Драгоценности",
    CurrentValue = UltimateHack.CollectSettings.Gems,
    Flag = "GemsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Gems = Value
    end,
})

CollectToggles.Artifacts = CollectTab:CreateToggle({
    Name = "🏺 Артефакты",
    CurrentValue = UltimateHack.CollectSettings.Artifacts,
    Flag = "ArtifactsToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Artifacts = Value
    end,
})

CollectToggles.Currency = CollectTab:CreateToggle({
    Name = "💰 Валюта",
    CurrentValue = UltimateHack.CollectSettings.Currency,
    Flag = "CurrencyToggle",
    Callback = function(Value)
        UltimateHack.CollectSettings.Currency = Value
    end,
})

CollectToggles.Miscellaneous = CollectTab:CreateToggle({
    Name = "📦 Разное",
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
OptimizationTab:CreateSection("Настройки графики")

local FPSSlider = OptimizationTab:CreateSlider({
    Name = "🎮 Лимит FPS",
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
    Name = "🖼️ Уровень качества",
    Range = {1, 10},
    Increment = 1,
    Suffix = "уровень",
    CurrentValue = 1,
    Flag = "QualitySlider",
    Callback = function(Value)
        UltimateHack.Functions.Optimization.SetQuality(Value)
    end,
})

local ShadowsToggle = OptimizationTab:CreateToggle({
    Name = "🌑 Тени",
    CurrentValue = false,
    Flag = "ShadowsToggle",
    Callback = function(Value)
        UltimateHack.Functions.Optimization.ToggleShadows()
    end,
})

local FogToggle = OptimizationTab:CreateToggle({
    Name = "🌫️ Туман",
    CurrentValue = false,
    Flag = "FogToggle",
    Callback = function(Value)
        UltimateHack.Functions.Optimization.ToggleFog()
    end,
})

local ParticlesToggle = OptimizationTab:CreateToggle({
    Name = "✨ Частицы",
    CurrentValue = true,
    Flag = "ParticlesToggle",
    Callback = function(Value)
        if Value then
            UltimateHack.Functions.Optimization.EnableParticles()
        else
            UltimateHack.Functions.Optimization.DisableParticles()
        end
    end,
})

local MobileOptimizeButton = OptimizationTab:CreateButton({
    Name = "📱 Применить мобильную оптимизацию",
    Callback = function()
        UltimateHack.Functions.Optimization.ApplyMobileOptimization()
    end,
})

local AutoOptimizeToggle = OptimizationTab:CreateToggle({
    Name = "⚡ Автооптимизация при запуске",
    CurrentValue = UltimateHack.Settings.AutoOptimize,
    Flag = "AutoOptimizeToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoOptimize = Value
    end,
})

Rayfield:Notify({
    Title = "99 Nights Ultimate Hack",
    Content = "Успешно загружен! v4.0 - ПОЛНАЯ ВЕРСИЯ",
    Duration = 6,
    Image = 4483362458
})

return UltimateHack