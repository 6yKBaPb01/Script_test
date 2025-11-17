-- 99 ночей в лесу - COMPLETE FIXED EDITION
-- ПОЛНЫЙ СКРИПТ БЕЗ ПРОПУЩЕННЫХ ФУНКЦИЙ

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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

-- 🔧 ЗАГРУЗКА RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = IS_MOBILE and "99 ночей 📱" or "99 ночей - ULTIMATE",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = IS_MOBILE and "Mobile Optimized" or "PC Edition",
    ConfigurationSaving = {Enabled = false}
})

-- 🔧 ФУНКЦИЯ АВТОСОРТИРОВКИ (КОТОРУЮ Я ЗАБЫЛ!)
function autoCompleteExploit()
    pcall(function()
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
            if not success and getgenv().StartPosition then
                Character.HumanoidRootPart.CFrame = CFrame.new(getgenv().StartPosition)
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
    end)
end

-- 🔧 ФУНКЦИЯ ПРОВЕРКИ ГРАНИЦ (КОТОРУЮ Я ЗАБЫЛ!)
function checkMapBounds(position)
    local bounds = getgenv().IS1_Config.AutoComplete.MapBounds
    return math.abs(position.X) > bounds or math.abs(position.Z) > bounds
end

-- 🔧 ФУНКЦИЯ ТЕЛЕПОРТА К КОСТРУ
function teleportToFire()
    pcall(function()
        local fire
        for _, name in pairs({"Campfire", "Fire", "CampFire", "MainFire"}) do
            fire = workspace:FindFirstChild(name)
            if fire then break end
        end
        
        if not fire then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Part") and (obj.Name:lower():find("fire") or obj.BrickColor == BrickColor.new("Bright orange")) then
                    fire = obj
                    break
                end
            end
        end
        
        if fire then
            local targetPosition
            if fire:IsA("Model") and fire.PrimaryPart then
                targetPosition = fire.PrimaryPart.Position
            else
                targetPosition = fire.Position
            end
            
            Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))
            
            Rayfield:Notify({
                Title = "✅ ТЕЛЕПОРТ",
                Content = "Успешно телепортирован к костру!",
                Duration = 3,
                Image = 4483362458
            })
            return true
        else
            Rayfield:Notify({
                Title = "❌ ОШИБКА",
                Content = "Костер не найден в мире!",
                Duration = 4,
                Image = 4483362458
            })
            return false
        end
    end)
end

-- 🔧 ФУНКЦИЯ ПОЛЕТА
function toggleFlyMode(state)
    pcall(function()
        if state then
            if flyConnection then flyConnection:Disconnect() end
            if noclipConnection then noclipConnection:Disconnect() end
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
            
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
                if not bodyGyro or not bodyVelocity or not Character or not Character.Parent then
                    return
                end
                
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                
                local direction = Vector3.new()
                
                if IS_PC then
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
                    direction = workspace.CurrentCamera.CFrame.LookVector
                end
                
                bodyVelocity.Velocity = direction * getgenv().IS1_Config.FlyMode.Speed
            end)
            
            if getgenv().IS1_Config.FlyMode.Noclip then
                noclipConnection = RunService.Stepped:Connect(function()
                    if not Character or not Character.Parent then return end
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            end
            
        else
            if flyConnection then flyConnection:Disconnect() flyConnection = nil end
            if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
            if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
            if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
            
            if Character and Character.Parent then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end)
end

-- 🔧 ФУНКЦИЯ АВТОЭКСПЛОИТА
function startAutoExplore()
    pcall(function()
        if exploreConnection then
            exploreConnection:Disconnect()
            exploreConnection = nil
        end
        
        local center
        for _, name in pairs({"Campfire", "Fire", "CampFire"}) do
            center = workspace:FindFirstChild(name)
            if center then break end
        end
        if not center then
            center = Character.HumanoidRootPart
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
            
            if not Character or not Character.Parent or not Character:FindFirstChild("HumanoidRootPart") then
                getgenv().IS1_Config.AutoExplore.Enabled = false
                return
            end
            
            local currentPos = Character.HumanoidRootPart.Position
            
            if currentRadius >= maxRadius or checkMapBounds(currentPos) then
                getgenv().IS1_Config.AutoExplore.Enabled = false
                autoCompleteExploit()
                return
            end
            
            currentAngle = currentAngle + 0.03
            currentRadius = currentRadius + (IS_MOBILE and 1.5 or 2)
            
            local x = math.cos(currentAngle) * currentRadius
            local z = math.sin(currentAngle) * currentRadius
            local y = getgenv().IS1_Config.AutoExplore.Height
            
            local targetPosition
            if center:IsA("Model") and center.PrimaryPart then
                targetPosition = center.PrimaryPart.Position + Vector3.new(x, y, z)
            else
                targetPosition = center.Position + Vector3.new(x, y, z)
            end
            
            Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            
            if getgenv().IS1_Config.AutoExplore.CollectResources then
                collectResourcesInRadius(IS_MOBILE and 30 or 50)
            end
            
            local progress = (currentRadius / maxRadius) * 100
            if progressLabel then
                progressLabel:Set(IS_MOBILE and 
                    ("📊 " .. math.floor(progress) .. "%") : 
                    ("Прогресс: " .. math.floor(progress) .. "%")
                )
            end
        end)
    end)
end

-- 🔧 ФУНКЦИЯ СБОРА РЕСУРСОВ
function collectResourcesInRadius(radius)
    pcall(function()
        if not Character or not Character.Parent then return end
        
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and item:FindFirstChild("ClickDetector") then
                local distance = (Character.HumanoidRootPart.Position - item.Position).Magnitude
                if distance <= radius then
                    pcall(function()
                        fireclickdetector(item.ClickDetector)
                    end)
                    wait(0.01)
                end
            end
        end
    end)
end

-- 🔧 ФУНКЦИЯ ПОИСКА РЕБЕНКА
function findChild()
    pcall(function()
        for _, child in pairs(workspace:GetDescendants()) do
            if child:IsA("Model") and child:FindFirstChild("Humanoid") then
                if child.Name:lower():find("child") or child.Name:lower():find("kid") then
                    return child
                end
            end
        end
    end)
    return nil
end

-- 📱 СОЗДАЕМ ИНТЕРФЕЙС
local MainTab = Window:CreateTab("🏠 Главная")

local childStatusLabel = MainTab:CreateLabel(IS_MOBILE and "👶: Поиск..." or "Ребенок: Поиск...")

spawn(function()
    while true do
        wait(5)
        pcall(function()
            local child = findChild()
            if child then
                getgenv().ChildLocation = child:GetPivot().Position
                childStatusLabel:Set(IS_MOBILE and "👶: Найден!" or "Ребенок: ✅ Найден")
            else
                childStatusLabel:Set(IS_MOBILE and "👶: Не найден" or "Ребенок: ❌ Не найден")
            end
        end)
    end
end)

-- 🚀 ВКЛАДКА ЭКСПЛОИТА
local ExploreTab = Window:CreateTab("🚀 Эксплоит")

local progressLabel = ExploreTab:CreateLabel("Прогресс: 0%")

ExploreTab:CreateButton({
    Name = IS_MOBILE and "🚀 СТАРТ" or "🚀 ЗАПУСТИТЬ ЭКСПЛОИТ",
    Callback = function()
        getgenv().IS1_Config.AutoExplore.Enabled = true
        toggleFlyMode(true)
        startAutoExplore()
    end
})

ExploreTab:CreateButton({
    Name = IS_MOBILE and "⏹️ СТОП" or "⏹️ ОСТАНОВИТЬ",
    Callback = function()
        getgenv().IS1_Config.AutoExplore.Enabled = false
        toggleFlyMode(false)
    end
})

ExploreTab:CreateButton({
    Name = IS_MOBILE and "📦 СОРТИРОВКА" or "📦 БЫСТРАЯ СОРТИРОВКА",
    Callback = function()
        autoCompleteExploit()
    end
})

-- 📍 ВКЛАДКА ТЕЛЕПОРТА
local TeleportTab = Window:CreateTab("📍 Телепорт")

TeleportTab:CreateButton({
    Name = "👶 К РЕБЕНКУ",
    Callback = function()
        pcall(function()
            local child = findChild()
            if child then
                Character.HumanoidRootPart.CFrame = child:GetPivot()
                Rayfield:Notify({
                    Title = "✅ ТЕЛЕПОРТ",
                    Content = "К ребенку!",
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
    end
})

TeleportTab:CreateButton({
    Name = "🔥 К КОСТРУ",
    Callback = function()
        teleportToFire()
    end
})

-- 🦅 ВКЛАДКА ПОЛЕТА
local FlyTab = Window:CreateTab("🦅 Полёт")

FlyTab:CreateToggle({
    Name = "ВКЛ/ВЫКЛ ПОЛЕТ",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().IS1_Config.FlyMode.Enabled = Value
        toggleFlyMode(Value)
    end
})

-- 🏃 ВКЛАДКА ДВИЖЕНИЯ
local MoveTab = Window:CreateTab("🏃 Движение")

MoveTab:CreateSlider({
    Name = "СКОРОСТЬ",
    Range = {16, 100},
    Increment = 5,
    Suffix = "studs",
    CurrentValue = 16,
    Callback = function(Value)
        pcall(function()
            getgenv().IS1_Config.Movement.WalkSpeed = Value
            Character.Humanoid.WalkSpeed = Value
        end)
    end
})

-- 🔧 ВОССТАНОВЛЕНИЕ ПРИ СМЕНЕ ПЕРСОНАЖА
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    wait(3)
    pcall(function()
        if getgenv().IS1_Config then
            Character.Humanoid.WalkSpeed = getgenv().IS1_Config.Movement.WalkSpeed or 16
        end
    end)
end)

-- ЗАГРУЗКА КОНФИГУРАЦИИ
Rayfield:LoadConfiguration()

Rayfield:Notify({
    Title = "✅ СКРИПТ ЗАГРУЖЕН!",
    Content = "Все функции активны!",
    Duration = 5,
    Image = 4483362458
})