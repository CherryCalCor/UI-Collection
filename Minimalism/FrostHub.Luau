local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local CONFIG = {

	BG_GRADIENT_START = Color3.fromRGB(215, 230, 245), 
	BG_GRADIENT_END = Color3.fromRGB(245, 248, 253),   
	PANEL_COLOR = Color3.fromRGB(255, 255, 255),
	PANEL_TRANSPARENCY = 0.22, -- Frosted glass opacity
	SIDEBAR_COLOR = Color3.fromRGB(240, 246, 255),
	SIDEBAR_TRANSPARENCY = 0.28,
	
	TEXT_MAIN = Color3.fromRGB(38, 48, 68),      
	TEXT_MUTED = Color3.fromRGB(115, 128, 148),   
	ACCENT_COLOR = Color3.fromRGB(80, 145, 220),  
	ACCENT_GREEN = Color3.fromRGB(85, 185, 145),  
	BORDER_COLOR = Color3.fromRGB(255, 255, 255),
	BORDER_TRANSPARENCY = 0.65,
	
	FONT_TITLE = Enum.Font.GothamMedium,
	FONT_BODY = Enum.Font.Gotham,
	FONT_BOLD = Enum.Font.GothamBold,
	
	ICON_SNOWFLAKE = "rbxassetid://10734964600",
	ICON_HOME = "rbxassetid://10723407389",
	ICON_SEARCH = "rbxassetid://10734943674",
	ICON_SHIELD = "rbxassetid://10734951847",
	ICON_SHIELD_CHECK = "rbxassetid://10734951367",
	ICON_ZAP = "rbxassetid://10747374023",
	ICON_RUN = "rbxassetid://10709752035",
	ICON_EYEOFF = "rbxassetid://10723346871",
	ICON_HEALTH = "rbxassetid://10723345518",
	ICON_JUMP = "rbxassetid://10709753177",
	ICON_MOUNTAIN = "rbxassetid://7743870286",
	
	WINDOW_SIZE = UDim2.new(0, 950, 0, 580),
}

local function create(className, properties, children)
	local instance = Instance.new(className)
	for k, v in pairs(properties) do
		instance[k] = v
	end
	if children then
		for _, child in ipairs(children) do
			child.Parent = instance
		end
	end
	return instance
end

local oldUI = LocalPlayer.PlayerGui:FindFirstChild("FrostHubGui")
if oldUI then oldUI:Destroy() end

local ScreenGui = create("ScreenGui", {
	Name = "FrostHubGui",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999
})

local Background = create("Frame", {
	Name = "Background",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderSizePixel = 0,
	Parent = ScreenGui
}, {
	create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, CONFIG.BG_GRADIENT_START),
			ColorSequenceKeypoint.new(1, CONFIG.BG_GRADIENT_END)
		}),
		Rotation = 45
	})
})

local SnowContainer = create("Frame", {
	Name = "SnowContainer",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
	Parent = Background
})

task.spawn(function()
	local activeSnowflakes = {}
	local maxSnowflakes = 45
	
	while true do
		task.wait(0.12)
		if #activeSnowflakes < maxSnowflakes then
			local size = math.random(3, 7)
			local snowflake = create("Frame", {
				Size = UDim2.fromOffset(size, size),
				Position = UDim2.new(math.random(), 0, -0.05, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = math.random(15, 45) / 100,
				BorderSizePixel = 0,
				Parent = SnowContainer
			}, {
				create("UICorner", { CornerRadius = UDim.new(1, 0) })
			})
			
			table.insert(activeSnowflakes, snowflake)
			
			local fallDuration = math.random(5, 11)
			local driftX = snowflake.Position.X.Scale + (math.random(-15, 15) / 100)
			
			local driftTween = TweenService:Create(snowflake, TweenInfo.new(fallDuration, Enum.EasingStyle.Linear), {
				Position = UDim2.new(driftX, 0, 1.05, 0),
				BackgroundTransparency = 1
			})
			
			driftTween:Play()
			driftTween.Completed:Connect(function()
				snowflake:Destroy()
				local index = table.find(activeSnowflakes, snowflake)
				if index then table.remove(activeSnowflakes, index) end
			end)
		end
	end
end)

local MainWindow = create("Frame", {
	Name = "MainWindow",
	Size = CONFIG.WINDOW_SIZE,
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = CONFIG.PANEL_COLOR,
	BackgroundTransparency = CONFIG.PANEL_TRANSPARENCY,
	Parent = Background
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 24) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = CONFIG.BORDER_TRANSPARENCY,
		Thickness = 1.5
	})
})

local glassPanels = { MainWindow }

local Sidebar = create("Frame", {
	Name = "Sidebar",
	Size = UDim2.new(0.25, 0, 1, 0),
	BackgroundColor3 = CONFIG.SIDEBAR_COLOR,
	BackgroundTransparency = CONFIG.SIDEBAR_TRANSPARENCY,
	BorderSizePixel = 0,
	Parent = MainWindow
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 24) })
})
table.insert(glassPanels, Sidebar)

local LogoContainer = create("Frame", {
	Name = "LogoContainer",
	Size = UDim2.new(1, -40, 0, 50),
	Position = UDim2.new(0, 20, 0, 25),
	BackgroundTransparency = 1,
	Parent = Sidebar
}, {
	create("ImageLabel", {
		Name = "LogoIcon",
		Size = UDim2.fromOffset(32, 32),
		Position = UDim2.new(0, 0, 0.5, -16),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_SNOWFLAKE,
		ImageColor3 = CONFIG.ACCENT_COLOR
	}),
	create("TextLabel", {
		Name = "HubTitle",
		Text = "FROST HUB",
		Font = CONFIG.FONT_BOLD,
		TextSize = 18,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 42, 0, 5),
		Size = UDim2.new(1, -42, 0, 20),
		BackgroundTransparency = 1
	}),
	create("TextLabel", {
		Name = "HubVersion",
		Text = "v1.0.0",
		Font = CONFIG.FONT_BODY,
		TextSize = 11,
		TextColor3 = CONFIG.TEXT_MUTED,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 42, 0, 24),
		Size = UDim2.new(1, -42, 0, 15),
		BackgroundTransparency = 1
	})
})

local NavigationContainer = create("Frame", {
	Name = "Navigation",
	Size = UDim2.new(1, -30, 0, 200),
	Position = UDim2.new(0, 15, 0, 100),
	BackgroundTransparency = 1,
	Parent = Sidebar
})

local HomeButton = create("Frame", {
	Name = "HomeButton",
	Size = UDim2.new(1, 0, 0, 46),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.55,
	Parent = NavigationContainer
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 10) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.5,
		Thickness = 1
	}),
	create("ImageLabel", {
		Name = "Icon",
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.new(0, 12, 0.5, -10),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_HOME,
		ImageColor3 = CONFIG.ACCENT_COLOR
	}),
	create("TextLabel", {
		Name = "Label",
		Text = "Home",
		Font = CONFIG.FONT_TITLE,
		TextSize = 14,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 42, 0, 0),
		Size = UDim2.new(1, -50, 1, 0),
		BackgroundTransparency = 1
	}),

	create("Frame", {
		Name = "AccentBar",
		Size = UDim2.new(0, 4, 0.45, 0),
		Position = UDim2.new(1, -8, 0.275, 0),
		BackgroundColor3 = CONFIG.ACCENT_COLOR,
		BorderSizePixel = 0,
		Parent = HomeButton
	}, {
		create("UICorner", { CornerRadius = UDim.new(1, 0) })
	})
})

local navBtnTrigger = create("TextButton", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Text = "",
	Parent = HomeButton
})
navBtnTrigger.MouseEnter:Connect(function()
	TweenService:Create(HomeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.4}):Play()
end)
navBtnTrigger.MouseLeave:Connect(function()
	TweenService:Create(HomeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.55}):Play()
end)

local ProfileCard = create("Frame", {
	Name = "UserProfile",
	Size = UDim2.new(1, -30, 0, 64),
	Position = UDim2.new(0, 15, 1, -84),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.5,
	Parent = Sidebar
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 14) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.6,
		Thickness = 1
	}),
	create("ImageLabel", {
		Name = "Avatar",
		Size = UDim2.fromOffset(40, 40),
		Position = UDim2.new(0, 12, 0.5, -20),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_SNOWFLAKE,
		ImageColor3 = CONFIG.ACCENT_COLOR
	}, {
		create("UICorner", { CornerRadius = UDim.new(1, 0) })
	}),
	create("TextLabel", {
		Name = "Username",
		Text = LocalPlayer.DisplayName,
		Font = CONFIG.FONT_TITLE,
		TextSize = 13,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 60, 0, 14),
		Size = UDim2.new(1, -65, 0, 18),
		BackgroundTransparency = 1
	}),
	create("TextLabel", {
		Name = "TierBadge",
		Text = "● Premium",
		Font = CONFIG.FONT_BODY,
		TextSize = 11,
		TextColor3 = CONFIG.ACCENT_COLOR,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 60, 0, 31),
		Size = UDim2.new(1, -65, 0, 15),
		BackgroundTransparency = 1
	})
})

local Content = create("Frame", {
	Name = "Content",
	Size = UDim2.new(0.75, 0, 1, 0),
	Position = UDim2.new(0.25, 0, 0, 0),
	BackgroundTransparency = 1,
	Parent = MainWindow
})

local TopBar = create("Frame", {
	Name = "TopBar",
	Size = UDim2.new(1, 0, 0, 65),
	BackgroundTransparency = 1,
	Parent = Content
})

local SearchBar = create("Frame", {
	Name = "SearchBar",
	Size = UDim2.new(0.55, 0, 0, 36),
	Position = UDim2.new(0, 20, 0.5, -18),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.45,
	Parent = TopBar
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 10) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.5,
		Thickness = 1
	}),
	create("ImageLabel", {
		Name = "SearchIcon",
		Size = UDim2.fromOffset(18, 18),
		Position = UDim2.new(0, 10, 0.5, -9),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_SEARCH,
		ImageColor3 = CONFIG.TEXT_MUTED
	}),
	create("TextBox", {
		Name = "Input",
		PlaceholderText = "Search features...",
		Text = "",
		Font = CONFIG.FONT_BODY,
		TextSize = 13,
		TextColor3 = CONFIG.TEXT_MAIN,
		PlaceholderColor3 = CONFIG.TEXT_MUTED,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 36, 0, 0),
		Size = UDim2.new(1, -46, 1, 0),
		BackgroundTransparency = 1
	})
})

local WindowButtons = create("Frame", {
	Name = "WindowButtons",
	Size = UDim2.new(0, 100, 0, 30),
	Position = UDim2.new(1, -115, 0.5, -15),
	BackgroundTransparency = 1,
	Parent = TopBar
}, {
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 12)
	})
})

local function buildWinButton(text, iconAsset, callback)
	local btn = create("ImageButton", {
		Size = UDim2.fromOffset(22, 22),
		BackgroundTransparency = 1,
		Image = iconAsset or "",
		ImageColor3 = CONFIG.TEXT_MUTED,
		Parent = WindowButtons
	})
	
	if not iconAsset then

		local lbl = create("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = text,
			Font = CONFIG.FONT_TITLE,
			TextSize = 14,
			TextColor3 = CONFIG.TEXT_MUTED,
			Parent = btn
		})
	end
	
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {ImageColor3 = CONFIG.ACCENT_COLOR}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {ImageColor3 = CONFIG.TEXT_MUTED}):Play()
	end)
	btn.MouseButton1Click:Connect(callback)
end

local isMinimized = false
buildWinButton("-", nil, function()
	isMinimized = not isMinimized
	local targetHeight = isMinimized and 65 or 580
	local targetOpacity = isMinimized and 1 or 0
	
	TweenService:Create(MainWindow, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 950, 0, targetHeight)}):Play()
	TweenService:Create(Sidebar, TweenInfo.new(0.3), {BackgroundTransparency = isMinimized and 1 or CONFIG.SIDEBAR_TRANSPARENCY}):Play()
	
	for _, child in ipairs(Sidebar:GetChildren()) do
		if child:IsA("Frame") or child:IsA("TextLabel") then
			TweenService:Create(child, TweenInfo.new(0.2), {GroupTransparency = isMinimized and 1 or 0}):Play()
		end
	end
	
	local homePage = Content:FindFirstChild("HomePage")
	if homePage then
		TweenService:Create(homePage, TweenInfo.new(0.3), {GroupTransparency = isMinimized and 1 or 0}):Play()
	end
end)

buildWinButton("⬜", nil, function() end)

buildWinButton("✕", nil, function()
	local closeTween = TweenService:Create(MainWindow, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
		Size = UDim2.fromOffset(900, 530),
		GroupTransparency = 1
	})
	closeTween:Play()
	closeTween.Completed:Connect(function()
		ScreenGui:Destroy()
	end)
end)

local dragInput, dragStart, startPos
local dragBar = Sidebar -- Sidebar and TopBar can trigger drag operations

local function update(input)
	local delta = input.Position - dragStart
	MainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function onInputStart(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local guiObj = dragBar
		local startDrag = true
		
		local localPos = input.Position
		
		if startDrag then
			dragStart = input.Position
			startPos = MainWindow.Position
			
			local changedConn
			changedConn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					changedConn:Disconnect()
				end
			end)
			
			local moveConn
			moveConn = UserInputService.InputChanged:Connect(function(moveInput)
				if moveInput.UserInputType == Enum.UserInputType.MouseMovement or moveInput.UserInputType == Enum.UserInputType.Touch then
					if input.UserInputState == Enum.UserInputState.End then
						moveConn:Disconnect()
					else
						update(moveInput)
					end
				end
			end)
		end
	end
end

dragBar.InputBegan:Connect(onInputStart)
TopBar.InputBegan:Connect(onInputStart)

local HomePage = create("CanvasGroup", {
	Name = "HomePage",
	Size = UDim2.new(1, 0, 1, -65),
	Position = UDim2.new(0, 0, 0, 65),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Parent = Content
})

local WelcomeHeader = create("Frame", {
	Name = "WelcomeHeader",
	Size = UDim2.new(0, 410, 0, 70),
	Position = UDim2.new(0, 20, 0, 15),
	BackgroundTransparency = 1,
	Parent = HomePage
}, {
	create("ImageLabel", {
		Name = "DecorativeIcon",
		Size = UDim2.fromOffset(40, 40),
		Position = UDim2.new(0, 0, 0.5, -20),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_SNOWFLAKE,
		ImageColor3 = CONFIG.ACCENT_COLOR
	}),
	create("TextLabel", {
		Name = "Greeting",
		Text = "Welcome, " .. LocalPlayer.DisplayName .. "!",
		Font = CONFIG.FONT_BOLD,
		TextSize = 22,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 50, 0, 10),
		Size = UDim2.new(1, -50, 0, 24),
		BackgroundTransparency = 1
	}),
	create("TextLabel", {
		Name = "Subtitle",
		Text = "Enjoy using Frost Hub.",
		Font = CONFIG.FONT_BODY,
		TextSize = 13,
		TextColor3 = CONFIG.TEXT_MUTED,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 50, 0, 34),
		Size = UDim2.new(1, -50, 0, 18),
		BackgroundTransparency = 1
	})
})

RunService.RenderStepped:Connect(function(deltaTime)
	local welcomeIcon = WelcomeHeader:FindFirstChild("DecorativeIcon")
	if welcomeIcon then
		welcomeIcon.Rotation = (welcomeIcon.Rotation + (12 * deltaTime)) % 360
	end
end)

local StatusCard = create("Frame", {
	Name = "StatusCard",
	Size = UDim2.new(0, 250, 0, 70),
	Position = UDim2.new(0, 450, 0, 15),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.5,
	Parent = HomePage
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 14) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.6,
		Thickness = 1
	}),
	create("ImageLabel", {
		Name = "StatusIcon",
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(0, 14, 0.5, -12),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_SHIELD_CHECK,
		ImageColor3 = CONFIG.ACCENT_GREEN
	}),
	create("TextLabel", {
		Name = "StatusLabel",
		Text = "SYSTEM STATUS",
		Font = CONFIG.FONT_BODY,
		TextSize = 10,
		TextColor3 = CONFIG.TEXT_MUTED,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 48, 0, 14),
		Size = UDim2.new(1, -55, 0, 16),
		BackgroundTransparency = 1
	}),
	create("TextLabel", {
		Name = "StatusState",
		Text = "Updated",
		Font = CONFIG.FONT_BOLD,
		TextSize = 14,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 48, 0, 30),
		Size = UDim2.new(1, -70, 0, 20),
		BackgroundTransparency = 1
	}),

	create("Frame", {
		Name = "PulsingDot",
		Size = UDim2.fromOffset(8, 8),
		Position = UDim2.new(1, -26, 0.5, -4),
		BackgroundColor3 = CONFIG.ACCENT_GREEN,
		BorderSizePixel = 0,
		Parent = StatusCard
	}, {
		create("UICorner", { CornerRadius = UDim.new(1, 0) })
	})
})

local pulseDot = StatusCard:FindFirstChild("PulsingDot")
if pulseDot then
	task.spawn(function()
		while true do
			local pulseInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
			local pulseTween = TweenService:Create(pulseDot, pulseInfo, {
				BackgroundTransparency = 0.45,
				Size = UDim2.fromOffset(12, 12),
				Position = UDim2.new(1, -28, 0.5, -6)
			})
			pulseTween:Play()
			break
		end
	end)
end

local QuickActions = create("Frame", {
	Name = "QuickActions",
	Size = UDim2.new(0, 410, 0, 175),
	Position = UDim2.new(0, 20, 0, 105),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.5,
	Parent = HomePage
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 16) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.6,
		Thickness = 1
	}),
	create("TextLabel", {
		Name = "Title",
		Text = "Quick Actions",
		Font = CONFIG.FONT_BOLD,
		TextSize = 14,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 16, 0, 14),
		Size = UDim2.new(1, -32, 0, 20),
		BackgroundTransparency = 1
	}),
	create("Frame", {
		Name = "Grid",
		Size = UDim2.new(1, -32, 1, -54),
		Position = UDim2.new(0, 16, 0, 38),
		BackgroundTransparency = 1,
		Parent = QuickActions
	}, {
		create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 10)
		})
	})
})
local quickActionsGrid = QuickActions:FindFirstChild("Grid")

local function buildActionCard(name, icon, stateCallback)
	local isEnabled = false
	
	local card = create("Frame", {
		Name = name .. "Button",
		Size = UDim2.new(0, 87, 1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.5,
		Parent = quickActionsGrid
	}, {
		create("UICorner", { CornerRadius = UDim.new(0, 10) }),
		create("UIStroke", {
			Name = "Outline",
			Color = CONFIG.BORDER_COLOR,
			Transparency = 0.5,
			Thickness = 1
		}),
		create("ImageLabel", {
			Name = "Icon",
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(0.5, -13, 0.3, -13),
			BackgroundTransparency = 1,
			Image = icon,
			ImageColor3 = CONFIG.ACCENT_COLOR
		}),
		create("TextLabel", {
			Name = "Name",
			Text = name,
			Font = CONFIG.FONT_TITLE,
			TextSize = 11,
			TextColor3 = CONFIG.TEXT_MAIN,
			Position = UDim2.new(0, 4, 0.65, 0),
			Size = UDim2.new(1, -8, 0, 20),
			BackgroundTransparency = 1
		}),
		create("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = ""
		})
	})
	
	local clickBtn = card:FindFirstChildOfClass("TextButton")
	local outline = card:FindFirstChild("Outline")
	local iconImg = card:FindFirstChild("Icon")
	
	clickBtn.MouseEnter:Connect(function()
		TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.25,
			Size = UDim2.new(0, 91, 1, 4)
		}):Play()
	end)
	
	clickBtn.MouseLeave:Connect(function()
		local targetTransparency = isEnabled and 0.15 or 0.5
		TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			BackgroundTransparency = targetTransparency,
			Size = UDim2.new(0, 87, 1, 0)
		}):Play()
	end)
	
	clickBtn.MouseButton1Down:Connect(function()
		TweenService:Create(card, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
			Size = UDim2.new(0, 83, 1, -4)
		}):Play()
	end)
	
	clickBtn.MouseButton1Up:Connect(function()
		isEnabled = not isEnabled
		
		local borderCol = isEnabled and CONFIG.ACCENT_COLOR or CONFIG.BORDER_COLOR
		local bgCol = isEnabled and Color3.fromRGB(240, 248, 255) or Color3.fromRGB(255, 255, 255)
		local bgTransparency = isEnabled and 0.15 or 0.25
		
		TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(0, 91, 1, 4),
			BackgroundColor3 = bgCol,
			BackgroundTransparency = bgTransparency
		}):Play()
		
		TweenService:Create(outline, TweenInfo.new(0.2), {Color = borderCol}):Play()
		
		if stateCallback then stateCallback(isEnabled) end
	end)
end

buildActionCard("God Mode", CONFIG.ICON_ZAP, function(enabled)
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.MaxHealth = enabled and 999999 or 100
		hum.Health = hum.MaxHealth
	end
end)

buildActionCard("WalkSpeed", CONFIG.ICON_RUN, function(enabled)
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = enabled and 50 or 16
	end
end)

local noclipConnection
buildActionCard("Noclip", CONFIG.ICON_SHIELD, function(enabled)
	if enabled then
		noclipConnection = RunService.Stepped:Connect(function()
			local char = LocalPlayer.Character
			if char then
				for _, part in ipairs(char:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
			end
		end)
	else
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end
	end
end)

buildActionCard("Invisible", CONFIG.ICON_EYEOFF, function(enabled)
	local char = LocalPlayer.Character
	if char then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				part.Transparency = enabled and 0.5 or 0
			elseif part:IsA("Decal") then
				part.Transparency = enabled and 0.5 or 0
			end
		end
	end
end)

local PlayerInfo = create("Frame", {
	Name = "PlayerInfo",
	Size = UDim2.new(0, 250, 0, 215),
	Position = UDim2.new(0, 450, 0, 105),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.5,
	Parent = HomePage
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 16) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.6,
		Thickness = 1
	}),
	create("TextLabel", {
		Name = "Title",
		Text = "Player Info",
		Font = CONFIG.FONT_BOLD,
		TextSize = 14,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 16, 0, 14),
		Size = UDim2.new(1, -32, 0, 20),
		BackgroundTransparency = 1
	}),
	create("Frame", {
		Name = "List",
		Size = UDim2.new(1, -32, 1, -48),
		Position = UDim2.new(0, 16, 0, 40),
		BackgroundTransparency = 1,
		Parent = PlayerInfo
	}, {
		create("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 14)
		})
	})
})
local playerInfoList = PlayerInfo:FindFirstChild("List")

local function buildStatBar(name, icon, layoutOrder)
	local container = create("Frame", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		LayoutOrder = layoutOrder,
		Parent = playerInfoList
	}, {
		create("ImageLabel", {
			Name = "Icon",
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
			Image = icon,
			ImageColor3 = CONFIG.TEXT_MUTED
		}),
		create("TextLabel", {
			Name = "Label",
			Text = name,
			Font = CONFIG.FONT_TITLE,
			TextSize = 12,
			TextColor3 = CONFIG.TEXT_MAIN,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.new(0, 24, 0, 0),
			Size = UDim2.new(0.5, -24, 0, 18),
			BackgroundTransparency = 1
		}),
		create("TextLabel", {
			Name = "Value",
			Text = "0",
			Font = CONFIG.FONT_BODY,
			TextSize = 12,
			TextColor3 = CONFIG.TEXT_MUTED,
			TextXAlignment = Enum.TextXAlignment.Right,
			Position = UDim2.new(0.5, 0, 0, 0),
			Size = UDim2.new(0.5, 0, 0, 18),
			BackgroundTransparency = 1
		}),
		create("Frame", {
			Name = "Track",
			Size = UDim2.new(1, 0, 0, 6),
			Position = UDim2.new(0, 0, 1, -6),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.7,
			Parent = container
		}, {
			create("UICorner", { CornerRadius = UDim.new(1, 0) }),
			create("Frame", {
				Name = "Fill",
				Size = UDim2.new(0, 0, 1, 0),
				BackgroundColor3 = CONFIG.ACCENT_COLOR,
				BorderSizePixel = 0
			}, {
				create("UICorner", { CornerRadius = UDim.new(1, 0) })
			})
		})
	})
	return container
end

local barHealth = buildStatBar("Health", CONFIG.ICON_HEALTH, 1)
local barSpeed = buildStatBar("WalkSpeed", CONFIG.ICON_RUN, 2)
local barJump = buildStatBar("JumpPower", CONFIG.ICON_JUMP, 3)

task.spawn(function()
	while true do
		task.wait(0.25)
		local char = LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then

			local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
			barHealth.Value.Text = tostring(math.floor(hum.Health)) .. "/" .. tostring(math.floor(hum.MaxHealth))
			TweenService:Create(barHealth.Track.Fill, TweenInfo.new(0.2), {Size = UDim2.new(healthPercent, 0, 1, 0)}):Play()
			
			local speedPercent = math.clamp(hum.WalkSpeed / 100, 0, 1)
			barSpeed.Value.Text = tostring(math.floor(hum.WalkSpeed))
			TweenService:Create(barSpeed.Track.Fill, TweenInfo.new(0.2), {Size = UDim2.new(speedPercent, 0, 1, 0)}):Play()
			
			local jumpPercent = math.clamp(hum.JumpPower / 250, 0, 1)
			barJump.Value.Text = tostring(math.floor(hum.JumpPower))
			TweenService:Create(barJump.Track.Fill, TweenInfo.new(0.2), {Size = UDim2.new(jumpPercent, 0, 1, 0)}):Play()
		end
	end
end)

local ScriptStatus = create("Frame", {
	Name = "ScriptStatus",
	Size = UDim2.new(0, 410, 0, 175),
	Position = UDim2.new(0, 20, 0, 295),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.5,
	Parent = HomePage
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 16) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.6,
		Thickness = 1
	}),
	create("TextLabel", {
		Name = "Title",
		Text = "Script Status",
		Font = CONFIG.FONT_BOLD,
		TextSize = 14,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 16, 0, 14),
		Size = UDim2.new(1, -32, 0, 20),
		BackgroundTransparency = 1
	}),
	create("ImageLabel", {
		Name = "CheckedIcon",
		Size = UDim2.fromOffset(36, 36),
		Position = UDim2.new(0, 16, 0, 52),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_SHIELD_CHECK,
		ImageColor3 = CONFIG.ACCENT_GREEN
	}),
	create("TextLabel", {
		Name = "InjectedText",
		Text = "Injected",
		Font = CONFIG.FONT_BOLD,
		TextSize = 18,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 64, 0, 48),
		Size = UDim2.new(1, -80, 0, 22),
		BackgroundTransparency = 1
	}),
	create("TextLabel", {
		Name = "DescText",
		Text = "Frost Hub is running successfully in your game execution client process environment.",
		Font = CONFIG.FONT_BODY,
		TextSize = 12,
		TextColor3 = CONFIG.TEXT_MUTED,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 64, 0, 72),
		Size = UDim2.new(0.55, 0, 0, 50),
		BackgroundTransparency = 1
	}),

	create("ImageLabel", {
		Name = "MountainArt",
		Size = UDim2.fromOffset(130, 100),
		Position = UDim2.new(1, -140, 1, -108),
		BackgroundTransparency = 1,
		Image = CONFIG.ICON_MOUNTAIN,
		ImageColor3 = CONFIG.ACCENT_COLOR,
		ImageTransparency = 0.8
	})
})

local Settings = create("Frame", {
	Name = "Settings",
	Size = UDim2.new(0, 250, 0, 135),
	Position = UDim2.new(0, 450, 0, 335),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 0.5,
	Parent = HomePage
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 16) }),
	create("UIStroke", {
		Color = CONFIG.BORDER_COLOR,
		Transparency = 0.6,
		Thickness = 1
	}),
	create("TextLabel", {
		Name = "Title",
		Text = "Settings",
		Font = CONFIG.FONT_BOLD,
		TextSize = 14,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 16, 0, 14),
		Size = UDim2.new(1, -32, 0, 20),
		BackgroundTransparency = 1
	})
})

local ThemeRow = create("Frame", {
	Name = "ThemeRow",
	Size = UDim2.new(1, -32, 0, 24),
	Position = UDim2.new(0, 16, 0, 42),
	BackgroundTransparency = 1,
	Parent = Settings
}, {
	create("TextLabel", {
		Name = "Title",
		Text = "UI Theme",
		Font = CONFIG.FONT_TITLE,
		TextSize = 12,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0.5, 0, 1, 0),
		BackgroundTransparency = 1
	}),
	create("TextLabel", {
		Name = "Value",
		Text = "Winter ▼",
		Font = CONFIG.FONT_BOLD,
		TextSize = 12,
		TextColor3 = CONFIG.ACCENT_COLOR,
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.new(0.5, 0, 0, 0),
		Size = UDim2.new(0.5, 0, 1, 0),
		BackgroundTransparency = 1
	})
})

local BlurRow = create("Frame", {
	Name = "BlurRow",
	Size = UDim2.new(1, -32, 0, 32),
	Position = UDim2.new(0, 16, 0, 75),
	BackgroundTransparency = 1,
	Parent = Settings
}, {
	create("TextLabel", {
		Name = "Title",
		Text = "UI Blur",
		Font = CONFIG.FONT_TITLE,
		TextSize = 12,
		TextColor3 = CONFIG.TEXT_MAIN,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0.5, 0, 0, 18),
		BackgroundTransparency = 1
	}),
	create("TextLabel", {
		Name = "ValueText",
		Text = "0.6",
		Font = CONFIG.FONT_BODY,
		TextSize = 11,
		TextColor3 = CONFIG.TEXT_MUTED,
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.new(0.5, 0, 0, 0),
		Size = UDim2.new(0.5, 0, 0, 18),
		BackgroundTransparency = 1
	}),
	create("Frame", {
		Name = "Track",
		Size = UDim2.new(1, 0, 0, 4),
		Position = UDim2.new(0, 0, 1, -4),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.7,
		Parent = BlurRow
	}, {
		create("UICorner", { CornerRadius = UDim.new(1, 0) }),
		create("Frame", {
			Name = "Fill",
			Size = UDim2.new(0.6, 0, 1, 0),
			BackgroundColor3 = CONFIG.ACCENT_COLOR,
			BorderSizePixel = 0
		}, {
			create("UICorner", { CornerRadius = UDim.new(1, 0) }),
			create("TextButton", {
				Name = "Knob",
				Size = UDim2.fromOffset(12, 12),
				Position = UDim2.new(1, -6, 0.5, -6),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Text = ""
			}, {
				create("UICorner", { CornerRadius = UDim.new(1, 0) }),
				create("UIStroke", {
					Color = CONFIG.ACCENT_COLOR,
					Thickness = 1.5
				})
			})
		})
	})
})

local sliderTrack = BlurRow:FindFirstChild("Track")
local sliderFill = sliderTrack and sliderTrack:FindFirstChild("Fill")
local sliderKnob = sliderFill and sliderFill:FindFirstChild("Knob")

local isDraggingSlider = false

local function handleSliderUpdate(input)
	local trackSizeX = sliderTrack.AbsoluteSize.X
	local localMouseX = input.Position.X - sliderTrack.AbsolutePosition.X
	local percentage = math.clamp(localMouseX / trackSizeX, 0, 1)
	
	sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
	BlurRow.ValueText.Text = string.format("%.1f", percentage)
	
	local calculatedGlassAlpha = 0.05 + ((1 - percentage) * 0.4)
	local calculatedSidebarAlpha = 0.1 + ((1 - percentage) * 0.35)
	
	MainWindow.BackgroundTransparency = calculatedGlassAlpha
	Sidebar.BackgroundTransparency = calculatedSidebarAlpha
end

sliderKnob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDraggingSlider = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDraggingSlider = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if isDraggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		handleSliderUpdate(input)
	end
end)

local Footer = create("TextLabel", {
	Name = "Footer",
	Text = "Made with ❄ for the community",
	Font = CONFIG.FONT_BODY,
	TextSize = 11,
	TextColor3 = CONFIG.TEXT_MUTED,
	Position = UDim2.new(0, 20, 1, -30),
	Size = UDim2.new(1, -40, 0, 20),
	BackgroundTransparency = 1,
	Parent = HomePage
})

HomePage.GroupTransparency = 1

local function bootFrostHub()
	MainWindow.Size = UDim2.fromOffset(0, 0)
	MainWindow.BackgroundTransparency = 1
	Sidebar.BackgroundTransparency = 1
	
	ScreenGui.Parent = LocalPlayer.PlayerGui
	
	local openingTween = TweenService:Create(MainWindow, TweenInfo.new(0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = CONFIG.WINDOW_SIZE
	})
	openingTween:Play()
	
	openingTween.Completed:Connect(function()
		TweenService:Create(MainWindow, TweenInfo.new(0.25), {BackgroundTransparency = CONFIG.PANEL_TRANSPARENCY}):Play()
		TweenService:Create(Sidebar, TweenInfo.new(0.25), {BackgroundTransparency = CONFIG.SIDEBAR_TRANSPARENCY}):Play()
		
		local showHome = TweenService:Create(HomePage, TweenInfo.new(0.4), {GroupTransparency = 0})
		showHome:Play()
	end)
end

bootFrostHub()
