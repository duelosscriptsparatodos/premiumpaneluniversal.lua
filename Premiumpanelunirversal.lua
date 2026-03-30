local HttpService = game:GetService("HttpService")

-- !!! PEGA TU ENLACE DE GOOGLE AQUÍ ABAJO !!!
local URL_EXCEL = https://script.google.com/macros/s/AKfycbxjP3d72k6fmqNq1wu9BkECejKOYqfZErbiKSrmjo9Np7nJNpbPnwcBHpOxBl9iYn6Icw/exec

-- 1. CREACIÓN DE LA INTERFAZ DE LOGUEO
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", Frame)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "SISTEMA DE LLAVES"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Frame)
Input.Size = UDim2.new(0, 240, 0, 40)
Input.Position = UDim2.new(0.5, -120, 0.35, 0)
Input.PlaceholderText = "Ingresa tu Key..."
Input.Text = ""

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(0, 140, 0, 40)
Btn.Position = UDim2.new(0.5, -70, 0.7, 0)
Btn.Text = "VERIFICAR"
Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Btn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Btn)

-- 2. LÓGICA DE VERIFICACIÓN
Btn.MouseButton1Click:Connect(function()
    Btn.Text = "CARGANDO..."
    
    -- Esta línea le pregunta a tu Excel si la key es buena
    local success, respuesta = pcall(function()
        return game:HttpGet(URL_EXCEL .. "?key=" .. Input.Text)
    end)
    
    if success then
        if respuesta == "VALIDO" then
            Btn.Text = "¡CORRECTO!"
            Btn.BackgroundColor3 = Color3.new(0, 1, 0)
            wait(1)
            ScreenGui:Destroy()
            
            -- ===========================================
            ---- ========================================================
-- PREMIUM POWER PANEL (CON SHIFT LOCK PARA CELULAR)
-- ========================================================

-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- =========================
-- VARIABLES PERSISTENTES
-- =========================
local savedWalkSpeed = 16
local savedJumpPower = 50
local savedFlySpeed = 50

local character, humanoid, root
local guiCreated = false
local flying, noclip, autoAim, infiniteJump, teleportMode, espEnabled, shiftLock = false, false, false, false, false, false, false

local bv, bg, jumpRequestConn
local espObjects = {}
local shiftLockConn = nil

-- =========================
-- FUNCIÓN SHIFT LOCK
-- =========================
local function toggleShiftLock(state)
	if state then
		-- Desplazamos la cámara al hombro (visible)
		if humanoid then
			humanoid.CameraOffset = Vector3.new(1.7, 0.5, 0)
		end
		-- Bucle para que el cuerpo siga a la cámara
		shiftLockConn = RunService.RenderStepped:Connect(function()
			if root and humanoid and character then
				local _, y, _ = camera.CFrame:ToEulerAnglesYXZ()
				root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, y, 0)
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			end
		end)
	else
		-- Restauramos valores originales
		if shiftLockConn then shiftLockConn:Disconnect() shiftLockConn = nil end
		if humanoid then
			humanoid.CameraOffset = Vector3.new(0, 0, 0)
		end
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
end

-- =========================
-- INTERFAZ DECORADA (UI)
-- =========================

local function createUI()
	if guiCreated then return end
	guiCreated = true

	local pg = player:WaitForChild("PlayerGui")

	local sg = Instance.new("ScreenGui")
	sg.Name = "PremiumHubGui"
	sg.ResetOnSpawn = false
	sg.Parent = pg

	-- Panel Principal
	local main = Instance.new("Frame")
	main.Name = "MainPanel"
	main.Size = UDim2.new(0, 260, 0, 420)
	main.Position = UDim2.new(0, 30, 0, 80)
	main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	main.BorderSizePixel = 0
	main.Active = true 
	main.Parent = sg

	-- Bordes Redondeados
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = main

	-- Sombra/Brillo Elegante
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(50, 50, 50)
	stroke.Thickness = 2
	stroke.Parent = main

	-- Barra Superior (Título)
	local topBar = Instance.new("Frame")
	topBar.Size = UDim2.new(1, 0, 0, 40)
	topBar.BackgroundTransparency = 1 
	topBar.Parent = main

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -40, 1, 0)
	title.Position = UDim2.new(0, 10, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "PREMIUM POWER PANEL"
	title.TextColor3 = Color3.fromRGB(0, 180, 255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = topBar

	-- Botón Minimizar
	local minimize = Instance.new("TextButton")
	minimize.Size = UDim2.new(0, 30, 0, 30)
	minimize.Position = UDim2.new(1, -35, 0, 5)
	minimize.Text = "-"
	minimize.Font = Enum.Font.GothamBold
	minimize.TextSize = 20
	minimize.TextColor3 = Color3.new(1, 1, 1)
	minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	minimize.AutoButtonColor = true
	minimize.Parent = topBar

	local minCorner = Instance.new("UICorner")
	minCorner.CornerRadius = UDim.new(0, 8)
	minCorner.Parent = minimize

	-- Botón Restaurar
	local restore = Instance.new("TextButton")
	restore.Size = UDim2.new(0, 50, 0, 50)
	restore.Position = UDim2.new(0, 10, 0, 10)
	restore.Text = "P"
	restore.Font = Enum.Font.GothamBold
	restore.TextSize = 24
	restore.TextColor3 = Color3.new(1, 1, 1)
	restore.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
	restore.Visible = false
	restore.Active = true
	restore.Parent = sg

	local resCorner = Instance.new("UICorner")
	resCorner.CornerRadius = UDim.new(1, 0)
	resCorner.Parent = restore
    
    local resStroke = Instance.new("UIStroke")
    resStroke.Color = Color3.new(1,1,1)
    resStroke.Thickness = 2
    resStroke.Parent = restore

	minimize.MouseButton1Click:Connect(function()
		main.Visible = false
		restore.Visible = true
	end)

	restore.MouseButton1Click:Connect(function()
		main.Visible = true
		restore.Visible = false
	end)

	-- Arrastrar GUI
	local function makeDraggable(guiObj)
		local dragging, dragInput, dragStart, startPos
		guiObj.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = guiObj.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then dragging = false end
				end)
			end
		end)
		guiObj.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and input == dragInput then
				local delta = input.Position - dragStart
				guiObj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end

	makeDraggable(main)
	makeDraggable(restore)

	-- Contenedor con Scroll
	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1, -20, 1, -60)
	scroll.Position = UDim2.new(0, 10, 0, 50)
	scroll.BackgroundTransparency = 1
	scroll.CanvasSize = UDim2.new(0, 0, 0, 620) -- Aumentado para el nuevo botón
	scroll.ScrollBarThickness = 4
	scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
	scroll.Parent = main

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 10)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Parent = scroll

	-- Creadores de Elementos
	local function createToggleButton(text, callback)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 35)
		btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		btn.Text = text .. " OFF"
		btn.Font = Enum.Font.Gotham
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.TextSize = 14
		btn.AutoButtonColor = true
		btn.Parent = scroll

		local bCorner = Instance.new("UICorner")
		bCorner.CornerRadius = UDim.new(0, 8)
		bCorner.Parent = btn

		local active = false
		btn.MouseButton1Click:Connect(function()
			active = not active
			btn.Text = text .. (active and " ON" or " OFF")
			local targetColor = active and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(35, 35, 35)
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
			callback(active)
		end)
		return btn
	end

	local function createSlider(text, min, max, default, callback)
		local holder = Instance.new("Frame")
		holder.Size = UDim2.new(1, 0, 0, 55)
		holder.BackgroundTransparency = 1
		holder.Parent = scroll

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 0, 20)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1, 1, 1)
		label.Font = Enum.Font.Gotham
		label.TextSize = 14
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Text = text .. ": " .. default
		label.Parent = holder

		local bgFrame = Instance.new("Frame")
		bgFrame.Size = UDim2.new(1, 0, 0, 10)
		bgFrame.Position = UDim2.new(0, 0, 0, 30)
		bgFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		bgFrame.Parent = holder
        
        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(1, 0)
        sCorner.Parent = bgFrame

		local fill = Instance.new("Frame")
		fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
		fill.Parent = bgFrame
        
        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(1, 0)
        fCorner.Parent = fill

		local dragging = false
		local function updateSlider(input)
			local rel = math.clamp((input.Position.X - bgFrame.AbsolutePosition.X) / bgFrame.AbsoluteSize.X, 0, 1)
			local val = math.floor(min + (max - min) * rel)
			fill.Size = UDim2.new(rel, 0, 1, 0)
			label.Text = text .. ": " .. val
			callback(val)
		end

		bgFrame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				updateSlider(input)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateSlider(input)
			end
		end)
	end

	-- Controles
	createToggleButton("Volar", function(v)
		flying = v
		if flying then
			humanoid.PlatformStand = true
			bv = Instance.new("BodyVelocity", root)
			bv.Name = "PowerFlyVel"
			bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			bg = Instance.new("BodyGyro", root)
			bg.Name = "PowerFlyGyro"
			bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		else
			humanoid.PlatformStand = false
			if root:FindFirstChild("PowerFlyVel") then root.PowerFlyVel:Destroy() end
			if root:FindFirstChild("PowerFlyGyro") then root.PowerFlyGyro:Destroy() end
		end
	end)

	createToggleButton("Noclip", function(v) noclip = v end)
	createToggleButton("Auto Aim", function(v) autoAim = v end)
	createToggleButton("Salto Infinito", function(v) infiniteJump = v end)
	createToggleButton("Teleport (Toque)", function(v) teleportMode = v end)
	
    local function refreshESP()
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= player then
				if espEnabled then createESPTag(plr) else removeESP(plr) end
			end
		end
	end
    
    createToggleButton("ESP Jugadores", function(v) 
        espEnabled = v 
        refreshESP()
    end)

	-- NUEVO BOTÓN: SHIFT LOCK PARA CELULAR
	createToggleButton("Shift Lock (Celular)", function(v)
		shiftLock = v
		toggleShiftLock(v)
	end)

	createSlider("Velocidad", 8, 150, savedWalkSpeed, function(v)
		savedWalkSpeed = v
		if humanoid then humanoid.WalkSpeed = v end
	end)

	createSlider("Vuelo", 10, 300, savedFlySpeed, function(v)
		savedFlySpeed = v
	end)

	createSlider("Salto", 50, 300, savedJumpPower, function(v)
		savedJumpPower = v
		if humanoid then humanoid.JumpPower = v end
	end)
end

-- =========================
-- ESP
-- =========================
function createESPTag(plr)
	if not plr.Character or espObjects[plr] or plr == player then return end
	local head = plr.Character:WaitForChild("Head", 5)
	if not head then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = "PowerESP_High"
	highlight.FillColor = Color3.fromRGB(255, 0, 100)
	highlight.OutlineColor = Color3.new(1, 1, 1)
	highlight.FillTransparency = 0.6
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = plr.Character

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PowerESP_Tag"
	billboard.Size = UDim2.new(0, 150, 0, 30)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = head

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, 0, 1, 0)
	text.BackgroundTransparency = 1
	text.TextScaled = true
	text.TextColor3 = Color3.fromRGB(255, 0, 100)
	text.Font = Enum.Font.GothamBold
	text.TextStrokeTransparency = 0
	text.Parent = billboard

	espObjects[plr] = { highlight = highlight, billboard = billboard, label = text }
end

function removeESP(plr)
	if espObjects[plr] then
		if espObjects[plr].highlight then espObjects[plr].highlight:Destroy() end
		if espObjects[plr].billboard then espObjects[plr].billboard:Destroy() end
		espObjects[plr] = nil
	end
end

for _, plr in ipairs(Players:GetPlayers()) do
	if plr ~= player then
		plr.CharacterAdded:Connect(function()
			task.wait(1)
			if espEnabled then createESPTag(plr) end
		end)
	end
end

Players.PlayerAdded:Connect(function(plr)
	if plr ~= player then
		plr.CharacterAdded:Connect(function()
			task.wait(1)
			if espEnabled then createESPTag(plr) end
		end)
	end
end)

Players.PlayerRemoving:Connect(removeESP)

-- =========================
-- TELEPORT
-- =========================
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if teleportMode and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and root then
		local ray = camera:ScreenPointToRay(input.Position.X, input.Position.Y)
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {character} 
		params.FilterType = Enum.RaycastFilterType.Blacklist

		local result = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
		if result then
			root.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
		end
	end
end)

-- =========================
-- LOOP PRINCIPAL
-- =========================
RunService.RenderStepped:Connect(function()
	if flying and bv and bg and root then
		bg.CFrame = camera.CFrame
		bv.Velocity = camera.CFrame.LookVector * savedFlySpeed
	end

	if noclip and character then
		for _, p in ipairs(character:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = false end
		end
	end

	if autoAim and root then
		local closest, dist = nil, math.huge
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = plr.Character.HumanoidRootPart
				local d = (hrp.Position - root.Position).Magnitude
				if d < dist then dist = d closest = hrp end
			end
		end
		if closest then
			camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
		end
	end

	if espEnabled then
		for plr, data in pairs(espObjects) do
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and root then
				local hrp = plr.Character.HumanoidRootPart
				local dist = math.floor((hrp.Position - root.Position).Magnitude)
				data.label.Text = plr.Name .. " [" .. dist .. "m]"
			else
                removeESP(plr)
            end
		end
	end
end)

-- =========================
-- INIT
-- =========================
local function setupCharacter(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")

	humanoid.WalkSpeed = savedWalkSpeed
	humanoid.JumpPower = savedJumpPower

	if jumpRequestConn then jumpRequestConn:Disconnect() end
	jumpRequestConn = UserInputService.JumpRequest:Connect(function()
		if infiniteJump and humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)

	createUI()
end

if player.Character then setupCharacter(player.Character) end
player.CharacterAdded:Connect(setupCharacter)

            -- ===========================================
            warn("Script cargado con éxito")
            
        elseif respuesta == "EXPIRADO" then
            Btn.Text = "KEY VENCIDA"
            Btn.BackgroundColor3 = Color3.new(1, 0, 0)
        else
            Btn.Text = "KEY INVÁLIDA"
            Btn.BackgroundColor3 = Color3.new(1, 0, 0)
        end
    else
        Btn.Text = "ERROR DE CONEXIÓN"
    end
    
    wait(2)
    Btn.Text = "VERIFICAR"
    Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)
