-- 99 ночей в лесу - MOBILE & PC EDITION
-- ОПТИМИЗИРОВАНО ДЛЯ ТЕЛЕФОНА И ПК

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ОПРЕДЕЛЯЕМ ПЛАТФОРМУ
local IS_MOBILE = UserInputService.TouchEnabled
local IS_PC = not IS_MOBILE

-- ОСНОВНОЙ КОНФИГ
getgenv().IS1_Config = {
    AutoExplore = {
        Enabled = false,
        Speed = IS_MOBILE and 80 or 100,
        Height = IS_MOBILE and 30 or 50,
        Radius = 500,
        CollectResources = true,
        FindChild = true
    },
    FlyMode = {
        Enabled = false,
        Speed = IS_MOBILE and 40 or 50,
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

-- 🔧 ОПТИМИЗИРОВАННЫЙ ИНТЕРФЕЙС ДЛЯ ТЕЛЕФОНА
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = IS_MOBILE and "99 ночей 📱" or "99 ночей - ULTIMATE",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = IS_MOBILE and "Mobile Optimized" or "PC Edition",
    ConfigurationSaving = {Enabled = false},
    Theme = {
        AccentColor = IS_MOBILE and Color3.fromRGB(0, 255, 136) or Color3.fromRGB(255, 85, 0)
    }
})

-- 🔧 АДАПТИВНЫЕ ФУНКЦИИ ДЛЯ ТЕЛЕФОНА
function createMobileFriendlyButton(tab, name, callback)
    return tab:CreateButton({
        Name = name,
        Callback = callback
    })
end

function createMobileToggle(tab, name, flag, callback)
    return tab:CreateToggle({
        Name = name,
        CurrentValue = false,
        Flag = flag,
        Callback = callback
    })
end

-- 🔧 ИСПРАВЛЕННАЯ ФУНКЦИЯ ПОЛЕТА ДЛЯ ТЕЛЕФОНА И ПК
function toggleFlyMode(state)
    if state then
        -- УБИРАЕМ СТАРЫЕ СКРИПТЫ
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
        if noclipConnection then noclipConnection:Disconnect() end
        
        -- СОЗДАЕМ НОВЫЕ
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Parent = Character.HumanoidRootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
        bodyGyro.P = 10000
        bodyGyro.D = 1000
        bodyGyro.Parent = Character.HumanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not bodyGyro or not bodyVelocity then return end
            
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            
            local direction = Vector3.new()
            
            if IS_PC then
                -- УПРАВЛЕНИЕ ДЛЯ ПК
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    direction = direction + workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    direction = direction - workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    direction = direction - workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    direction = direction + workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    direction = direction + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    direction = direction - Vector3.new(0, 1, 0)
                end
            else
                -- ДЛЯ ТЕЛЕФОНА - ПРОСТО ДВИЖЕНИЕ ВПЕРЕД
                direction = workspace.CurrentCamera.CFrame.LookVector
            end
            
            bodyVelocity.Velocity = direction * getgenv().IS1_Config.FlyMode.Speed
        end)
        
        -- NOCLIP
        if getgenv().IS1_Config.FlyMode.Noclip then
            noclipConnection = RunService.Stepped:Connect(function()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end
        
        Rayfield:Notify({
            Title = IS_MOBILE and "🦅 ПОЛЕТ АКТИВЕН" or "🦅 FLY MODE ACTIVE",
            Content = IS_MOBILE and "Двигайтесь вперед автоматически" or "Use WASD + Space/Shift to fly",
            Duration = 4,
            Image = 4483362458
        })
        
    else
        -- ВЫКЛЮЧАЕМ ПОЛЕТ
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        
        -- ВОССТАНАВЛИВАЕМ КОЛЛИЗИИ
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- 🔧 ИСПРАВЛЕННАЯ ФУНКЦИЯ ТЕЛЕПОРТА К КОСТРУ
function teleportToFire()
    -- ИЩЕМ КОСТЕР РАЗНЫМИ СПОСОБАМИ
    local fire = workspace:FindFirstChild("Campfire") 
                or workspace:FindFirstChild("Fire") 
                or workspace:FindFirstChild("CampFire")
    
    if not fire then
        -- ЕСЛИ НЕ НАШЛИ ПО ИМЕНИ, ИЩЕМ ПО ВНЕШНОСТИ
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and (obj.Name:lower():find("fire") or obj.BrickColor == BrickColor.new("Bright orange")) then
                fire = obj
                break
            end
        end
    end
    
    if fire then
        local targetCFrame
        if fire:IsA("Model") then
            targetCFrame = fire:GetModelCFrame()
        else
            targetCFrame = fire.CFrame
        end
        
        Character.HumanoidRootPart.CFrame = targetCFrame + Vector3.new(0, 5, 0)
        return true
    else
        Rayfield:Notify({
            Title = "❌ КОСТЕР НЕ НАЙДЕН",
            Content = "Убедитесь что костер существует в мире",
            Duration = 4,
            Image = 4483362458
        })
        return false
    end
end

-- 🔧 ОПТИМИЗИРОВАННАЯ ФУНКЦИЯ АВТОЭКСПЛОИТА
function startAutoExplore()
    if exploreConnection then
        exploreConnection:Disconnect()
        exploreConnection = nil
    end
    
    local center = workspace:FindFirstChild("Campfire") or workspace:FindFirstChild("Fire")
    if not center then
        center = Character.HumanoidRootPart
        Rayfield:Notify({
            Title = "⚠️ ЦЕНТР НЕ НАЙДЕН",
            Content = "Использую текущую позицию как центр",
            Duration = 3,
            Image = 4483362458
        })
    end
    
    getgenv().StartPosition = Character.HumanoidRootPart.Position
    
    local currentAngle = 0
    local currentRadius = 10
    local maxRadius = getgenv().IS1_Config.AutoComplete.MapBounds
    
    exploreConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().IS1_Config.AutoExplore.Enabled then
            if exploreConnection then
                exploreConnection:Disconnect()
                exploreConnection = nil
            end
            return
        end
        
        -- ПРОВЕРЯЕМ ЧТО ПЕРСОНАЖ СУЩЕСТВУЕТ
        if not Character or not Character:FindFirstChild("HumanoidRootPart") then
            getgenv().IS1_Config.AutoExplore.Enabled = false
            return
        end
        
        local currentPos = Character.HumanoidRootPart.Position
        
        -- ПРОВЕРКА ДОСТИЖЕНИЯ КОНЦА КАРТЫ
        if checkMapBounds(currentPos) or currentRadius >= maxRadius then
            Rayfield:Notify({
                Title = "🗺️ ЭКСПЛОИТ ЗАВЕРШЕН",
                Content = "Достигнуты границы карты!",
                Duration = 5,
                Image = 4483362458
            })
            autoCompleteExploit()
            return
        end
        
        -- ДВИЖЕНИЕ ПО СПИРАЛИ
        currentAngle = currentAngle + 0.03 -- МЕДЛЕННЕЕ ДЛЯ СТАБИЛЬНОСТИ
        currentRadius = currentRadius + (IS_MOBILE and 1.5 or 2) -- РАЗНАЯ СКОРОСТЬ
        
        local x = math.cos(currentAngle) * currentRadius
        local z = math.sin(currentAngle) * currentRadius
        local y = getgenv().IS1_Config.AutoExplore.Height
        
        local targetPosition
        if center:IsA("Model") then
            targetPosition = center:GetModelCFrame().Position + Vector3.new(x, y, z)
        else
            targetPosition = center.Position + Vector3.new(x, y, z)
        end
        
        Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        
        -- АВТО-СБОР РЕСУРСОВ
        if getgenv().IS1_Config.AutoExplore.CollectResources then
            collectResourcesInRadius(IS_MOBILE and 30 or 50)
        end
        
        -- ПОИСК РЕБЕНКА
        if getgenv().IS1_Config.AutoExplore.FindChild then
            local child = findChild()
            if child then
                getgenv().ChildLocation = child.HumanoidRootPart.Position
            end
        end
        
        -- ОБНОВЛЯЕМ ПРОГРЕСС
        local progress = (currentRadius / maxRadius) * 100
        if progressLabel then
            progressLabel:Set(IS_MOBILE and 
                ("📊 " .. math.floor(progress) .. "%") : 
                ("Прогресс: " .. math.floor(progress) .. "% | Радиус: " .. math.floor(currentRadius))
            )
        end
    end)
end

-- 🔧 ОПТИМИЗИРОВАННАЯ ФУНКЦИЯ СБОРА РЕСУРСОВ
function collectResourcesInRadius(radius)
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Part") and item:FindFirstChild("ClickDetector") then
            local distance = (Character.HumanoidRootPart.Position - item.Position).Magnitude
            if distance <= radius then
                if item.Parent == workspace then
                    pcall(function()
                        fireclickdetector(item.ClickDetector)
                    end)
                end
            end
        end
    end
end

-- 🔧 ФУНКЦИЯ АВТОСОРТИРОВКИ
function autoCompleteExploit()
    getgenv().IS1_Config.AutoExplore.Enabled = false
    
    if exploreConnection then
        exploreConnection:Disconnect()
        exploreConnection = nil
    end
    
    toggleFlyMode(false)
    
    Rayfield:Notify({
        Title = "📦 НАЧИНАЕМ СОРТИРОВКУ",
        Content = "Автосортировка ресурсов...",
        Duration = 5,
        Image = 4483362458
    })
    
    wait(2)
    
    -- ТП К КОСТРУ
    if getgenv().IS1_Config.AutoComplete.ReturnToFire then
        local success = teleportToFire()
        if not success then
            if getgenv().StartPosition then
                Character.HumanoidRootPart.CFrame = CFrame.new(getgenv().StartPosition)
            end
        end
        wait(2)
    end
    
    -- НАХОДИМ ВЕРСТАК И КОСТЕР
    local workbench = workspace:FindFirstChild("Workbench") or workspace:FindFirstChild("CraftingTable")
    local fire = workspace:FindFirstChild("Campfire") or workspace:FindFirstChild("Fire")
    
    -- 1. ТУЛЫ И ОРУЖИЕ В СТАРТОВУЮ ПОЗИЦИЮ
    if getgenv().StartPosition then
        Rayfield:Notify({
            Title = "🛠️ СОРТИРУЕМ ТУЛЫ",
            Content = "Складываем инструменты и оружие...",
            Duration = 3,
            Image = 4483362458
        })
        
        Character.HumanoidRootPart.CFrame = CFrame.new(getgenv().StartPosition)
        wait(1)
        
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") then
                if item.Name:find("Axe") or item.Name:find("Rifle") or item.Name:find("Gun") or
                   item.Name:find("Pistol") or item.Name:find("Tool") or item.Name:find("Flashlight") or
                   item.Name:find("Flute") or item.Name:find("Lantern") or item.Name:find("Weapon") then
                   
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
            Content = "Ресурсы отправляются в верстак...",
            Duration = 3,
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
            Content = "Топливо отправляется в костер...",
            Duration = 3,
            Image = 4483362458
        })
        
        Character.HumanoidRootPart.CFrame = fire.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
        wait(1)
        
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") then
                if item.Name:find("Coal") or item.Name:find("Canister") or item.Name:find("Barrel") then
                    item.CFrame = fire.PrimaryPart.CFrame + Vector3.new(0, 1, 0)
                end
            end
        end
        wait(2)
    end
    
    Rayfield:Notify({
        Title = "🎉 СОРТИРОВКА ЗАВЕРШЕНА!",
        Content = "Все ресурсы разложены по местам!",
        Duration = 6,
        Image = 4483362458
    })
end

-- 🔧 ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
function findChild()
    for _, child in pairs(workspace:GetDescendants()) do
        if child:FindFirstChild("Humanoid") and not child:FindFirstChild("Player") then
            if child.Name:lower():find("child") or child.Name:lower():find("kid") then
                return child
            end
        end
    end
    return nil
end

function checkMapBounds(position)
    local bounds = getgenv().IS1_Config.AutoComplete.MapBounds
    return math.abs(position.X) > bounds or math.abs(position.Z) > bounds
end

-- 📱 ИНТЕРФЕЙС ДЛЯ ТЕЛЕФОНА И ПК
local MainTab = Window:CreateTab(IS_MOBILE and "🏠 Главная" or "🏠 Главная", 4483362458)

-- СТАТУС РЕБЕНКА
local childStatusLabel = MainTab:CreateLabel(IS_MOBILE and "👶: Поиск..." or "Статус ребенка: Поиск...")
spawn(function()
    while true do
        wait(3)
        if getgenv().ChildLocation then
            childStatusLabel:Set(IS_MOBILE and "👶: Найден!" or "Статус ребенка: ✅ НАЙДЕН")
        else
            local currentChild = findChild()
            if currentChild then
                getgenv().ChildLocation = currentChild.HumanoidRootPart.Position
                childStatusLabel:Set(IS_MOBILE and "👶: Найден!" or "Статус ребенка: ✅ НАЙДЕН")
            else
                childStatusLabel:Set(IS_MOBILE and "👶: Не найден" or "Статус ребенка: ❌ НЕ НАЙДЕН")
            end
        end
    end
end)

-- 🚀 ВКЛАДКА АВТОЭКСПЛОИТА
local ExploreTab = Window:CreateTab(IS_MOBILE and "🚀 Эксплоит" or "🚀 Автоэксплоит", 4483362458)

local progressLabel = ExploreTab:CreateLabel(IS_MOBILE and "📊 0%" or "Прогресс: 0%")

-- КНОПКИ ДЛЯ ТЕЛЕФОНА (БОЛЬШИЕ И ПРОСТЫЕ)
createMobileFriendlyButton(ExploreTab, IS_MOBILE and "🚀 ЗАПУСТИТЬ" or "🚀 ЗАПУСТИТЬ АВТОЭКСПЛОИТ", function()
    getgenv().IS1_Config.AutoExplore.Enabled = true
    toggleFlyMode(true)
    startAutoExplore()
    Rayfield:Notify({
        Title = IS_MOBILE and "🚀 СТАРТ!" or "АВТОЭКСПЛОИТ ЗАПУЩЕН!",
        Content = IS_MOBILE and "Летим по карте..." or "Летающая муха активирована!",
        Duration = 4,
        Image = 4483362458
    })
end)

createMobileFriendlyButton(ExploreTab, IS_MOBILE and "⏹️ СТОП" or "⏹️ ОСТАНОВИТЬ", function()
    getgenv().IS1_Config.AutoExplore.Enabled = false
    toggleFlyMode(false)
    if exploreConnection then
        exploreConnection:Disconnect()
    end
    Rayfield:Notify({
        Title = "⏹️ ОСТАНОВЛЕНО",
        Content = "Эксплоит остановлен",
        Duration = 3,
        Image = 4483362458
    })
end)

createMobileFriendlyButton(ExploreTab, IS_MOBILE and "📦 СОРТИРОВКА" or "📦 СИЛОЙ ЗАВЕРШИТЬ", function()
    autoCompleteExploit()
end)

-- 📍 ВКЛАДКА ТЕЛЕПОРТА
local TeleportTab = Window:CreateTab(IS_MOBILE and "📍 ТП" or "📍 Телепорт", 4483362458)

createMobileFriendlyButton(TeleportTab, IS_MOBILE and "👶 ТП к ребенку" or "👶 ТП к ребенку", function()
    local child = findChild()
    if child then
        Character.HumanoidRootPart.CFrame = child.HumanoidRootPart.CFrame
        Rayfield:Notify({
            Title = "✅ ТЕЛЕПОРТ",
            Content = "Успешно телепортирован к ребенку!",
            Duration = 3,
            Image = 4483362458
        })
    else
        Rayfield:Notify({
            Title = "❌ ОШИБКА",
            Content = "Ребенок не найден!",
            Duration = 3,
            Image = 4483362458
        })
    end
end)

createMobileFriendlyButton(TeleportTab, IS_MOBILE and "🔥 ТП к костру" or "🔥 ТП к костру", function()
    teleportToFire()
end)

-- 🦅 ВКЛАДКА ПОЛЕТА
local FlyTab = Window:CreateTab(IS_MOBILE and "🦅 Полёт" or "🦅 Ручной полет", 4483362458)

createMobileToggle(FlyTab, IS_MOBILE and "🦅 Режим полета" or "🦅 Режим полета", "FlyToggle", function(Value)
    getgenv().IS1_Config.FlyMode.Enabled = Value
    toggleFlyMode(Value)
end)

-- 🏃 ВКЛАДКА ДВИЖЕНИЯ
local MoveTab = Window:CreateTab(IS_MOBILE and "🏃 Движение" or "🏃 Движение", 4483362458)

MoveTab:CreateSlider({
    Name = IS_MOBILE and "🚶 Скорость" or "🚶 Скорость ходьбы",
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

-- 🔧 АВТО-ВОССТАНОВЛЕНИЕ ПРИ СМЕНЕ ПЕРСОНАЖА
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    wait(2)
    
    -- ВОССТАНАВЛИВАЕМ НАСТРОЙКИ
    if getgenv().IS1_Config then
        Character.Humanoid.WalkSpeed = getgenv().IS1_Config.Movement.WalkSpeed or 16
    end
    
    Rayfield:Notify({
        Title = "🔧 ПЕРСОНАЖ ОБНОВЛЕН",
        Content = "Настройки движения восстановлены",
        Duration = 3,
        Image = 4483362458
    })
end)

Rayfield:LoadConfiguration()

-- 📊 АВТООБНОВЛЕНИЕ ПРОГРЕССА
spawn(function()
    while true do
        wait(5)
        if getgenv().IS1_Config.AutoExplore.Enabled and progressLabel then
            local center = workspace:FindFirstChild("Campfire")
            if center then
                local currentPos = Character.HumanoidRootPart.Position
                local distanceFromCenter = (currentPos - center.PrimaryPart.Position).Magnitude
                local progress = (distanceFromCenter / getgenv().IS1_Config.AutoComplete.MapBounds) * 100
                progressLabel:Set(IS_MOBILE and 
                    ("📊 " .. math.min(math.floor(progress), 100) .. "%") : 
                    ("Прогресс: " .. math.min(math.floor(progress), 100) .. "%")
                )
            end
        end
    end
end)

Rayfield:Notify({
    Title = IS_MOBILE and "📱 СКРИПТ ЗАГРУЖЕН!" or "🎮 СКРИПТ АКТИВИРОВАН!",
    Content = IS_MOBILE and "Оптимизировано для телефона!" or "Полный функционал готов!",
    Duration = 6,
    Image = 4483362458
})