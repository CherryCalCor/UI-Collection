local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Config = {
    Colors = {
        Background = Color3.fromRGB(255, 247, 250),  
        Surface = Color3.fromRGB(255, 251, 252),     
        Border = Color3.fromRGB(244, 215, 225),      
        Accent = Color3.fromRGB(238, 137, 169),      
        AccentHover = Color3.fromRGB(219, 114, 147), 
        AccentLight = Color3.fromRGB(255, 225, 235), 
        TextDark = Color3.fromRGB(105, 82, 92),      
        TextMuted = Color3.fromRGB(145, 125, 135),    
        OnlineGreen = Color3.fromRGB(46, 204, 113)   
    },
    
    Icons = {
        Sakura = "rbxassetid://10723345479",
        Home = "rbxassetid://10723351906",
        Scripts = "rbxassetid://10747373187",
        Favorites = "rbxassetid://10723346991",
        Settings = "rbxassetid://10723350128",
        Info = "rbxassetid://10723348649",
        StarUnfilled = "rbxassetid://10723343543",
        StarFilled = "rbxassetid://10723343321",
        Lightning = "rbxassetid://10723348914",
        Code = "rbxassetid://10734951111",
        Roblox = "rbxassetid://10723345864",
        Close = "rbxassetid://10723343971",
        Minimize = "rbxassetid://10723344265",
        SakuraBranch = "rbxassetid://71550200385232" 
    },
    
    Scripts = {
        {Name = "Blox Fruits Auto Farm", Category = "Игровые механики"},
        {Name = "Pet Simulator 99 Auto Hatch", Category = "Утилиты"},
        {Name = "Doors ESP", Category = "Визуальные"},
        {Name = "Arsenal Silent Aim", Category = "Аимботы"}
    },
    
    Navigation = {
        {Name = "Главная", Icon = "Home", Active = true},
        {Name = "Скрипты", Icon = "Scripts", Active = false},
        {Name = "Избранное", Icon = "Favorites", Active = false},
        {Name = "Настройки", Icon = "Settings", Active = false},
        {Name = "Информация", Icon = "Info", Active = false}
    },
    
    Cards = {
        {
            Icon = "Code",
            Title = "Большая библиотека",
            Desc = "Скрипты для популярных игр на Roblox"
        },
        {
            Icon = "Lightning",
            Title = "Быстро и безопасно",
            Desc = "Оптимизированная работа и защита от бана"
        },
        {
            Icon = "Favorites",
            Title = "Избранное",
            Desc = "Сохраняйте любимые скрипты в один клик"
        }
    }
}

local function create(className: string, properties: {[string]: any}): any
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    return instance
end

local function addCorner(parent: Instance, radius: number): UICorner
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius),
        Parent = parent
    })
end

local function addStroke(parent: Instance, thickness: number, color: Color3, transparency: number?): UIStroke
    return create("UIStroke", {
        Thickness = thickness,
        Color = color,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

local function addPadding(parent: Instance, top: number, bottom: number, left: number, right: number): UIPadding
    return create("UIPadding", {
        PaddingTop = UDim.new(0, top),
        PaddingBottom = UDim.new(0, bottom),
        PaddingLeft = UDim.new(0, left),
        PaddingRight = UDim.new(0, right),
        Parent = parent
    })
end

local ScreenGui = create("ScreenGui", {
    Name = "SakuraHubGui",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = PlayerGui
})

local MainWindow = create("CanvasGroup", {
    Name = "MainWindow",
    Size = UDim2.new(0, 500, 0, 720),
    Position = UDim2.new(0.5, -260, 0.5, -210),
    BackgroundColor3 = Config.Colors.Background,
    GroupTransparency = 1,
    Active = true,
    Parent = ScreenGui
})
addCorner(MainWindow, 20)
addStroke(MainWindow, 1.5, Config.Colors.Border)

local WindowScale = create("UIScale", {
    Scale = 0.95,
    Parent = MainWindow
})

local Sidebar = create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 155, 1, 0),
    BackgroundColor3 = Config.Colors.Surface,
    BorderSizePixel = 0,
    Parent = MainWindow
})

local SidebarSeparator = create("Frame", {
    Name = "Separator",
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(1, -1, 0, 0),
    BackgroundColor3 = Config.Colors.Border,
    BorderSizePixel = 0,
    Parent = Sidebar
})

local BrandContainer = create("Frame", {
    Name = "BrandContainer",
    Size = UDim2.new(1, 0, 0, 50),
    Position = UDim2.new(0, 0, 0, 15),
    BackgroundTransparency = 1,
    Parent = Sidebar
})
addPadding(BrandContainer, 0, 0, 12, 12)

local Logo = create("ImageLabel", {
    Name = "Logo",
    Size = UDim2.new(0, 24, 0, 24),
    Position = UDim2.new(0, 0, 0.5, -12),
    BackgroundTransparency = 1,
    Image = Config.Icons.Sakura,
    ImageColor3 = Config.Colors.Accent,
    Parent = BrandContainer
})

local TitleContainer = create("Frame", {
    Name = "TitleContainer",
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.new(0, 30, 0, 0),
    BackgroundTransparency = 1,
    Parent = BrandContainer
})

local BrandName = create("TextLabel", {
    Name = "BrandName",
    Size = UDim2.new(1, 0, 0, 15),
    Position = UDim2.new(0, 0, 0, 4),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = string.format('<b><font color="rgb(%d,%d,%d)">Sakura</font> <font color="rgb(%d,%d,%d)">Hub</font></b>', 
        Config.Colors.Accent.R*255, Config.Colors.Accent.G*255, Config.Colors.Accent.B*255,
        Config.Colors.TextDark.R*255, Config.Colors.TextDark.G*255, Config.Colors.TextDark.B*255
    ),
    TextColor3 = Config.Colors.TextDark,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    RichText = true,
    Parent = TitleContainer
})

local BrandSubtitle = create("TextLabel", {
    Name = "BrandSubtitle",
    Size = UDim2.new(1, 0, 0, 10),
    Position = UDim2.new(0, 0, 0, 18),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = "Roblox Script Hub",
    TextColor3 = Config.Colors.TextMuted,
    TextSize = 8.5,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = TitleContainer
})

local NavContainer = create("Frame", {
    Name = "NavContainer",
    Size = UDim2.new(1, 0, 0, 180),
    Position = UDim2.new(0, 0, 0, 75),
    BackgroundTransparency = 1,
    Parent = Sidebar
})
addPadding(NavContainer, 0, 0, 10, 10)

local NavListLayout = create("UIListLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 5),
    Parent = NavContainer
})

for i, nav in ipairs(Config.Navigation) do
    local btn = create("TextButton", {
        Name = nav.Name,
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = nav.Active and 0 or 1,
        BackgroundColor3 = Config.Colors.AccentLight,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = i,
        Parent = NavContainer
    })
    addCorner(btn, 8)
    addPadding(btn, 0, 0, 8, 8)
    
    local icon = create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 0, 0.5, -7),
        BackgroundTransparency = 1,
        Image = Config.Icons[nav.Icon],
        ImageColor3 = nav.Active and Config.Colors.Accent or Config.Colors.TextMuted,
        Parent = btn
    })
    
    local label = create("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Font = nav.Active and Enum.Font.GothamBold or Enum.Font.GothamMedium,
        Text = nav.Name,
        TextColor3 = nav.Active and Config.Colors.Accent or Config.Colors.TextMuted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = btn
    })
    
    if not nav.Active then
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.5,
                BackgroundColor3 = Config.Colors.AccentLight
            }):Play()
            TweenService:Create(icon, TweenInfo.new(0.2), { ImageColor3 = Config.Colors.Accent }):Play()
            TweenService:Create(label, TweenInfo.new(0.2), { TextColor3 = Config.Colors.TextDark }):Play()
        end)
        
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(icon, TweenInfo.new(0.2), { ImageColor3 = Config.Colors.TextMuted }):Play()
            TweenService:Create(label, TweenInfo.new(0.2), { TextColor3 = Config.Colors.TextMuted }):Play()
        end)
        
        btn.MouseButton1Down:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.3
            }):Play()
        end)
        
        btn.MouseButton1Up:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.5
            }):Play()
        end)
    end
end

local StatusCard = create("Frame", {
    Name = "StatusCard",
    Size = UDim2.new(1, -20, 0, 36),
    Position = UDim2.new(0, 10, 1, -48),
    BackgroundColor3 = Config.Colors.Surface,
    Parent = Sidebar
})
addCorner(StatusCard, 8)
addStroke(StatusCard, 1, Config.Colors.Border)
addPadding(StatusCard, 0, 0, 8, 8)

local StatusText = create("TextLabel", {
    Name = "StatusText",
    Size = UDim2.new(1, -24, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = string.format('<font color="rgb(%d,%d,%d)">●</font> Подключено\n<font size="8" color="rgb(%d,%d,%d)">Roblox Client</font>',
        Config.Colors.OnlineGreen.R*255, Config.Colors.OnlineGreen.G*255, Config.Colors.OnlineGreen.B*255,
        Config.Colors.TextMuted.R*255, Config.Colors.TextMuted.G*255, Config.Colors.TextMuted.B*255
    ),
    TextColor3 = Config.Colors.TextDark,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left,
    RichText = true,
    Parent = StatusCard
})

local RobloxIcon = create("ImageLabel", {
    Name = "RobloxIcon",
    Size = UDim2.new(0, 16, 0, 16),
    Position = UDim2.new(1, -16, 0.5, -8),
    BackgroundTransparency = 1,
    Image = Config.Icons.Roblox,
    ImageColor3 = Config.Colors.Accent,
    ImageTransparency = 0.25,
    Parent = StatusCard
})

local MainContent = create("Frame", {
    Name = "MainContent",
    Size = UDim2.new(1, -155, 1, 0),
    Position = UDim2.new(0, 155, 0, 0),
    BackgroundColor3 = Config.Colors.Background,
    BorderSizePixel = 0,
    Parent = MainWindow
})
addPadding(MainContent, 14, 14, 16, 16)

local DecorativeBranch = create("ImageLabel", {
    Name = "DecorativeBranch",
    Size = UDim2.new(0, 130, 0, 100),
    Position = UDim2.new(1, 10, 0, -10),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1,
    Image = Config.Icons.SakuraBranch,
    ImageColor3 = Color3.fromRGB(255, 255, 255),
    ImageTransparency = 0.25,
    ZIndex = 1,
    Parent = MainContent
})

local HeaderContainer = create("Frame", {
    Name = "HeaderContainer",
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundTransparency = 1,
    ZIndex = 2,
    Parent = MainContent
})

local WelcomeLabel = create("TextLabel", {
    Name = "WelcomeLabel",
    Size = UDim2.new(1, 0, 0, 12),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = "Добро пожаловать в",
    TextColor3 = Config.Colors.TextMuted,
    TextSize = 9.5,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = HeaderContainer
})

local WelcomeTitle = create("TextLabel", {
    Name = "WelcomeTitle",
    Size = UDim2.new(1, 0, 0, 20),
    Position = UDim2.new(0, 0, 0, 13),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = string.format('<b><font color="rgb(%d,%d,%d)">Sakura</font> <font color="rgb(%d,%d,%d)">Hub</font></b> 🌸',
        Config.Colors.Accent.R*255, Config.Colors.Accent.G*255, Config.Colors.Accent.B*255,
        Config.Colors.TextDark.R*255, Config.Colors.TextDark.G*255, Config.Colors.TextDark.B*255
    ),
    TextColor3 = Config.Colors.TextDark,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    RichText = true,
    Parent = HeaderContainer
})

local SubtitleLabel = create("TextLabel", {
    Name = "SubtitleLabel",
    Size = UDim2.new(1, 0, 0, 10),
    Position = UDim2.new(0, 0, 0, 34),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Ваш минималистичный хаб для Roblox скриптов",
    TextColor3 = Config.Colors.TextMuted,
    TextSize = 8.5,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = HeaderContainer
})

local CardsContainer = create("Frame", {
    Name = "CardsContainer",
    Size = UDim2.new(1, 0, 0, 72),
    Position = UDim2.new(0, 0, 0, 58),
    BackgroundTransparency = 1,
    ZIndex = 2,
    Parent = MainContent
})

local CardsLayout = create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 6),
    Parent = CardsContainer
})

for i, cardData in ipairs(Config.Cards) do
    local card = create("Frame", {
        Name = "Card_"..tostring(i),
        Size = UDim2.new(0, 105, 1, 0),
        BackgroundColor3 = Config.Colors.Surface,
        LayoutOrder = i,
        Parent = CardsContainer
    })
    addCorner(card, 10)
    addStroke(card, 1, Config.Colors.Border, 0.5)
    addPadding(card, 6, 6, 8, 8)
    
    local icon = create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 15, 0, 15),
        BackgroundTransparency = 1,
        Image = Config.Icons[cardData.Icon],
        ImageColor3 = Config.Colors.Accent,
        Parent = card
    })
    
    local title = create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 0, 18),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = cardData.Title,
        TextColor3 = Config.Colors.TextDark,
        TextSize = 8.5,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card
    })
    
    local desc = create("TextLabel", {
        Name = "Desc",
        Size = UDim2.new(1, 0, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = cardData.Desc,
        TextColor3 = Config.Colors.TextMuted,
        TextSize = 7,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Parent = card
    })

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Config.Colors.AccentLight
        }):Play()
        TweenService:Create(icon, TweenInfo.new(0.2), { ImageColor3 = Config.Colors.AccentHover }):Play()
    end)
    
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Config.Colors.Surface
        }):Play()
        TweenService:Create(icon, TweenInfo.new(0.2), { ImageColor3 = Config.Colors.Accent }):Play()
    end)
end

local SectionHeader = create("TextLabel", {
    Name = "SectionHeader",
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 0, 140),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "Популярные скрипты",
    TextColor3 = Config.Colors.TextDark,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 2,
    Parent = MainContent
})

local ScriptsListContainer = create("ScrollingFrame", {
    Name = "ScriptsListContainer",
    Size = UDim2.new(1, 0, 1, -178),
    Position = UDim2.new(0, 0, 0, 160),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Config.Colors.Accent,
    ScrollBarImageTransparency = 0.5,
    ClipsDescendants = true,
    ZIndex = 2,
    Parent = MainContent
})

local ScriptsListLayout = create("UIListLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 4),
    Parent = ScriptsListContainer
})

local favoritedScripts = {}

(Toast Notifications)
local function createNotification(scriptName: string)
    local toast = create("Frame", {
        Name = "Toast",
        Size = UDim2.new(0, 220, 0, 46),
        Position = UDim2.new(1, 50, 1, -60), 
        BackgroundColor3 = Config.Colors.Surface,
        ZIndex = 10,
        Parent = ScreenGui
    })
    addCorner(toast, 10)
    addStroke(toast, 1, Config.Colors.Border)
    addPadding(toast, 6, 6, 10, 10)
    
    local toastIcon = create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 0, 0.5, -8),
        BackgroundTransparency = 1,
        Image = Config.Icons.Sakura,
        ImageColor3 = Config.Colors.Accent,
        Parent = toast
    })
    
    local toastText = create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, -22, 1, 0),
        Position = UDim2.new(0, 22, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Text = string.format('<b><font color="rgb(%d,%d,%d)">Запуск</font></b>\n<font size="8" color="rgb(%d,%d,%d)">%s запущен успешно!</font>',
            Config.Colors.Accent.R*255, Config.Colors.Accent.G*255, Config.Colors.Accent.B*255,
            Config.Colors.TextDark.R*255, Config.Colors.TextDark.G*255, Config.Colors.TextDark.B*255,
            scriptName
        ),
        TextSize = 9.5,
        TextColor3 = Config.Colors.TextDark,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
        Parent = toast
    })

    local slideIn = TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -240, 1, -60)
    })
    local slideOut = TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 50, 1, -60)
    })
    
    slideIn:Play()
    task.delay(3, function()
        slideOut:Play()
        slideOut.Completed:Connect(function()
            toast:Destroy()
        end)
    end)
end

for i, scriptItem in ipairs(Config.Scripts) do
    local row = create("Frame", {
        Name = "Row_"..scriptItem.Name,
        Size = UDim2.new(1, -6, 0, 38), 
        BackgroundColor3 = Config.Colors.Surface,
        LayoutOrder = i,
        Parent = ScriptsListContainer
    })
    addCorner(row, 8)
    addStroke(row, 1, Config.Colors.Border, 0.7)
    addPadding(row, 0, 0, 8, 8)
    
    local miniSakura = create("ImageLabel", {
        Name = "MiniSakura",
        Size = UDim2.new(0, 11, 0, 11),
        Position = UDim2.new(0, 0, 0.5, -5.5),
        BackgroundTransparency = 1,
        Image = Config.Icons.Sakura,
        ImageColor3 = Config.Colors.Accent,
        ImageTransparency = 0.3,
        Parent = row
    })
    
    local infoFrame = create("Frame", {
        Name = "Info",
        Size = UDim2.new(1, -125, 1, 0),
        Position = UDim2.new(0, 18, 0, 0),
        BackgroundTransparency = 1,
        Parent = row
    })
    
    local nameLbl = create("TextLabel", {
        Name = "Name",
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 0, 6),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = scriptItem.Name,
        TextColor3 = Config.Colors.TextDark,
        TextSize = 9.5,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = infoFrame
    })
    
    local catLbl = create("TextLabel", {
        Name = "Category",
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 0, 18),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = scriptItem.Category,
        TextColor3 = Config.Colors.TextMuted,
        TextSize = 7.5,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = infoFrame
    })

    local runBtn = create("TextButton", {
        Name = "RunButton",
        Size = UDim2.new(0, 64, 0, 20),
        Position = UDim2.new(1, -95, 0.5, -10),
        BackgroundColor3 = Config.Colors.AccentLight,
        Font = Enum.Font.GothamBold,
        Text = "Запустить",
        TextColor3 = Config.Colors.Accent,
        TextSize = 8,
        AutoButtonColor = false,
        Parent = row
    })
    addCorner(runBtn, 6)

    local starBtn = create("ImageButton", {
        Name = "StarButton",
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(1, -22, 0.5, -9),
        BackgroundTransparency = 1,
        Image = Config.Icons.StarUnfilled,
        ImageColor3 = Config.Colors.TextMuted,
        AutoButtonColor = false,
        Parent = row
    })

    row.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 238, 243)
        }):Play()
    end)
    row.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.2), {
            BackgroundColor3 = Config.Colors.Surface
        }):Play()
    end)

    runBtn.MouseEnter:Connect(function()
        TweenService:Create(runBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Config.Colors.Accent,
            TextColor3 = Config.Colors.Surface
        }):Play()
    end)
    runBtn.MouseLeave:Connect(function()
        TweenService:Create(runBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Config.Colors.AccentLight,
            TextColor3 = Config.Colors.Accent
        }):Play()
    end)

    runBtn.MouseButton1Down:Connect(function()
        TweenService:Create(runBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 58, 0, 18),
            Position = UDim2.new(1, -92, 0.5, -9)
        }):Play()
    end)
    
    runBtn.MouseButton1Up:Connect(function()
        TweenService:Create(runBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 64, 0, 20),
            Position = UDim2.new(1, -95, 0.5, -10)
        }):Play()
        createNotification(scriptItem.Name)
    end)
    
    local isStarred = false
    starBtn.MouseButton1Click:Connect(function()
        isStarred = not isStarred
        favoritedScripts[scriptItem.Name] = isStarred
        
        local targetImage = isStarred and Config.Icons.StarFilled or Config.Icons.StarUnfilled
        local targetColor = isStarred and Config.Colors.Accent or Config.Colors.TextMuted
        
        local bounceInfo = TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local bounceDown = TweenService:Create(starBtn, bounceInfo, { Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -20, 0.5, -7) })
        local bounceUp = TweenService:Create(starBtn, bounceInfo, { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(1, -22, 0.5, -9) })
        
        bounceDown:Play()
        bounceDown.Completed:Connect(function()
            starBtn.Image = targetImage
            starBtn.ImageColor3 = targetColor
            bounceUp:Play()
        end)
    end)
end

local MetaContainer = create("Frame", {
    Name = "MetaContainer",
    Size = UDim2.new(1, 0, 0, 12),
    Position = UDim2.new(0, 0, 1, -12),
    BackgroundTransparency = 1,
    ZIndex = 2,
    Parent = MainContent
})

local MetaText = create("TextLabel", {
    Name = "MetaText",
    Size = UDim2.new(1, -16, 1, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Sakura Hub v1.0.0",
    TextColor3 = Config.Colors.TextMuted,
    TextSize = 8,
    TextXAlignment = Enum.TextXAlignment.Right,
    Parent = MetaContainer
})

local MetaSakura = create("ImageLabel", {
    Name = "MetaSakura",
    Size = UDim2.new(0, 10, 0, 10),
    Position = UDim2.new(1, -10, 0.5, -5),
    BackgroundTransparency = 1,
    Image = Config.Icons.Sakura,
    ImageColor3 = Config.Colors.Accent,
    ImageTransparency = 0.3,
    Parent = MetaContainer
})

local WindowControls = create("Frame", {
    Name = "WindowControls",
    Size = UDim2.new(0, 48, 0, 18),
    Position = UDim2.new(1, -58, 0, 10),
    BackgroundTransparency = 1,
    ZIndex = 5,
    Parent = MainWindow
})

local ControlsLayout = create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 6),
    Parent = WindowControls
})

local MinimizeBtn = create("ImageButton", {
    Name = "Minimize",
    Size = UDim2.new(0, 16, 0, 16),
    BackgroundTransparency = 1,
    Image = Config.Icons.Minimize,
    ImageColor3 = Config.Colors.TextMuted,
    AutoButtonColor = false,
    LayoutOrder = 1,
    Parent = WindowControls
})

local CloseBtn = create("ImageButton", {
    Name = "Close",
    Size = UDim2.new(0, 16, 0, 16),
    BackgroundTransparency = 1,
    Image = Config.Icons.Close,
    ImageColor3 = Config.Colors.TextMuted,
    AutoButtonColor = false,
    LayoutOrder = 2,
    Parent = WindowControls
})

local function addControlHover(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { ImageColor3 = Config.Colors.Accent }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { ImageColor3 = Config.Colors.TextMuted }):Play()
    end)
end
addControlHover(CloseBtn)
addControlHover(MinimizeBtn)

for i = 1, 4 do
    local petal = create("ImageLabel", {
        Name = "Petal_"..tostring(i),
        Size = UDim2.new(0, math.random(10, 14), 0, math.random(10, 14)),
        BackgroundTransparency = 1,
        Image = Config.Icons.Sakura,
        ImageColor3 = Config.Colors.AccentLight,
        ImageTransparency = 0.8,
        ZIndex = 1,
        Parent = MainWindow
    })
    
    local function animate()
        if not MainWindow.Parent then return end
        
        local startX = math.random(0, 100) / 100
        local startY = -0.05
        petal.Position = UDim2.new(startX, 0, startY, 0)
        petal.Rotation = math.random(0, 360)
        petal.ImageTransparency = 0.85
        
        local endX = startX + (math.random(-20, 20) / 100)
        local endY = 1.05
        local endRot = petal.Rotation + math.random(120, 360)
        
        local duration = math.random(8, 14)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        
        local moveTween = TweenService:Create(petal, tweenInfo, {
            Position = UDim2.new(endX, 0, endY, 0),
            Rotation = endRot,
            ImageTransparency = 1
        })
        
        moveTween:Play()
        moveTween.Completed:Connect(function()
            task.delay(math.random(1, 3), animate)
        end)
    end
    
    task.delay(math.random(0, 4), animate)
end

local ReopenBtn = create("ImageButton", {
    Name = "ReopenButton",
    Size = UDim2.new(0, 36, 0, 36),
    Position = UDim2.new(1, -56, 1, -56),
    BackgroundColor3 = Config.Colors.Surface,
    Visible = false,
    ZIndex = 9,
    Parent = ScreenGui
})
addCorner(ReopenBtn, 18)
addStroke(ReopenBtn, 1.5, Config.Colors.Border)

local ReopenIcon = create("ImageLabel", {
    Name = "Icon",
    Size = UDim2.new(0, 18, 0, 18),
    Position = UDim2.new(0.5, -9, 0.5, -9),
    BackgroundTransparency = 1,
    Image = Config.Icons.Sakura,
    ImageColor3 = Config.Colors.Accent,
    Parent = ReopenBtn
})

local function openMainWindow()
    ReopenBtn.Visible = false
    MainWindow.Visible = true
    
    WindowScale.Scale = 0.93
    MainWindow.GroupTransparency = 1
    
    local scaleTween = TweenService:Create(WindowScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    })
    local fadeTween = TweenService:Create(MainWindow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    })
    
    scaleTween:Play()
    fadeTween:Play()
end

local function closeMainWindow()
    local scaleTween = TweenService:Create(WindowScale, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Scale = 0.93
    })
    local fadeTween = TweenService:Create(MainWindow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        GroupTransparency = 1
    })
    
    scaleTween:Play()
    fadeTween:Play()
    
    fadeTween.Completed:Connect(function()
        MainWindow.Visible = false
        ReopenBtn.Visible = true

        ReopenBtn.Size = UDim2.new(0, 0, 0, 0)
        ReopenBtn.Position = UDim2.new(1, -38, 1, -38)
        
        TweenService:Create(ReopenBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 36, 0, 36),
            Position = UDim2.new(1, -56, 1, -56)
        }):Play()
    end)
end

CloseBtn.MouseButton1Click:Connect(closeMainWindow)
MinimizeBtn.MouseButton1Click:Connect(closeMainWindow)
ReopenBtn.MouseButton1Click:Connect(openMainWindow)

ReopenBtn.MouseEnter:Connect(function()
    TweenService:Create(ReopenBtn, TweenInfo.new(0.2), { BackgroundColor3 = Config.Colors.AccentLight }):Play()
    TweenService:Create(ReopenIcon, TweenInfo.new(0.2), { ImageColor3 = Config.Colors.AccentHover }):Play()
end)
ReopenBtn.MouseLeave:Connect(function()
    TweenService:Create(ReopenBtn, TweenInfo.new(0.2), { BackgroundColor3 = Config.Colors.Surface }):Play()
    TweenService:Create(ReopenIcon, TweenInfo.new(0.2), { ImageColor3 = Config.Colors.Accent }):Play()
end)

local dragToggle, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    local newPosition = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
    TweenService:Create(MainWindow, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = newPosition
    }):Play()
end

MainWindow.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
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

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
        updateInput(input)
    end
end)

openMainWindow()
