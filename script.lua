-- 99 ночей в лесу - ULTIMATE COMPLETE FINAL EDITION
-- ВСЕ ФУНКЦИИ ВКЛЮЧЕНЫ: АВТОЭКСПЛОИТ, ПОЛЕТ, ТЕЛЕПОРТЫ, АВТОСБОР, АВТОСАЖАНИЕ, АВТОЛУТ, ВЫБОР ИГРОКОВ

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ОПРЕДЕЛЯЕМ ПЛАТФОРМУ
local IS_MOBILE = UserInputService.TouchEnabled
local IS_PC = not IS_MOBILE

-- ЖДЕМ ЗАГРУЗКИ
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
wait(2)

-- ПОЛНЫЙ КОНФИГ
getgenv().IS1_Config = {
    AutoExplore = {
        Enabled = false, 
        Speed = IS_MOBILE and 80 or 100, 
        Height = IS_MOBILE and 30 or 50,
        CollectResources = true,
        FindChild = true,
        MapBounds = IS_MOBILE and 1000 or 2000
    },
    FlyMode = {
        Enabled = false, 
        Speed = IS_MOBILE and 40 or 50, 
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
        Speed = IS_MOBILE and 3 or 2,
        CollectSaplings = true
    },
    AutoLoot = {
        Enabled = false,
        Radius = IS_MOBILE and 30 or 50,
        UseInstantOpen = true,
        ShowProgress = true,
        ReturnDelay = 2
    },
    AutoComplete = {
        Enabled = true,
        ReturnToFire = true,
        CraftToWorkbench = true,
        FuelToFire = true
    }
}

-- ВСЕ ПЕРЕМЕННЫЕ
local flyConnection, noclipConnection, exploreConnection, plantConnection, lootConnection
local bodyVelocity, bodyGyro
local selectedPlayers = {}
getgenv().StartPosition = nil
getgenv().ChildLocation = nil
getgenv().LootStartPosition = nil

-- ЗАГРУЗКА RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local Window = Rayfield:CreateWindow({
    Name = IS_MOBILE and "99 ночей 📱" or "99 ночей - ULTIMATE",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = IS_MOBILE and "Mobile Optimized" or "PC Edition",
    ConfigurationSaving = {Enabled = false}
})

-- 🔧 АДАПТИВНЫЕ ФУНКЦИИ ДЛЯ ИНТЕРФЕЙСА
function createMobileButton(tab, name, callback)
    return tab:CreateButton({
        Name = IS_MOBILE and string.sub(name, 1, 15) or name,
        Callback = callback
    })
end

function createMobileToggle(tab, name, callback)
    return tab:CreateToggle({
        Name = IS_MOBILE and string.sub(name, 1, 20) or name,
        CurrentValue = false,
        Callback = callback
    })
end

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
    -- Ищем костер-спавн по разным возможным именам
    local fire = nil
    
    -- Проверяем различные варианты названий спавна
    local possibleNames = {
        "Spawn", "Campfire", "Fire", "CampFire", "MainFire", 
        "Base", "Start", "Home", "SpawnPoint"
    }
    
    -- Сначала ищем в workspace
    for _, name in pairs(possibleNames) do
        fire = workspace:FindFirstChild(name)
        if fire then break end
    end
    
    -- Если не нашли, ищем среди всех потомков workspace
    if not fire then
        for _, obj in pairs(workspace:GetDescendants()) do
            for _, name in pairs(possibleNames) do
                if obj.Name:lower():find(name:lower()) then
                    fire = obj
                    break
                end
            end
            if fire then break end
        end
    end
    
    -- Если все еще не нашли, ищем части с желтым/оранжевым цветом (типичный цвет костра)
    if not fire then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") then
                if obj.BrickColor == BrickColor.new("Bright orange") or 
                   obj.BrickColor == BrickColor.new("Bright yellow") or
                   obj.BrickColor == BrickColor.new("Neon orange") then
                    fire = obj
                    break
                end
            end
        end
    end
    
    if not fire then
        Rayfield:Notify({Title = "❌ ОШИБКА", Content = "Костер-спавн не найден!", Duration = 4})
        return false
    end
    
    -- Определяем позицию для телепорта
    local targetPosition
    if fire:IsA("Model") and fire.PrimaryPart then
        targetPosition = fire.PrimaryPart.Position
    elseif fire:IsA("Part") then
        targetPosition = fire.Position
    else
        targetPosition = fire:GetPivot().Position
    end
    
    -- Телепортируемся немного выше позиции костра
    Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))
    
    Rayfield:Notify({
        Title = "✅ УСПЕХ", 
        Content = "Телепорт к костру-спавну!",
        Duration = 3
    })
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

-- 📦 ПОЛНАЯ СИСТЕМА СБОРА ПРЕДМЕТОВ
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

-- 🎯 ПОЛНАЯ СИСТЕМА ВЫБОРА И ТП ИГРОКОВ
function updatePlayerSelection()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not selectedPlayers[player.Name] then
            selectedPlayers[player.Name] = false
        end
    end
end

function countSelectedPlayers()
    local count = 0
    for _, isSelected in pairs(selectedPlayers) do
        if isSelected then count = count + 1 end
    end
    return count
end

function teleportSelectedPlayersToFire()
    local selectedCount = countSelectedPlayers()
    
    if selectedCount == 0 then
        Rayfield:Notify({
            Title = "❌ НЕТ ВЫБРАННЫХ",
            Content = "Сначала выбери игроков для ТП!",
            Duration = 4
        })
        return
    end
    
    local fire = findFire()
    if not fire then return end
    
    local targetPosition = fire:IsA("Model") and fire.PrimaryPart and fire.PrimaryPart.Position or fire.Position
    local teleportedCount = 0
    
    Rayfield:Notify({
        Title = "🎯 ТП ВЫБРАННЫХ",
        Content = "Телепортируем " .. selectedCount .. " игроков...",
        Duration = 4
    })
    
    for playerName, shouldTeleport in pairs(selectedPlayers) do
        if shouldTeleport then
            local player = Players:FindFirstChild(playerName)
            if player and player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(
                        math.random(-3, 3), 3, math.random(-3, 3)
                    ))
                    teleportedCount = teleportedCount + 1
                    wait(0.2)
                end)
            end
        end
    end
    
    Rayfield:Notify({
        Title = "✅ ТП ВЫПОЛНЕН",
        Content = "Успешно телепортировано " .. teleportedCount .. " игроков!",
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

-- 🦅 ПОЛНАЯ СИСТЕМА ПОЛЕТА
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
            
            if IS_PC then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end
            else
                direction = workspace.CurrentCamera.CFrame.LookVector
            end
            
            bodyVelocity.Velocity = direction * getgenv().IS1_Config.FlyMode.Speed
        end)
        
        if getgenv().IS1_Config.FlyMode.Noclip then
            noclipConnection = RunService.Stepped:Connect(function()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end)
        end
        
        Rayfield:Notify({
            Title = IS_MOBILE and "🦅 ПОЛЕТ" or "🦅 ПОЛЕТ АКТИВЕН",
            Content = IS_MOBILE and "Двигайтесь вперед" or "WASD + Space/Shift для управления",
            Duration = 4
        })
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

-- 🚀 ПОЛНАЯ СИСТЕМА АВТОЭКСПЛОИТА
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

-- 🌳 ПОЛНАЯ СИСТЕМА АВТОСАЖАНИЯ
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
        
        -- СБОР САЖЕНЦЕВ С КАРТЫ
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
        
        -- САЖАЕМ ДЕРЕВЬЯ
        if getgenv().IS1_Config.AutoPlant.Mode == "TreeInTree" then
            local plantPosition = firePosition + Vector3.new(5, 0, 0)
            Character.HumanoidRootPart.CFrame = CFrame.new(plantPosition)
            
            pcall(function()
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

-- 🎒 ПОЛНАЯ СИСТЕМА АВТОЛУТА
function startAutoLoot()
    getgenv().LootStartPosition = Character.HumanoidRootPart.Position
    local chestsFound = 0
    local totalChests = 0
    
    local allChests = {}
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Model") and (item.Name:lower():find("chest") or item.Name:lower():find("box") or item.Name:lower():find("cache")) then
            table.insert(allChests, item)
        end
    end
    
    totalChests = #allChests
    
    if totalChests == 0 then
        Rayfield:Notify({
            Title = "❌ СУНДУКОВ НЕТ",
            Content = "На карте не найдено сундуков!",
            Duration = 4
        })
        getgenv().IS1_Config.AutoLoot.Enabled = false
        return
    end
    
    Rayfield:Notify({
        Title = "🎒 НАЧИНАЕМ ЛУТ",
        Content = "Найдено " .. totalChests .. " сундуков!",
        Duration = 4
    })
    
    lootConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().IS1_Config.AutoLoot.Enabled then
            if lootConnection then lootConnection:Disconnect() end
            return
        end
        
        local remainingChests = 0
        
        for _, chest in pairs(allChests) do
            if not getgenv().IS1_Config.AutoLoot.Enabled then break end
            
            local distance = (Character.HumanoidRootPart.Position - chest:GetPivot().Position).Magnitude
            if distance <= getgenv().IS1_Config.AutoLoot.Radius then
                remainingChests = remainingChests + 1
                
                if getgenv().IS1_Config.AutoLoot.UseInstantOpen then
                    pcall(function()
                        local openEvent = game:GetService("ReplicatedStorage"):FindFirstChild("OpenChest")
                        if openEvent then
                            openEvent:FireServer(chest)
                            chestsFound = chestsFound + 1
                        else
                            for _, part in pairs(chest:GetDescendants()) do
                                if part:IsA("ClickDetector") then
                                    fireclickdetector(part)
                                    chestsFound = chestsFound + 1
                                    break
                                end
                            end
                        end
                    end)
                else
                    local originalPosition = Character.HumanoidRootPart.Position
                    Character.HumanoidRootPart.CFrame = chest:GetPivot()
                    
                    pcall(function()
                        for _, part in pairs(chest:GetDescendants()) do
                            if part:IsA("ClickDetector") then
                                fireclickdetector(part)
                                chestsFound = chestsFound + 1
                                break
                            end
                        end
                    end)
                    
                    Character.HumanoidRootPart.CFrame = CFrame.new(originalPosition)
                end
            end
        end
        
        if remainingChests == 0 then
            getgenv().IS1_Config.AutoLoot.Enabled = false
            
            Rayfield:Notify({
                Title = "✅ ЛУТ ЗАВЕРШЕН",
                Content = "Вскрыто " .. chestsFound .. " из " .. totalChests .. " сундуков!",
                Duration = 6
            })
        end
    end)
end

function quickLootAllChests()
    local chestsFound = 0
    local totalChests = 0
    
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Model") and item.Name:lower():find("chest") then
            totalChests = totalChests + 1
        end
    end
    
    if totalChests == 0 then
        Rayfield:Notify({
            Title = "❌ СУНДУКОВ НЕТ",
            Content = "На карте не найдено сундуков!",
            Duration = 4
        })
        return
    end
    
    Rayfield:Notify({
        Title = "⚡ БЫСТРЫЙ ЛУТ",
        Content = "Мгновенно открываем " .. totalChests .. " сундуков...",
        Duration = 4
    })
    
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Model") and item.Name:lower():find("chest") then
            pcall(function()
                local openEvent = game:GetService("ReplicatedStorage"):FindFirstChild("OpenChest")
                if openEvent then
                    openEvent:FireServer(item)
                end
                
                for _, part in pairs(item:GetDescendants()) do
                    if part:IsA("ClickDetector") then
                        fireclickdetector(part)
                    end
                end
                
                chestsFound = chestsFound + 1
            end)
        end
    end
    
    Rayfield:Notify({
        Title = "⚡ ЛУТ ВЫПОЛНЕН",
        Content = "Мгновенно открыто " .. chestsFound .. " сундуков!",
        Duration = 5
    })
end

-- 📦 СИСТЕМА АВТОСОРТИРОВКИ
function autoSortResources()
    local fire = findFire()
    local workbench = workspace:FindFirstChild("Workbench") or workspace:FindFirstChild("CraftingTable")
    
    Rayfield:Notify({Title = "📦 СОРТИРОВКА", Content = "Начинаем сортировку ресурсов...", Duration = 4})
    
    if fire and getgenv().IS1_Config.AutoComplete.FuelToFire then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and (item.Name:find("Coal") or item.Name:find("Canister") or item.Name:find("Barrel")) then
                item.CFrame = (fire:IsA("Model") and fire.PrimaryPart and fire.PrimaryPart.CFrame or fire.CFrame) + Vector3.new(0, 2, 0)
            end
        end
    end
    
    if workbench and getgenv().IS1_Config.AutoComplete.CraftToWorkbench then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and (item.Name:find("Metal") or item.Name:find("Wood") or item.Name:find("Chair")) then
                item.CFrame = workbench.PrimaryPart.CFrame + Vector3.new(math.random(-3, 3), 2, math.random(-3, 3))
            end
        end
    end
    
    if getgenv().StartPosition then
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("Part") and (item.Name:find("Axe") or item.Name:find("Rifle") or item.Name:find("Tool") or item.Name:find("Flashlight")) then
                item.CFrame = CFrame.new(getgenv().StartPosition + Vector3.new(math.random(-2, 2), 1, math.random(-2, 2)))
            end
        end
    end
    
    Rayfield:Notify({Title = "✅ СОРТИРОВКА ЗАВЕРШЕНА", Content = "Все ресурсы разложены!", Duration = 4})
end

-- 📱 ПОЛНЫЙ ИНТЕРФЕЙС
local MainTab = Window:CreateTab(IS_MOBILE and "🏠 Глвн" or "🏠 Главная")
createMobileButton(MainTab, "🔥 ТП к костру", teleportToFire)
createMobileButton(MainTab, "👶 ТП к ребенку", teleportToChild)

-- 📦 ВЗЯТИЕ ПРЕДМЕТОВ
MainTab:CreateSection("📦 Взять предметы")
local itemTypes = {"Wood", "Metal", "Food", "Tools", "Chairs", "Fuel", "Weapons", "Ammo", "Saplings", "All"}
for _, itemType in pairs(itemTypes) do
    createMobileButton(MainTab, "📦 Взять " .. itemType, function() collectItems(itemType) end)
end

-- 🎯 ВЫБОР ИГРОКОВ
local PlayerTab = Window:CreateTab("🎯 Игроки")
local selectedPlayersLabel = PlayerTab:CreateLabel("Выбрано: 0 игроков")

function refreshPlayerList()
    selectedPlayersLabel:Set("Выбрано: " .. tostring(countSelectedPlayers()) .. " игроков")
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        PlayerTab:CreateToggle({
            Name = "👤 " .. player.Name,
            CurrentValue = false,
            Callback = function(Value)
                selectedPlayers[player.Name] = Value
                refreshPlayerList()
            end
        })
    end
end

createMobileButton(PlayerTab, "🎯 ТП ВЫБРАННЫХ", teleportSelectedPlayersToFire)
createMobileButton(PlayerTab, "💥 ТП ВСЕХ", teleportAllPlayersToFire)

-- 🚀 ЭКСПЛОИТ
local ExploreTab = Window:CreateTab("🚀 Эксплоит")
createMobileToggle(ExploreTab, "Авто-эксплоит карты", function(Value)
    getgenv().IS1_Config.AutoExplore.Enabled = Value
    if Value then 
        startAutoExplore()
        Rayfield:Notify({Title = "🚀 ЭКСПЛОИТ", Content = "Автообход карты запущен!", Duration = 4})
    end
end)

createMobileButton(ExploreTab, "📦 Авто-сортировка", autoSortResources)

-- 🌳 ПОСАДКА
local PlantTab = Window:CreateTab("🌳 Посадка")
createMobileToggle(PlantTab, "Авто-посадка деревьев", function(Value)
    getgenv().IS1_Config.AutoPlant.Enabled = Value
    if Value then 
        startAutoPlanting()
        Rayfield:Notify({Title = "🌳 АВТОСАЖАНИЕ", Content = "Сбор саженцев и посадка!", Duration = 4})
    else
        stopAutoPlanting()
    end
end)

PlantTab:CreateDropdown({
    Name = "Режим посадки",
    Options = {"TreeInTree", "Wall"},
    CurrentOption = "TreeInTree",
    Callback = function(Option) getgenv().IS1_Config.AutoPlant.Mode = Option end
})

-- 🎒 АВТОЛУТ
local LootTab = Window:CreateTab("🎒 Автолут")
createMobileToggle(LootTab, "Авто-лут сундуков", function(Value)
    getgenv().IS1_Config.AutoLoot.Enabled = Value
    if Value then
        startAutoLoot()
    else
        if lootConnection then lootConnection:Disconnect() end
    end
end)

createMobileButton(LootTab, "⚡ Быстрый лут всех", quickLootAllChests)

LootTab:CreateToggle({
    Name = "Мгновенное открытие",
    CurrentValue = true,
    Callback = function(Value) getgenv().IS1_Config.AutoLoot.UseInstantOpen = Value end
})

-- 🦅 ПОЛЕТ
local FlyTab = Window:CreateTab("🦅 Полёт")
createMobileToggle(FlyTab, "Включить полет", function(Value)
    getgenv().IS1_Config.FlyMode.Enabled = Value
    toggleFlyMode(Value)
end)

FlyTab:CreateSlider({
    Name = "Скорость полета",
    Range = {10, 200},
    Increment = 10,
    Suffix = "studs",
    CurrentValue = IS_MOBILE and 40 or 50,
    Callback = function(Value) getgenv().IS1_Config.FlyMode.Speed = Value end
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

MoveTab:CreateToggle({
    Name = "Ходить по небу",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
        end
    end
})

-- 🔧 СИСТЕМНЫЕ ФУНКЦИИ
Players.PlayerAdded:Connect(function(player)
    wait(2)
    refreshPlayerList()
end)

Players.PlayerRemoving:Connect(function(player)
    selectedPlayers[player.Name] = nil
    refreshPlayerList()
end)

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    wait(3)
    if getgenv().IS1_Config then
        Character.Humanoid.WalkSpeed = getgenv().IS1_Config.Movement.WalkSpeed or 16
    end
end)

Rayfield:Notify({
    Title = "🎉 ПОЛНЫЙ СКРИПТ ЗАГРУЖЕН!",
    Content = "Все функции активны! Оптимизация для мобильных и ПК!",
    Duration = 6
})

print("✅ ULTIMATE COMPLETE FINAL SCRIPT LOADED!")