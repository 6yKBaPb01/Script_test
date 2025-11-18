-- 99 NIGHTS ULTIMATE MEGA HACK by I.S.-1
-- ПОЛНЫЙ ФУНКЦИОНАЛ НА ВСЕ СЛУЧАИ ЖИЗНИ

local UltimateHack = {}

-- Загружаем Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua'))()
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

-- НАСТРОЙКИ
UltimateHack.Settings = {
    -- ТЕЛЕПОРТАЦИЯ
    AutoTPToFire = true,
    
    -- АУРЫ
    KillAura = true,
    KillAuraRadius = 50,
    TreeAura = true,
    TreeAuraRadius = 30,
    
    -- АВТОМАТЫ
    AutoFish = true,
    AutoPlant = true,
    AutoLoot = true,
    AntiAFK = true,
    AutoFindChildren = true,
    AutoCollectResources = false,
    
    -- ЧИТЫ
    FlyHack = true,
    NoClip = false,
    GodMode = true,
    SpeedHack = false,
    SpeedMultiplier = 2,
    
    -- ЭКСПЛОЙД
    AutoExploit = true,
    ExploitRadius = 1000,
    ExploitSpeed = 50,
    
    -- СБОР РЕСУРСОВ
    CollectWood = true,
    CollectMetal = true,
    CollectFuel = true,
    CollectTools = true,
    CollectAmmo = true,
    CollectMedkits = true,
    CollectFood = true,
    CollectPelf = true,
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
end

function UltimateHack.Functions.Optimization.ToggleFog()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = lighting.FogEnd == 100000 and 1000 or 100000
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
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(UltimateHack.FirePosition)
        end
    end
    Rayfield:Notify({
        Title = "Телепортация",
        Content = "Все игроки телепортированы к костру!",
        Duration = 3,
        Image = 4483362458
    })
end

-- АУРЫ
UltimateHack.Functions.Auras = {}

function UltimateHack.Functions.Auras.KillAura()
    while UltimateHack.Settings.KillAura and UltimateHack.IsRunning do
        wait(0.1)
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if character then
            -- УБИВАЕМ ВСЕХ ВРАГОВ (ВОЛКИ, МЕДВЕДИ, ИГРОКИ)
            for _, target in pairs(game.Players:GetPlayers()) do
                if target ~= player and target.Character then
                    local targetChar = target.Character
                    local distance = (character.HumanoidRootPart.Position - targetChar.HumanoidRootPart.Position).Magnitude
                    
                    if distance < UltimateHack.Settings.KillAuraRadius then
                        -- НЕ УБИВАЕМ ДЕТЕЙ!
                        if not (target:FindFirstChild("Status") and target.Status.Value == "Child") then
                            targetChar.Humanoid.Health = 0
                        end
                    end
                end
            end
            
            -- УБИВАЕМ NPC ВРАГОВ
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

-- АВТОМАТЫ
UltimateHack.Functions.Automation = {}

function UltimateHack.Functions.Automation.AutoFish()
    while UltimateHack.Settings.AutoFish and UltimateHack.IsRunning do
        wait(2)
        local fishingRod = game.Players.LocalPlayer.Backpack:FindFirstChild("FishingRod") or game.Players.LocalPlayer.Character:FindFirstChild("FishingRod")
        if fishingRod then
            pcall(function()
                game:GetService("ReplicatedStorage"):FindFirstChild("FishingEvent"):FireServer("StartFishing")
            end)
        end
    end
end

function UltimateHack.Functions.Automation.AutoPlant()
    while UltimateHack.Settings.AutoPlant and UltimateHack.IsRunning do
        wait(3)
        
        -- ЗАЩИТНАЯ СТЕНА ВОКРУГ КОСТРА
        for x = -20, 20, 4 do
            for z = -20, 20, 4 do
                if x == -20 or x == 20 or z == -20 or z == 20 then
                    local plantPos = UltimateHack.FirePosition + Vector3.new(x, 0, z)
                    pcall(function()
                        game:GetService("ReplicatedStorage"):FindFirstChild("PlantTree"):FireServer(plantPos)
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
        
        -- ЛУТАЕМ СУНДУКИ И РЕСУРСЫ
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
        
        -- ПОИСК ВСЕХ 4 ДЕТЕЙ
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

function UltimateHack.Functions.Automation.AutoCollectResources()
    while UltimateHack.Settings.AutoCollectResources and UltimateHack.IsRunning do
        wait(10)
        UltimateHack.Functions.Collect.AllResources()
    end
end

-- ЧИТЫ ДЛЯ ИГРОКА
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

-- ЭКСПЛОЙД КАРТЫ
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
    local maxHeight = 100
    
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
        
        -- СКАНИРУЕМ И ЛУТАЕМ ВСЁ ВОКРУГ
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
            -- ЛУТАЕМ РЕСУРСЫ И СУНДУКИ
            if obj.Name:find("Chest") or obj.Name:find("Loot") or obj.Name:find("Resource") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
    end
end

-- СБОР РЕСУРСОВ (ПОЛНЫЙ КОМПЛЕКТ)
UltimateHack.Functions.Collect = {}

function UltimateHack.Functions.Collect.AllResources()
    Rayfield:Notify({
        Title = "Сбор ресурсов",
        Content = "Начинаю сбор ВСЕХ ресурсов...",
        Duration = 3,
        Image = 4483362458
    })

    local collectedCount = 0
    local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    -- ВСЕ КАТЕГОРИИ РЕСУРСОВ
    local allResources = {
        -- ДЕРЕВО
        "Wood", "Log", "Tree", "Stick", "Plank",
        -- МЕТАЛЛ
        "Metal", "Scrap", "Iron", "Steel", "Ore", "Canister", "Tire", "Microwave", "Bolt",
        -- ТОПЛИВО
        "Fuel", "Coal", "Oil", "Gas", "Petrol",
        -- ИНСТРУМЕНТЫ
        "Axe", "Chainsaw", "Rod", "Flute", "Sack", "Tool", "Hammer", "Saw", "Pickaxe",
        -- ПАТРОНЫ И ОРУЖИЕ
        "Ammo", "Bullet", "Gun", "Rifle", "Pistol", "Shotgun", "Arrow", "Bow",
        -- АПТЕЧКИ И МЕДИЦИНА
        "Bandage", "Medkit", "Med", "Health", "Potion", "Heal",
        -- ЕДА
        "Carrot", "Corn", "Pumpkin", "Apple", "Berry", "Morsel", "Steak", "Ribs", 
        "Cake", "Chili", "Stew", "Mackerel", "Salmon", "Clownfish", "Jellyfish", "Char", "Eel", "Swordfish", "Shark",
        "Fish", "Meat", "Food", "Bread", "Water", "Drink",
        -- ПРОЧЕЕ (PELF)
        "Pelt", "Fur", "Skin", "Hide", "Leather", "Gem", "Crystal", "Diamond", "Ruby", "Emerald", "Gold", "Silver",
        "Cultist", "Artifact", "Relic", "Treasure", "Coin", "Money"
    }

    -- Поиск и сбор предметов по всем ключевым словам
    for _, resourceName in pairs(allResources) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find(resourceName:lower()) then
                -- Телепортируемся к предмету
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                wait(0.05)
                
                -- Подбираем предмет
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                
                collectedCount = collectedCount + 1
            end
        end
    end

    -- Возврат на исходную позицию
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)

    Rayfield:Notify({
        Title = "Сбор завершен",
        Content = "Собрано предметов: " .. collectedCount,
        Duration = 5,
        Image = 4483362458
    })
end

-- ОТДЕЛЬНЫЕ ФУНКЦИИ СБОРА
function UltimateHack.Functions.Collect.Wood()
    UltimateHack.Functions.Collect.SpecificResources({"Wood", "Log", "Tree", "Stick", "Plank"}, "дерева")
end

function UltimateHack.Functions.Collect.Metal()
    UltimateHack.Functions.Collect.SpecificResources({"Metal", "Scrap", "Iron", "Steel", "Ore", "Canister", "Tire", "Microwave", "Bolt"}, "металла")
end

function UltimateHack.Functions.Collect.Fuel()
    UltimateHack.Functions.Collect.SpecificResources({"Fuel", "Coal", "Oil", "Gas", "Petrol"}, "топлива")
end

function UltimateHack.Functions.Collect.Tools()
    UltimateHack.Functions.Collect.SpecificResources({"Axe", "Chainsaw", "Rod", "Flute", "Sack", "Tool", "Hammer", "Saw", "Pickaxe"}, "инструментов")
end

function UltimateHack.Functions.Collect.Ammo()
    UltimateHack.Functions.Collect.SpecificResources({"Ammo", "Bullet", "Gun", "Rifle", "Pistol", "Shotgun", "Arrow", "Bow"}, "патронов и оружия")
end

function UltimateHack.Functions.Collect.Medkits()
    UltimateHack.Functions.Collect.SpecificResources({"Bandage", "Medkit", "Med", "Health", "Potion", "Heal"}, "аптечек")
end

function UltimateHack.Functions.Collect.Food()
    UltimateHack.Functions.Collect.SpecificResources({
        "Carrot", "Corn", "Pumpkin", "Apple", "Berry", "Morsel", "Steak", "Ribs", 
        "Cake", "Chili", "Stew", "Mackerel", "Salmon", "Clownfish", "Jellyfish", "Char", "Eel", "Swordfish", "Shark",
        "Fish", "Meat", "Food", "Bread", "Water", "Drink"
    }, "еды")
end

function UltimateHack.Functions.Collect.Pelf()
    UltimateHack.Functions.Collect.SpecificResources({
        "Pelt", "Fur", "Skin", "Hide", "Leather", "Gem", "Crystal", "Diamond", "Ruby", "Emerald", "Gold", "Silver",
        "Cultist", "Artifact", "Relic", "Treasure", "Coin", "Money"
    }, "прочих ресурсов")
end

function UltimateHack.Functions.Collect.SpecificResources(resources, resourceName)
    Rayfield:Notify({
        Title = "Сбор " .. resourceName,
        Content = "Начинаю поиск...",
        Duration = 3,
        Image = 4483362458
    })

    local collectedCount = 0
    local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    for _, resourceType in pairs(resources) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find(resourceType:lower()) then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                wait(0.05)
                
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                
                collectedCount = collectedCount + 1
            end
        end
    end

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(startPos)

    Rayfield:Notify({
        Title = "Сбор завершен",
        Content = "Собрано " .. resourceName .. ": " .. collectedCount,
        Duration = 5,
        Image = 4483362458
    })
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
    
    -- ЗАПУСКАЕМ ОСНОВНЫЕ СИСТЕМЫ
    spawn(function() UltimateHack.Functions.Auras.KillAura() end)
    spawn(function() UltimateHack.Functions.Auras.TreeAura() end)
    spawn(function() UltimateHack.Functions.Automation.AutoFish() end)
    spawn(function() UltimateHack.Functions.Automation.AutoPlant() end)
    spawn(function() UltimateHack.Functions.Automation.AutoLoot() end)
    spawn(function() UltimateHack.Functions.Automation.FindChildren() end)
    spawn(function() UltimateHack.Functions.Automation.AntiAFK() end)
    spawn(function() UltimateHack.Functions.Automation.AutoCollectResources() end)
    
    if UltimateHack.Settings.AutoExploit then
        spawn(function() UltimateHack.Functions.AutoExploit.StartSpiralExploit() end)
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

MainTab:CreateSection("Телепортация")

local SetFireButton = MainTab:CreateButton({
    Name = "📍 Установить позицию костра",
    Callback = function()
        UltimateHack.Functions.Teleport.SetFirePosition()
    end,
})

local TPToFireButton = MainTab:CreateButton({
    Name = "🔥 ТП к костру",
    Callback = function()
        UltimateHack.Functions.Teleport.ToFire()
    end,
})

local TPToChildButton = MainTab:CreateButton({
    Name = "👶 ТП к ребенку",
    Callback = function()
        UltimateHack.Functions.Teleport.ToChild()
    end,
})

local TPAllButton = MainTab:CreateButton({
    Name = "👥 ТП всех к костру",
    Callback = function()
        UltimateHack.Functions.Teleport.AllToFire()
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

local AutoCollectToggle = AutoTab:CreateToggle({
    Name = "🔄 Автосбор ресурсов",
    CurrentValue = UltimateHack.Settings.AutoCollectResources,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        UltimateHack.Settings.AutoCollectResources = Value
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

-- СБОР РЕСУРСОВ
CollectTab:CreateSection("Сбор ресурсов")

local CollectAllButton = CollectTab:CreateButton({
    Name = "🗲 Собрать ВСЕ предметы",
    Callback = function()
        UltimateHack.Functions.Collect.AllResources()
    end,
})

CollectTab:CreateSection("Отдельные категории")

local CollectWoodButton = CollectTab:CreateButton({
    Name = "🪵 Собрать дерево",
    Callback = function()
        UltimateHack.Functions.Collect.Wood()
    end,
})

local CollectMetalButton = CollectTab:CreateButton({
    Name = "🔩 Собрать металл",
    Callback = function()
        UltimateHack.Functions.Collect.Metal()
    end,
})

local CollectFuelButton = CollectTab:CreateButton({
    Name = "⛽ Собрать топливо",
    Callback = function()
        UltimateHack.Functions.Collect.Fuel()
    end,
})

local CollectToolsButton = CollectTab:CreateButton({
    Name = "🛠️ Собрать инструменты",
    Callback = function()
        UltimateHack.Functions.Collect.Tools()
    end,
})

local CollectAmmoButton = CollectTab:CreateButton({
    Name = "🔫 Собрать патроны",
    Callback = function()
        UltimateHack.Functions.Collect.Ammo()
    end,
})

local CollectMedkitsButton = CollectTab:CreateButton({
    Name = "💊 Собрать аптечки",
    Callback = function()
        UltimateHack.Functions.Collect.Medkits()
    end,
})

local CollectFoodButton = CollectTab:CreateButton({
    Name = "🍖 Собрать еду",
    Callback = function()
        UltimateHack.Functions.Collect.Food()
    end,
})

local CollectPelfButton = CollectTab:CreateButton({
    Name = "💎 Собрать прочее (Pelf)",
    Callback = function()
        UltimateHack.Functions.Collect.Pelf()
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

Rayfield:Notify({
    Title = "99 Nights Ultimate Hack",
    Content = "Успешно загружен! v3.0 - ПОЛНАЯ ВЕРСИЯ",
    Duration = 6,
    Image = 4483362458
})

return UltimateHack