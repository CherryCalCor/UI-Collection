local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local COLORS = {
    BgMain = Color3.fromRGB(5, 6, 7),
    BgPanel = Color3.fromRGB(10, 13, 14),
    BgCard = Color3.fromRGB(13, 16, 17),
    PrimaryYellow = Color3.fromRGB(246, 210, 26),
    BrightYellow = Color3.fromRGB(255, 228, 92),
    AccentRed = Color3.fromRGB(214, 41, 41),
    TextPrimary = Color3.fromRGB(232, 232, 232),
    TextSecondary = Color3.fromRGB(139, 143, 145),
    TextMuted = Color3.fromRGB(85, 90, 93),
    BorderGold = Color3.fromRGB(92, 77, 25),
    BorderDark = Color3.fromRGB(30, 35, 37),
}

local FONTS = {
    Main = Enum.Font.GothamMedium,
    Bold = Enum.Font.GothamBold,
    Technical = Enum.Font.Code,
}

local ASSETS = {
    LogoEmblem = "rbxassetid://18227653629",
}

local function AddTechCorners(parent: GuiObject)
    local cornerSize = 6
    local thickness = 1.5

    local points = {

        {UDim2.new(0, 0, 0, 0), UDim2.new(0, cornerSize, 0, thickness)},
        {UDim2.new(0, 0, 0, 0), UDim2.new(0, thickness, 0, cornerSize)},

        {UDim2.new(1, -cornerSize, 0, 0), UDim2.new(0, cornerSize, 0, thickness)},
        {UDim2.new(1, -thickness, 0, 0), UDim2.new(0, thickness, 0, cornerSize)},

        {UDim2.new(0, 0, 1, -thickness), UDim2.new(0, cornerSize, 0, thickness)},
        {UDim2.new(0, 0, 1, -cornerSize), UDim2.new(0, thickness, 0, cornerSize)},

        {UDim2.new(1, -cornerSize, 1, -thickness), UDim2.new(0, cornerSize, 0, thickness)},
        {UDim2.new(1, -thickness, 1, -cornerSize), UDim2.new(0, thickness, 0, cornerSize)},
    }

    for _, cfg in ipairs(points) do
        local line = Instance.new("Frame")
        line.BorderSizePixel = 0
        line.BackgroundColor3 = COLORS.PrimaryYellow
        line.Position = cfg[1]
        line.Size = cfg[2]
        line.ZIndex = parent.ZIndex + 2
        line.Parent = parent
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NCHub_Gui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0.85, 0, 0.85, 0)
MainWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
MainWindow.BackgroundColor3 = COLORS.BgMain
MainWindow.BorderSizePixel = 0
MainWindow.ClipsDescendants = true
MainWindow.Parent = ScreenGui

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Color = COLORS.BorderGold
WindowStroke.Thickness = 1.2
WindowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
WindowStroke.Parent = MainWindow

local AspectConstraint = Instance.new("UIAspectRatioConstraint")
AspectConstraint.AspectRatio = 1.45
AspectConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
AspectConstraint.DominantAxis = Enum.DominantAxis.Width
AspectConstraint.Parent = MainWindow

local UIScale = Instance.new("UIScale")
UIScale.Parent = MainWindow

local function AdjustScale()
    local vp = workspace.CurrentCamera.ViewportSize

    local scale = math.clamp(vp.Y / 850, 0.55, 1.15)
    UIScale.Scale = scale
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(AdjustScale)
AdjustScale()

AddTechCorners(MainWindow)

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 48)
TopBar.BackgroundColor3 = COLORS.BgPanel
TopBar.BorderSizePixel = 0
TopBar.Parent = MainWindow

local TopBarLine = Instance.new("Frame")
TopBarLine.Size = UDim2.new(1, 0, 0, 1)
TopBarLine.Position = UDim2.new(0, 0, 1, -1)
TopBarLine.BackgroundColor3 = COLORS.BorderDark
TopBarLine.BorderSizePixel = 0
TopBarLine.Parent = TopBar

local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(0.4, 0, 1, 0)
TitleFrame.Position = UDim2.new(0, 16, 0, 0)
TitleFrame.BackgroundTransparency = 1
TitleFrame.Parent = TopBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 75, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "NC HUB"
TitleText.TextColor3 = COLORS.PrimaryYellow
TitleText.Font = FONTS.Bold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleFrame

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(0, 40, 1, 0)
VersionText.Position = UDim2.new(0, 80, 0, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = "2.0"
VersionText.TextColor3 = COLORS.AccentRed
VersionText.Font = FONTS.Bold
VersionText.TextSize = 13
VersionText.TextXAlignment = Enum.TextXAlignment.Left
VersionText.Parent = TitleFrame

local SubtitleText = Instance.new("TextLabel")
SubtitleText.Size = UDim2.new(1, 0, 0, 12)
SubtitleText.Position = UDim2.new(0, 0, 0, 30)
SubtitleText.BackgroundTransparency = 1
SubtitleText.Text = "Example"
SubtitleText.TextColor3 = COLORS.TextMuted
SubtitleText.Font = FONTS.Technical
SubtitleText.TextSize = 8
SubtitleText.TextXAlignment = Enum.TextXAlignment.Left
SubtitleText.Parent = TitleFrame

local WindowControls = Instance.new("Frame")
WindowControls.Size = UDim2.new(0, 90, 1, 0)
WindowControls.Position = UDim2.new(1, -100, 0, 0)
WindowControls.BackgroundTransparency = 1
WindowControls.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 5, 0.5, -17)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = COLORS.TextSecondary
MinimizeBtn.Font = FONTS.Bold
MinimizeBtn.TextSize = 12
MinimizeBtn.Parent = WindowControls

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(0, 45, 0.5, -17)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = COLORS.TextSecondary
CloseBtn.Font = FONTS.Bold
CloseBtn.TextSize = 14
CloseBtn.Parent = WindowControls

local function ConnectTopButtonAnim(btn: TextButton, activeColor: Color3)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {TextColor3 = activeColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {TextColor3 = COLORS.TextSecondary}):Play()
    end)
end
ConnectTopButtonAnim(MinimizeBtn, COLORS.BrightYellow)
ConnectTopButtonAnim(CloseBtn, COLORS.AccentRed)

local dragToggle, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = MainWindow.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragToggle and input == dragInput then
        local delta = input.Position - dragStart
        MainWindow.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + (delta.X / UIScale.Scale),
            startPos.Y.Scale,
            startPos.Y.Offset + (delta.Y / UIScale.Scale)
        )
    end
end)

local LeftSidebar = Instance.new("Frame")
LeftSidebar.Name = "LeftSidebar"
LeftSidebar.Size = UDim2.new(0, 210, 1, -48)
LeftSidebar.Position = UDim2.new(0, 0, 0, 48)
LeftSidebar.BackgroundColor3 = COLORS.BgMain
LeftSidebar.BorderSizePixel = 0
LeftSidebar.Parent = MainWindow

local SidebarRightLine = Instance.new("Frame")
SidebarRightLine.Size = UDim2.new(0, 1, 1, 0)
SidebarRightLine.Position = UDim2.new(1, -1, 0, 0)
SidebarRightLine.BackgroundColor3 = COLORS.BorderDark
SidebarRightLine.BorderSizePixel = 0
SidebarRightLine.Parent = LeftSidebar

local SidebarButtonsContainer = Instance.new("Frame")
SidebarButtonsContainer.Size = UDim2.new(1, -20, 0.7, 0)
SidebarButtonsContainer.Position = UDim2.new(0, 10, 0, 15)
SidebarButtonsContainer.BackgroundTransparency = 1
SidebarButtonsContainer.Parent = LeftSidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = SidebarButtonsContainer

local categories = {"Example1", "Example", "Example", "Example", "Example", "Example", "Example"}

for i, catName in ipairs(categories) do
    local isHome = (catName == "Example1")
    
    local btn = Instance.new("Frame")
    btn.Name = catName .. "_Tab"
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    btn.Parent = SidebarButtonsContainer

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Parent = btn

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -30, 1, 0)
    textLabel.Position = UDim2.new(0, 30, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = catName
    textLabel.Font = FONTS.Bold
    textLabel.TextSize = 11
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = btn

    local marker = Instance.new("Frame")
    marker.Size = UDim2.new(0, 4, 0, 4)
    marker.Position = UDim2.new(0, 14, 0.5, -2)
    marker.BorderSizePixel = 0
    marker.Parent = btn

    if isHome then
        btn.BackgroundColor3 = COLORS.PrimaryYellow
        stroke.Color = COLORS.PrimaryYellow
        textLabel.TextColor3 = COLORS.BgMain
        marker.BackgroundColor3 = COLORS.BgMain

        local miniHighlight = Instance.new("Frame")
        miniHighlight.Size = UDim2.new(0, 2, 1, 0)
        miniHighlight.Position = UDim2.new(0, 0, 0, 0)
        miniHighlight.BackgroundColor3 = COLORS.AccentRed
        miniHighlight.BorderSizePixel = 0
        miniHighlight.Parent = btn
    else
        btn.BackgroundColor3 = COLORS.BgMain
        stroke.Color = COLORS.BorderDark
        textLabel.TextColor3 = COLORS.TextMuted
        marker.BackgroundColor3 = COLORS.TextMuted

        local hoverTrigger = Instance.new("TextButton")
        hoverTrigger.Size = UDim2.new(1, 0, 1, 0)
        hoverTrigger.BackgroundTransparency = 1
        hoverTrigger.Text = ""
        hoverTrigger.Parent = btn

        hoverTrigger.MouseEnter:Connect(function()
            TweenService:Create(stroke, TweenInfo.new(0.2), {Color = COLORS.BorderGold}):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.2), {TextColor3 = COLORS.TextSecondary}):Play()
            TweenService:Create(marker, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.PrimaryYellow}):Play()
        end)
        hoverTrigger.MouseLeave:Connect(function()
            TweenService:Create(stroke, TweenInfo.new(0.2), {Color = COLORS.BorderDark}):Play()
            TweenService:Create(textLabel, TweenInfo.new(0.2), {TextColor3 = COLORS.TextMuted}):Play()
            TweenService:Create(marker, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.TextMuted}):Play()
        end)
    end
end

local SidebarFooter = Instance.new("Frame")
SidebarFooter.Size = UDim2.new(1, -20, 0, 60)
SidebarFooter.Position = UDim2.new(0, 10, 1, -70)
SidebarFooter.BackgroundTransparency = 1
SidebarFooter.Parent = LeftSidebar

local FooterTitle = Instance.new("TextLabel")
FooterTitle.Size = UDim2.new(1, 0, 0, 10)
FooterTitle.BackgroundTransparency = 1
FooterTitle.Text = "BUILT FOR"
FooterTitle.TextColor3 = COLORS.TextMuted
FooterTitle.Font = FONTS.Technical
FooterTitle.TextSize = 7
FooterTitle.TextXAlignment = Enum.TextXAlignment.Left
FooterTitle.Parent = SidebarFooter

local FooterSubtitle = Instance.new("TextLabel")
FooterSubtitle.Size = UDim2.new(1, 0, 0, 14)
FooterSubtitle.Position = UDim2.new(0, 0, 0, 10)
FooterSubtitle.BackgroundTransparency = 1
FooterSubtitle.Text = "ROBLOX ENGINE"
FooterSubtitle.TextColor3 = COLORS.TextPrimary
FooterSubtitle.Font = FONTS.Bold
FooterSubtitle.TextSize = 11
FooterSubtitle.TextXAlignment = Enum.TextXAlignment.Left
FooterSubtitle.Parent = SidebarFooter

local TechSpecs = Instance.new("TextLabel")
TechSpecs.Size = UDim2.new(1, 0, 0, 24)
TechSpecs.Position = UDim2.new(0, 0, 0, 28)
TechSpecs.BackgroundTransparency = 1
TechSpecs.Text = "Example"
TechSpecs.TextColor3 = COLORS.AccentRed
TechSpecs.Font = FONTS.Technical
TechSpecs.TextSize = 8
TechSpecs.LineHeight = 1.3
TechSpecs.TextXAlignment = Enum.TextXAlignment.Left
TechSpecs.Parent = SidebarFooter

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "Content"
ContentFrame.Size = UDim2.new(1, -210, 1, -48)
ContentFrame.Position = UDim2.new(0, 210, 0, 48)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainWindow

local HomePage = Instance.new("Frame")
HomePage.Name = "Example1Page"
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.Parent = ContentFrame

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingLeft = UDim.new(0, 20)
ContentPadding.PaddingRight = UDim.new(0, 20)
ContentPadding.PaddingTop = UDim.new(0, 20)
ContentPadding.PaddingBottom = UDim.new(0, 20)
ContentPadding.Parent = Example1Page

local ContentHeader = Instance.new("Frame")
ContentHeader.Name = "Header"
ContentHeader.Size = UDim2.new(1, 0, 0, 45)
ContentHeader.BackgroundTransparency = 1
ContentHeader.Parent = Example1Page

local MainGreeting = Instance.new("TextLabel")
MainGreeting.Size = UDim2.new(0.6, 0, 0, 24)
MainGreeting.BackgroundTransparency = 1
MainGreeting.Text = "WELCOME, ..."
MainGreeting.TextColor3 = COLORS.TextPrimary
MainGreeting.Font = FONTS.Bold
MainGreeting.TextSize = 18
MainGreeting.TextXAlignment = Enum.TextXAlignment.Left
MainGreeting.Parent = ContentHeader

local SubGreeting = Instance.new("TextLabel")
SubGreeting.Size = UDim2.new(0.6, 0, 0, 14)
SubGreeting.Position = UDim2.new(0, 0, 0, 24)
SubGreeting.BackgroundTransparency = 1
SubGreeting.Text = "Test."
SubGreeting.TextColor3 = COLORS.TextSecondary
SubGreeting.Font = FONTS.Main
SubGreeting.TextSize = 9
SubGreeting.TextXAlignment = Enum.TextXAlignment.Left
SubGreeting.Parent = ContentHeader

local ConnectionStatus = Instance.new("Frame")
ConnectionStatus.Size = UDim2.new(0.4, 0, 0, 24)
ConnectionStatus.Position = UDim2.new(0.6, 0, 0, 0)
ConnectionStatus.BackgroundTransparency = 1
ConnectionStatus.Parent = ContentHeader

local ConnectionText = Instance.new("TextLabel")
ConnectionText.Size = UDim2.new(1, -16, 1, 0)
ConnectionText.BackgroundTransparency = 1
ConnectionText.Text = "Example"
ConnectionText.TextColor3 = COLORS.TextSecondary
ConnectionText.Font = FONTS.Bold
ConnectionText.TextSize = 10
ConnectionText.TextXAlignment = Enum.TextXAlignment.Right
ConnectionText.Parent = ConnectionStatus

local ConnectionDot = Instance.new("Frame")
ConnectionDot.Size = UDim2.new(0, 6, 0, 6)
ConnectionDot.Position = UDim2.new(1, -6, 0.5, -3)
ConnectionDot.BackgroundColor3 = COLORS.PrimaryYellow
ConnectionDot.BorderSizePixel = 0
ConnectionDot.Parent = ConnectionStatus

task.spawn(function()
    while true do
        local t1 = TweenService:Create(ConnectionDot, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(130, 110, 15)})
        t1:Play()
        task.wait(0.8)
        local t2 = TweenService:Create(ConnectionDot, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = COLORS.PrimaryYellow})
        t2:Play()
        task.wait(0.8)
    end
end)

local CardsContainer = Instance.new("Frame")
CardsContainer.Name = "Cards"
CardsContainer.Size = UDim2.new(1, 0, 1, -95)
CardsContainer.Position = UDim2.new(0, 0, 0, 55)
CardsContainer.BackgroundTransparency = 1
CardsContainer.Parent = HomePage

local CardsLayout = Instance.new("UIListLayout")
CardsLayout.FillDirection = Enum.FillDirection.Horizontal
CardsLayout.SortOrder = Enum.SortOrder.LayoutOrder
CardsLayout.Padding = UDim.new(0, 16)
CardsLayout.Parent = CardsContainer

local function CreateCardFrame(name: string, widthScale: number, layoutOrder: number)
    local card = Instance.new("Frame")
    card.Name = name .. "Card"

    card.Size = UDim2.new(widthScale, -11, 1, 0)
    card.BackgroundColor3 = COLORS.BgPanel
    card.BorderSizePixel = 0
    card.LayoutOrder = layoutOrder
    card.Parent = CardsContainer

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = COLORS.BorderDark
    cardStroke.Thickness = 1
    cardStroke.Parent = card

    local titleContainer = Instance.new("Frame")
    titleContainer.Size = UDim2.new(1, 0, 0, 28)
    titleContainer.BackgroundColor3 = COLORS.BgCard
    titleContainer.BorderSizePixel = 0
    titleContainer.Parent = card

    local cardTitle = Instance.new("TextLabel")
    cardTitle.Size = UDim2.new(1, -12, 1, 0)
    cardTitle.Position = UDim2.new(0, 12, 0, 0)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Text = name
    cardTitle.TextColor3 = COLORS.PrimaryYellow
    cardTitle.Font = FONTS.Bold
    cardTitle.TextSize = 10
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.Parent = titleContainer

    local bottomBorder = Instance.new("Frame")
    bottomBorder.Size = UDim2.new(1, 0, 0, 1)
    bottomBorder.Position = UDim2.new(0, 0, 1, -1)
    bottomBorder.BackgroundColor3 = COLORS.BorderDark
    bottomBorder.BorderSizePixel = 0
    bottomBorder.Parent = titleContainer

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, -28)
    content.Position = UDim2.new(0, 0, 0, 28)
    content.BackgroundTransparency = 1
    content.Parent = card

    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, 12)
    p.PaddingRight = UDim.new(0, 12)
    p.PaddingTop = UDim.new(0, 14)
    p.PaddingBottom = UDim.new(0, 12)
    p.Parent = content

    return card, content
end

local QuickActionsCard, QAContent = CreateCardFrame("QUICK ACTIONS", 0.33, 1)
local MainSettingsCard, MainContent = CreateCardFrame("MAIN", 0.42, 2)
local InfoCard, InfoContent = CreateCardFrame("INFO", 0.25, 3)

local QALayout = Instance.new("UIListLayout")
QALayout.Padding = UDim.new(0, 10)
QALayout.Parent = QAContent

local function CreateActionButton(text: string, prefix: string, callback: () -> ())
    local actionBtn = Instance.new("Frame")
    actionBtn.Size = UDim2.new(1, 0, 0, 36)
    actionBtn.BackgroundColor3 = COLORS.BgCard
    actionBtn.BorderSizePixel = 0
    actionBtn.Parent = QAContent

    local stroke = Instance.new("UIStroke")
    stroke.Color = COLORS.BorderDark
    stroke.Thickness = 1
    stroke.Parent = actionBtn

    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(1, -30, 1, 0)
    labelText.Position = UDim2.new(0, 10, 0, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = prefix .. "  " .. text
    labelText.TextColor3 = COLORS.TextPrimary
    labelText.Font = FONTS.Main
    labelText.TextSize = 10
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = actionBtn

    local caret = Instance.new("TextLabel")
    caret.Size = UDim2.new(0, 20, 1, 0)
    caret.Position = UDim2.new(1, -25, 0, 0)
    caret.BackgroundTransparency = 1
    caret.Text = ">"
    caret.TextColor3 = COLORS.TextSecondary
    caret.Font = FONTS.Bold
    caret.TextSize = 11
    caret.TextXAlignment = Enum.TextXAlignment.Right
    caret.Parent = actionBtn

    local trigger = Instance.new("TextButton")
    trigger.Size = UDim2.new(1, 0, 1, 0)
    trigger.BackgroundTransparency = 1
    trigger.Text = ""
    trigger.Parent = actionBtn

    trigger.MouseEnter:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = COLORS.PrimaryYellow}):Play()
        TweenService:Create(labelText, TweenInfo.new(0.2), {TextColor3 = COLORS.BrightYellow}):Play()
        TweenService:Create(caret, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0, 0), TextColor3 = COLORS.PrimaryYellow}):Play()
    end)

    trigger.MouseLeave:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = COLORS.BorderDark}):Play()
        TweenService:Create(labelText, TweenInfo.new(0.2), {TextColor3 = COLORS.TextPrimary}):Play()
        TweenService:Create(caret, TweenInfo.new(0.2), {Position = UDim2.new(1, -25, 0, 0), TextColor3 = COLORS.TextSecondary}):Play()
    end)

    trigger.MouseButton1Down:Connect(function()
        actionBtn.BackgroundColor3 = COLORS.BorderGold
        task.wait(0.08)
        actionBtn.BackgroundColor3 = COLORS.BgCard
        callback()
    end)
end

CreateActionButton("Test", ">_", function()
    print("[NC HUB] Test triggered.")
end)

CreateActionButton("Test", "↑", function()
    print("[NC HUB] Test toggled.")
end)

CreateActionButton("Test", "⬡", function()
    print("[NC HUB] Test action toggled.")
end)

CreateActionButton("Test", "⊙", function()
    print("[NC HUB] Test activated.")
end)

local MainLayout = Instance.new("UIListLayout")
MainLayout.Padding = UDim.new(0, 12)
MainLayout.Parent = MainContent

local function CreateToggle(name: string, default: boolean, callback: (boolean) -> ())
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 24)
    container.BackgroundTransparency = 1
    container.Parent = MainContent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = COLORS.TextSecondary
    label.Font = FONTS.Main
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 36, 0, 16)
    switch.Position = UDim2.new(1, -36, 0.5, -8)
    switch.BackgroundColor3 = COLORS.BgMain
    switch.BorderSizePixel = 0
    switch.Parent = container

    local switchStroke = Instance.new("UIStroke")
    switchStroke.Thickness = 1
    switchStroke.Parent = switch

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 8, 0, 8)
    knob.BorderSizePixel = 0
    knob.Parent = switch

    local active = default

    local function updateVisuals(instant: boolean)
        local dur = instant and 0 or 0.18
        local targetPos = active and UDim2.new(1, -12, 0.5, -4) or UDim2.new(0, 4, 0.5, -4)
        local knobCol = active and COLORS.PrimaryYellow or COLORS.TextMuted
        local strokeCol = active and COLORS.PrimaryYellow or COLORS.BorderDark
        local textCol = active and COLORS.TextPrimary or COLORS.TextSecondary

        TweenService:Create(knob, TweenInfo.new(dur), {Position = targetPos, BackgroundColor3 = knobCol}):Play()
        TweenService:Create(switchStroke, TweenInfo.new(dur), {Color = strokeCol}):Play()
        TweenService:Create(label, TweenInfo.new(dur), {TextColor3 = textCol}):Play()
    end

    updateVisuals(true)

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = container

    button.MouseButton1Click:Connect(function()
        active = not active
        updateVisuals(false)
        callback(active)
    end)
end

local function CreateSlider(name: string, min: number, max: number, default: number, callback: (number) -> ())
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 36)
    container.BackgroundTransparency = 1
    container.Parent = MainContent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 14)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = COLORS.TextSecondary
    label.Font = FONTS.Main
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.4, 0, 0, 14)
    valueLabel.Position = UDim2.new(0.6, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = COLORS.PrimaryYellow
    valueLabel.Font = FONTS.Bold
    valueLabel.TextSize = 10
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = container

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 3)
    track.Position = UDim2.new(0, 0, 0, 22)
    track.BackgroundColor3 = COLORS.BgMain
    track.BorderSizePixel = 0
    track.Parent = container

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = COLORS.PrimaryYellow
    fill.BorderSizePixel = 0
    fill.Parent = track

    local handle = Instance.new("Frame")
    handle.Size = UDim2.new(0, 5, 0, 11)
    handle.Position = UDim2.new((default - min) / (max - min), -2, 0.5, -5)
    handle.BackgroundColor3 = COLORS.PrimaryYellow
    handle.BorderSizePixel = 0
    handle.Parent = track

    local function updateValue(percentage: number)
        percentage = math.clamp(percentage, 0, 1)
        local value = math.round(min + percentage * (max - min))
        valueLabel.Text = tostring(value)
        fill.Size = UDim2.new(percentage, 0, 1, 0)
        handle.Position = UDim2.new(percentage, -2, 0.5, -5)
        callback(value)
    end

    local isDragging = false
    local function processInput(input: InputObject)
        local trackPos = track.AbsolutePosition.X
        local trackWidth = track.AbsoluteSize.X
        local deltaX = input.Position.X - trackPos
        updateValue(deltaX / trackWidth)
    end

    local dragButton = Instance.new("TextButton")
    dragButton.Size = UDim2.new(1, 0, 0, 20)
    dragButton.Position = UDim2.new(0, 0, 0, 12)
    dragButton.BackgroundTransparency = 1
    dragButton.Text = ""
    dragButton.Parent = container

    dragButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            processInput(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            processInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
end

CreateToggle("Test", false, function(val)
    print("[NC HUB] Test set to:", val)
end)

CreateToggle("Test", false, function(val)
    print("[NC HUB] Test set to:", val)
end)

CreateSlider("Test", 16, 250, 100, function(val)

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = character:WaitForChild("Humanoid") :: Humanoid
    if hum then
        hum.WalkSpeed = val
    end
end)

CreateSlider("Test", 50, 300, 100, function(val)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = character:WaitForChild("Humanoid") :: Humanoid
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = val
    end
end)

CreateToggle("NOCLIP", false, function(val)
    print("[NC HUB] Noclip set to:", val)
end)

CreateToggle("ANTI AFK", true, function(val)
    print("[NC HUB] Anti AFK active:", val)
end)

local InfoLayout = Instance.new("UIListLayout")
InfoLayout.Padding = UDim.new(0, 14)
InfoLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
InfoLayout.Parent = InfoContent

local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 70, 0, 70)
LogoFrame.BackgroundColor3 = COLORS.BgCard
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = InfoContent

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = COLORS.BorderGold
LogoStroke.Thickness = 1
LogoStroke.Parent = LogoFrame

local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.new(1, -12, 1, -12)
LogoImage.Position = UDim2.new(0, 6, 0, 6)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = ASSETS.LogoEmblem
LogoImage.ImageColor3 = COLORS.AccentRed
LogoImage.Parent = LogoFrame

AddTechCorners(LogoFrame)


local MetadataContainer = Instance.new("Frame")
MetadataContainer.Size = UDim2.new(1, 0, 1, -95)
MetadataContainer.BackgroundTransparency = 1
MetadataContainer.Parent = InfoContent

local MetaLayout = Instance.new("UIListLayout")
MetaLayout.Padding = UDim.new(0, 6)
MetaLayout.Parent = MetadataContainer

local function CreateMetaLine(label: string, defaultVal: string): TextLabel
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 22)
    line.BackgroundColor3 = COLORS.BgCard
    line.BorderSizePixel = 0
    line.Parent = MetadataContainer

    local border = Instance.new("UIStroke")
    border.Color = COLORS.BorderDark
    border.Thickness = 1
    border.Parent = line

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(0.4, 0, 1, 0)
    nameLbl.Position = UDim2.new(0, 8, 0, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = label
    nameLbl.TextColor3 = COLORS.AccentRed
    nameLbl.Font = FONTS.Bold
    nameLbl.TextSize = 8
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = line

    local valueLbl = Instance.new("TextLabel")
    valueLbl.Size = UDim2.new(0.6, -16, 1, 0)
    valueLbl.Position = UDim2.new(0.4, 8, 0, 0)
    valueLbl.BackgroundTransparency = 1
    valueLbl.Text = defaultVal
    valueLbl.TextColor3 = COLORS.TextSecondary
    valueLbl.Font = FONTS.Technical
    valueLbl.TextSize = 8
    valueLbl.TextXAlignment = Enum.TextXAlignment.Right
    valueLbl.Parent = line

    return valueLbl
end

local userHash = string.format("%04d", LocalPlayer.UserId % 10000)
local UserValue = CreateMetaLine("USER:", LocalPlayer.Name .. "#" .. userHash)

local GameValue = CreateMetaLine("GAME:", "Scanning...")
task.spawn(function()
    local success, res = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    if success and res then
        if #res > 15 then res = string.sub(res, 1, 13) .. ".." end
        GameValue.Text = string.upper(res)
    else
        GameValue.Text = "UNIVERSAL"
    end
end)

local VersionValue = CreateMetaLine("VERSION:", "2.0.0")
local UptimeValue = CreateMetaLine("UPTIME:", "00:00:00")

local runStart = os.time()
task.spawn(function()
    while task.wait(1) do
        local elapsed = os.time() - runStart
        local hrs = math.floor(elapsed / 3600)
        local mins = math.floor((elapsed % 3600) / 60)
        local secs = elapsed % 60
        UptimeValue.Text = string.format("%02d:%02d:%02d", hrs, mins, secs)
    end
end)

local BottomStatus = Instance.new("Frame")
BottomStatus.Name = "BottomStatus"
BottomStatus.Size = UDim2.new(1, 0, 0, 30)
BottomStatus.Position = UDim2.new(0, 0, 1, -30)
BottomStatus.BackgroundTransparency = 1
BottomStatus.Parent = HomePage

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(0.5, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Test"
StatusText.TextColor3 = COLORS.TextMuted
StatusText.Font = FONTS.Main
StatusText.TextSize = 9
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = BottomStatus

local CyberwareReadyFrame = Instance.new("Frame")
CyberwareReadyFrame.Size = UDim2.new(0.4, 0, 1, 0)
CyberwareReadyFrame.Position = UDim2.new(0.6, 0, 0, 0)
CyberwareReadyFrame.BackgroundTransparency = 1
CyberwareReadyFrame.Parent = BottomStatus

local CyberText = Instance.new("TextLabel")
CyberText.Size = UDim2.new(1, -85, 1, 0)
CyberText.BackgroundTransparency = 1
CyberText.Text = "Test"
CyberText.TextColor3 = COLORS.AccentRed
CyberText.Font = FONTS.Bold
CyberText.TextSize = 8
CyberText.TextXAlignment = Enum.TextXAlignment.Right
CyberText.Parent = CyberwareReadyFrame

local IndicatorBars = Instance.new("TextLabel")
IndicatorBars.Size = UDim2.new(0, 75, 1, 0)
IndicatorBars.Position = UDim2.new(1, -75, 0, 0)
IndicatorBars.BackgroundTransparency = 1
IndicatorBars.Text = "|||||||||||||||"
IndicatorBars.TextColor3 = COLORS.PrimaryYellow
IndicatorBars.Font = FONTS.Bold
IndicatorBars.TextSize = 10
IndicatorBars.TextXAlignment = Enum.TextXAlignment.Right
IndicatorBars.Parent = CyberwareReadyFrame

local isMinimized = false
local originalHeight = MainWindow.Size.Y.Scale
local originalOffset = MainWindow.Size.Y.Offset

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then

        TweenService:Create(MainWindow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(MainWindow.Size.X.Scale, MainWindow.Size.X.Offset, 0, 48)
        }):Play()
        ContentFrame.Visible = false
        LeftSidebar.Visible = false
    else

        local t = TweenService:Create(MainWindow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(MainWindow.Size.X.Scale, MainWindow.Size.X.Offset, originalHeight, originalOffset)
        })
        t:Play()
        t.Completed:Connect(function()
            if not isMinimized then
                ContentFrame.Visible = true
                LeftSidebar.Visible = true
            end
        end)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
    closeTween:Play()
    closeTween.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)
