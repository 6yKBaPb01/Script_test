-- 99 ночей в лесу - ULTIMATE SCRIPT by I.S.-1
-- ПОЛНЫЙ ФУНКЦИОНАЛ БЕЗ ЛИШНЕЙ ХУЙНИ

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ОСНОВНОЙ КОНФИГ
getgenv().IS1_Config = {
    AutoExplore = {
        Enabled = false,
        Speed = 100,
        Height = 50,
        Radius = 500,
        CollectResources = true,
        FindChild = true
    },
    FlyMode = {
        Enabled = false,
        Speed = 50,
        Noclip = true
    },
    AutoCollect = {
        Wood = true,
        Metal = true,
        Food = true,
        Tools = true,
        Chairs = true,
        Fuel = true,
        Ammo = true,
        Weapons = true
    },
    AutoComplete = {
        Enabled = true,
        ReturnToFire = true,
        CraftToWorkbench = true,
        FuelToFire = true,
        MapBounds = 2000
    },
    Movement = {
        WalkSpeed = 16,
        JumpPower = 50
    }
}

-- ПЕРЕМЕННЫЕ
local flyConnection, noclipConnection, exploreConnection
local bodyVelocity, bodyGyro
getgenv().StartPosition = nil
getgenv().ChildLocation = nil

-- ФУНКЦИЯ ПОЛЕТА
function toggleFlyMode(state)
    if state then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = Character.HumanoidRootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyGyro.P = 1000
        bodyGyro.D = 50
        bodyGyro.Parent = Character.HumanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            
            local direction = Vector3.new()
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                direction = direction + Vector3.new(0, 0, -1)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                direction = direction + Vector3.new(0, 0, 1)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                direction = direction + Vector3.new(-1, 0, 0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                direction = direction + Vector3.new(1, 0, 0)
            end
            
            local cameraDirection = workspace.CurrentCamera.CFrame:VectorToWorldSpace(direction)
            bodyVelocity.Velocity = cameraDirection * getgenv().IS1_Config.FlyMode.Speed
        end)
        
        if getgenv().IS1_Config.FlyMode.Noclip then
            noclipConnection = RunService.Stepped:Connect(function()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end
        
    else
        if flyConnection then flyConnection:Disconnect() end
        if noclipConnection then noclipConnection:Disconnect() end
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- ФУНКЦИЯ ПРОВЕРКИ ГРАНИЦ КАРТЫ
function checkMapBounds(position)
    local bounds = getgenv().IS1_Config.AutoComplete.MapBounds
    return math.abs(position.X) > bounds or math.abs(position.Z) > bounds
end

-- ФУНКЦИЯ АВТОЭКСПЛОИТА
function startAutoExplore()
    local center = workspace:FindFirstChild("Campfire") or workspace:FindFirstChild("Fire")
    if not center then
        center = Character.HumanoidRootPart
    end
    
    getgenv().StartPosition = Character.HumanoidRootPart.Position
    
    local currentAngle = 0
    local currentRadius = 10
    local maxRadius = getgenv().IS1_Config.AutoComplete.MapBounds
    
    exploreConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().IS1_Config.AutoExplore.Enabled then
            exploreConnection:Disconnect()
            return
        end
        
        local currentPos = Character.HumanoidRootPart.Position
        if checkMapBounds(currentPos) or currentRadius >= maxRadius then
            Rayfield:Notify({
                Title = "КАРТА ПОЛНОСТЬЮ ИССЛЕДОВАНА! 🗺️",
                Content = "Достигнуты границы карты! Завершаем эксплоит...",
                Duration = 5,
                Image = 4483362458
            })
            autoCompleteExploit()
            return
        end
        
        currentAngle = currentAngle + 0.05
        currentRadius = currentRadius + 0.5
        
        local x = math.cos(currentAngle) * currentRadius
        local z = math.sin(currentAngle) * currentRadius
        local y = getgenv().IS1_Config.AutoExplore.Height
        
        local targetPosition = center.PrimaryPart.Position + Vector3.new(x, y, z)
        Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        
        if getgenv().IS1_Config.AutoExplore.CollectResources then
            collectResourcesInRadius(150)
        end
        
        if getgenv().IS1_Config.AutoExplore.FindChild then
            local child = findChild()
            if child then
                getgenv().ChildLocation = child.HumanoidRootPart.Position
            end
        end
        
        local progress = (currentRadius / maxRadius) * 100
        if progressLabel then
            progressLabel:Set("Прогресс обхода: " .. math.floor(progress) .. "%")
        end
    end)
end

-- ФУНКЦИЯ СБОРА РЕСУРСОВ
function collectResourcesInRadius(radius)
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Part") and item:FindFirstChild("ClickDetector") then
            local distance = (Character.HumanoidRootPart.Position - item.Position).Magnitude
            if distance <= radius then
                if getgenv().IS1_Config.AutoCollect.Wood and 
                   (item.Name:find("Wood") or item.Name:find("Log") or item.Name:find("Plank")) then
                    fireclickdetector(item.ClickDetector)
                end
                
                if getgenv().IS1_Config.AutoCollect.Metal and 
                   (item.Name:find("Metal") or item.Name:find("Iron") or item.Name:find("Steel")) then
                    fireclickdetector(item.ClickDetector)
                end
                
                if getgenv().IS1_Config.AutoCollect.Food and 
                   (item.Name:find("Morsel") or item.Name:find("Steak") or 
                    item.Name:find("Ribs") or item.Name:find("Carrot") or 
                    item.Name:find("Fish")) then
                    fireclickdetector(item.ClickDetector)
                end
                
                if getgenv().IS1_Config.AutoCollect.Tools and 
                   (item.Name:find("Tool") or item.Name:find("Flashlight") or 
                    item.Name:find("Flute") or item.Name:find("Lantern") or
                    item.Name:find("Axe") or item.Name:find("Pickaxe")) then
                    fireclickdetector(item.ClickDetector)
                end
                
                if getgenv().IS1_Config.AutoCollect.Weapons and 
                   (item.Name:find("Rifle") or item.Name:find("Gun") or 
                    item.Name:find("Pistol") or item.Name:find("Shotgun")) then
                    fireclickdetector(item.ClickDetector)
                end
                
                if getgenv().IS1_Config.AutoCollect.Chairs and 
                   (item.Name:find("Chair") or item.Name:find("Stool")) then
                    fireclickdetector(item.ClickDetector)
                end
                
                if getgenv().IS1_Config.AutoCollect.Fuel and 
                   (item.Name:find("Coal") or item.Name:find("Canister") or item.Name:find("Barrel")) then
                    fireclickdetector(item.ClickDetector)
                end
                
                if getgenv().IS1_Config.AutoCollect.Ammo and 
                   (item.Name:find("Ammo") or item.Name:find("Bullet") or item.Name:find("Magazine")) then
                    fireclickdetector(item.ClickDetector)
                end
            end
        end
    end
end

-- ФУНКЦИЯ АВТОСОРТИРОВКИ
function autoCompleteExploit()
    getgenv().IS1_Config.AutoExplore.Enabled = false
    if exploreConnection then
        exploreConnection:Disconnect()
    end
    toggleFlyMode(false)
    
    Rayfield:Notify({
        Title = "🚀 ЭКСПЛОИТ ЗАВЕРШЕН!",
        Content = "Начинаем автосортировку ресурсов...",
        Duration = 5,
        Image = 4483362458
    })
    
    wait(1)
    
    if getgenv().IS1_Config.AutoComplete.ReturnToFire then
        teleportToFire()
        wait(1)
    end
    
    local workbench = workspace:FindFirstChild("Workbench") or workspace:FindFirstChild("CraftingTable")
    local fire = workspace:FindFirstChild("Campfire") or workspace:FindFirstChild("Fire")
    
    -- 1. ТУЛЫ И ОРУЖИЕ В СТАРТОВУЮ ПОЗИЦИЮ
    if getgenv().StartPosition then
        Rayfield:Notify({
            Title = "🛠️ СКЛАДЫВАЕМ ТУЛЫ И ОРУЖИЕ",
            Content = "Топоры, винтовки и инструменты в стартовую позицию...",
            Duration = 4,
            Image = 4483362458
        })
        
        Character.HumanoidRootPart.CFrame = CFrame.new(getgenv().StartPosition)
        wait(1)
        
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") then
                if item.Name:find("Axe") or item.Name:find("Rifle") or item.Name:find("Gun") or
                   item.Name:find("Pistol") or item.Name:find("Tool") or item.Name:find("Flashlight") or
                   item.Name:find("Flute") or item.Name:find("Lantern") or item.Name:find("Weapon") or
                   item.Name:find("Shotgun") or item.Name:find("Pickaxe") then
                   
                    item.CFrame = CFrame.new(getgenv().StartPosition + Vector3.new(
                        math.random(-2, 2),
                        1,
                        math.random(-2, 2)
                    ))
                end
            end
        end
        wait(2)
    end
    
    -- 2. МЕТАЛЛ, ДЕРЕВО И СТУЛЬЯ В ВЕРСТАК
    if getgenv().IS1_Config.AutoComplete.CraftToWorkbench and workbench then
        Rayfield:Notify({
            Title = "🔨 СКЛАДЫВАЕМ В ВЕРСТАК",
            Content = "Металл, дерево и стулья в верстак...",
            Duration = 4,
            Image = 4483362458
        })
        
        Character.HumanoidRootPart.CFrame = workbench.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
        wait(1)
        
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") then
                if item.Name:find("Metal") or item.Name:find("Iron") or item.Name:find("Steel") or
                   item.Name:find("Wood") or item.Name:find("Log") or item.Name:find("Plank") or
                   item.Name:find("Chair") or item.Name:find("Stool") then
                   
                    item.CFrame = workbench.PrimaryPart.CFrame + Vector3.new(
                        math.random(-3, 3),
                        2,
                        math.random(-3, 3)
                    )
                end
            end
        end
        wait(2)
    end
    
    -- 3. ТОПЛИВО В КОСТЕР
    if getgenv().IS1_Config.AutoComplete.FuelToFire and fire then
        Rayfield:Notify({
            Title = "🔥 ЗАКЛАДЫВАЕМ ТОПЛИВО",
            Content = "Все топливо в костер...",
            Duration = 4,
            Image = 4483362458
        })
        
        Character.HumanoidRootPart.CFrame = fire.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
        wait(1)
        
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") then
                if item.Name:find("Coal") or item.Name:find("Canister") or item.Name:find("Barrel") then
                    item.CFrame = fire.PrimaryPart.CFrame + Vector3.new(0, 1, 0)
                    game:GetService("ReplicatedStorage"):FindFirstChild("AddFuel"):FireServer(fire)
                end
            end
        end
        wait(2)
    end
    
    -- 4. ПАТРОНЫ В СТАРТОВУЮ ПОЗИЦИЮ
    if getgenv().StartPosition then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") then
                if item.Name:find("Ammo") or item.Name:find("Bullet") or item.Name:find("Magazine") then
                    item.CFrame = CFrame.new(getgenv().StartPosition + Vector3.new(
                        math.random(-2, 2),
                        1,
                        math.random(-2, 2)
                    ))
                end
            end
        end
    end
    
    if fire then
        Character.HumanoidRootPart.CFrame = fire.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
    end
    
    Rayfield:Notify({
        Title = "🎉 АВТОСОРТИРОВКА ЗАВЕРШЕНА!",
        Content = "Все ресурсы и тулы разложены по местам!",
        Duration = 6,
        Image = 4483362458
    })
end

-- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
function findChild()
    for _, child in pairs(workspace:GetDescendants()) do
        if child.Name:lower():find("child") or child.Name:lower():find("kid") then
            if child:FindFirstChild("HumanoidRootPart") then
                return child
            end
        end
    end
    return nil
end

function teleportToFire()
    local fire = workspace:FindFirstChild("Campfire") or workspace:FindFirstChild("Fire")
    if fire then
        Character.HumanoidRootPart.CFrame = fire.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
    end
end

function teleportToChildWithCheck()
    local child = findChild()
    if child then
        Character.HumanoidRootPart.CFrame = child.HumanoidRootPart.CFrame
        Rayfield:Notify({
            Title = "ТП К РЕБЕНКУ ✅",
            Content = "Ребенок найден! Телепортация...",
            Duration = 3,
            Image = 4483362458
        })
    else
        Rayfield:Notify({
            Title = "ТП К РЕБЕНКУ ❌", 
            Content = "Ребенок не найден на карте!",
            Duration = 3,
            Image = 4483362458
        })
    end
end

-- ИНТЕРФЕЙС
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "99 ночей - ULTIMATE SCRIPT",
    LoadingTitle = "Загрузка полного функционала...",
    LoadingSubtitle = "by I.S.-1 | АВТОЭКСПЛОИТ + СОРТИРОВКА",
    ConfigurationSaving = {Enabled = false}
})

-- ГЛАВНАЯ ВКЛАДКА
local MainTab = Window:CreateTab("🏠 Главная", 4483362458)

local childStatusLabel = MainTab:CreateLabel("Статус ребенка: ❌ НЕ НАЙДЕН")
spawn(function()
    while true do
        wait(3)
        if getgenv().ChildLocation then
            childStatusLabel:Set("Статус ребенка: ✅ НАЙДЕН")
        else
            local currentChild = findChild()
            if currentChild then
                getgenv().ChildLocation = currentChild.HumanoidRootPart.Position
                childStatusLabel:Set("Статус ребенка: ✅ НАЙДЕН")
            else
                childStatusLabel:Set("Статус ребенка: ❌ НЕ НАЙДЕН")
            end
        end
    end
end)

-- АВТОЭКСПЛОИТ ВКЛАДКА
local ExploreTab = Window:CreateTab("🚀 Автоэксплоит", 4483362458)

local progressLabel = ExploreTab:CreateLabel("Прогресс обхода: 0%")

ExploreTab:CreateButton({
    Name = "🚀 ЗАПУСТИТЬ ПОЛНЫЙ АВТОЭКСПЛОИТ",
    Callback = function()
        getgenv().IS1_Config.AutoExplore.Enabled = true
        toggleFlyMode(true)
        startAutoExplore()
        Rayfield:Notify({
            Title = "АВТОЭКСПЛОИТ ЗАПУЩЕН!",
            Content = "Летающая муха активирована! Идем до границ карты!",
            Duration = 6,
            Image = 4483362458
        })
    end
})

ExploreTab:CreateButton({
    Name = "⏹️ ОСТАНОВИТЬ ЭКСПЛОИТ",
    Callback = function()
        getgenv().IS1_Config.AutoExplore.Enabled = false
        toggleFlyMode(false)
        if exploreConnection then
            exploreConnection:Disconnect()
        end
    end
})

ExploreTab:CreateButton({
    Name = "📦 СИЛОЙ ЗАВЕРШИТЬ И СОРТИРОВАТЬ",
    Callback = function()
        autoCompleteExploit()
    end
})

ExploreTab:CreateSection("Настройки эксплоита")

ExploreTab:CreateSlider({
    Name = "Границы карты",
    Range = {500, 5000},
    Increment = 100,
    Suffix = "studs",
    CurrentValue = 2000,
    Flag = "MapBounds",
    Callback = function(Value)
        getgenv().IS1_Config.AutoComplete.MapBounds = Value
    end
})

ExploreTab:CreateSlider({
    Name = "Высота полета",
    Range = {10, 500},
    Increment = 10,
    Suffix = "studs",
    CurrentValue = 50,
    Flag = "ExploreHeight",
    Callback = function(Value)
        getgenv().IS1_Config.AutoExplore.Height = Value
    end
})

ExploreTab:CreateToggle({
    Name = "Сбор ресурсов в полете",
    CurrentValue = true,
    Flag = "CollectWhileFlying",
    Callback = function(Value)
        getgenv().IS1_Config.AutoExplore.CollectResources = Value
    end
})

ExploreTab:CreateToggle({
    Name = "Поиск ребенка",
    CurrentValue = true,
    Flag = "FindChildExplore",
    Callback = function(Value)
        getgenv().IS1_Config.AutoExplore.FindChild = Value
    end
})

ExploreTab:CreateSection("Настройки сбора")

local collectOptions = {
    {Name = "Дерево", Flag = "CollectWood", Config = "Wood"},
    {Name = "Металл", Flag = "CollectMetal", Config = "Metal"},
    {Name = "Еда", Flag = "CollectFood", Config = "Food"},
    {Name = "Инструменты", Flag = "CollectTools", Config = "Tools"},
    {Name = "Оружие", Flag = "CollectWeapons", Config = "Weapons"},
    {Name = "Стулья", Flag = "CollectChairs", Config = "Chairs"},
    {Name = "Топливо", Flag = "CollectFuel", Config = "Fuel"},
    {Name = "Патроны", Flag = "CollectAmmo", Config = "Ammo"}
}

for _, option in pairs(collectOptions) do
    ExploreTab:CreateToggle({
        Name = option.Name,
        CurrentValue = true,
        Flag = option.Flag,
        Callback = function(Value)
            getgenv().IS1_Config.AutoCollect[option.Config] = Value
        end
    })
end

-- ТЕЛЕПОРТ ВКЛАДКА
local TeleportTab = Window:CreateTab("📍 Телепорт", 4483362458)

TeleportTab:CreateButton({
    Name = "👶 ТП к ребенку (с проверкой)",
    Callback = function()
        teleportToChildWithCheck()
    end
})

TeleportTab:CreateButton({
    Name = "🔥 ТП к костру",
    Callback = function()
        teleportToFire()
    end
})

TeleportTab:CreateButton({
    Name = "💾 Сохранить текущую позицию",
    Callback = function()
        getgenv().SavedPosition = Character.HumanoidRootPart.Position
        Rayfield:Notify({
            Title = "ПОЗИЦИЯ СОХРАНЕНА",
            Content = "Координаты сохранены для быстрого ТП",
            Duration = 3,
            Image = 4483362458
        })
    end
})

TeleportTab:CreateButton({
    Name = "📍 ТП к сохраненной позиции", 
    Callback = function()
        if getgenv().SavedPosition then
            Character.HumanoidRootPart.CFrame = CFrame.new(getgenv().SavedPosition)
        end
    end
})

-- РУЧНОЙ ПОЛЕТ
local FlyTab = Window:CreateTab("🦅 Ручной полет", 4483362458)

FlyTab:CreateToggle({
    Name = "Режим полета (ручной)",
    CurrentValue = false,
    Flag = "ManualFly",
    Callback = function(Value)
        getgenv().IS1_Config.FlyMode.Enabled = Value
        toggleFlyMode(Value)
    end
})

FlyTab:CreateSlider({
    Name = "Скорость ручного полета",
    Range = {10, 200},
    Increment = 10,
    Suffix = "studs", 
    CurrentValue = 50,
    Flag = "ManualFlySpeed",
    Callback = function(Value)
        getgenv().IS1_Config.FlyMode.Speed = Value
    end
})

FlyTab:CreateToggle({
    Name = "Noclip (проходить сквозь стены)",
    CurrentValue = true,
    Flag = "NoclipToggle",
    Callback = function(Value)
        getgenv().IS1_Config.FlyMode.Noclip = Value
    end
})

FlyTab:CreateLabel("Управление полетом:")
FlyTab:CreateLabel("W/S - вперед/назад")
FlyTab:CreateLabel("A/D - влево/вправо")

-- ДВИЖЕНИЕ
local MoveTab = Window:CreateTab("🏃 Движение", 4483362458)

MoveTab:CreateSlider({
    Name = "Скорость ходьбы",
    Range = {16, 500},
    Increment = 10,
    Suffix = "studs",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        getgenv().IS1_Config.Movement.WalkSpeed = Value
        Character.Humanoid.WalkSpeed = Value
    end
})

MoveTab:CreateSlider({
    Name = "Сила прыжка",
    Range = {50, 500},
    Increment = 10,
    Suffix = "studs",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        getgenv().IS1_Config.Movement.JumpPower = Value
        Character.Humanoid.JumpPower = Value
    end
})

MoveTab:CreateToggle({
    Name = "Ходить по небу",
    CurrentValue = false,
    Flag = "SkyWalk",
    Callback = function(Value)
        if Value then
            Character.HumanoidRootPart.CFrame = CFrame.new(
                Character.HumanoidRootPart.Position.X,
                100,
                Character.HumanoidRootPart.Position.Z
            )
        end
    end
})

Rayfield:LoadConfiguration()

-- АВТООБНОВЛЕНИЕ ПРОГРЕССА
spawn(function()
    while true do
        wait(5)
        if getgenv().IS1_Config.AutoExplore.Enabled and progressLabel then
            local center = workspace:FindFirstChild("Campfire")
            if center then
                local currentPos = Character.HumanoidRootPart.Position
                local distanceFromCenter = (currentPos - center.PrimaryPart.Position).Magnitude
                local progress = (distanceFromCenter / getgenv().IS1_Config.AutoComplete.MapBounds) * 100
                progressLabel:Set("Прогресс обхода: " .. math.min(math.floor(progress), 100) .. "%")
            end
        end
    end
end)

Rayfield:Notify({
    Title = "🎮 ULTIMATE SCRIPT АКТИВИРОВАН!",
    Content = "Полный функционал готов к работе!",
    Duration = 6,
    Image = 4483362458
})
