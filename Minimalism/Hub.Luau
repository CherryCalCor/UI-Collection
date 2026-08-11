local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FutureHub_GUI"
ScreenGui.ResetOnSpawn = false

local success, _ = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not success then
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 0, 0, 0) 
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 600, 0, 350),
    Position = UDim2.new(0.5, -300, 0.5, -175)
}):Play()

local LeftPanel = Instance.new("Frame")
LeftPanel.Name = "LeftPanel"
LeftPanel.Size = UDim2.new(0, 150, 1, 0)
LeftPanel.Position = UDim2.new(0, 0, 0, 0)
LeftPanel.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
LeftPanel.BorderSizePixel = 0
LeftPanel.Parent = MainFrame

local LeftPanelCorner = Instance.new("UICorner")
LeftPanelCorner.CornerRadius = UDim.new(0, 8)
LeftPanelCorner.Parent = LeftPanel

local LeftPanelFix = Instance.new("Frame")
LeftPanelFix.Name = "LeftPanelFix"
LeftPanelFix.Size = UDim2.new(0, 10, 1, 0)
LeftPanelFix.Position = UDim2.new(1, -10, 0, 0)
LeftPanelFix.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
LeftPanelFix.BorderSizePixel = 0
LeftPanelFix.Parent = LeftPanel

local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(0, 1, 1, 0)
Divider.Position = UDim2.new(0, 150, 0, 0)
Divider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Divider.BackgroundTransparency = 0.85
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0, 138, 0, 35)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Future Hub"
TitleLabel.TextColor3 = Color3.fromRGB(35, 35, 35)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = LeftPanel

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(100, 100, 100)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamMedium
CloseButton.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.TextSize = 12
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(1, 0, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundTransparency = 1
Sidebar.Parent = LeftPanel

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -151, 1, -35)
ContentArea.Position = UDim2.new(0, 151, 0, 35)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local HomeButton = Instance.new("TextButton")
HomeButton.Name = "HomeButton"
HomeButton.Size = UDim2.new(1, -20, 0, 35)
HomeButton.Position = UDim2.new(0, 10, 0, 10)
HomeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HomeButton.AutoButtonColor = false
HomeButton.BorderSizePixel = 0
HomeButton.Text = "            Home"
HomeButton.TextColor3 = Color3.fromRGB(35, 35, 35)
HomeButton.Font = Enum.Font.GothamSemibold
HomeButton.TextSize = 14
HomeButton.TextXAlignment = Enum.TextXAlignment.Left
HomeButton.Parent = Sidebar

local HomeButtonCorner = Instance.new("UICorner")
HomeButtonCorner.CornerRadius = UDim.new(0, 6)
HomeButtonCorner.Parent = HomeButton

local HomeIcon = Instance.new("ImageLabel")
HomeIcon.Name = "HomeIcon"
HomeIcon.Size = UDim2.new(0, 20, 0, 20)
HomeIcon.Position = UDim2.new(0, 10, 0.5, -10)
HomeIcon.BackgroundTransparency = 1
HomeIcon.Image = "rbxassetid://119483233546817"
HomeIcon.Parent = HomeButton

local TabIndicator = Instance.new("Frame")
TabIndicator.Name = "TabIndicator"
TabIndicator.Size = UDim2.new(0, 3, 0, 18)
TabIndicator.Position = UDim2.new(0, 0, 0.5, -9)
TabIndicator.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabIndicator.BorderSizePixel = 0
TabIndicator.Parent = HomeButton

local IndicatorCorner = Instance.new("UICorner")
IndicatorCorner.CornerRadius = UDim.new(1, 0)
IndicatorCorner.Parent = TabIndicator

local ProfileBox = Instance.new("Frame")
ProfileBox.Name = "ProfileBox"
ProfileBox.Size = UDim2.new(0, 130, 0, 50)
ProfileBox.Position = UDim2.new(0, 10, 1, -60)
ProfileBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProfileBox.Parent = Sidebar

local ProfileBoxCorner = Instance.new("UICorner")
ProfileBoxCorner.CornerRadius = UDim.new(0, 6)
ProfileBoxCorner.Parent = ProfileBox

local ProfileStroke = Instance.new("UIStroke")
ProfileStroke.Color = Color3.fromRGB(230, 230, 230)
ProfileStroke.Parent = ProfileBox

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Name = "AvatarImage"
AvatarImage.Size = UDim2.new(0, 36, 0, 36)
AvatarImage.Position = UDim2.new(0, 7, 0, 7)
AvatarImage.BackgroundTransparency = 1
AvatarImage.Image = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
AvatarImage.Parent = ProfileBox

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImage

local NameLabel = Instance.new("TextLabel")
NameLabel.Name = "NameLabel"
NameLabel.Size = UDim2.new(0, 75, 0, 15)
NameLabel.Position = UDim2.new(0, 50, 0, 10)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = Players.LocalPlayer.DisplayName
NameLabel.TextColor3 = Color3.fromRGB(35, 35, 35)
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextSize = 12
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
NameLabel.Parent = ProfileBox

local StatusCircle = Instance.new("Frame")
StatusCircle.Name = "StatusCircle"
StatusCircle.Size = UDim2.new(0, 8, 0, 8)
StatusCircle.Position = UDim2.new(0, 50, 0, 30)
StatusCircle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
StatusCircle.Parent = ProfileBox

local StatusCircleCorner = Instance.new("UICorner")
StatusCircleCorner.CornerRadius = UDim.new(1, 0)
StatusCircleCorner.Parent = StatusCircle

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(0, 65, 0, 15)
StatusLabel.Position = UDim2.new(0, 63, 0, 26)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Online"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = ProfileBox

local HomeTab = Instance.new("Frame")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, 0, 1, 0)
HomeTab.BackgroundTransparency = 1
HomeTab.Parent = ContentArea

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Name = "WelcomeLabel"
WelcomeLabel.Size = UDim2.new(1, -40, 0, 40)
WelcomeLabel.Position = UDim2.new(0, 20, 0, 15)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Welcome, Back"
WelcomeLabel.TextColor3 = Color3.fromRGB(35, 35, 35)
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.TextSize = 24
WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
WelcomeLabel.Parent = HomeTab

local StatsContainer = Instance.new("Frame")
StatsContainer.Name = "StatsContainer"
StatsContainer.Size = UDim2.new(1, -40, 0, 200)
StatsContainer.Position = UDim2.new(0, 20, 0, 70)
StatsContainer.BackgroundTransparency = 1
StatsContainer.Parent = HomeTab

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 15)
UIGridLayout.CellSize = UDim2.new(0, 195, 0, 75)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.Parent = StatsContainer

local function CreateStatBox(name, titleText, layoutOrder)
    local Box = Instance.new("TextButton")
    Box.Name = name
    Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
    Box.LayoutOrder = layoutOrder
    Box.Text = ""
    Box.AutoButtonColor = false
    Box.Parent = StatsContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8) 
    Corner.Parent = Box
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(230, 230, 230)
    Stroke.Transparency = 0.4
    Stroke.Parent = Box
    
    local Scale = Instance.new("UIScale")
    Scale.Scale = 1
    Scale.Parent = Box
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 20)
    Title.Position = UDim2.new(0, 12, 0, 12)
    Title.BackgroundTransparency = 1
    Title.Text = titleText

    Title.TextColor3 = Color3.fromRGB(150, 150, 150)
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 12
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Box
    
    local Value = Instance.new("TextLabel")
    Value.Name = "Value"
    Value.Size = UDim2.new(1, -24, 0, 30)
    Value.Position = UDim2.new(0, 12, 0, 32)
    Value.BackgroundTransparency = 1
    Value.Text = "..."

    Value.TextColor3 = Color3.fromRGB(35, 35, 35)
    Value.Font = Enum.Font.GothamBold
    Value.TextSize = 18
    Value.TextXAlignment = Enum.TextXAlignment.Left
    Value.TextTruncate = Enum.TextTruncate.AtEnd
    Value.Parent = Box
    
    Box.Size = UDim2.new(0, 195, 0, 75)

    Box.MouseEnter:Connect(function()

        TweenService:Create(Box, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        }):Play()

        TweenService:Create(Scale, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.03 -- 1.03 дает красивое легкое увеличение
        }):Play()

        TweenService:Create(Stroke, TweenInfo.new(0.25), {
            Color = Color3.fromRGB(0, 0, 0)
        }):Play()

        TweenService:Create(Title, TweenInfo.new(0.25), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()

        TweenService:Create(Value, TweenInfo.new(0.25), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)

    Box.MouseLeave:Connect(function()

        TweenService:Create(Box, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()

        TweenService:Create(Scale, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play()

        TweenService:Create(Stroke, TweenInfo.new(0.25), {
            Color = Color3.fromRGB(230, 230, 230)
        }):Play()

        TweenService:Create(Title, TweenInfo.new(0.25), {
            TextColor3 = Color3.fromRGB(150, 150, 150)
        }):Play()

        TweenService:Create(Value, TweenInfo.new(0.25), {
            TextColor3 = Color3.fromRGB(35, 35, 35)
        }):Play()
    end)
    
    return Box, Value
end

local _, fpsValue = CreateStatBox("FPSBox", "FPS", 1)
local _, pingValue = CreateStatBox("PingBox", "Ping", 2)
local _, playersValue = CreateStatBox("PlayersBox", "Players", 3)
local serverIdBox, serverIdValue = CreateStatBox("ServerIDBox", "Server ID", 4)
serverIdValue.TextSize = 14

local idCopied = false
serverIdBox.MouseButton1Click:Connect(function()
    if idCopied then return end
    idCopied = true
    
    if setclipboard then
        pcall(function()
            setclipboard(game.JobId ~= "" and game.JobId or "Studio / Local")
        end)
    end
    
    TweenService:Create(serverIdValue, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(0, 200, 0)}):Play()
    serverIdValue.Text = "Copied!"
    
    task.delay(1.5, function()
        TweenService:Create(serverIdValue, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        idCopied = false
    end)
end)

local frameCount = 0
local lastUpdate = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    
    if now - lastUpdate >= 1 then
        fpsValue.Text = tostring(math.floor(frameCount / (now - lastUpdate)))
        
        local ping = 0
        pcall(function() ping = math.floor(Players.LocalPlayer:GetNetworkPing() * 1000) end)
        pingValue.Text = tostring(ping) .. " ms"
        
        playersValue.Text = tostring(#Players:GetPlayers()) .. " / " .. tostring(Players.MaxPlayers)
        
        if not idCopied then
            local jobId = game.JobId
            serverIdValue.Text = (jobId == "" and "Studio / Local" or jobId)
        end
        
        frameCount = 0
        lastUpdate = now
    end
end)

HomeButton.MouseEnter:Connect(function()
    TweenService:Create(HomeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}):Play()
end)
HomeButton.MouseLeave:Connect(function()
    TweenService:Create(HomeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(100, 100, 100)}):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    local closeAnim = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    closeAnim:Play()
    closeAnim.Completed:Wait()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(35, 35, 35)}):Play()
end)
MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(100, 100, 100)}):Play()
end)

local isMinimized = false
local normalSize = UDim2.new(0, 600, 0, 350)
local minimizedSize = UDim2.new(0, 600, 0, 35)

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = minimizedSize}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = normalSize}):Play()
    end
end)

local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

