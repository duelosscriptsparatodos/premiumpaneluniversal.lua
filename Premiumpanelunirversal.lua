local HttpService = game:GetService("HttpService")

-- ========================================================
-- CONFIGURACIÓN DE ENLACES (ACTUALIZADOS)
-- ========================================================
-- Tu NUEVA API de Google Sheets
local URL_GOOGLE = "https://script.google.com/macros/s/AKfycbyMWrhpyXqOdAAvz9373fo4anSMPwBc8ZnRbFs1BaTeeLg3fW6PWA0zZSN-NZ9XVbQtCQ/exec" 

-- Tu Panel Original (El que se ejecutará si la Key es correcta)
local URL_PANEL_ORIGINAL = "https://raw.githubusercontent.com/duelosscriptsparatodos/premiumpaneluniversal.lua/main/Premiumpaneluniversal.lua"

-- ========================================================
-- INTERFAZ DEL SISTEMA DE LLAVES
-- ========================================================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 160)
Frame.Position = UDim2.new(0.5, -150, 0.5, -80)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "PREMIUM SYSTEM LOGIN"
Title.TextColor3 = Color3.fromRGB(0, 180, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local Input = Instance.new("TextBox", Frame)
Input.Size = UDim2.new(0, 240, 0, 40)
Input.Position = UDim2.new(0.5, -120, 0.35, 0)
Input.PlaceholderText = "Ingresa Key..."
Input.Text = ""
Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Input.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Input)

local Btn = Instance.new("TextButton", Frame)
Btn.Size = UDim2.new(0, 140, 0, 40)
Btn.Position = UDim2.new(0.5, -70, 0.7, 0)
Btn.Text = "VERIFICAR"
Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", Btn)

-- ========================================================
-- LÓGICA DE LANZAMIENTO
-- ========================================================
Btn.MouseButton1Click:Connect(function()
    Btn.Text = "COMPROBANDO..."
    
    local success, res = pcall(function()
        return game:HttpGet(URL_GOOGLE .. "?key=" .. Input.Text)
    end)
    
    if success and res == "VALIDO" then
        Btn.Text = "¡ACCESO CONCEDIDO!"
        Btn.BackgroundColor3 = Color3.new(0, 0.8, 0)
        wait(1)
        ScreenGui:Destroy()
        
        -- AQUÍ SE DISPARA TU PANEL ORIGINAL
        loadstring(game:HttpGet(URL_PANEL_ORIGINAL))()
    else
        Input.Text = ""
        Input.PlaceholderText = (res == "EXPIRADO" and "KEY VENCIDA" or "KEY INCORRECTA")
        Btn.Text = "ERROR"
        Btn.BackgroundColor3 = Color3.new(0.8, 0, 0)
        wait(2)
        Btn.Text = "VERIFICAR"
        Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    end
end)
