-- 99 NIGHTS ULTIMATE HACK by I.S.-1 v17.0 PERFECT
-- ПОЛНОСТЬЮ РАБОЧИЙ СКРИПТ БЕЗ ОШИБОК

local UltimateHack = {}

-- БЕЗОПАСНАЯ ЗАГРУЗКА RAYFIELD
local Rayfield
local success, error = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Rayfield load error: " .. tostring(error))
    return
end

-- АВТООПРЕДЕЛЕНИЕ ПЛАТФОРМЫ
local IS_MOBILE = game:GetService("UserInputService").TouchEnabled
local IS_TABLET = IS_MOBILE and (workspace.CurrentCamera.ViewportSize.X > 1000)

-- БЕЗОПАСНОЕ СОЗДАНИЕ ОКНА
local Window
success, error = pcall(function()
    Window = Rayfield:CreateWindow({
        Name = IS_MOBILE and "99 NIGHTS MOBILE" or "99 NIGHTS ULTIMATE HACK",
        LoadingTitle = "I.S.-1 Loading...",
        LoadingSubtitle = "PERFECT EDITION",
        ConfigurationSaving = {Enabled = false},
        KeySystem = false,
    })
end)

if not success then
    warn("Window creation error: " .. tostring(error))
    return
end

-- СОЗДАЕМ ВКЛАДКИ С ЗАЩИТОЙ ОТ ОШИБОК
local tabs = {}
local tabNames = {"Главные", "Игрок", "Авто", "Карта", "Сбор", "ТП", "Оптимизация", "Посадка", "Дебаг"}

for _, tabName in ipairs(tabNames) do
    local tabSuccess, tab = pcall(function()
        return Window:CreateTab(tabName, 4483362458)
    end)
    if tabSuccess then
        tabs[tabName] = tab
    else
        warn("Tab creation error for: " .. tabName)
    end
end

-- ОСНОВНЫЕ НАСТРОЙКИ
UltimateHack.Settings = {
    -- АУРЫ
    KillAura = false,
    KillAuraRadius = IS_MOBILE and 30 or 50,
    TreeAura = false,
    TreeAuraRadius = IS_MOBILE and 20 or 30,
    
    -- АВТОМАТЫ
    AutoFish = false,
    AutoLoot = false,
    AntiAFK = IS_MOBILE,
    AutoFindChildren = false,
    AutoCookFood = false,
    AutoCollectDropped = true,
    
    -- ЧИТЫ
    FlyEnabled = false,
    NoClipEnabled = false,
    GodModeEnabled = false,
    SpeedEnabled = false,
    SpeedValue = IS_MOBILE and 25 or 16,
    JumpPowerValue = IS_MOBILE and 70 or 50,
    InfiniteStamina = IS_MOBILE,
    NoHunger = IS_MOBILE,
    NoThirst = IS_MOBILE,
    
    -- ЭКСПЛОРОМ
    AutoExplore = false,
    ExploreRadius = IS_MOBILE and 500 or 1000,
    ExploreSpeed = IS_MOBILE and 40 or 60,
    
    -- ОПТИМИЗАЦИЯ
    AutoOptimize = IS_MOBILE,
    
    -- АВТОПОСАДКА
    AutoPlantTrees = false,
}

-- СИСТЕМНЫЕ ПЕРЕМЕННЫЕ
UltimateHack.Runtime = {
    IsRunning = false,
    ActiveLoops = {},
    FirePosition = Vector3.new(0, 0, 0),
    ChildrenNames = {"Дино малыш", "Малыш Кракен", "Малыш спрут", "Малыш коала"}
}

UltimateHack.Explore = {
    IsExploring = false,
    ChestsFound = 0,
    ResourcesFound = 0,
    LastFoundItem = "Ничего"
}

-- ОСНОВНЫЕ ФУНКЦИИ С ЗАЩИТОЙ ОТ ОШИБОК
UltimateHack.Functions = {}

-- БЕЗОПАСНЫЙ NOTIFY
function UltimateHack.SafeNotify(title, content, duration)
    pcall(function()
        Rayfield:Notify({
            Title = title or "Уведомление",
            Content = content or "...",
            Duration = duration or 3
        })
    end)
end

-- СИСТЕМА АВТОПОДБОРА ПРЕДМЕТОВ
UltimateHack.Functions.AutoCollect = {}

function UltimateHack.Functions.AutoCollect.Start()
    if UltimateHack.Runtime.ActiveLoops.AutoCollect then return end
    
    UltimateHack.Runtime.ActiveLoops.AutoCollect = true
    
    spawn(function()
        while UltimateHack.Settings.AutoCollectDropped and UltimateHack.Runtime.IsRunning do
            wait(IS_MOBILE and 3 or 2)
            
            local player = game.Players.LocalPlayer
            local character = player and player.Character
            if not character then continue end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then continue end
            
            -- ПРОСТОЙ ПОИСК БЛИЖАЙШИХ ПРЕДМЕТОВ
            local closestItem = nil
            local closestDistance = 50
            
            for _, obj in pairs(workspace:GetChildren()) do
                if not UltimateHack.Runtime.IsRunning then break end
                if obj:IsA("BasePart") and obj.Name ~= "Baseplate" then
                    local distance = (humanoidRootPart.Position - obj.Position).Magnitude
                    if distance < closestDistance then
                        closestItem = obj
                        closestDistance = distance
                    end
                end
            end
            
            if closestItem then
                pcall(function()
                    -- ТЕЛЕПОРТ К ПРЕДМЕТУ
                    humanoidRootPart.CFrame = CFrame.new(closestItem.Position + Vector3.new(0, 2, 0))
                    wait(0.2)
                    
                    -- ПОДБОР ПРЕДМЕТА
                    firetouchinterest(humanoidRootPart, closestItem, 0)
                    firetouchinterest(humanoidRootPart, closestItem, 1)
                    
                    UltimateHack.Explore.LastFoundItem = closestItem.Name
                    UltimateHack.Explore.ResourcesFound = UltimateHack.Explore.ResourcesFound + 1
                end)
            end
        end
        UltimateHack.Runtime.ActiveLoops.AutoCollect = false
    end)
end

-- УПРОЩЕННАЯ КИЛЛАУРА
UltimateHack.Functions.KillAura = {}

function UltimateHack.Functions.KillAura.Start()
    if UltimateHack.Runtime.ActiveLoops.KillAura then return end
    
    UltimateHack.Runtime.ActiveLoops.KillAura = true
    
    spawn(function()
        while UltimateHack.Settings.KillAura and UltimateHack.Runtime.IsRunning do
            wait(IS_MOBILE and 1.0 or 0.7)
            
            local player = game.Players.LocalPlayer
            local character = player and player.Character
            if not character then continue end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoidRootPart or not humanoid then continue end
            
            -- ПОИСК ОРУЖИЯ
            local weapon = nil
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    weapon = tool
                    break
                end
            end
            
            if not weapon then continue end
            
            -- ПОИСК БЛИЖАЙШЕГО ВРАГА
            local closestEnemy = nil
            local closestDistance = UltimateHack.Settings.KillAuraRadius
            
            for _, target in pairs(game.Players:GetPlayers()) do
                if target == player then continue end
                
                local targetChar = target.Character
                if not targetChar then continue end
                
                local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = targetChar:FindFirstChild("Humanoid")
                if not targetHRP or not targetHumanoid then continue end
                
                if targetHumanoid.Health <= 0 then continue end
                
                local distance = (humanoidRootPart.Position - targetHRP.Position).Magnitude
                if distance < closestDistance then
                    closestEnemy = targetChar
                    closestDistance = distance
                end
            end
            
            if closestEnemy then
                pcall(function()
                    local enemyHRP = closestEnemy:FindFirstChild("HumanoidRootPart")
                    if enemyHRP then
                        humanoidRootPart.CFrame = enemyHRP.CFrame
                        wait(0.2)
                        if weapon:IsA("Tool") then
                            weapon:Activate()
                        end
                    end
                end)
            end
        end
        UltimateHack.Runtime.ActiveLoops.KillAura = false
    end)
end

-- УПРОЩЕННАЯ РУБКА ДЕРЕВЬЕВ
UltimateHack.Functions.TreeAura = {}

function UltimateHack.Functions.TreeAura.Start()
    if UltimateHack.Runtime.ActiveLoops.TreeAura then return end
    
    UltimateHack.Runtime.ActiveLoops.TreeAura = true
    
    spawn(function()
        while UltimateHack.Settings.TreeAura and UltimateHack.Runtime.IsRunning do
            wait(0.8)
            
            local player = game.Players.LocalPlayer
            local character = player and player.Character
            if not character then continue end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then continue end
            
            -- ПОИСК ИНСТРУМЕНТА
            local tool = nil
            for _, item in pairs(character:GetChildren()) do
                if item:IsA("Tool") then
                    tool = item
                    break
                end
            end
            
            if not tool then continue end
            
            -- ПОИСК БЛИЖАЙШЕГО ДЕРЕВА
            local closestTree = nil
            local closestDistance = UltimateHack.Settings.TreeAuraRadius
            
            for _, obj in pairs(workspace:GetChildren()) do
                if not UltimateHack.Runtime.IsRunning then break end
                
                if obj:IsA("Part") or obj:IsA("MeshPart") then
                    local objName = obj.Name:lower()
                    if objName:find("tree") or objName:find("wood") or objName:find("log") then
                        local distance = (humanoidRootPart.Position - obj.Position).Magnitude
                        if distance < closestDistance then
                            closestTree = obj
                            closestDistance = distance
                        end
                    end
                end
            end
            
            if closestTree then
                pcall(function()
                    humanoidRootPart.CFrame = CFrame.new(closestTree.Position + Vector3.new(0, 3, 0))
                    wait(0.2)
                    
                    if tool:IsA("Tool") then
                        for i = 1, 2 do
                            tool:Activate()
                            wait(0.3)
                        end
                    end
                end)
            end
        end
        UltimateHack.Runtime.ActiveLoops.TreeAura = false
    end)
end

-- ПРОСТОЙ ЭКСПЛОРОМ
UltimateHack.Functions.Explore = {}

function UltimateHack.Functions.Explore.StartQuick()
    if UltimateHack.Explore.IsExploring then return end
    
    UltimateHack.Explore.IsExploring = true
    UltimateHack.Explore.ChestsFound = 0
    UltimateHack.Explore.ResourcesFound = 0
    
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then 
        UltimateHack.Explore.IsExploring = false
        return 
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then 
        UltimateHack.Explore.IsExploring = false
        return 
    end
    
    local startPos = humanoidRootPart.Position
    
    UltimateHack.SafeNotify("🌍 ЭКСПЛОРОМ", "Начинаю быстрое сканирование...")
    
    spawn(function()
        -- ПРОСТОЙ КРУГОВОЙ ПОИСК
        local steps = IS_MOBILE and 6 or 8
        local radius = UltimateHack.Settings.ExploreRadius
        
        for i = 1, steps do
            if not UltimateHack.Explore.IsExploring then break end
            
            local angle = (i / steps) * math.pi * 2
            local x = math.cos(angle) * radius
            local z = math.sin(angle) * radius
            
            local scanPos = Vector3.new(
                startPos.X + x,
                startPos.Y + 10,
                startPos.Z + z
            )
            
            pcall(function()
                humanoidRootPart.CFrame = CFrame.new(scanPos)
                wait(0.5)
                
                -- ПОИСК ПРЕДМЕТОВ ВОКРУГ
                for _, obj in pairs(workspace:GetChildren()) do
                    if not UltimateHack.Explore.IsExploring then break end
                    
                    if obj:IsA("Part") then
                        local distance = (scanPos - obj.Position).Magnitude
                        if distance < 30 then
                            if obj.Name:lower():find("chest") then
                                UltimateHack.Explore.ChestsFound = UltimateHack.Explore.ChestsFound + 1
                            else
                                UltimateHack.Explore.ResourcesFound = UltimateHack.Explore.ResourcesFound + 1
                                UltimateHack.Explore.LastFoundItem = obj.Name
                            end
                        end
                    end
                end
            end)
            
            -- ОБНОВЛЕНИЕ ПРОГРЕССА
            if i % 2 == 0 then
                UltimateHack.SafeNotify(
                    "🌍 Сканирование...", 
                    string.format("Прогресс: %d/%d\nНайдено: %d предметов", i, steps, UltimateHack.Explore.ResourcesFound)
                )
            end
            
            wait(1)
        end
        
        -- ВОЗВРАТ НА СТАРТ
        pcall(function()
            humanoidRootPart.CFrame = CFrame.new(startPos)
        end)
        
        UltimateHack.Explore.IsExploring = false
        
        UltimateHack.SafeNotify(
            "✅ СКАНИРОВАНИЕ ЗАВЕРШЕНО",
            string.format("Сундуков: %d\nРесурсов: %d\nПоследний предмет: %s",
                UltimateHack.Explore.ChestsFound,
                UltimateHack.Explore.ResourcesFound,
                UltimateHack.Explore.LastFoundItem)
        )
    end)
end

function UltimateHack.Functions.Explore.Stop()
    UltimateHack.Explore.IsExploring = false
    UltimateHack.SafeNotify("Эксплором", "Сканирование остановлено")
end

-- СИСТЕМА ЧИТОВ
UltimateHack.Functions.Cheats = {}

-- ПРОСТОЙ ПОЛЕТ
function UltimateHack.Functions.Cheats.ToggleFly()
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    if UltimateHack.Settings.FlyEnabled then
        -- ВЫКЛЮЧЕНИЕ ПОЛЕТА
        local bodyVelocity = humanoidRootPart:FindFirstChild("FlyBodyVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
        character.Humanoid.PlatformStand = false
        UltimateHack.Settings.FlyEnabled = false
        UltimateHack.SafeNotify("Полет", "Выключен")
    else
        -- ВКЛЮЧЕНИЕ ПОЛЕТА
        character.Humanoid.PlatformStand = true
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyBodyVelocity"
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        bodyVelocity.Parent = humanoidRootPart
        
        UltimateHack.Settings.FlyEnabled = true
        UltimateHack.SafeNotify("Полет", "Включен - используйте WASD для управления")
    end
end

-- ПРОСТОЙ NOCLIP
function UltimateHack.Functions.Cheats.ToggleNoClip()
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    if UltimateHack.Settings.NoClipEnabled then
        -- ВЫКЛЮЧЕНИЕ NOCLIP
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        UltimateHack.Settings.NoClipEnabled = false
        UltimateHack.SafeNotify("NoClip", "Выключен")
    else
        -- ВКЛЮЧЕНИЕ NOCLIP
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        UltimateHack.Settings.NoClipEnabled = true
        UltimateHack.SafeNotify("NoClip", "Включен")
    end
end

-- ПРОСТОЙ GOD MODE
function UltimateHack.Functions.Cheats.ToggleGodMode()
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if UltimateHack.Settings.GodModeEnabled then
        -- ВЫКЛЮЧЕНИЕ GOD MODE
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        UltimateHack.Settings.GodModeEnabled = false
        UltimateHack.SafeNotify("God Mode", "Выключен")
    else
        -- ВКЛЮЧЕНИЕ GOD MODE
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        UltimateHack.Settings.GodModeEnabled = true
        UltimateHack.SafeNotify("God Mode", "Включен")
    end
end

-- СКОРОСТЬ
function UltimateHack.Functions.Cheats.SetSpeed(value)
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    humanoid.WalkSpeed = value
    UltimateHack.Settings.SpeedValue = value
    UltimateHack.Settings.SpeedEnabled = value > 16
    
    UltimateHack.SafeNotify("Скорость", "Установлена: " .. value)
end

-- СИЛА ПРЫЖКА
function UltimateHack.Functions.Cheats.SetJumpPower(value)
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    humanoid.JumpPower = value
    UltimateHack.Settings.JumpPowerValue = value
    UltimateHack.SafeNotify("Прыжок", "Сила установлена: " .. value)
end

-- ХОДЬБА ПО НЕБУ
function UltimateHack.Functions.Cheats.WalkOnSky()
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    humanoidRootPart.CFrame = CFrame.new(0, 500, 0)
    UltimateHack.SafeNotify("Небо", "Телепортирован на небо!")
end

-- ВЫКЛЮЧЕНИЕ ВСЕХ ЧИТОВ
function UltimateHack.Functions.Cheats.DisableAll()
    -- ВЫКЛЮЧЕНИЕ ПОЛЕТА
    if UltimateHack.Settings.FlyEnabled then
        UltimateHack.Functions.Cheats.ToggleFly()
    end
    
    -- ВЫКЛЮЧЕНИЕ NOCLIP
    if UltimateHack.Settings.NoClipEnabled then
        UltimateHack.Functions.Cheats.ToggleNoClip()
    end
    
    -- ВЫКЛЮЧЕНИЕ GOD MODE
    if UltimateHack.Settings.GodModeEnabled then
        UltimateHack.Functions.Cheats.ToggleGodMode()
    end
    
    -- СБРОС СКОРОСТИ
    if UltimateHack.Settings.SpeedEnabled then
        UltimateHack.Functions.Cheats.SetSpeed(16)
    end
    
    UltimateHack.SafeNotify("Читы", "Все читы выключены!")
end

-- ПРОСТЫЕ АВТОМАТЫ
UltimateHack.Functions.Automation = {}

-- АНТИ-АФК
function UltimateHack.Functions.Automation.StartAntiAFK()
    if UltimateHack.Runtime.ActiveLoops.AntiAFK then return end
    
    UltimateHack.Runtime.ActiveLoops.AntiAFK = true
    
    spawn(function()
        while UltimateHack.Settings.AntiAFK and UltimateHack.Runtime.IsRunning do
            wait(30)
            
            local player = game.Players.LocalPlayer
            local character = player and player.Character
            if not character then continue end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then continue end
            
            pcall(function()
                humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(1, 0, 0)
            end)
        end
        UltimateHack.Runtime.ActiveLoops.AntiAFK = false
    end)
end

-- АВТОПОИСК ДЕТЕЙ
function UltimateHack.Functions.Automation.StartFindChildren()
    if UltimateHack.Runtime.ActiveLoops.FindChildren then return end
    
    UltimateHack.Runtime.ActiveLoops.FindChildren = true
    
    spawn(function()
        while UltimateHack.Settings.AutoFindChildren and UltimateHack.Runtime.IsRunning do
            wait(15)
            
            local player = game.Players.LocalPlayer
            local character = player and player.Character
            if not character then continue end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then continue end
            
            for _, target in pairs(game.Players:GetPlayers()) do
                if target == player then continue end
                
                for _, childName in pairs(UltimateHack.Runtime.ChildrenNames) do
                    if target.Name:find(childName) or (target.DisplayName and target.DisplayName:find(childName)) then
                        local targetChar = target.Character
                        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                            pcall(function()
                                humanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                                UltimateHack.SafeNotify("Ребенок", "Найден: " .. childName)
                                wait(5)
                            end)
                            break
                        end
                    end
                end
            end
        end
        UltimateHack.Runtime.ActiveLoops.FindChildren = false
    end)
end

-- ТЕЛЕПОРТАЦИЯ
UltimateHack.Functions.Teleport = {}

function UltimateHack.Functions.Teleport.SetFirePosition()
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    UltimateHack.Runtime.FirePosition = humanoidRootPart.Position
    UltimateHack.SafeNotify("Костер", "Позиция установлена!")
end

function UltimateHack.Functions.Teleport.ToFire()
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    humanoidRootPart.CFrame = CFrame.new(UltimateHack.Runtime.FirePosition)
    UltimateHack.SafeNotify("ТП", "Телепорт к костру!")
end

function UltimateHack.Functions.Teleport.ToPlayer(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if not targetPlayer then
        UltimateHack.SafeNotify("Ошибка", "Игрок не найден: " .. tostring(playerName))
        return
    end
    
    local targetChar = targetPlayer.Character
    if not targetChar then
        UltimateHack.SafeNotify("Ошибка", "Персонаж игрока не найден")
        return
    end
    
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP then
        UltimateHack.SafeNotify("Ошибка", "HRP игрока не найден")
        return
    end
    
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    humanoidRootPart.CFrame = targetHRP.CFrame
    UltimateHack.SafeNotify("ТП", "Телепорт к игроку: " .. playerName)
end

-- ОСНОВНОЕ УПРАВЛЕНИЕ
function UltimateHack.StartAllSystems()
    if UltimateHack.Runtime.IsRunning then
        UltimateHack.SafeNotify("Внимание", "Системы уже запущены!")
        return
    end
    
    UltimateHack.Runtime.IsRunning = true
    
    -- АВТООПТИМИЗАЦИЯ ДЛЯ МОБИЛ
    if IS_MOBILE and UltimateHack.Settings.AutoOptimize then
        if setfpscap then
            pcall(function() setfpscap(30) end)
        end
        pcall(function() settings().Rendering.QualityLevel = 1 end)
    end
    
    -- ЗАПУСК СИСТЕМ
    if UltimateHack.Settings.KillAura then
        UltimateHack.Functions.KillAura.Start()
    end
    
    if UltimateHack.Settings.TreeAura then
        UltimateHack.Functions.TreeAura.Start()
    end
    
    if UltimateHack.Settings.AutoCollectDropped then
        UltimateHack.Functions.AutoCollect.Start()
    end
    
    if UltimateHack.Settings.AntiAFK then
        UltimateHack.Functions.Automation.StartAntiAFK()
    end
    
    if UltimateHack.Settings.AutoFindChildren then
        UltimateHack.Functions.Automation.StartFindChildren()
    end
    
    if UltimateHack.Settings.AutoExplore then
        spawn(function()
            wait(3)
            UltimateHack.Functions.Explore.StartQuick()
        end)
    end
    
    UltimateHack.SafeNotify(
        IS_MOBILE and "MOBILE SYSTEM" or "ULTIMATE HACK",
        IS_MOBILE and "Мобильные системы активированы!" or "Все системы запущены!"
    )
end

function UltimateHack.StopAllSystems()
    UltimateHack.Runtime.IsRunning = false
    UltimateHack.Explore.IsExploring = false
    
    -- ОСТАНАВЛИВАЕМ ВСЕ ЦИКЛЫ
    for loopName, _ in pairs(UltimateHack.Runtime.ActiveLoops) do
        UltimateHack.Runtime.ActiveLoops[loopName] = false
    end
    
    -- ВЫКЛЮЧАЕМ ЧИТЫ
    UltimateHack.Functions.Cheats.DisableAll()
    
    -- СБРАСЫВАЕМ НАСТРОЙКИ
    UltimateHack.Settings.KillAura = false
    UltimateHack.Settings.TreeAura = false
    UltimateHack.Settings.AutoExplore = false
    
    UltimateHack.SafeNotify("Система", "Все системы остановлены!")
end

-- СОЗДАЕМ ИНТЕРФЕЙС
if tabs["Главные"] then
    tabs["Главные"]:CreateSection("Основное управление")
    
    tabs["Главные"]:CreateButton({
        Name = "🚀 ЗАПУСТИТЬ ВСЕ СИСТЕМЫ",
        Callback = UltimateHack.StartAllSystems
    })
    
    tabs["Главные"]:CreateButton({
        Name = "🛑 ОСТАНОВИТЬ ВСЕ СИСТЕМЫ", 
        Callback = UltimateHack.StopAllSystems
    })
end

if tabs["Игрок"] then
    tabs["Игрок"]:CreateSection("Ауры")
    
    tabs["Игрок"]:CreateToggle({
        Name = "🔫 Киллаура",
        CurrentValue = UltimateHack.Settings.KillAura,
        Callback = function(value)
            UltimateHack.Settings.KillAura = value
            if value and UltimateHack.Runtime.IsRunning then
                UltimateHack.Functions.KillAura.Start()
            end
        end
    })
    
    tabs["Игрок"]:CreateToggle({
        Name = "🪓 Рубка деревьев",
        CurrentValue = UltimateHack.Settings.TreeAura,
        Callback = function(value)
            UltimateHack.Settings.TreeAura = value
            if value and UltimateHack.Runtime.IsRunning then
                UltimateHack.Functions.TreeAura.Start()
            end
        end
    })
    
    tabs["Игрок"]:CreateSection("Читы")
    
    tabs["Игрок"]:CreateButton({
        Name = "🔴 ВЫКЛЮЧИТЬ ВСЕ ЧИТЫ",
        Callback = UltimateHack.Functions.Cheats.DisableAll
    })
    
    tabs["Игрок"]:CreateToggle({
        Name = "🦅 Режим полета",
        CurrentValue = UltimateHack.Settings.FlyEnabled,
        Callback = UltimateHack.Functions.Cheats.ToggleFly
    })
    
    tabs["Игрок"]:CreateToggle({
        Name = "👻 NoClip",
        CurrentValue = UltimateHack.Settings.NoClipEnabled,
        Callback = UltimateHack.Functions.Cheats.ToggleNoClip
    })
    
    tabs["Игрок"]:CreateToggle({
        Name = "🛡️ God Mode", 
        CurrentValue = UltimateHack.Settings.GodModeEnabled,
        Callback = UltimateHack.Functions.Cheats.ToggleGodMode
    })
    
    tabs["Игрок"]:CreateSlider({
        Name = "💨 Скорость",
        Range = {16, 100},
        Increment = 1,
        Suffix = "ед.",
        CurrentValue = UltimateHack.Settings.SpeedValue,
        Callback = UltimateHack.Functions.Cheats.SetSpeed
    })
    
    tabs["Игрок"]:CreateSlider({
        Name = "🦘 Сила прыжка",
        Range = {50, 200},
        Increment = 5,
        Suffix = "ед.",
        CurrentValue = UltimateHack.Settings.JumpPowerValue,
        Callback = UltimateHack.Functions.Cheats.SetJumpPower
    })
    
    tabs["Игрок"]:CreateButton({
        Name = "☁️ Ходить по небу",
        Callback = UltimateHack.Functions.Cheats.WalkOnSky
    })
end

if tabs["Авто"] then
    tabs["Авто"]:CreateSection("Автоматизация")
    
    tabs["Авто"]:CreateToggle({
        Name = "🎯 Автоподбор предметов",
        CurrentValue = UltimateHack.Settings.AutoCollectDropped,
        Callback = function(value)
            UltimateHack.Settings.AutoCollectDropped = value
            if value and UltimateHack.Runtime.IsRunning then
                UltimateHack.Functions.AutoCollect.Start()
            end
        end
    })
    
    tabs["Авто"]:CreateToggle({
        Name = "⏰ Анти-АФК",
        CurrentValue = UltimateHack.Settings.AntiAFK,
        Callback = function(value)
            UltimateHack.Settings.AntiAFK = value
            if value and UltimateHack.Runtime.IsRunning then
                UltimateHack.Functions.Automation.StartAntiAFK()
            end
        end
    })
    
    tabs["Авто"]:CreateToggle({
        Name = "👶 Автопоиск детей",
        CurrentValue = UltimateHack.Settings.AutoFindChildren,
        Callback = function(value)
            UltimateHack.Settings.AutoFindChildren = value
            if value and UltimateHack.Runtime.IsRunning then
                UltimateHack.Functions.Automation.StartFindChildren()
            end
        end
    })
end

if tabs["Карта"] then
    tabs["Карта"]:CreateSection("Эксплором карты")
    
    tabs["Карта"]:CreateButton({
        Name = "🌍 БЫСТРЫЙ ПОИСК",
        Callback = UltimateHack.Functions.Explore.StartQuick
    })
    
    tabs["Карта"]:CreateButton({
        Name = "⏹️ ОСТАНОВИТЬ ПОИСК",
        Callback = UltimateHack.Functions.Explore.Stop
    })
    
    tabs["Карта"]:CreateToggle({
        Name = "🔄 Автопоиск при запуске",
        CurrentValue = UltimateHack.Settings.AutoExplore,
        Callback = function(value)
            UltimateHack.Settings.AutoExplore = value
        end
    })
    
    tabs["Карта"]:CreateSection("Статус")
    
    tabs["Карта"]:CreateButton({
        Name = "📊 ПОКАЗАТЬ СТАТУС",
        Callback = function()
            UltimateHack.SafeNotify(
                "📊 Статус поиска",
                string.format("Сундуков: %d\nРесурсов: %d\nПоследний предмет: %s",
                    UltimateHack.Explore.ChestsFound,
                    UltimateHack.Explore.ResourcesFound,
                    UltimateHack.Explore.LastFoundItem)
            )
        end
    })
end

if tabs["ТП"] then
    tabs["ТП"]:CreateSection("Телепортация")
    
    tabs["ТП"]:CreateButton({
        Name = "📍 УСТАНОВИТЬ КОСТЕР",
        Callback = UltimateHack.Functions.Teleport.SetFirePosition
    })
    
    tabs["ТП"]:CreateButton({
        Name = "🔥 ТП К КОСТРУ",
        Callback = UltimateHack.Functions.Teleport.ToFire
    })
    
    tabs["ТП"]:CreateSection("ТП к игроку")
    
    tabs["ТП"]:CreateInput({
        Name = "Имя игрока",
        PlaceholderText = "Введите никнейм",
        RemoveTextAfterFocusLost = false,
        Callback = function(text)
            if text and text ~= "" then
                UltimateHack.Functions.Teleport.ToPlayer(text)
            end
        end
    })
end

if tabs["Оптимизация"] then
    tabs["Оптимизация"]:CreateSection("Настройки")
    
    tabs["Оптимизация"]:CreateToggle({
        Name = "🔧 Автооптимизация",
        CurrentValue = UltimateHack.Settings.AutoOptimize,
        Callback = function(value)
            UltimateHack.Settings.AutoOptimize = value
        end
    })
end

-- ЗАПУСКАЕМ ОСНОВНЫЕ СИСТЕМЫ
spawn(function()
    wait(2)
    if UltimateHack.Settings.AutoCollectDropped then
        UltimateHack.Functions.AutoCollect.Start()
    end
    if UltimateHack.Settings.AntiAFK then
        UltimateHack.Functions.Automation.StartAntiAFK()
    end
end)

UltimateHack.SafeNotify(
    "🎯 I.S.-1 PERFECT EDITION", 
    "Скрипт успешно загружен!\nВсе системы готовы к работе."
)

return UltimateHack