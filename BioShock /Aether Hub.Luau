local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local ParentGui = RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or CoreGui

if ParentGui:FindFirstChild("AetherHubUI") then
    ParentGui:FindFirstChild("AetherHubUI"):Destroy()
end

local Theme = {
    AntiqueGold  = Color3.fromRGB(201, 161, 74),   
    DarkBrass    = Color3.fromRGB(140, 106, 45),   
    IvoryPaper   = Color3.fromRGB(239, 229, 200),  
    BurnedPaper  = Color3.fromRGB(214, 194, 156),  
    DarkBrown    = Color3.fromRGB(51, 38, 27),     
    AlmostBlack  = Color3.fromRGB(26, 22, 18),     
    WarmGlow     = Color3.fromRGB(255, 215, 115),  
    InkDark      = Color3.fromRGB(45, 38, 28),     
    MutedInk     = Color3.fromRGB(105, 90, 70),    
    CrimsonWax   = Color3.fromRGB(138, 28, 28),    
}

local Fonts = {
    Title = Enum.Font.Garamond,
    Body = Enum.Font.Garamond,
    Code = Enum.Font.Code,
}

local function CreateTween(obj, duration, properties, easingStyle, easingDir)
    local info = TweenInfo.new(
        duration or 0.25, 
        easingStyle or Enum.EasingStyle.Quad, 
        easingDir or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(obj, info, properties)
    tween:Play()
    return tween
end

local function ApplyGoldGradient(parentInstance, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.DarkBrass),
        ColorSequenceKeypoint.new(0.3, Theme.AntiqueGold),
        ColorSequenceKeypoint.new(0.5, Theme.WarmGlow),
        ColorSequenceKeypoint.new(0.7, Theme.AntiqueGold),
        ColorSequenceKeypoint.new(1, Theme.DarkBrass)
    })
    gradient.Rotation = rotation or 45
    gradient.Parent = parentInstance
    return gradient
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AetherHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = ParentGui

local MainScale = Instance.new("UIScale")
MainScale.Scale = 1.0
MainScale.Parent = ScreenGui

local MainShadow = Instance.new("ImageLabel")
MainShadow.Name = "MainShadow"
MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
MainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
MainShadow.Size = UDim2.new(0, 840, 0, 580)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxassetid://601589021"
MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.ImageTransparency = 0.4
MainShadow.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 800, 0, 540)
MainFrame.BackgroundColor3 = Theme.AlmostBlack
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false
MainFrame.Parent = MainShadow

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

local OuterStroke = Instance.new("UIStroke")
OuterStroke.Thickness = 1.5
OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ApplyGoldGradient(OuterStroke)
OuterStroke.Parent = MainFrame

local Parchment = Instance.new("Frame")
Parchment.Name = "Parchment"
Parchment.Size = UDim2.new(1, -24, 1, -24)
Parchment.Position = UDim2.new(0, 12, 0, 12)
Parchment.BackgroundColor3 = Theme.IvoryPaper
Parchment.BorderSizePixel = 0
Parchment.Parent = MainFrame

local ParchmentCorner = Instance.new("UICorner")
ParchmentCorner.CornerRadius = UDim.new(0, 4)
ParchmentCorner.Parent = Parchment

local PaperTexture = Instance.new("ImageLabel")
PaperTexture.Name = "PaperTexture"
PaperTexture.Size = UDim2.new(1, 0, 1, 0)
PaperTexture.BackgroundTransparency = 1
PaperTexture.Image = "rbxassetid://6031265842"
PaperTexture.ImageColor3 = Theme.BurnedPaper
PaperTexture.ImageTransparency = 0.85
PaperTexture.ScaleType = Enum.ScaleType.Tile
PaperTexture.TileSize = UDim2.new(0, 256, 0, 256)
PaperTexture.Parent = Parchment

local InnerBorder = Instance.new("Frame")
InnerBorder.Name = "InnerBorder"
InnerBorder.Size = UDim2.new(1, -12, 1, -12)
InnerBorder.Position = UDim2.new(0, 6, 0, 6)
InnerBorder.BackgroundTransparency = 1
InnerBorder.Parent = Parchment

local InnerStroke = Instance.new("UIStroke")
InnerStroke.Thickness = 1
InnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
InnerStroke.Color = Theme.DarkBrass
InnerStroke.Transparency = 0.5
InnerStroke.Parent = InnerBorder

local function AddFlourish(name, position, rotation)
    local flourish = Instance.new("ImageLabel")
    flourish.Name = name
    flourish.Size = UDim2.new(0, 32, 0, 32)
    flourish.BackgroundTransparency = 1
    flourish.Image = "rbxassetid://14457788878"
    flourish.ImageColor3 = Theme.AntiqueGold
    flourish.ImageTransparency = 0.15
    flourish.Rotation = rotation
    
    if position == "TL" then
        flourish.Position = UDim2.new(0, 2, 0, 2)
    elseif position == "TR" then
        flourish.Position = UDim2.new(1, -34, 0, 2)
    elseif position == "BL" then
        flourish.Position = UDim2.new(0, 2, 1, -34)
    elseif position == "BR" then
        flourish.Position = UDim2.new(1, -34, 1, -34)
    end
    
    flourish.Parent = InnerBorder
end

AddFlourish("CornerTL", "TL", 0)
AddFlourish("CornerTR", "TR", 90)
AddFlourish("CornerBL", "BL", -90)
AddFlourish("CornerBR", "BR", 180)

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, -20, 0, 65)
Header.Position = UDim2.new(0, 10, 0, 10)
Header.BackgroundTransparency = 1
Header.Parent = InnerBorder

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 300, 0, 32)
Title.Position = UDim2.new(0, 15, 0, 12)
Title.BackgroundTransparency = 1
Title.Font = Fonts.Title
Title.Text = "A E T H E R   H U B"
Title.TextColor3 = Theme.DarkBrown
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local TitleGradient = ApplyGoldGradient(Title, 0)

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(0, 300, 0, 16)
Subtitle.Position = UDim2.new(0, 16, 0, 38)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Fonts.Body
Subtitle.Text = "PREMIUM UTILITIES & SCRIPT COMPENDIUM"
Subtitle.TextColor3 = Theme.DarkBrass
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

local VersionBadge = Instance.new("TextLabel")
VersionBadge.Name = "VersionBadge"
VersionBadge.Size = UDim2.new(0, 60, 0, 20)
VersionBadge.Position = UDim2.new(0, 190, 0, 13)
VersionBadge.BackgroundTransparency = 1
VersionBadge.Font = Fonts.Body
VersionBadge.Text = "V3.0"
VersionBadge.TextColor3 = Theme.AntiqueGold
VersionBadge.TextSize = 12
VersionBadge.TextXAlignment = Enum.TextXAlignment.Left
VersionBadge.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -38, 0, 14)
CloseButton.BackgroundColor3 = Theme.CrimsonWax
CloseButton.AutoButtonColor = false
CloseButton.Font = Fonts.Title
CloseButton.Text = "X"
CloseButton.TextColor3 = Theme.IvoryPaper
CloseButton.TextSize = 14
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Thickness = 1.5
CloseStroke.Color = Theme.DarkBrass
CloseStroke.Parent = CloseButton

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
MinimizeButton.Position = UDim2.new(1, -74, 0, 14) 
MinimizeButton.BackgroundColor3 = Theme.DarkBrass
MinimizeButton.AutoButtonColor = false
MinimizeButton.Font = Fonts.Title
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Theme.IvoryPaper
MinimizeButton.TextSize = 14
MinimizeButton.Parent = Header

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

local MinimizeStroke = Instance.new("UIStroke")
MinimizeStroke.Thickness = 1.5
MinimizeStroke.Color = Theme.AntiqueGold
MinimizeStroke.Parent = MinimizeButton

local RestoreButton = Instance.new("TextButton")
RestoreButton.Name = "RestoreButton"
RestoreButton.Size = UDim2.new(0, 50, 0, 50)
RestoreButton.Position = UDim2.new(0.95, -50, 0.9, -50)
RestoreButton.BackgroundColor3 = Theme.AlmostBlack
RestoreButton.Visible = false
RestoreButton.AutoButtonColor = false
RestoreButton.Font = Fonts.Title
RestoreButton.Text = "⚜"
RestoreButton.TextColor3 = Theme.AntiqueGold
RestoreButton.TextSize = 24
RestoreButton.Parent = ScreenGui

local RestoreCorner = Instance.new("UICorner")
RestoreCorner.CornerRadius = UDim.new(1, 0)
RestoreCorner.Parent = RestoreButton

local RestoreStroke = Instance.new("UIStroke")
RestoreStroke.Thickness = 2
ApplyGoldGradient(RestoreStroke)
RestoreStroke.Parent = RestoreButton

local RestoreScale = Instance.new("UIScale")
RestoreScale.Scale = 0
RestoreScale.Parent = RestoreButton

CloseButton.MouseEnter:Connect(function()
    CreateTween(CloseButton, 0.2, {BackgroundColor3 = Color3.fromRGB(168, 38, 38), Rotation = 5})
end)
CloseButton.MouseLeave:Connect(function()
    CreateTween(CloseButton, 0.2, {BackgroundColor3 = Theme.CrimsonWax, Rotation = 0})
end)

MinimizeButton.MouseEnter:Connect(function()
    CreateTween(MinimizeButton, 0.2, {BackgroundColor3 = Theme.AntiqueGold, Rotation = -5})
end)
MinimizeButton.MouseLeave:Connect(function()
    CreateTween(MinimizeButton, 0.2, {BackgroundColor3 = Theme.DarkBrass, Rotation = 0})
end)

RestoreButton.MouseEnter:Connect(function()
    CreateTween(RestoreButton, 0.2, {BackgroundColor3 = Theme.InkDark})
end)
RestoreButton.MouseLeave:Connect(function()
    CreateTween(RestoreButton, 0.2, {BackgroundColor3 = Theme.AlmostBlack})
end)

local function CloseUI()
    CreateTween(MainShadow, 0.25, {ImageTransparency = 1})
    CreateTween(MainFrame, 0.25, {BackgroundTransparency = 1})
    local t = CreateTween(Parchment, 0.25, {BackgroundTransparency = 1})
    t.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

local isMinimized = false

local function MinimizeUI()
    if isMinimized then return end
    isMinimized = true
    
    CreateTween(MainShadow, 0.3, {ImageTransparency = 1})
    CreateTween(MainFrame, 0.3, {BackgroundTransparency = 1})
    local t = CreateTween(Parchment, 0.3, {BackgroundTransparency = 1})
    
    t.Completed:Connect(function()
        MainShadow.Visible = false
        RestoreButton.Visible = true
        CreateTween(RestoreScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
    end)
end

local function RestoreUI()
    if not isMinimized then return end
    isMinimized = false
    
    local t = CreateTween(RestoreScale, 0.3, {Scale = 0}, Enum.EasingStyle.Back)
    t.Completed:Connect(function()
        RestoreButton.Visible = false
        MainShadow.Visible = true
        CreateTween(MainShadow, 0.3, {ImageTransparency = 0.4})
        CreateTween(MainFrame, 0.3, {BackgroundTransparency = 0})
        CreateTween(Parchment, 0.3, {BackgroundTransparency = 0})
    end)
end

CloseButton.Activated:Connect(CloseUI)
MinimizeButton.Activated:Connect(MinimizeUI)
RestoreButton.Activated:Connect(RestoreUI)

local HeaderDivider = Instance.new("Frame")
HeaderDivider.Name = "HeaderDivider"
HeaderDivider.Size = UDim2.new(1, -30, 0, 2)
HeaderDivider.Position = UDim2.new(0, 15, 0, 64)
HeaderDivider.BorderSizePixel = 0
HeaderDivider.BackgroundColor3 = Theme.DarkBrass
HeaderDivider.Parent = Header

local DivGradient = ApplyGoldGradient(HeaderDivider, 0)

local NavigationFrame = Instance.new("Frame")
NavigationFrame.Name = "Navigation"
NavigationFrame.Size = UDim2.new(0, 160, 1, -110)
NavigationFrame.Position = UDim2.new(0, 15, 0, 80)
NavigationFrame.BackgroundTransparency = 1
NavigationFrame.Parent = InnerBorder

local NavListLayout = Instance.new("UIListLayout")
NavListLayout.Padding = UDim.new(0, 8)
NavListLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavListLayout.Parent = NavigationFrame

local PageContainer = Instance.new("Frame")
PageContainer.Name = "PageContainer"
PageContainer.Size = UDim2.new(1, -200, 1, -110)
PageContainer.Position = UDim2.new(0, 185, 0, 80)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = InnerBorder

local VertDivider = Instance.new("Frame")
VertDivider.Name = "VertDivider"
VertDivider.Size = UDim2.new(0, 1, 1, -110)
VertDivider.Position = UDim2.new(0, 178, 0, 80)
VertDivider.BorderSizePixel = 0
VertDivider.BackgroundColor3 = Theme.DarkBrass
VertDivider.Transparency = 0.6
VertDivider.Parent = InnerBorder

local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Size = UDim2.new(1, -30, 0, 22)
StatusBar.Position = UDim2.new(0, 15, 1, -32)
StatusBar.BackgroundTransparency = 1
StatusBar.Parent = InnerBorder

local StatusDivider = Instance.new("Frame")
StatusDivider.Name = "StatusDivider"
StatusDivider.Size = UDim2.new(1, 0, 0, 1)
StatusDivider.Position = UDim2.new(0, 0, 0, -2)
StatusDivider.BorderSizePixel = 0
StatusDivider.BackgroundColor3 = Theme.DarkBrass
StatusDivider.Transparency = 0.5
StatusDivider.Parent = StatusBar

local UserLabel = Instance.new("TextLabel")
UserLabel.Size = UDim2.new(0.3, 0, 1, 0)
UserLabel.BackgroundTransparency = 1
UserLabel.Font = Fonts.Body
UserLabel.TextColor3 = Theme.MutedInk
UserLabel.TextSize = 11
UserLabel.TextXAlignment = Enum.TextXAlignment.Left
UserLabel.Text = "User: " .. Players.LocalPlayer.Name
UserLabel.Parent = StatusBar

local FpsLabel = Instance.new("TextLabel")
FpsLabel.Size = UDim2.new(0.2, 0, 1, 0)
FpsLabel.Position = UDim2.new(0.3, 0, 0, 0)
FpsLabel.BackgroundTransparency = 1
FpsLabel.Font = Fonts.Body
FpsLabel.TextColor3 = Theme.MutedInk
FpsLabel.TextSize = 11
FpsLabel.TextXAlignment = Enum.TextXAlignment.Left
FpsLabel.Text = "FPS: 60"
FpsLabel.Parent = StatusBar

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(0.2, 0, 1, 0)
PingLabel.Position = UDim2.new(0.5, 0, 0, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Font = Fonts.Body
PingLabel.TextColor3 = Theme.MutedInk
PingLabel.TextSize = 11
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.Text = "Ping: 0 ms"
PingLabel.Parent = StatusBar

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(0.3, 0, 1, 0)
TimeLabel.Position = UDim2.new(0.7, 0, 0, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Font = Fonts.Body
TimeLabel.TextColor3 = Theme.MutedInk
TimeLabel.TextSize = 11
TimeLabel.TextXAlignment = Enum.TextXAlignment.Right
TimeLabel.Text = "12:00 PM"
TimeLabel.Parent = StatusBar

task.spawn(function()
    local lastTime = os.clock()
    local frameCount = 0
    while task.wait(0.5) do
        local currentTime = os.clock()
        local fps = math.round(frameCount / (currentTime - lastTime))
        FpsLabel.Text = "FPS: " .. tostring(fps)
        frameCount = 0
        lastTime = currentTime
        
        local pingVal = 0
        local s, err = pcall(function()
            pingVal = math.round(Players.LocalPlayer:GetNetworkPing() * 1000)
        end)
        PingLabel.Text = s and ("Ping: " .. pingVal .. " ms") or "Ping: N/A"
        
        TimeLabel.Text = os.date("%I:%M %p")
    end
end)
RunService.RenderStepped:Connect(function()

    local frameCount = 0
end)

local Pages = {}
local NavButtons = {}
local ActiveTab = nil

local function SwitchTab(tabName)
    if ActiveTab == tabName then return end
    
    if ActiveTab then
        local currentBtn = NavButtons[ActiveTab]
        local currentPage = Pages[ActiveTab]
        
        CreateTween(currentBtn.BackgroundFrame, 0.25, {BackgroundTransparency = 1})
        CreateTween(currentBtn.TextLabel, 0.25, {TextColor3 = Theme.MutedInk})
        CreateTween(currentBtn.Flourish, 0.25, {ImageTransparency = 1, Position = UDim2.new(0, -10, 0.5, -6)})
        
        currentPage.Visible = false
    end
    
    ActiveTab = tabName
    local targetBtn = NavButtons[tabName]
    local targetPage = Pages[tabName]
    
    CreateTween(targetBtn.BackgroundFrame, 0.25, {BackgroundTransparency = 0.9, BackgroundColor3 = Theme.AntiqueGold})
    CreateTween(targetBtn.TextLabel, 0.25, {TextColor3 = Theme.DarkBrown})
    CreateTween(targetBtn.Flourish, 0.25, {ImageTransparency = 0.1, Position = UDim2.new(0, 8, 0.5, -6)})
    
    targetPage.Visible = true
end

local function RegisterTab(tabName, unicodeIcon)

    local Page = Instance.new("ScrollingFrame")
    Page.Name = tabName .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Theme.DarkBrass
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.Parent = PageContainer
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 12)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Parent = Page
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
    end)
    
    local NavBtn = Instance.new("TextButton")
    NavBtn.Name = tabName .. "Button"
    NavBtn.Size = UDim2.new(1, 0, 0, 36)
    NavBtn.BackgroundTransparency = 1
    NavBtn.Text = ""
    NavBtn.AutoButtonColor = false
    NavBtn.Parent = NavigationFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = NavBtn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Theme.DarkBrass
    Stroke.Transparency = 0.75
    Stroke.Parent = NavBtn
    
    local BackgroundFrame = Instance.new("Frame")
    BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
    BackgroundFrame.BackgroundTransparency = 1
    BackgroundFrame.BorderSizePixel = 0
    BackgroundFrame.ZIndex = 1
    BackgroundFrame.Parent = NavBtn
    
    local BgCorner = Instance.new("UICorner")
    BgCorner.CornerRadius = UDim.new(0, 4)
    BgCorner.Parent = BackgroundFrame
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -40, 1, 0)
    TextLabel.Position = UDim2.new(0, 30, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.ZIndex = 2
    TextLabel.Font = Fonts.Body
    TextLabel.Text = (unicodeIcon or "❖") .. "  " .. tabName:upper()
    TextLabel.TextColor3 = Theme.MutedInk
    TextLabel.TextSize = 13
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = NavBtn
    
    local SelectedFlourish = Instance.new("ImageLabel")
    SelectedFlourish.Size = UDim2.new(0, 12, 0, 12)
    SelectedFlourish.Position = UDim2.new(0, -10, 0.5, -6)
    SelectedFlourish.BackgroundTransparency = 1
    SelectedFlourish.Image = "rbxassetid://11603504111"
    SelectedFlourish.ImageColor3 = Theme.DarkBrass
    SelectedFlourish.ImageTransparency = 1
    SelectedFlourish.ZIndex = 2
    SelectedFlourish.Parent = NavBtn
    
    NavButtons[tabName] = {
        Button = NavBtn,
        BackgroundFrame = BackgroundFrame,
        TextLabel = TextLabel,
        Flourish = SelectedFlourish
    }
    Pages[tabName] = Page
    
    NavBtn.MouseEnter:Connect(function()
        if ActiveTab ~= tabName then
            CreateTween(BackgroundFrame, 0.2, {BackgroundTransparency = 0.95, BackgroundColor3 = Theme.AntiqueGold})
            CreateTween(TextLabel, 0.2, {TextColor3 = Theme.DarkBrown})
        end
    end)
    NavBtn.MouseLeave:Connect(function()
        if ActiveTab ~= tabName then
            CreateTween(BackgroundFrame, 0.2, {BackgroundTransparency = 1})
            CreateTween(TextLabel, 0.2, {TextColor3 = Theme.MutedInk})
        end
    end)
    NavBtn.MouseButton1Click:Connect(function()
        SwitchTab(tabName)
    end)
    
    return Page
end

local UI = {}

function UI:CreateSection(parent, text)
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Size = UDim2.new(1, -10, 0, 32)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Fonts.Title
    Label.Text = "✦ " .. text:upper() .. " ✦"
    Label.TextColor3 = Theme.DarkBrass
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Center
    Label.Parent = SectionFrame
    
    local LineLeft = Instance.new("Frame")
    LineLeft.Size = UDim2.new(0.25, 0, 0, 1)
    LineLeft.Position = UDim2.new(0, 0, 0.5, 0)
    LineLeft.BackgroundColor3 = Theme.DarkBrass
    LineLeft.BorderSizePixel = 0
    LineLeft.Transparency = 0.5
    LineLeft.Parent = SectionFrame
    
    local LineRight = Instance.new("Frame")
    LineRight.Size = UDim2.new(0.25, 0, 0, 1)
    LineRight.Position = UDim2.new(0.75, 0, 0.5, 0)
    LineRight.BackgroundColor3 = Theme.DarkBrass
    LineRight.BorderSizePixel = 0
    LineRight.Transparency = 0.5
    LineRight.Parent = SectionFrame
end

function UI:CreateButton(parent, text, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, -10, 0, 38)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = parent
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundColor3 = Theme.BurnedPaper
    Button.AutoButtonColor = false
    Button.Font = Fonts.Body
    Button.Text = text
    Button.TextColor3 = Theme.InkDark
    Button.TextSize = 13
    Button.Parent = ButtonFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Theme.DarkBrass
    Stroke.Transparency = 0.4
    Stroke.Parent = Button
    
    Button.MouseEnter:Connect(function()
        CreateTween(Button, 0.2, {BackgroundColor3 = Theme.IvoryPaper})
        CreateTween(Stroke, 0.2, {Color = Theme.AntiqueGold, Thickness = 1.5})
    end)
    Button.MouseLeave:Connect(function()
        CreateTween(Button, 0.2, {BackgroundColor3 = Theme.BurnedPaper})
        CreateTween(Stroke, 0.2, {Color = Theme.DarkBrass, Thickness = 1})
    end)
    Button.MouseButton1Down:Connect(function()
        CreateTween(Button, 0.1, {Size = UDim2.new(0.98, 0, 0.92, 0), Position = UDim2.new(0.01, 0, 0.04, 0)})
    end)
    Button.MouseButton1Up:Connect(function()
        CreateTween(Button, 0.1, {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)})
        task.spawn(callback)
    end)
end

function UI:CreateToggle(parent, text, defaultState, callback)
    local state = defaultState or false
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 40)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Fonts.Body
    Label.Text = text
    Label.TextColor3 = Theme.InkDark
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.Parent = ToggleFrame
    
    local Track = Instance.new("TextButton")
    Track.Size = UDim2.new(0, 44, 0, 20)
    Track.Position = UDim2.new(1, -49, 0.5, -10)
    Track.BackgroundColor3 = Theme.BurnedPaper
    Track.Text = ""
    Track.AutoButtonColor = false
    Track.Parent = ToggleFrame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = Track
    
    local TrackStroke = Instance.new("UIStroke")
    TrackStroke.Thickness = 1
    TrackStroke.Color = Theme.DarkBrass
    TrackStroke.Parent = Track
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    Knob.BackgroundColor3 = state and Theme.AntiqueGold or Theme.DarkBrass
    Knob.BorderSizePixel = 0
    Knob.Parent = Track
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local function ToggleState()
        state = not state
        local targetPosition = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        local targetColor = state and Theme.AntiqueGold or Theme.DarkBrass
        local targetBg = state and Theme.IvoryPaper or Theme.BurnedPaper
        
        CreateTween(Knob, 0.2, {Position = targetPosition, BackgroundColor3 = targetColor})
        CreateTween(Track, 0.2, {BackgroundColor3 = targetBg})
        
        task.spawn(callback, state)
    end
    
    Track.MouseButton1Click:Connect(ToggleState)
    
    Track.MouseEnter:Connect(function()
        CreateTween(TrackStroke, 0.2, {Color = Theme.AntiqueGold})
    end)
    Track.MouseLeave:Connect(function()
        CreateTween(TrackStroke, 0.2, {Color = Theme.DarkBrass})
    end)
end

function UI:CreateSlider(parent, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -10, 0, 50)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Font = Fonts.Body
    Label.Text = text
    Label.TextColor3 = Theme.InkDark
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Position = UDim2.new(0, 5, 0, 2)
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0, 20)
    ValueLabel.Position = UDim2.new(0.7, -5, 0, 2)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Fonts.Body
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Theme.DarkBrass
    ValueLabel.TextSize = 13
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    
    local Rail = Instance.new("TextButton")
    Rail.Size = UDim2.new(1, -10, 0, 6)
    Rail.Position = UDim2.new(0, 5, 1, -14)
    Rail.BackgroundColor3 = Theme.BurnedPaper
    Rail.Text = ""
    Rail.AutoButtonColor = false
    Rail.Parent = SliderFrame
    
    local RailCorner = Instance.new("UICorner")
    RailCorner.CornerRadius = UDim.new(1, 0)
    RailCorner.Parent = Rail
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.AntiqueGold
    Fill.BorderSizePixel = 0
    Fill.Parent = Rail
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
    Knob.BackgroundColor3 = Theme.DarkBrass
    Knob.BorderSizePixel = 0
    Knob.Parent = Rail
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local KnobStroke = Instance.new("UIStroke")
    KnobStroke.Thickness = 1
    KnobStroke.Color = Theme.AntiqueGold
    KnobStroke.Parent = Knob
    
    local isDragging = false
    
    local function UpdateSliderValue(input)
        local relativeX = math.clamp((input.Position.X - Rail.AbsolutePosition.X) / Rail.AbsoluteSize.X, 0, 1)
        local value = math.round(min + (max - min) * relativeX)
        
        ValueLabel.Text = tostring(value)
        Fill.Size = UDim2.new(relativeX, 0, 1, 0)
        Knob.Position = UDim2.new(relativeX, 0, 0.5, 0)
        
        task.spawn(callback, value)
    end
    
    Rail.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            UpdateSliderValue(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSliderValue(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
end

function UI:CreateTextbox(parent, placeholder, callback)
    local TextboxFrame = Instance.new("Frame")
    TextboxFrame.Size = UDim2.new(1, -10, 0, 38)
    TextboxFrame.BackgroundTransparency = 1
    TextboxFrame.Parent = parent
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, 0, 1, 0)
    TextBox.BackgroundColor3 = Theme.IvoryPaper
    TextBox.Font = Fonts.Body
    TextBox.PlaceholderText = placeholder
    TextBox.PlaceholderColor3 = Theme.MutedInk
    TextBox.Text = ""
    TextBox.TextColor3 = Theme.InkDark
    TextBox.TextSize = 13
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = TextboxFrame
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.PaddingRight = UDim.new(0, 10)
    Padding.Parent = TextBox
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = TextBox
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Theme.DarkBrass
    Stroke.Transparency = 0.5
    Stroke.Parent = TextBox
    
    TextBox.Focused:Connect(function()
        CreateTween(Stroke, 0.2, {Color = Theme.AntiqueGold, Transparency = 0.1})
    end)
    
    TextBox.FocusLost:Connect(function(enterPressed)
        CreateTween(Stroke, 0.2, {Color = Theme.DarkBrass, Transparency = 0.5})
        task.spawn(callback, TextBox.Text, enterPressed)
    end)
end

function UI:CreateDropdown(parent, text, options, callback)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, -10, 0, 38)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.ClipsDescendants = true
    DropdownFrame.Parent = parent
    
    local HeaderBtn = Instance.new("TextButton")
    HeaderBtn.Size = UDim2.new(1, 0, 0, 38)
    HeaderBtn.BackgroundColor3 = Theme.BurnedPaper
    HeaderBtn.AutoButtonColor = false
    HeaderBtn.Font = Fonts.Body
    HeaderBtn.Text = text .. " : [Select Option]"
    HeaderBtn.TextColor3 = Theme.InkDark
    HeaderBtn.TextSize = 13
    HeaderBtn.TextXAlignment = Enum.TextXAlignment.Left
    HeaderBtn.Parent = DropdownFrame
    
    local HeaderPadding = Instance.new("UIPadding")
    HeaderPadding.PaddingLeft = UDim.new(0, 10)
    HeaderPadding.Parent = HeaderBtn
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 4)
    HeaderCorner.Parent = HeaderBtn
    
    local HeaderStroke = Instance.new("UIStroke")
    HeaderStroke.Thickness = 1
    HeaderStroke.Color = Theme.DarkBrass
    HeaderStroke.Transparency = 0.5
    HeaderStroke.Parent = HeaderBtn
    
    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 38, 0, 38)
    Arrow.Position = UDim2.new(1, -38, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Font = Fonts.Body
    Arrow.Text = "▼"
    Arrow.TextColor3 = Theme.DarkBrass
    Arrow.TextSize = 10
    Arrow.Parent = HeaderBtn
    
    local OptionsFrame = Instance.new("ScrollingFrame")
    OptionsFrame.Size = UDim2.new(1, 0, 0, 120)
    OptionsFrame.Position = UDim2.new(0, 0, 0, 42)
    OptionsFrame.BackgroundColor3 = Theme.IvoryPaper
    OptionsFrame.BorderSizePixel = 0
    OptionsFrame.ScrollBarThickness = 3
    OptionsFrame.ScrollBarImageColor3 = Theme.DarkBrass
    OptionsFrame.Visible = false
    OptionsFrame.Parent = DropdownFrame
    
    local OptionsLayout = Instance.new("UIListLayout")
    OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    OptionsLayout.Parent = OptionsFrame
    
    local DropStroke = Instance.new("UIStroke")
    DropStroke.Thickness = 1
    DropStroke.Color = Theme.DarkBrass
    DropStroke.Parent = OptionsFrame
    
    local function ToggleDropdown()
        local opened = DropdownFrame.Size.Y.Offset > 40
        if opened then
            CreateTween(DropdownFrame, 0.2, {Size = UDim2.new(1, -10, 0, 38)})
            Arrow.Text = "▼"
            task.delay(0.2, function() OptionsFrame.Visible = false end)
        else
            OptionsFrame.Visible = true
            CreateTween(DropdownFrame, 0.2, {Size = UDim2.new(1, -10, 0, 170)})
            Arrow.Text = "▲"
        end
    end
    
    HeaderBtn.MouseButton1Click:Connect(ToggleDropdown)
    
    for i, option in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 30)
        OptBtn.BackgroundColor3 = Theme.IvoryPaper
        OptBtn.BackgroundTransparency = 1
        OptBtn.AutoButtonColor = false
        OptBtn.Font = Fonts.Body
        OptBtn.Text = tostring(option)
        OptBtn.TextColor3 = Theme.InkDark
        OptBtn.TextSize = 12
        OptBtn.Parent = OptionsFrame
        
        OptBtn.MouseEnter:Connect(function()
            CreateTween(OptBtn, 0.2, {BackgroundTransparency = 0.5, BackgroundColor3 = Theme.BurnedPaper})
        end)
        OptBtn.MouseLeave:Connect(function()
            CreateTween(OptBtn, 0.2, {BackgroundTransparency = 1})
        end)
        OptBtn.MouseButton1Click:Connect(function()
            HeaderBtn.Text = text .. " : " .. tostring(option)
            ToggleDropdown()
            task.spawn(callback, option)
        end)
    end
end

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart

    MainShadow.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainShadow.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local HomeTab      = RegisterTab("Example1", "⚜")
local CombatTab    = RegisterTab("Example2", "⚔")
local VisualsTab   = RegisterTab("Example3", "👁")
local TeleportTab  = RegisterTab("Example4", "⚓")
local ExecutorTab  = RegisterTab("Example5", "✍")
local SettingsTab  = RegisterTab("Settigns", "⚙")

UI:CreateSection(HomeTab, "Welcome")

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Size = UDim2.new(1, -10, 0, 75)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Font = Fonts.Body
WelcomeText.TextColor3 = Theme.InkDark
WelcomeText.TextWrapped = true
WelcomeText.TextSize = 14
WelcomeText.Text = "Welcome to the AETHER Compendium. An elite archival design reminiscent of old Victorian luxury. Herein lies access to your modern script library, engineered with beautiful mechanical interfaces."
WelcomeText.TextXAlignment = Enum.TextXAlignment.Left
WelcomeText.Parent = HomeTab

local DividerGraphic = Instance.new("ImageLabel")
DividerGraphic.Size = UDim2.new(0, 180, 0, 16)
DividerGraphic.BackgroundTransparency = 1
DividerGraphic.Image = "rbxassetid://11603504111"
DividerGraphic.ImageColor3 = Theme.DarkBrass
DividerGraphic.ImageTransparency = 0.5
DividerGraphic.Parent = HomeTab

UI:CreateSection(HomeTab, "System Status")

local StatusInfo = Instance.new("TextLabel")
StatusInfo.Size = UDim2.new(1, -10, 0, 50)
StatusInfo.BackgroundTransparency = 1
StatusInfo.Font = Fonts.Body
StatusInfo.TextColor3 = Theme.MutedInk
StatusInfo.TextSize = 13
StatusInfo.TextXAlignment = Enum.TextXAlignment.Left
StatusInfo.Text = "• Executor Platform: Universal API\n• License Type: Premium Archival Access\n• Server Security Protocol: Active & Encrypted"
StatusInfo.Parent = HomeTab

UI:CreateSection(CombatTab, "Example22")

UI:CreateToggle(CombatTab, "Example", false, function(state)
    print("Aether Lock state:", state)
end)

UI:CreateSlider(CombatTab, "Example", 10, 360, 90, function(value)
    print("Aimlock FOV modified to:", value)
end)

UI:CreateDropdown(CombatTab, "Exmaple", {"Head", "Torso", "HumanoidRootPart"}, function(selected)
    print("Anchor Target locked to:", selected)
end)

UI:CreateSection(CombatTab, "Example4")

UI:CreateToggle(CombatTab, "Aether Rapid Trigger", false, function(state)
    print("Rapid Fire:", state)
end)

UI:CreateSection(VisualsTab, "Example1")

UI:CreateToggle(VisualsTab, "Example", false, function(state)
    print("ESP Active:", state)
end)

UI:CreateToggle(VisualsTab, "Example", false, function(state)
    print("Skeleton Drawing:", state)
end)

UI:CreateToggle(VisualsTab, "Example", false, function(state)
    print("Names Revealed:", state)
end)

UI:CreateSlider(VisualsTab, "Example", 50, 5000, 1000, function(value)
    print("Render Distance threshold changed:", value)
end)

UI:CreateSection(TeleportTab, "Example8")

UI:CreateButton(TeleportTab, "Shift to Humanoid Coordinates", function()
    print("Initiating shift...")
end)

UI:CreateDropdown(TeleportTab, "Example", {"Example", "Example", "Example", "Example"}, function(selected)
    print("Warping coordinates directly to:", selected)
end)

UI:CreateSection(ExecutorTab, "Example10")

local EditorFrame = Instance.new("Frame")
EditorFrame.Size = UDim2.new(1, -10, 0, 180)
EditorFrame.BackgroundColor3 = Theme.IvoryPaper
EditorFrame.Parent = ExecutorTab

local EditorCorner = Instance
ditorCorner.CornerRadius = UDim.new(0, 4)
EditorCorner.Parent = EditorFrame

local EditorStroke = Instance.new("UIStroke")
EditorStroke.Thickness = 1
EditorStroke.Color = Theme.DarkBrass
EditorStroke.Parent = EditorFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -10, 1, -10)
TextBox.Position = UDim2.new(0, 5, 0, 5)
TextBox.BackgroundTransparency = 1
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.Font = Fonts.Code
TextBox.PlaceholderText = "-- Scribe your Lua equations here...\nprint('Greetings from Columbia')"
TextBox.PlaceholderColor3 = Theme.MutedInk
TextBox.Text = ""
TextBox.TextColor3 = Theme.InkDark
TextBox.TextSize = 12
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.Parent = EditorFrame

local ActionContainer = Instance.new("Frame")
ActionContainer.Size = UDim2.new(1, -10, 0, 40)
ActionContainer.BackgroundTransparency = 1
ActionContainer.Parent = ExecutorTab

local ActionLayout = Instance.new("UIHorizontalLayout")

local ExecBtn = Instance.new("TextButton")
ExecBtn.Size = UDim2.new(0.48, 0, 1, 0)
ExecBtn.BackgroundColor3 = Theme.BurnedPaper
ExecBtn.Font = Fonts.Body
ExecBtn.Text = "Execute Equation"
ExecBtn.TextColor3 = Theme.InkDark
ExecBtn.TextSize = 13
ExecBtn.Parent = ActionContainer

local ExecCorner = Instance.new("UICorner")
ExecCorner.CornerRadius = UDim.new(0, 4)
ExecCorner.Parent = ExecBtn

local ExecStroke = Instance.new("UIStroke")
ExecStroke.Thickness = 1
ExecStroke.Color = Theme.DarkBrass
ExecStroke.Parent = ExecBtn

ExecBtn.MouseButton1Click:Connect(function()
    local code = TextBox.Text
    local success, err = pcall(function()
        if loadstring then
            local func, compileError = loadstring(code)
            if func then
                task.spawn(func)
            else
                warn("Example]: " .. tostring(compileError))
            end
        else
            warn("Example.")
        end
    end)
    if not success then
        warn("Example]: " .. tostring(err))
    end
end)

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0.48, 0, 1, 0)
ClearBtn.Position = UDim2.new(0.52, 0, 0, 0)
ClearBtn.BackgroundColor3 = Theme.BurnedPaper
ClearBtn.Font = Fonts.Body
ClearBtn.Text = "Clear Ink"
ClearBtn.TextColor3 = Theme.InkDark
ClearBtn.TextSize = 13
ClearBtn.Parent = ActionContainer

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 4)
ClearCorner.Parent = ClearBtn

local ClearStroke = Instance.new("UIStroke")
ClearStroke.Thickness = 1
ClearStroke.Color = Theme.DarkBrass
ClearStroke.Parent = ClearBtn

ClearBtn.MouseButton1Click:Connect(function()
    TextBox.Text = ""
end)

local function HookButtonHover(btn, stroke)
    btn.MouseEnter:Connect(function()
        CreateTween(btn, 0.2, {BackgroundColor3 = Theme.IvoryPaper})
        CreateTween(stroke, 0.2, {Color = Theme.AntiqueGold})
    end)
    btn.MouseLeave:Connect(function()
        CreateTween(btn, 0.2, {BackgroundColor3 = Theme.BurnedPaper})
        CreateTween(stroke, 0.2, {Color = Theme.DarkBrass})
    end)
end
HookButtonHover(ExecBtn, ExecStroke)
HookButtonHover(ClearBtn, ClearStroke)

UI:CreateSection(SettingsTab, "Example")

UI:CreateSlider(SettingsTab, "Example3", 50, 150, 100, function(value)
    MainScale.Scale = value / 100
end)

UI:CreateSection(SettingsTab, "Example")

UI:CreateButton(SettingsTab, "Destroy Interface Safely", function()
    CreateTween(MainShadow, 0.25, {ImageTransparency = 1})
    CreateTween(MainFrame, 0.25, {BackgroundTransparency = 1})
    local t = CreateTween(Parchment, 0.25, {BackgroundTransparency = 1})
    t.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

local function RunIntroAnimation()

    MainShadow.ImageTransparency = 1
    MainFrame.BackgroundTransparency = 1
    Parchment.BackgroundTransparency = 1
    PaperTexture.ImageTransparency = 1
    InnerStroke.Transparency = 1
    Title.TextTransparency = 1
    Subtitle.TextTransparency = 1
    VersionBadge.TextTransparency = 1
    
    CreateTween(MainShadow, 0.8, {ImageTransparency = 0.4})
    CreateTween(MainFrame, 0.8, {BackgroundTransparency = 0})
    CreateTween(Parchment, 0.8, {BackgroundTransparency = 0})
    CreateTween(PaperTexture, 0.8, {ImageTransparency = 0.85})
    CreateTween(InnerStroke, 1.0, {Transparency = 0.5})
    CreateTween(Title, 1.2, {TextTransparency = 0})
    CreateTween(Subtitle, 1.4, {TextTransparency = 0})
    CreateTween(VersionBadge, 1.4, {TextTransparency = 0})
    
    SwitchTab("Example1")
end

RunIntroAnimation()
