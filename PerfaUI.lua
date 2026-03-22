--[[

  > part of JollyUI repo
  > By Late-n-sea @ versal

--]]

local msg = [[>

PERFA-UI MADE BY VERSAL
DISCORD.GG/VERSAL

Late-N-Sea

--X-----X--XXXXXXXX--XXXXXXXX--XXXXXXXX-----XX-----X-------<3
--X-----X--X---------X------X--X-----------X--X----X---------
--X-----X--X---------X------X--X-----------X--X----X---------
--X-----X--X---------X------X--X----------X----X---X---------
--X-----X--XXXXXXXX--XXXXXXXX--XXXXXXXX---X----X---X---------
--X-----X--X---------X----X-----------X--X-XXXX-X--X---------
--X-----X--X---------X----X-----------X--X------X--X---------
---X---X---X---------X-----X----------X--X------X--X---------
---X---X---X---------X-----X----------X--X------X--X---------
----X-X----X---------X------X---------X--X------X--X---------
-----X-----XXXXXXXX--X------X--XXXXXXXX--X------X--XXXXXXXX--

>
]]

--[[

	TODO: tab switching
	TODO: config save/load
	TODO: dropdowns / sliders (done kinda?)
	TODO: keybind system

]]

local players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local new = Instance.new

local PerfaUi = {}

-- > THEME
PerfaUi.Theme = {
	Background = Color3.fromRGB(48, 53, 62),
	Accent = Color3.fromRGB(121, 87, 255),
	Text = Color3.fromRGB(255,255,255)
}

function PerfaUi:NewTheme(themeTable)
	if typeof(themeTable) ~= "table" then return end
	
	for k,v in pairs(themeTable) do
		self.Theme[k] = v
	end
end

-- > UTILITY
function PerfaUi:Tween(instance, time, props, style, direction)
	if not instance then return end
	local info = TweenInfo.new(
		time or 0.25,
		style or Enum.EasingStyle.Quad,
		direction or Enum.EasingDirection.Out
	)
	local tween = TweenService:Create(instance, info, props)
	tween:Play()
	return tween
end

-- > FOLDER
local Folder = {}
Folder.new = function(name,parent):Folder
	parent = parent or players.LocalPlayer
	name = name or tostring(#players.LocalPlayer:GetChildren())

	local folder = Instance.new("Folder")
	folder.Parent=parent 
	folder.Name=name
	return folder
end

Folder.clear = function(folder:Folder,whitelist:{string}?):()
	whitelist=whitelist or {}
	for _,c in pairs(folder:GetChildren()) do
		if not table.find(whitelist,c.ClassName) then
			c:Destroy()
		end
	end
end

-- > EXTRAS
local Extras = {}

Extras.ListLayout = function(parent,cVal:{Padding:UDim?,Direction:Enum.FillDirection?}):UIListLayout
	parent = parent or players.LocalPlayer.PlayerGui
	cVal = cVal or {}
	local v2 = Instance.new("UIListLayout")
	v2.Padding = cVal.Padding or UDim.new(0,5)
	v2.FillDirection = cVal.Direction or Enum.FillDirection.Vertical
	v2.Parent=parent
	return v2
end

Extras.Padding = function(parent, padding)
	local pad = Instance.new("UIPadding")
	padding = padding or 5
	pad.PaddingTop = UDim.new(0,padding)
	pad.PaddingBottom = UDim.new(0,padding)
	pad.PaddingLeft = UDim.new(0,padding)
	pad.PaddingRight = UDim.new(0,padding)
	pad.Parent = parent
	return pad
end

Extras.Label = function(parent, text)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,0,0,25)
	lbl.BackgroundTransparency = 1
	lbl.Text = text or "Label"
	lbl.TextColor3 = PerfaUi.Theme.Text
	lbl.Font = Enum.Font.Gotham
	lbl.TextScaled = true
	lbl.Parent = parent
	return lbl
end

Extras.Button = function(parent, text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,0,0,30)
	btn.BackgroundColor3 = PerfaUi.Theme.Background
	btn.Text = text or "Button"
	btn.TextColor3 = PerfaUi.Theme.Text
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.Parent = parent
	
	PerfaUi:Corner(btn,{Radius=UDim.new(0,5)})
	PerfaUi:Outline(btn)

	btn.MouseEnter:Connect(function()
		PerfaUi:Tween(btn,0.15,{BackgroundColor3 = PerfaUi.Theme.Accent})
	end)
	btn.MouseLeave:Connect(function()
		PerfaUi:Tween(btn,0.15,{BackgroundColor3 = PerfaUi.Theme.Background})
	end)

	return btn
end

Extras.Tab = function(parent):Frame
	parent = parent or game
	local newTab = PerfaUi:Frame(parent,{Size=UDim2.new(.9,0,0,30)})
	PerfaUi:Outline(newTab)
	PerfaUi:Corner(newTab,{Radius=UDim.new(0,5)})
	
	local gui = players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("PERFA-UI")
	if not gui then return newTab end
	
	local tabFolder = gui:FindFirstChild("Tabs",true)
	if not tabFolder then return newTab end
	
	local objectValue = new"ObjectValue"
	objectValue.Parent = tabFolder
	objectValue.Name = "Tab_#"..tostring(#tabFolder:GetChildren())
	objectValue.Value = newTab
	
	return newTab
end

Extras.Dropdown = function(parent, data)
	data = data or {}
	
	local title = data.Title or "Dropdown"
	local options = data.Options or {"Option 1","Option 2"}
	local callback = data.Callback or function() end
	
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1,0,0,30)
	holder.BackgroundTransparency = 1
	holder.Parent = parent
	
	local main = Instance.new("TextButton")
	main.Size = UDim2.new(1,0,1,0)
	main.BackgroundColor3 = PerfaUi.Theme.Background
	main.Text = title
	main.TextColor3 = PerfaUi.Theme.Text
	main.Font = Enum.Font.Gotham
	main.TextScaled = true
	main.BorderSizePixel = 0
	main.Parent = holder
	
	PerfaUi:Corner(main,{Radius=UDim.new(0,5)})
	PerfaUi:Outline(main)
	
	local listFrame = Instance.new("Frame")
	listFrame.Size = UDim2.new(1,0,0,0)
	listFrame.Position = UDim2.new(0,0,1,5)
	listFrame.BackgroundColor3 = PerfaUi.Theme.Background
	listFrame.ClipsDescendants = true
	listFrame.Parent = holder
	
	PerfaUi:Corner(listFrame,{Radius=UDim.new(0,5)})
	PerfaUi:Outline(listFrame)
	
	local layout = Instance.new("UIListLayout")
	layout.Parent = listFrame
	
	local opened = false
	local optionButtons = {}
	
	local function refreshSize()
		local total = 0
		for _,b in pairs(optionButtons) do
			total += b.Size.Y.Offset + 5
		end
		return total
	end
	
	for _,opt in ipairs(options) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1,0,0,25)
		btn.BackgroundColor3 = PerfaUi.Theme.Background
		btn.Text = tostring(opt)
		btn.TextColor3 = PerfaUi.Theme.Text
		btn.Font = Enum.Font.Gotham
		btn.TextScaled = true
		btn.BorderSizePixel = 0
		btn.Parent = listFrame
		
		PerfaUi:Corner(btn,{Radius=UDim.new(0,4)})
		
		btn.MouseEnter:Connect(function()
			PerfaUi:Tween(btn,0.15,{BackgroundColor3 = PerfaUi.Theme.Accent})
		end)
		btn.MouseLeave:Connect(function()
			PerfaUi:Tween(btn,0.15,{BackgroundColor3 = PerfaUi.Theme.Background})
		end)
		
		btn.MouseButton1Click:Connect(function()
			main.Text = title..": "..tostring(opt)
			callback(opt)
		end)
		
		table.insert(optionButtons,btn)
	end
	
	main.MouseButton1Click:Connect(function()
		opened = not opened
		
		if opened then
			local size = refreshSize()
			PerfaUi:Tween(listFrame,0.25,{Size = UDim2.new(1,0,0,size)})
		else
			PerfaUi:Tween(listFrame,0.25,{Size = UDim2.new(1,0,0,0)})
		end
	end)
	
	return holder
end

-- > MAIN UI
function PerfaUi.new(customName):ScreenGui
	customName="PERFA-UI"

	local screengui = Instance.new("ScreenGui")
	screengui.IgnoreGuiInset=true 
	screengui.Name = customName
	screengui.ResetOnSpawn=false 
	screengui.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
	
	local coreFrame = PerfaUi:Frame(screengui,{Draggable=true}) 
	coreFrame.Name="UI.CORE"
	
	PerfaUi:Corner(coreFrame,{Radius=UDim.new(0,5)})
	PerfaUi:Outline(coreFrame)
	PerfaUi:CloseButton(coreFrame)

	local coreTabs = Folder.new("Tabs",coreFrame)

	local SideBar = PerfaUi:ScrollingFrame(coreFrame,{Size=UDim2.new(0.25,0,1,0)})
	PerfaUi:Outline(SideBar)
	PerfaUi:Corner(SideBar,{Radius=UDim.new(0,5)})

	return screengui
end

-- > FRAME
function PerfaUi:Frame(parent,cVal):Frame
	cVal=cVal or {}
	parent = parent or game
	local v1 = Instance.new("Frame",parent)

	v1.BackgroundColor3=cVal.BackgroundgColor or self.Theme.Background
	v1.BorderSizePixel=cVal.BorderSize or 0
	v1.Size = cVal.Size or UDim2.new(0,600,0,350)
	v1.Draggable=cVal.Draggable or false
	v1.Active=cVal.Active ~= false
	v1.Position=cVal.Position or UDim2.new(0,0,0,0)
	v1.Name = cVal.Name or v1.Name

	v1:SetAttribute("OriginalSize",v1.Size)
	return v1
end

-- > SCROLLING FRAME
function PerfaUi:ScrollingFrame(parent,cVal):ScrollingFrame
	cVal=cVal or {}
	parent = parent or game

	local v1 = Instance.new("ScrollingFrame",parent)
	v1.BackgroundColor3=cVal.BackgroundgColor or self.Theme.Background
	v1.BorderSizePixel=cVal.BorderSize or 0
	v1.Size = cVal.Size or UDim2.new(0,600,0,350)
	v1.Draggable=cVal.Draggable or false
	v1.Active=cVal.Active ~= false
	v1.Position=cVal.Position or UDim2.new(0,0,0,0)
	v1.Name = cVal.Name or v1.Name
	v1.ScrollBarImageTransparency = cVal.ScrollBarTransparency or 1

	v1:SetAttribute("OriginalSize",v1.Size)
	return v1
end

-- > CLOSE BUTTON
function PerfaUi:CloseButton(parent)
	if not parent or not parent:IsA("Frame") then return end
	
	local v1 = Instance.new("TextButton",parent)
	v1.Size = UDim2.new(0,20,0,20)
	v1.AnchorPoint=Vector2.new(1,0)
	v1.Position = UDim2.new(1,0,0,0)
	v1.Text = "X"
	v1.TextColor3 = Color3.new(1,1,1)
	v1.BackgroundColor3 = self.Theme.Background
	v1.BorderSizePixel = 0
	v1.TextScaled = true
	v1.ZIndex=999
	
	self:Corner(v1,{Radius=UDim.new(0,5)})
	self:Outline(v1,{Context=Enum.ApplyStrokeMode.Border})

	coroutine.wrap(function()
		local minimized = false
		local debounce = false

		v1.MouseButton1Click:Connect(function()
			if debounce then return end
			debounce = true
			task.delay(0.3,function() debounce = false end)

			minimized = not minimized

			if minimized then
				v1.Text="O"
				self:Tween(parent,0.3,{Size = UDim2.new(0,80,0,20)})
			else
				v1.Text="X"
				local osize = parent:GetAttribute("OriginalSize")
				if osize then
					self:Tween(parent,0.3,{Size = osize})
				end
			end
		end)
	end)()

	return v1
end

-- > OUTLINE
function PerfaUi:Outline(parent,cVal):UIStroke
	cVal=cVal or {}
	parent = parent or game
	local v1 = Instance.new("UIStroke",parent)
	v1.Color = cVal.Color or self.Theme.Accent
	v1.ApplyStrokeMode = cVal.Context or Enum.ApplyStrokeMode.Contextual
	return v1
end

-- > CORNER
function PerfaUi:Corner(instance,cVal):UICorner
	instance = instance or game
	cVal = cVal or {}
	local corner = Instance.new("UICorner")
	corner.CornerRadius = cVal.Radius or UDim.new(0.02,0)
	corner.Parent=instance
	return corner
end

return PerfaUi
