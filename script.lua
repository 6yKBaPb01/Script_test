-- 99 ночей в лесу - ULTIMATE COMPLETE SCRIPT
-- ВСЕ ФУНКЦИИ: АВТОЭКСПЛОИТ, ПОЛЕТ, ТЕЛЕПОРТЫ, АВТОСБОР, АВТОСАЖАНИЕ, ТП ИГРОКОВ

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ЖДЕМ ЗАГРУЗКИ
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
wait(2)

-- КОНФИГ
getgenv().IS1_Config = {
    AutoExplore = {
        Enabled = false, 
        Speed = 100, 
        Height = 50,
        CollectResources = true,
        FindChild = true,
        MapBounds = 2000
    },
    FlyMode = {
        Enabled = false, 
        Speed = 50, 
        Noclip = true
    },
    Movement = {
        WalkSpeed = 16, 
        JumpPower = 50
    },
    AutoCollect = {
        Wood = true, Metal = true, Food = true, 
        Tools = true, Chairs = true, Fuel = true,
        Ammo = true, Weapons = true, Saplings = true
    },
    AutoPlant = {
        Enabled = false,
        Mode = "TreeInTree",
        Speed = 2,
        CollectSaplings = true
    },
    AutoComplete = {
        Enabled = true,
        ReturnToFire = true,
        CraftToWorkbench = true,
        FuelToFire = true
    }
}

-- ПЕРЕМЕННЫЕ
local flyConnection, noclipConnection, exploreConnection, plantConnection
local bodyVelocity, bodyGyro
local selectedPlayers = {}
getgenv().StartPosition = nil
getgenv().ChildLocation = nil

-- ЗАГРУЗКА RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local Window = Rayfield:CreateWindow({
    Name = "99 ночей - ULTIMATE",
    LoadingTitle = "Загрузка...",
    ConfigurationSaving = {Enabled = false}
})

-- 🔧 ОСНОВНЫЕ ФУНКЦИИ
function findFire()
    for _, name in pairs({"Campfire", "Fire", "CampFire", "MainFire"}) do
        local fire = workspace:FindFirstChild(name)
        if fire then return fire end
    end
    return nil
end

function findChild()
    for _, child in pairs(workspace:GetDescendants()) do
        if child:IsA("Model") and child:FindFirstChild("Humanoid") then
            if child.Name:lower():find("child") or child.Name:lower():find("kid") then
                return child
            end
        end
    end
    return nil
end

function teleportToFire()
    local fire = findFire()
    if not fire then
        Rayfield:Notify({Title = "❌ ОШИБКА", Content = "Костер не найден!", Duration = 4})
        return false
    end
    
    local targetPosition = fire:IsA("Model") and fire.PrimaryPart and fire.PrimaryPart.Position or fire.Position
    Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))
    Rayfield:Notify({Title = "✅ УСПЕХ", Content = "Телепорт к костру!", Duration = 3})
    return true
end

function teleportToChild()
    local child = findChild()
    if child then
        Character.HumanoidRootPart.CFrame = child:GetPivot() or child.PrimaryPart.CFrame
        Rayfield:Notify({Title = "✅ УСПЕХ", Content = "Телепорт к ребенку!", Duration = 3})
    else
        Rayfield:Notify({Title = "❌ ОШИБКА", Content = "Ребенок не найден!", Duration = 3})
    end
end

-- 📦 СИСТЕМА СБОРА ПРЕДМЕТОВ
function collectItems(itemType)
    local collected = 0
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Part") and item:FindFirstChild("ClickDetector") then
            local shouldCollect = false
            
            if itemType == "Wood" and (item.Name:find("Wood") or item.Name:find("Log") or item.Name:find("Plank")) then
                shouldCollect = true
            elseif itemType == "Metal" and (item.Name:find("Metal") or item.Name:find("Iron") or item.Name:find("Steel")) then
                shouldCollect = true
            elseif itemType == "Food" and (item.Name:find("Morsel") or item.Name:find("Steak") or item.Name:find("Ribs") or item.Name:find("Fish") or item.Name:find("Carrot")) then
                shouldCollect = true
            elseif itemType == "Tools" and (item.Name:find("Tool") or item.Name:find("Flashlight") or item.Name:find("Axe") or item.Name:find("Pickaxe")) then
                shouldCollect = true
            elseif itemType == "Chairs" and (item.Name:find("Chair") or item.Name:find("Stool")) then
                shouldCollect = true
            elseif itemType == "Fuel" and (item.Name:find("Coal") or item.Name:find("Canister") or item.Name:find("Barrel")) then
                shouldCollect = true
            elseif itemType == "Weapons" and (item.Name:find("Rifle") or item.Name:find("Gun") or item.Name:find("Pistol") or item.Name:find("Shotgun")) then
                shouldCollect = true
            elseif itemType == "Ammo" and (item.Name:find("Ammo") or item.Name:find("Bullet") or item.Name:find("Magazine")) then
                shouldCollect = true
            elseif itemType == "Saplings" and (item.Name:find("Sapling") or item.Name:find("Seed") or item.Name:find("Plant")) then
                shouldCollect = true
            elseif itemType == "All" then
                shouldCollect = true
            end
            
            if shouldCollect and getgenv().IS1_Config.AutoCollect[itemType] ~= false then
                pcall(function()
                    fireclickdetector(item.ClickDetector)
                    collected = collected + 1
                    wait(0.01)
                end)
            end
        end
    end
    
    Rayfield:Notify({
        Title = "📦 ВЗЯТИЕ ПРЕДМЕТОВ",
        Content = "Собрано " .. collected .. " предметов типа: " .. itemType,
        Duration = 4
    })
end

-- 🎯 СИСТЕМА ТП ИГРОКОВ
function teleportSelectedPlayersToFire()
    local fire = findFire()
    if not fire then return end
    
    local targetPosition = fire:IsA("Model") and fire.PrimaryPart and fire.PrimaryPart.Position or fire.Position
    local teleportedCount = 0
    
    for playerName, shouldTeleport in pairs(selectedPlayers) do
        if shouldTeleport then
            local player = Players:FindFirstChild(playerName)
            if player and player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(
                        math.random(-3, 3), 3, math.random(-3, 3)
                    ))
                    teleportedCount = teleportedCount + 1
                    wait(0.1)
                end)
            end
        end
    end
    
    Rayfield:Notify({
        Title = "🎯 ВЫБОРОЧНЫЙ ТП",
        Content = "Телепортировано " .. teleportedCount .. " выбранных игроков!",
        Duration = 5
    })
end

function teleportAllPlayersToFire()
    local fire = findFire()
    if not fire then return end
    
    local targetPosition = fire:IsA("Model") and fire.PrimaryPart and fire.PrimaryPart.Position or fire.Position
    local teleportedCount = 0
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(
                    math.random(-5, 5), 3, math.random(-5, 5)
                ))
                teleportedCount = teleportedCount + 1
                wait(0.1)
            end)
        end
    end
    
    Rayfield:Notify({
        Title = "💥 ТП ВСЕХ ИГРОКОВ",
        Content = "Телепортировано " .. teleportedCount .. " игроков!",
        Duration = 5
    })
end

-- 🦅 СИСТЕМА ПОЛЕТА
function toggleFlyMode(state)
    if state then
        if flyConnection then flyConnection:Disconnect() end
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Parent = Character.HumanoidRootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
        bodyGyro.Parent = Character.HumanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not bodyGyro or not bodyVelocity then return end
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            
            local direction = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end
            
            bodyVelocity.Velocity = direction * getgenv().IS1_Config.FlyMode.Speed
        end)
        
        if getgenv().IS1_Config.FlyMode.Noclip then
            noclipConnection = RunService.Stepped:Connect(function()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end)
        end
        
        Rayfield:Notify({Title = "🦅 ПОЛЕТ АКТИВЕН", Content = "WASD + Space/Shift для управления", Duration = 4})
    else
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- 🚀 СИСТЕМА АВТОЭКСПЛОИТА
function startAutoExplore()
    local center = findFire() or Character.HumanoidRootPart
    if not center then return end
    
    getgenv().StartPosition = Character.HumanoidRootPart.Position
    local currentAngle, currentRadius = 0, 10
    local maxRadius = getgenv().IS1_Config.AutoExplore.MapBounds
    
    exploreConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().IS1_Config.AutoExplore.Enabled then
            if exploreConnection then exploreConnection:Disconnect() end
            return
        end
        
        if currentRadius >= maxRadius then
            getgenv().IS1_Config.AutoExplore.Enabled = false
            Rayfield:Notify({Title = "✅ ЗАВЕРШЕНО", Content = "Карта полностью исследована!", Duration = 5})
            return
        end
        
        currentAngle = currentAngle + 0.05
        currentRadius = currentRadius + 2
        
        local x, z = math.cos(currentAngle) * currentRadius, math.sin(currentAngle) * currentRadius
        local targetPosition = (center:IsA("Model") and center.PrimaryPart and center.PrimaryPart.Position or center.Position) + Vector3.new(x, getgenv().IS1_Config.AutoExplore.Height, z)
        
        Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        
        -- АВТОСБОР РЕСУРСОВ ВО ВРЕМЯ ПОЛЕТА
        if getgenv().IS1_Config.AutoExplore.CollectResources then
            for _, item in pairs(workspace:GetDescendants()) do
                if item:IsA("Part") and item:FindFirstChild("ClickDetector") then
                    local distance = (Character.HumanoidRootPart.Position - item.Position).Magnitude
                    if distance <= 50 then
                        pcall(function() 
                            fireclickdetector(item.ClickDetector)
                            wait(0.01)
                        end)
                    end
                end
            end
        end
        
        -- ПОИСК РЕБЕНКА
        if getgenv().IS1_Config.AutoExplore.FindChild then
            local child = findChild()
            if child then
                getgenv().ChildLocation = child:GetPivot().Position
            end
        end
    end)
end

-- 🌳 СИСТЕМА АВТОСАЖАНИЯ С ЗАБОРОМ САЖЕНЦЕВ
function startAutoPlanting()
    local fire = findFire()
    if not fire then
        Rayfield:Notify({Title = "❌ ОШИБКА", Content = "Костер не найден для посадки!", Duration = 4})
        getgenv().IS1_Config.AutoPlant.Enabled = false
        return
    end
    
    local firePosition = fire:IsA("Model") and fire.PrimaryPart and fire.PrimaryPart.Position or fire.Position
    
    plantConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().IS1_Config.AutoPlant.Enabled then
            if plantConnection then plantConnection:Disconnect() end
            return
        end
        
        -- 🔧 СНАЧАЛА СОБИРАЕМ САЖЕНЦЫ С КАРТЫ
        if getgenv().IS1_Config.AutoPlant.CollectSaplings then
            for _, item in pairs(workspace:GetDescendants()) do
                if item:IsA("Part") and item:FindFirstChild("ClickDetector") then
                    if item.Name:find("Sapling") or item.Name:find("Seed") then
                        local distance = (Character.HumanoidRootPart.Position - item.Position).Magnitude
                        if distance <= 30 then
                            pcall(function()
                                fireclickdetector(item.ClickDetector)
                                wait(0.05)
                            end)
                        end
                    end
                end
            end
        end
        
        -- 🌳 ЗАТЕМ САЖАЕМ ДЕРЕВЬЯ
        if getgenv().IS1_Config.AutoPlant.Mode == "TreeInTree" then
            -- ДЕРЕВО В ДЕРЕВЕ
            local plantPosition = firePosition + Vector3.new(5, 0, 0)
            Character.HumanoidRootPart.CFrame = CFrame.new(plantPosition)
            
            pcall(function()
                -- ПОПЫТКА ПОСАДКИ РАЗНЫМИ СПОСОБАМИ
                local plantTool = LocalPlayer.Backpack:FindFirstChild("PlantTool") or Character:FindFirstChild("PlantTool")
                if plantTool then
                    plantTool:Activate()
                else
                    local plantEvent = game:GetService("ReplicatedStorage"):FindFirstChild("PlantTree")
                    if plantEvent then
                        plantEvent:FireServer(plantPosition)
                    end
                end
            end)
            
        elseif getgenv().IS1_Config.AutoPlant.Mode == "Wall" then
            -- СТЕНА ИЗ ДЕРЕВЬЕВ
            for i = 1, 8 do
                if not getgenv().IS1_Config.AutoPlant.Enabled then break end
                
                local angle = (i / 8) * math.pi * 2
                local x = math.cos(angle) * 15
                local z = math.sin(angle) * 15
                local plantPosition = firePosition + Vector3.new(x, 0, z)
                
                Character.HumanoidRootPart.CFrame = CFrame.new(plantPosition)
                
                pcall(function()
                    local plantEvent = game:GetService("ReplicatedStorage"):FindFirstChild("PlantTree")
                    if plantEvent then
                        plantEvent:FireServer(plantPosition)
                    end
                end)
                
                wait(0.5)
            end
        end
        
        wait(getgenv().IS1_Config.AutoPlant.Speed)
    end)
end

function stopAutoPlanting()
    getgenv().IS1_Config.AutoPlant.Enabled = false
    if plantConnection then
        plantConnection:Disconnect()
        plantConnection = nil
    end
end

-- 📦 СИСТЕМА АВТОСОРТИРОВКИ
function autoSortResources()
    local fire = findFire()
    local workbench = workspace:FindFirstChild("Workbench") or workspace:FindFirstChild("CraftingTable")
    
    Rayfield:Notify({Title = "📦 СОРТИРОВКА", Content = "Начинаем сортировку ресурсов...", Duration = 4})
    
    if fire and getgenv().IS1_Config.AutoComplete.FuelToFire then
        -- ТОПЛИВО В КОСТЕР
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and (item.Name:find("Coal") or item.Name:find("Canister") or item.Name:find("Barrel")) then
                item.CFrame = (fire:IsA("Model") and fire.PrimaryPart and fire.PrimaryPart.CFrame or fire.CFrame) + Vector3.new(0, 2, 0)
            end
        end
    end
    
    if workbench and getgenv().IS1_Config.AutoComplete.CraftToWorkbench then
        -- РЕСУРСЫ В ВЕРСТАК
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and (item.Name:find("Metal") or item.Name:find("Wood") or item.Name:find("Chair")) then
                item.CFrame = workbench.PrimaryPart.CFrame + Vector3.new(math.random(-3, 3), 2, math.random(-3, 3))
            end
        end
    end
    
    -- ТУЛЫ В СТАРТОВУЮ ПОЗИЦИЮ
    if getgenv().StartPosition then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and (item.Name:find("Axe") or item.Name:find("Rifle") or item.Name:find("Tool") or item.Name:find("Flashlight")) then
                item.CFrame = CFrame.new(getgenv().StartPosition + Vector3.new(math.random(-2, 2), 1, math.random(-2, 2)))
            end
        end
    end
    
    Rayfield:Notify({Title = "✅ СОРТИРОВКА ЗАВЕРШЕНА", Content = "Все ресурсы разложены!", Duration = 4})
end

-- 📱 ИНТЕРФЕЙС
local MainTab = Window:CreateTab("🏠 Главная")

MainTab:CreateButton({Name = "🔥 ТП к костру", Callback = teleportToFire})
MainTab:CreateButton({Name = "👶 ТП к ребенку", Callback = teleportToChild})

-- 📦 ВЗЯТИЕ ПРЕДМЕТОВ
MainTab:CreateSection("📦 Взять предметы")
local itemTypes = {"Wood", "Metal", "Food", "Tools", "Chairs", "Fuel", "Weapons", "Ammo", "Saplings", "All"}
for _, itemType in pairs(itemTypes) do
    MainTab:CreateButton({
        Name = "📦 Взять " .. itemType,
        Callback = function() collectItems(itemType) end
    })
end

-- 🎯 ВЫБОР ИГРОКОВ
local PlayerTab = Window:CreateTab("🎯 Игроки")
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        PlayerTab:CreateToggle({
            Name = "👤 " .. player.Name,
            CurrentValue = false,
            Callback = function(Value) selectedPlayers[player.Name] = Value end
        })
    end
end

PlayerTab:CreateButton({Name = "🎯 ТП ВЫБРАННЫХ В КОСТЕР", Callback = teleportSelectedPlayersToFire})
PlayerTab:CreateButton({Name = "💥 ТП ВСЕХ В КОСТЕР", Callback = teleportAllPlayersToFire})

-- 🚀 ЭКСПЛОИТ
local ExploreTab = Window:CreateTab("🚀 Эксплоит")
ExploreTab:CreateToggle({
    Name = "Авто-эксплоит карты", 
    CurrentValue = false,
    Callback = function(Value)
        getgenv().IS1_Config.AutoExplore.Enabled = Value
        if Value then 
            startAutoExplore()
            Rayfield:Notify({Title = "🚀 ЭКСПЛОИТ", Content = "Автообход карты запущен!", Duration = 4})
        end
    end
})

ExploreTab:CreateButton({Name = "📦 Авто-сортировка", Callback = autoSortResources})

-- 🌳 ПОСАДКА
local PlantTab = Window:CreateTab("🌳 Посадка")
PlantTab:CreateToggle({
    Name = "Включить авто-посадку",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().IS1_Config.AutoPlant.Enabled = Value
        if Value then 
            startAutoPlanting()
            Rayfield:Notify({Title = "🌳 АВТОСАЖАНИЕ", Content = "Сбор саженцев и посадка!", Duration = 4})
        else
            stopAutoPlanting()
        end
    end
})

PlantTab:CreateDropdown({
    Name = "Режим посадки",
    Options = {"TreeInTree", "Wall"},
    CurrentOption = "TreeInTree",
    Callback = function(Option) getgenv().IS1_Config.AutoPlant.Mode = Option end
})

PlantTab:CreateToggle({
    Name = "Собирать саженцы с карты",
    CurrentValue = true,
    Callback = function(Value) getgenv().IS1_Config.AutoPlant.CollectSaplings = Value end
})

-- 🦅 ПОЛЕТ
local FlyTab = Window:CreateTab("🦅 Полёт")
FlyTab:CreateToggle({
    Name = "🦅 Включить полет",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().IS1_Config.FlyMode.Enabled = Value
        toggleFlyMode(Value)
    end
})

-- 🏃 ДВИЖЕНИЕ
local MoveTab = Window:CreateTab("🏃 Движение")
MoveTab:CreateSlider({
    Name = "Скорость ходьбы",
    Range = {16, 100},
    Increment = 5,
    Suffix = "studs",
    CurrentValue = 16,
    Callback = function(Value)
        getgenv().IS1_Config.Movement.WalkSpeed = Value
        Character.Humanoid.WalkSpeed = Value
    end
})

-- 🔧 АВТОВОССТАНОВЛЕНИЕ
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    wait(2)
    if getgenv().IS1_Config then
        Character.Humanoid.WalkSpeed = getgenv().IS1_Config.Movement.WalkSpeed or 16
    end
end)

Rayfield:Notify({
    Title = "🎉 ПОЛНЫЙ СКРИПТ ЗАГРУЖЕН!",
    Content = "Все функции активны! Автосажание с сбором саженцев!",
    Duration = 6
})

print("✅ ULTIMATE COMPLETE SCRIPT LOADED!")