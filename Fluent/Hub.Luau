local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local isRunning = true
local connections = {}

local oldGui = PlayerGui:FindFirstChild("RobloxHubFluent")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RobloxHubFluent"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local OpenMenuBtn = Instance.new("ImageButton")
OpenMenuBtn.Name = "OpenMenuBtn"
OpenMenuBtn.Size = UDim2.fromOffset(46, 46)
OpenMenuBtn.Position = UDim2.new(0.5, 0, 0.05, 0)
OpenMenuBtn.AnchorPoint = Vector2.new(0.5, 0)
OpenMenuBtn.BackgroundColor3 = Color3.fromRGB(138, 92, 246)
OpenMenuBtn.Image = "rbxassetid://10723407389"
OpenMenuBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
OpenMenuBtn.Visible = false
OpenMenuBtn.Parent = ScreenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0.5, 0)
openCorner.Parent = OpenMenuBtn

local openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2
openStroke.Color = Color3.fromRGB(255, 255, 255)
openStroke.Parent = OpenMenuBtn

local Themes = {
	Light = {
		MainBackground = Color3.fromRGB(240, 242, 250),
		SidebarBackground = Color3.fromRGB(249, 250, 251),
		CardBackground = Color3.fromRGB(255, 255, 255),
		HeaderTextColor = Color3.fromRGB(15, 23, 42),
		SubTextColor = Color3.fromRGB(100, 116, 139),
		BorderColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(219, 223, 235),
		SelectedTabBackground = Color3.fromRGB(255, 255, 255),
		SelectedTabTransparency = 0.4,
		UnselectedTabTextColor = Color3.fromRGB(100, 116, 139),
		UnselectedTabIconColor = Color3.fromRGB(148, 163, 184),
		TextDark = Color3.fromRGB(30, 41, 59),
		TextLight = Color3.fromRGB(243, 244, 246),
		ControlTrack = Color3.fromRGB(219, 223, 235),
		ControlTrackDark = Color3.fromRGB(209, 213, 219)
	},
	Dark = {
		MainBackground = Color3.fromRGB(20, 21, 30),
		SidebarBackground = Color3.fromRGB(14, 15, 23),
		CardBackground = Color3.fromRGB(28, 30, 43),
		HeaderTextColor = Color3.fromRGB(241, 245, 249),
		SubTextColor = Color3.fromRGB(148, 163, 184),
		BorderColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(45, 47, 66),
		SelectedTabBackground = Color3.fromRGB(45, 47, 66),
		SelectedTabTransparency = 0.4,
		UnselectedTabTextColor = Color3.fromRGB(156, 163, 175),
		UnselectedTabIconColor = Color3.fromRGB(107, 114, 128),
		TextDark = Color3.fromRGB(243, 244, 246),
		TextLight = Color3.fromRGB(30, 41, 59),
		ControlTrack = Color3.fromRGB(55, 65, 81),
		ControlTrackDark = Color3.fromRGB(75, 85, 99)
	}
}

local currentTheme = "Light"
local themeRegistry = {}

local function RegisterTheme(instance, property, lightVal, darkVal)
	table.insert(themeRegistry, {
		Instance = instance,
		Property = property,
		Light = lightVal,
		Dark = darkVal
	})
	instance[property] = (currentTheme == "Light" and lightVal) or darkVal
end

local function Tween(instance, duration, properties, easingStyle, easingDir)
	local style = easingStyle or Enum.EasingStyle.Quad
	local dir = easingDir or Enum.EasingDirection.Out
	local tween = TweenService:Create(instance, TweenInfo.new(duration, style, dir), properties)
	tween:Play()
	return tween
end

local MainWindow = Instance.new("CanvasGroup")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.fromScale(0.75, 0.75)
MainWindow.Position = UDim2.fromScale(0.5, 0.5)
MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
MainWindow.GroupTransparency = 1
MainWindow.BackgroundColor3 = Color3.fromRGB(240, 242, 250)
MainWindow.Parent = ScreenGui
RegisterTheme(MainWindow, "BackgroundColor3", Themes.Light.MainBackground, Themes.Dark.MainBackground)

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = MainWindow

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1.5
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = MainWindow
RegisterTheme(mainStroke, "Color", Themes.Light.StrokeColor, Themes.Dark.StrokeColor)

local mainAspectRatio = Instance.new("UIAspectRatioConstraint")
mainAspectRatio.AspectRatio = 1.545
mainAspectRatio.Parent = MainWindow

local mainSizeConstraint = Instance.new("UISizeConstraint")
mainSizeConstraint.MinSize = Vector2.new(700, 450)
mainSizeConstraint.MaxSize = Vector2.new(850, 550)
mainSizeConstraint.Parent = MainWindow

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0.28, 0, 1, 0)
Sidebar.BackgroundTransparency = 0.15
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainWindow
RegisterTheme(Sidebar, "BackgroundColor3", Themes.Light.SidebarBackground, Themes.Dark.SidebarBackground)

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingLeft = UDim.new(0, 16)
sidebarPadding.PaddingRight = UDim.new(0, 16)
sidebarPadding.PaddingTop = UDim.new(0, 20)
sidebarPadding.PaddingBottom = UDim.new(0, 20)
sidebarPadding.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(0.72, 0, 1, 0)
Content.Position = UDim2.new(0.28, 0, 0, 0)
Content.BackgroundTransparency = 0
Content.BorderSizePixel = 0
Content.Parent = MainWindow
RegisterTheme(Content, "BackgroundColor3", Themes.Light.MainBackground, Themes.Dark.MainBackground)

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingLeft = UDim.new(0, 24)
contentPadding.PaddingRight = UDim.new(0, 24)
contentPadding.PaddingTop = UDim.new(0, 20)
contentPadding.PaddingBottom = UDim.new(0, 20)
contentPadding.Parent = Content

local WindowControls = Instance.new("Frame")
WindowControls.Name = "WindowControls"
WindowControls.Size = UDim2.fromOffset(80, 24)
WindowControls.Position = UDim2.new(1, -10, 0, 0)
WindowControls.AnchorPoint = Vector2.new(1, 0)
WindowControls.BackgroundTransparency = 1
WindowControls.Parent = Content

local controlLayout = Instance.new("UIListLayout")
controlLayout.FillDirection = Enum.FillDirection.Horizontal
controlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
controlLayout.SortOrder = Enum.SortOrder.LayoutOrder
controlLayout.Padding = UDim.new(0, 6)
controlLayout.Parent = WindowControls

local function createWinBtn(text, order, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromOffset(20, 20)
	btn.BackgroundTransparency = 1
	btn.Text = text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 11
	btn.LayoutOrder = order
	btn.Parent = WindowControls
	RegisterTheme(btn, "TextColor3", Color3.fromRGB(100, 116, 139), Color3.fromRGB(148, 163, 184))

	btn.MouseEnter:Connect(function() Tween(btn, 0.2, {TextTransparency = 0.3}) end)
	btn.MouseLeave:Connect(function() Tween(btn, 0.2, {TextTransparency = 0}) end)
	btn.MouseButton1Click:Connect(callback)
end

createWinBtn("✕", 3, function()
	isRunning = false 
	for _, conn in ipairs(connections) do
		conn:Disconnect() 
	end
	
	local closeTween = Tween(MainWindow, 0.4, {Size = UDim2.fromScale(0.1, 0.1), GroupTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	closeTween.Completed:Connect(function()
		ScreenGui:Destroy()
	end)
end)

createWinBtn("☐", 2, function() end)

createWinBtn("—", 1, function()
	local minTween = Tween(MainWindow, 0.3, {GroupTransparency = 1, Size = UDim2.fromScale(0.6, 0.6)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	minTween.Completed:Connect(function()
		MainWindow.Visible = false
		OpenMenuBtn.Visible = true
		OpenMenuBtn.Size = UDim2.fromOffset(0, 0)
		Tween(OpenMenuBtn, 0.3, {Size = UDim2.fromOffset(46, 46)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	end)
end)

OpenMenuBtn.MouseButton1Click:Connect(function()
	local openAnim = Tween(OpenMenuBtn, 0.2, {Size = UDim2.fromOffset(0, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	openAnim.Completed:Connect(function()
		OpenMenuBtn.Visible = false
		MainWindow.Visible = true
		Tween(MainWindow, 0.4, {GroupTransparency = 0, Size = UDim2.fromScale(0.75, 0.75)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	end)
end)

local LogoContainer = Instance.new("Frame")
LogoContainer.Name = "LogoContainer"
LogoContainer.Size = UDim2.new(1, 0, 0, 42)
LogoContainer.BackgroundTransparency = 1
LogoContainer.Parent = Sidebar

local logoLayout = Instance.new("UIListLayout")
logoLayout.FillDirection = Enum.FillDirection.Horizontal
logoLayout.VerticalAlignment = Enum.VerticalAlignment.Center
logoLayout.SortOrder = Enum.SortOrder.LayoutOrder
logoLayout.Padding = UDim.new(0, 10)
logoLayout.Parent = LogoContainer

local LogoIcon = Instance.new("Frame")
LogoIcon.Name = "LogoIcon"
LogoIcon.Size = UDim2.fromOffset(42, 42)
LogoIcon.BackgroundColor3 = Color3.fromRGB(138, 92, 246)
LogoIcon.LayoutOrder = 1
LogoIcon.Parent = LogoContainer

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 10)
logoCorner.Parent = LogoIcon

local logoGrid = Instance.new("UIGridLayout")
logoGrid.CellSize = UDim2.fromOffset(13, 13)
logoGrid.CellPadding = UDim2.fromOffset(4, 4)
logoGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
logoGrid.VerticalAlignment = Enum.VerticalAlignment.Center
logoGrid.Parent = LogoIcon

for i = 1, 4 do
	local dot = Instance.new("Frame")
	dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dot.BackgroundTransparency = 0.15
	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(0, 4)
	dotCorner.Parent = dot
	dot.Parent = LogoIcon
end

local LogoTextContainer = Instance.new("Frame")
LogoTextContainer.Size = UDim2.new(1, -52, 1, 0)
LogoTextContainer.BackgroundTransparency = 1
LogoTextContainer.LayoutOrder = 2
LogoTextContainer.Parent = LogoContainer

local logoTextLayout = Instance.new("UIListLayout")
logoTextLayout.FillDirection = Enum.FillDirection.Vertical
logoTextLayout.VerticalAlignment = Enum.VerticalAlignment.Center
logoTextLayout.Parent = LogoTextContainer

local AppTitle = Instance.new("TextLabel")
AppTitle.Text = "Hub Collection"
AppTitle.Font = Enum.Font.GothamBold
AppTitle.TextSize = 15
AppTitle.TextXAlignment = Enum.TextXAlignment.Left
AppTitle.BackgroundTransparency = 1
AppTitle.Size = UDim2.new(1, 0, 0, 18)
AppTitle.Parent = LogoTextContainer
RegisterTheme(AppTitle, "TextColor3", Themes.Light.HeaderTextColor, Themes.Dark.HeaderTextColor)

local AppSubtitle = Instance.new("TextLabel")
AppSubtitle.Text = "by CherryCalCor"
AppSubtitle.Font = Enum.Font.GothamMedium
AppSubtitle.TextSize = 11
AppSubtitle.TextXAlignment = Enum.TextXAlignment.Left
AppSubtitle.BackgroundTransparency = 1
AppSubtitle.Size = UDim2.new(1, 0, 0, 14)
AppSubtitle.Parent = LogoTextContainer
RegisterTheme(AppSubtitle, "TextColor3", Themes.Light.SubTextColor, Themes.Dark.SubTextColor)

local NavigationFrame = Instance.new("Frame")
NavigationFrame.Name = "NavigationFrame"
NavigationFrame.Size = UDim2.new(1, 0, 0.6, 0)
NavigationFrame.Position = UDim2.new(0, 0, 0, 65)
NavigationFrame.BackgroundTransparency = 1
NavigationFrame.Parent = Sidebar

local navLayout = Instance.new("UIListLayout")
navLayout.FillDirection = Enum.FillDirection.Vertical
navLayout.SortOrder = Enum.SortOrder.LayoutOrder
navLayout.Padding = UDim.new(0, 8)
navLayout.Parent = NavigationFrame

local activeTabIndicator = Instance.new("Frame")
activeTabIndicator.Name = "ActiveTabIndicator"
activeTabIndicator.Size = UDim2.new(0, 3, 0, 20)
activeTabIndicator.Position = UDim2.new(0, 0, 0, 10)
activeTabIndicator.BackgroundColor3 = Color3.fromRGB(138, 92, 246)
activeTabIndicator.BorderSizePixel = 0
activeTabIndicator.Parent = NavigationFrame

local activeTabIndicatorCorner = Instance.new("UICorner")
activeTabIndicatorCorner.CornerRadius = UDim.new(1, 0)
activeTabIndicatorCorner.Parent = activeTabIndicator

local tabButtons = {}
local activeTab = nil

local function CreateTab(name, iconId, selected)
	local tab = Instance.new("TextButton")
	tab.Name = name .. "Tab"
	tab.Size = UDim2.new(1, 0, 0, 36)
	tab.BackgroundTransparency = 1
	tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tab.Text = ""
	tab.Parent = NavigationFrame

	local tabCorner = Instance.new("UICorner")
	tabCorner.CornerRadius = UDim.new(0, 8)
	tabCorner.Parent = tab

	local tabStroke = Instance.new("UIStroke")
	tabStroke.Thickness = 1
	tabStroke.Transparency = 1
	tabStroke.Parent = tab
	RegisterTheme(tabStroke, "Color", Themes.Light.StrokeColor, Themes.Dark.StrokeColor)

	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.fromOffset(18, 18)
	icon.Position = UDim2.new(0, 28, 0.5, 0)
	icon.AnchorPoint = Vector2.new(0, 0.5)
	icon.BackgroundTransparency = 1
	icon.Image = iconId
	icon.ImageColor3 = Color3.fromRGB(138, 92, 246)
	icon.Parent = tab

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -55, 1, 0)
	label.Position = UDim2.new(0, 54, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = tab

	local function setVisualState(isActive)
		if isActive then
			tabStroke.Transparency = 0
			RegisterTheme(tab, "BackgroundColor3", Themes.Light.SelectedTabBackground, Themes.Dark.SelectedTabBackground)
			RegisterTheme(tab, "BackgroundTransparency", Themes.Light.SelectedTabTransparency, Themes.Dark.SelectedTabTransparency)
			RegisterTheme(label, "TextColor3", Themes.Light.HeaderTextColor, Themes.Dark.HeaderTextColor)
			icon.ImageColor3 = Color3.fromRGB(138, 92, 246)
		else
			tabStroke.Transparency = 1
			tab.BackgroundTransparency = 1
			RegisterTheme(label, "TextColor3", Themes.Light.UnselectedTabTextColor, Themes.Dark.UnselectedTabTextColor)
			RegisterTheme(icon, "ImageColor3", Themes.Light.UnselectedTabIconColor, Themes.Dark.UnselectedTabIconColor)
		end
	end

	tab.MouseButton1Click:Connect(function()
		for _, otherTab in ipairs(tabButtons) do
			otherTab.SetVisual(false)
		end
		setVisualState(true)
		Tween(activeTabIndicator, 0.25, {Position = UDim2.new(0, 8, 0, tab.Position.Y.Offset + 8)})
	end)

	local cell = {
		Button = tab,
		SetVisual = setVisualState
	}
	table.insert(tabButtons, cell)

	if selected then
		activeTab = tab
		setVisualState(true)
		task.defer(function()
			activeTabIndicator.Position = UDim2.new(0, 8, 0, tab.Position.Y.Offset + 8)
		end)
	else
		setVisualState(false)
	end
end

CreateTab("Home", "rbxassetid://10723407389", true)
CreateTab("Scripts", "rbxassetid://10734883354", false)
CreateTab("Players", "rbxassetid://10747373426", false)
CreateTab("Settings", "rbxassetid://10723423730", false)
CreateTab("Info", "rbxassetid://10723416041", false)

local ProfileCard = Instance.new("Frame")
ProfileCard.Name = "ProfileCard"
ProfileCard.Size = UDim2.new(1, 0, 0, 50)
ProfileCard.Position = UDim2.new(0, 0, 1, -50)
ProfileCard.AnchorPoint = Vector2.new(0, 1)
ProfileCard.BackgroundTransparency = 1
ProfileCard.Parent = Sidebar

local profileLayout = Instance.new("UIListLayout")
profileLayout.FillDirection = Enum.FillDirection.Horizontal
profileLayout.VerticalAlignment = Enum.VerticalAlignment.Center
profileLayout.SortOrder = Enum.SortOrder.LayoutOrder
profileLayout.Padding = UDim.new(0, 10)
profileLayout.Parent = ProfileCard

local AvatarFrame = Instance.new("ImageLabel")
AvatarFrame.Name = "AvatarFrame"
AvatarFrame.Size = UDim2.fromOffset(36, 36)
AvatarFrame.BackgroundTransparency = 1
AvatarFrame.LayoutOrder = 1
AvatarFrame.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
AvatarFrame.Parent = ProfileCard

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = AvatarFrame

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Thickness = 1.5
avatarStroke.Color = Color3.fromRGB(138, 92, 246)
avatarStroke.Parent = AvatarFrame

local ProfileInfo = Instance.new("Frame")
ProfileInfo.Size = UDim2.new(1, -90, 1, 0) 
ProfileInfo.BackgroundTransparency = 1
ProfileInfo.LayoutOrder = 2
ProfileInfo.Parent = ProfileCard

local profileInfoLayout = Instance.new("UIListLayout")
profileInfoLayout.FillDirection = Enum.FillDirection.Vertical
profileInfoLayout.VerticalAlignment = Enum.VerticalAlignment.Center
profileInfoLayout.Parent = ProfileInfo

local ProfileName = Instance.new("TextLabel")
ProfileName.Text = LocalPlayer.DisplayName
ProfileName.Font = Enum.Font.GothamBold
ProfileName.TextSize = 13
ProfileName.TextXAlignment = Enum.TextXAlignment.Left
ProfileName.BackgroundTransparency = 1
ProfileName.Size = UDim2.new(1, 0, 0, 16)
ProfileName.Parent = ProfileInfo
RegisterTheme(ProfileName, "TextColor3", Themes.Light.HeaderTextColor, Themes.Dark.HeaderTextColor)

local ProfileStatus = Instance.new("TextLabel")
ProfileStatus.Text = "Premium 👑"
ProfileStatus.Font = Enum.Font.GothamMedium
ProfileStatus.TextSize = 11
ProfileStatus.TextColor3 = Color3.fromRGB(138, 92, 246)
ProfileStatus.TextXAlignment = Enum.TextXAlignment.Left
ProfileStatus.BackgroundTransparency = 1
ProfileStatus.Size = UDim2.new(1, 0, 0, 14)
ProfileStatus.Parent = ProfileInfo

local ThemeButton = Instance.new("ImageButton")
ThemeButton.Name = "ThemeButton"
ThemeButton.Size = UDim2.fromOffset(32, 32)
ThemeButton.LayoutOrder = 3
ThemeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ThemeButton.Image = "rbxassetid://10734974297"
ThemeButton.ImageColor3 = Color3.fromRGB(138, 92, 246)
ThemeButton.Parent = ProfileCard
RegisterTheme(ThemeButton, "BackgroundColor3", Themes.Light.CardBackground, Themes.Dark.CardBackground)

local themeBtnCorner = Instance.new("UICorner")
themeBtnCorner.CornerRadius = UDim.new(0, 8)
themeBtnCorner.Parent = ThemeButton

local themeBtnStroke = Instance.new("UIStroke")
themeBtnStroke.Thickness = 1
themeBtnStroke.Parent = ThemeButton
RegisterTheme(themeBtnStroke, "Color", Themes.Light.StrokeColor, Themes.Dark.StrokeColor)

local function SwitchTheme()
	currentTheme = (currentTheme == "Light" and "Dark") or "Light"
	for _, item in ipairs(themeRegistry) do
		if item.Instance and item.Instance.Parent then
			local targetVal = (currentTheme == "Light" and item.Light) or item.Dark
			Tween(item.Instance, 0.4, {[item.Property] = targetVal})
		end
	end
	if currentTheme == "Light" then
		ThemeButton.Image = "rbxassetid://10734974297"
	else
		ThemeButton.Image = "rbxassetid://10734950339"
	end
end
ThemeButton.MouseButton1Click:Connect(SwitchTheme)

local ContentHeader = Instance.new("Frame")
ContentHeader.Name = "ContentHeader"
ContentHeader.Size = UDim2.new(1, 0, 0, 50)
ContentHeader.BackgroundTransparency = 1
ContentHeader.Parent = Content

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Text = "Welcome"
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextSize = 28
WelcomeText.TextXAlignment = Enum.TextXAlignment.Left
WelcomeText.BackgroundTransparency = 1
WelcomeText.Size = UDim2.new(0.7, 0, 0, 30)
WelcomeText.Parent = ContentHeader
RegisterTheme(WelcomeText, "TextColor3", Themes.Light.HeaderTextColor, Themes.Dark.HeaderTextColor)

local SubWelcomeText = Instance.new("TextLabel")
SubWelcomeText.Text = "Enjoy using our hub collection."
SubWelcomeText.Font = Enum.Font.GothamMedium
SubWelcomeText.TextSize = 13
SubWelcomeText.TextXAlignment = Enum.TextXAlignment.Left
SubWelcomeText.BackgroundTransparency = 1
SubWelcomeText.Size = UDim2.new(0.7, 0, 0, 20)
SubWelcomeText.Position = UDim2.new(0, 0, 0, 30)
SubWelcomeText.Parent = ContentHeader
RegisterTheme(SubWelcomeText, "TextColor3", Themes.Light.SubTextColor, Themes.Dark.SubTextColor)

local CardsContainer = Instance.new("Frame")
CardsContainer.Name = "CardsContainer"
CardsContainer.Size = UDim2.new(1, 0, 0, 105)
CardsContainer.Position = UDim2.new(0, 0, 0, 75)
CardsContainer.BackgroundTransparency = 1
CardsContainer.Parent = Content

local cardsLayout = Instance.new("UIListLayout")
cardsLayout.FillDirection = Enum.FillDirection.Horizontal
cardsLayout.SortOrder = Enum.SortOrder.LayoutOrder
cardsLayout.Padding = UDim.new(0, 12)
cardsLayout.Parent = CardsContainer

local function CreateCard(title, value, iconId, accentColor)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(0.315, 0, 1, 0)
	card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	card.Parent = CardsContainer
	RegisterTheme(card, "BackgroundColor3", Themes.Light.CardBackground, Themes.Dark.CardBackground)

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 12)
	cardCorner.Parent = card

	local cardStroke = Instance.new("UIStroke")
	cardStroke.Thickness = 1
	cardStroke.Parent = card
	RegisterTheme(cardStroke, "Color", Themes.Light.StrokeColor, Themes.Dark.StrokeColor)

	local cardPadding = Instance.new("UIPadding")
	cardPadding.PaddingLeft = UDim.new(0, 12)
	cardPadding.PaddingRight = UDim.new(0, 12)
	cardPadding.PaddingTop = UDim.new(0, 12)
	cardPadding.PaddingBottom = UDim.new(0, 10)
	cardPadding.Parent = card

	local iconContainer = Instance.new("Frame")
	iconContainer.Size = UDim2.fromOffset(32, 32)
	iconContainer.BackgroundColor3 = accentColor
	iconContainer.BackgroundTransparency = 0.8
	iconContainer.Parent = card

	local iconCorner = Instance.new("UICorner")
	iconCorner.CornerRadius = UDim.new(1, 0)
	iconCorner.Parent = iconContainer

	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.fromOffset(16, 16)
	icon.Position = UDim2.fromScale(0.5, 0.5)
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.BackgroundTransparency = 1
	icon.Image = iconId
	icon.ImageColor3 = accentColor
	icon.Parent = iconContainer

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -40, 0, 14)
	titleLabel.Position = UDim2.new(0, 42, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.Font = Enum.Font.GothamMedium
	titleLabel.TextSize = 12
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = card
	RegisterTheme(titleLabel, "TextColor3", Themes.Light.SubTextColor, Themes.Dark.SubTextColor)

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(1, -40, 0, 22)
	valueLabel.Position = UDim2.new(0, 42, 0, 14)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = value
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 20
	valueLabel.TextColor3 = accentColor
	valueLabel.TextXAlignment = Enum.TextXAlignment.Left
	valueLabel.Parent = card

	local WaveContainer = Instance.new("Frame")
	WaveContainer.Size = UDim2.new(1, 0, 0, 24)
	WaveContainer.Position = UDim2.new(0, 0, 1, 0)
	WaveContainer.AnchorPoint = Vector2.new(0, 1)
	WaveContainer.BackgroundTransparency = 1
	WaveContainer.Parent = card

	local waveLayout = Instance.new("UIListLayout")
	waveLayout.FillDirection = Enum.FillDirection.Horizontal
	waveLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	waveLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	waveLayout.SortOrder = Enum.SortOrder.LayoutOrder
	waveLayout.Padding = UDim.new(0, 2)
	waveLayout.Parent = WaveContainer

	local bars = {}
	for i = 1, 18 do
		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(0.04, 0, 0, 4)
		bar.BackgroundColor3 = accentColor
		bar.BorderSizePixel = 0
		bar.Parent = WaveContainer

		local barCorner = Instance.new("UICorner")
		barCorner.CornerRadius = UDim.new(1, 0)
		barCorner.Parent = bar

		table.insert(bars, bar)
	end

	task.spawn(function()
		while isRunning and task.wait(0.04) do
			if card and card.Parent then
				local t = tick() * 6
				for idx, bar in ipairs(bars) do
					local heightScale = math.sin(t + (idx * 0.45)) * 0.35 + 0.5
					bar.Size = UDim2.new(0.04, 0, heightScale, 0)
				end
			end
		end
	end)

	return valueLabel
end

local fpsValLabel = CreateCard("FPS", "144", "rbxassetid://10709752035", Color3.fromRGB(138, 92, 246))
local pingValLabel = CreateCard("Ping", "48 ms", "rbxassetid://10747382504", Color3.fromRGB(34, 197, 94))
local playersValLabel = CreateCard("Players", "12 / 20", "rbxassetid://10747373426", Color3.fromRGB(59, 130, 246))

local lastTime = os.clock()
local frameCount = 0
local currentFPS = 60

local renderConn = RunService.RenderStepped:Connect(function()
	if not isRunning then return end
	frameCount += 1
	local now = os.clock()
	if now - lastTime >= 0.5 then
		currentFPS = math.round(frameCount / (now - lastTime))
		frameCount = 0
		lastTime = now
	end
end)
table.insert(connections, renderConn)

local currentPing = 0
task.spawn(function()
	while isRunning and task.wait(1) do
		if LocalPlayer then
			local success, latency = pcall(function()
				return LocalPlayer:GetNetworkPing()
			end)
			if success and latency then
				currentPing = math.round(latency * 1000)
			else
				currentPing = math.random(32, 58) 
			end
		end
	end
end)

task.spawn(function()
	while isRunning and task.wait(0.25) do
		if fpsValLabel and pingValLabel and playersValLabel then
			fpsValLabel.Text = tostring(currentFPS)
			pingValLabel.Text = tostring(currentPing) .. " ms"
			
			local maxPlayers = Players.MaxPlayers
			local onlinePlayers = #Players:GetPlayers()
			playersValLabel.Text = tostring(onlinePlayers) .. " / " .. tostring(maxPlayers)
		end
	end
end)

local ExamplesTitle = Instance.new("TextLabel")
ExamplesTitle.Name = "ExamplesTitle"
ExamplesTitle.Text = "Examples"
ExamplesTitle.Font = Enum.Font.GothamBold
ExamplesTitle.TextSize = 14
ExamplesTitle.TextXAlignment = Enum.TextXAlignment.Left
ExamplesTitle.BackgroundTransparency = 1
ExamplesTitle.Size = UDim2.new(1, 0, 0, 20)
ExamplesTitle.Position = UDim2.new(0, 0, 0, 195)
ExamplesTitle.Parent = Content
RegisterTheme(ExamplesTitle, "TextColor3", Themes.Light.HeaderTextColor, Themes.Dark.HeaderTextColor)

local ExamplesFrame = Instance.new("Frame")
ExamplesFrame.Name = "ExamplesFrame"
ExamplesFrame.Size = UDim2.new(1, 0, 0.44, 0)
ExamplesFrame.Position = UDim2.new(0, 0, 0, 222)
ExamplesFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExamplesFrame.Parent = Content
RegisterTheme(ExamplesFrame, "BackgroundColor3", Themes.Light.CardBackground, Themes.Dark.CardBackground)

local examplesCorner = Instance.new("UICorner")
examplesCorner.CornerRadius = UDim.new(0, 12)
examplesCorner.Parent = ExamplesFrame

local examplesStroke = Instance.new("UIStroke")
examplesStroke.Thickness = 1
examplesStroke.Parent = ExamplesFrame
RegisterTheme(examplesStroke, "Color", Themes.Light.StrokeColor, Themes.Dark.StrokeColor)

local examplesPadding = Instance.new("UIPadding")
examplesPadding.PaddingLeft = UDim.new(0, 16)
examplesPadding.PaddingRight = UDim.new(0, 16)
examplesPadding.PaddingTop = UDim.new(0, 12)
examplesPadding.PaddingBottom = UDim.new(0, 12)
examplesPadding.Parent = ExamplesFrame

local examplesLayout = Instance.new("UIListLayout")
examplesLayout.FillDirection = Enum.FillDirection.Vertical
examplesLayout.SortOrder = Enum.SortOrder.LayoutOrder
examplesLayout.Padding = UDim.new(0, 4)
examplesLayout.Parent = ExamplesFrame

local function CreateSlider(config)
	local min = config.Min or 0
	local max = config.Max or 100
	local default = config.Default or 50
	local color = config.Color or Color3.fromRGB(138, 92, 246)
	local callback = config.Callback or function() end

	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 36)
	row.BackgroundTransparency = 1
	row.Parent = ExamplesFrame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.4, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = config.Name or "Slider"
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = row
	RegisterTheme(label, "TextColor3", Themes.Light.TextDark, Themes.Dark.TextDark)

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0.1, 0, 1, 0)
	valueLabel.Position = UDim2.new(0.9, 0, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	valueLabel.Font = Enum.Font.GothamMedium
	valueLabel.TextSize = 13
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = row
	RegisterTheme(valueLabel, "TextColor3", Themes.Light.SubTextColor, Themes.Dark.SubTextColor)

	local sliderBar = Instance.new("Frame")
	sliderBar.Size = UDim2.new(0.45, 0, 0, 4)
	sliderBar.Position = UDim2.new(0.4, 0, 0.5, -2)
	sliderBar.BackgroundColor3 = Color3.fromRGB(229, 231, 235)
	sliderBar.BorderSizePixel = 0
	sliderBar.Parent = row
	RegisterTheme(sliderBar, "BackgroundColor3", Themes.Light.ControlTrack, Themes.Dark.ControlTrack)

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(1, 0)
	barCorner.Parent = sliderBar

	local fill = Instance.new("Frame")
	fill.Size = UDim2.fromScale((default - min) / (max - min), 1)
	fill.BackgroundColor3 = color
	fill.BorderSizePixel = 0
	fill.Parent = sliderBar

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local knob = Instance.new("ImageButton")
	knob.Size = UDim2.fromOffset(12, 12)
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.Position = UDim2.fromScale((default - min) / (max - min), 0.5)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = sliderBar

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local knobStroke = Instance.new("UIStroke")
	knobStroke.Color = color
	knobStroke.Thickness = 2.5
	knobStroke.Parent = knob

	local function updateValue(input)
		local totalWidth = sliderBar.AbsoluteSize.X
		local relativeX = math.clamp(input.Position.X - sliderBar.AbsolutePosition.X, 0, totalWidth)
		local percent = relativeX / totalWidth
		local value = math.round(min + (max - min) * percent)

		valueLabel.Text = tostring(value)
		Tween(fill, 0.05, {Size = UDim2.fromScale(percent, 1)})
		Tween(knob, 0.05, {Position = UDim2.fromScale(percent, 0.5)})

		callback(value)
	end

	local dragging = false
	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateValue(input)
		end
	end)

	sliderBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			updateValue(input)
			dragging = true
		end
	end)
end

local function CreateToggle(config)
	local state = config.Default or false
	local color = config.Color or Color3.fromRGB(138, 92, 246)
	local callback = config.Callback or function() end

	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 36)
	row.BackgroundTransparency = 1
	row.Parent = ExamplesFrame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.5, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = config.Name or "Toggle"
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = row
	RegisterTheme(label, "TextColor3", Themes.Light.TextDark, Themes.Dark.TextDark)

	local switch = Instance.new("ImageButton")
	switch.Size = UDim2.fromOffset(40, 22)
	switch.Position = UDim2.new(1, 0, 0.5, 0)
	switch.AnchorPoint = Vector2.new(1, 0.5)
	switch.BackgroundColor3 = Color3.fromRGB(209, 213, 219)
	switch.BorderSizePixel = 0
	switch.Parent = row

	local switchCorner = Instance.new("UICorner")
	switchCorner.CornerRadius = UDim.new(1, 0)
	switchCorner.Parent = switch

	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(16, 16)
	knob.Position = state and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
	knob.AnchorPoint = Vector2.new(0, 0.5)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = switch

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local function updateVisualState()
		local activeColor = color
		local inactiveColor = (currentTheme == "Light" and Themes.Light.ControlTrackDark) or Themes.Dark.ControlTrackDark
		
		if state then
			Tween(switch, 0.2, {BackgroundColor3 = activeColor})
			Tween(knob, 0.2, {Position = UDim2.new(1, -19, 0.5, 0)})
		else
			Tween(switch, 0.2, {BackgroundColor3 = inactiveColor})
			Tween(knob, 0.2, {Position = UDim2.new(0, 3, 0.5, 0)})
		end
	end

	RegisterTheme(switch, "BackgroundColor3", Themes.Light.ControlTrackDark, Themes.Dark.ControlTrackDark)

	local function toggle()
		state = not state
		updateVisualState()
		callback(state)
	end

	switch.MouseButton1Click:Connect(toggle)
	updateVisualState()
end

CreateSlider({ Name = "Slider Example", Min = 0, Max = 100, Default = 75, Color = Color3.fromRGB(138, 92, 246) })
CreateSlider({ Name = "Another Slider", Min = 0, Max = 500, Default = 250, Color = Color3.fromRGB(59, 130, 246) })
CreateToggle({ Name = "Toggle Example", Default = true, Color = Color3.fromRGB(138, 92, 246) })
CreateToggle({ Name = "Another Toggle", Default = false, Color = Color3.fromRGB(59, 130, 246) })

local FooterText = Instance.new("TextLabel")
FooterText.Name = "FooterText"
FooterText.Text = "Windows 11 Fluent Design"
FooterText.Font = Enum.Font.GothamMedium
FooterText.TextSize = 11
FooterText.TextAlignment = Enum.TextAlignment.Center
FooterText.BackgroundTransparency = 1
FooterText.Size = UDim2.new(1, 0, 0, 20)
FooterText.Position = UDim2.new(0.5, 0, 1, 0)
FooterText.AnchorPoint = Vector2.new(0.5, 1)
FooterText.Parent = Content
RegisterTheme(FooterText, "TextColor3", Themes.Light.SubTextColor, Themes.Dark.SubTextColor)

local function MakeDraggable(frame, dragHandle)
	local dragging = false
	local dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	dragHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

MakeDraggable(MainWindow, Sidebar) 
MakeDraggable(OpenMenuBtn, OpenMenuBtn) 

MainWindow.Size = UDim2.fromScale(0.1, 0.1)
MainWindow.GroupTransparency = 1

task.wait(0.1)
Tween(MainWindow, 0.6, {
	Size = UDim2.fromScale(0.75, 0.75),
	GroupTransparency = 0
}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
