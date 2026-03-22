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

-->

local new = Instance.new

local PerfaUi = {}

local Folder = {}
Folder.new = function(name,parent):Folder
	parent = parent or game.Players.LocalPlayer
	name = name or tostring(#game.Players.LocalPlayer:GetChildren())

	local folder = Instance.new("Folder")
	folder.Parent=parent folder.Name=name
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

local Extras = {}
Extras.ListLayout = function(parent,cVal:{Padding:UDim?,Direction:Enum.FillDirection?}):UIListLayout
	parent = parent or game.Players.LocalPlayer.PlayerGui
	cVal = cVal or {}
	local v2 = Instance.new("UIListLayout")
	v2.Padding = cVal.Padding or UDim.new(0,5)
	v2.FillDirection = cVal.Direction or Enum.FillDirection.Vertical
	v2.Parent=parent
	return v2
end

Extras.Tab = function(parent):Frame
	parent = parent or game
	local newTab = PerfaUi:Frame(parent,{Size=UDim2.new(.9,0,0,30)})
	PerfaUi:Outline(newTab)
	PerfaUi:Corner(newTab,{Radius=UDim.new(0,5)})
	
	local objectValue = new"ObjectValue"
	objectValue.Parent=game.Players.LocalPlayer.PlayerGui:FindFirstChild("PERFA-UI"):FindFirstChild("Tabs",true)
	objectValue.Name="Tab_#"..tostring(#objectValue.Parent:GetChildren())
	objectValue.Value=newTab
	return newTab
end

function PerfaUi.new(customName):ScreenGui
	game:GetService("TestService"):Message(msg)
	
	--customName=customName or "PERFA-UI"
	customName="PERFA-UI"
	local screengui = Instance.new("ScreenGui")
	screengui.IgnoreGuiInset=true screengui.Name = customName
	screengui.ResetOnSpawn=false screengui.Parent = game.Players.LocalPlayer.PlayerGui
	
	-->
	
	local coreFrame = PerfaUi:Frame(screengui,{Draggable=true}) coreFrame.Name="UI.CORE"
	PerfaUi:Corner(coreFrame,{Radius=UDim.new(0,5)})
	PerfaUi:Outline(coreFrame)
	PerfaUi:CloseButton(coreFrame)
	
	local coreTabs = Folder.new("Tabs",coreFrame)
	
	-->
	
	local SideBar = PerfaUi:ScrollingFrame(coreFrame,{Size=UDim2.new(0.25,0,1,0)})
	PerfaUi:Outline(SideBar)
	PerfaUi:Corner(SideBar,{Radius=UDim.new(0,5)})
	
	Extras.ListLayout(SideBar)
	
	-->
	
	Extras.Tab(SideBar)
	Extras.Tab(SideBar)
	Extras.Tab(SideBar)
end

function PerfaUi:Frame(parent,cVal:{Anchor:Vector2,BackgroundgColor:Color3,BorderSize:number,Size:UDim2,Draggable:boolean,Active:boolean,Position:UDim2}?):Frame
	cVal=cVal or {}
	parent = parent or game
	local v1 = Instance.new("Frame",parent)
	v1.BackgroundColor3=cVal.BackgroundgColor or Color3.new(0.188235, 0.207843, 0.243137)
	v1.BorderSizePixel=cVal.BorderSize or 0
	v1.Size = cVal.Size or UDim2.new(0,600,0,350)
	v1.Draggable=cVal.Draggable or false
	v1.Active=cVal.Active or true
	v1.Position=cVal.Position or UDim2.new(0,0,0,0)
	v1.Name = cVal.Name or v1.Name
	
	v1:SetAttribute("OriginalSize",v1.Size)
	return v1
end

function PerfaUi:ScrollingFrame(parent,cVal:{Anchor:Vector2,BackgroundgColor:Color3,BorderSize:number,Size:UDim2,Draggable:boolean,Active:boolean,Position:UDim2}?):Frame
	cVal=cVal or {}
	parent = parent or game
	local v1 = Instance.new("ScrollingFrame",parent)
	v1.BackgroundColor3=cVal.BackgroundgColor or Color3.new(0.188235, 0.207843, 0.243137)
	v1.BorderSizePixel=cVal.BorderSize or 0
	v1.Size = cVal.Size or UDim2.new(0,600,0,350)
	v1.Draggable=cVal.Draggable or false
	v1.Active=cVal.Active or true
	v1.Position=cVal.Position or UDim2.new(0,0,0,0)
	v1.Name = cVal.Name or v1.Name
	v1.ScrollBarImageTransparency = cVal.ScrollBarTransparency or 1

	v1:SetAttribute("OriginalSize",v1.Size)
	return v1
end

function PerfaUi:CloseButton(parent)
	if not parent or not parent:IsA("Frame") then return end
	local v1 = Instance.new("TextButton",parent)
	v1.BackgroundColor3 = Color3.new(0.188235, 0.207843, 0.243137)
	v1.Size = UDim2.new(0,20,0,20)
	v1.AnchorPoint=Vector2.new(1,0)
	v1.Position = UDim2.new(1,0,0,0)
	v1.Text = "X"
	v1.TextColor3 = Color3.new(1,1,1)
	v1.Font = Enum.Font.Arial
	v1.BorderSizePixel = 0
	v1.TextScaled = true
	v1.ZIndex=999
	
	PerfaUi:Corner(v1,{Radius=UDim.new(0,5)})
	PerfaUi:Outline(v1,{Context=Enum.ApplyStrokeMode.Border})
	
	coroutine.wrap(function()
		local new = false
		local stored = {}
		local cool = {on=false,timer=0.3}
		local stored = {} :: {[Instance]:any}
		v1.MouseButton1Click:Connect(function()
			if cool.on then return end
			cool.on = true
			task.delay(cool.timer,function() cool.on = false end)
			new = not new
			local ts = game:GetService("TweenService")
			local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			if new then
				v1.Text="O"
				local osize:UDim2 = parent:GetAttribute("OriginalSize")
				ts:Create(parent,TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
					{Size = UDim2.new(0,80,0,20)}):Play()

				for _, child in pairs(parent:GetDescendants()) do
					if child ~= v1 then
						stored[child] = {}

						if child:IsA("GuiObject") then
							stored[child].BackgroundTransparency = child.BackgroundTransparency
							ts:Create(child,tweenInfo,{BackgroundTransparency=1}):Play()
						end
						if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
							stored[child].TextTransparency = child.TextTransparency
							ts:Create(child,tweenInfo,{TextTransparency=1}):Play()
						end
						if child:IsA("ImageLabel") or child:IsA("ImageButton") then
							stored[child].ImageTransparency = child.ImageTransparency
							ts:Create(child,tweenInfo,{ImageTransparency=1}):Play()
						end
						for _, s in pairs(child:GetDescendants()) do
							if s:IsA("UIStroke") then
								stored[child][s] = s.Transparency
								ts:Create(s,tweenInfo,{Transparency=1}):Play()
							end
						end
					end
				end
			else
				v1.Text="X"
				local osize:UDim2 = parent:GetAttribute("OriginalSize")
				ts:Create(parent,TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
					{Size = osize}):Play()

				for child, values in pairs(stored) do
					if child and child.Parent then warn(child,values)
						if values.BackgroundTransparency ~= nil then
							ts:Create(child,tweenInfo,{BackgroundTransparency=values.BackgroundTransparency}):Play()
						end
						if values.TextTransparency ~= nil then
							ts:Create(child,tweenInfo,{TextTransparency=values.TextTransparency}):Play()
						end
						if values.ImageTransparency ~= nil then
							ts:Create(child,tweenInfo,{ImageTransparency=values.ImageTransparency}):Play()
						end
						for k, v in pairs(values) do
							if typeof(k)=="Instance" and k:IsA("UIStroke") then
								ts:Create(k,tweenInfo,{Transparency=v}):Play()
							end
						end
					end
				end
			end
		end)
	end)()
	return v1
end

function PerfaUi:Outline(parent,cVal:{string}?):UIStroke
	cVal=cVal or {}
	parent = parent or game
	local v1 = Instance.new("UIStroke",parent)
	v1.Color = cVal.Color or Color3.new(0.47451, 0.341176, 1)
	v1.ApplyStrokeMode = cVal.Context or Enum.ApplyStrokeMode.Contextual
	return v1
end

function PerfaUi:Corner(instance,cVal:{Radius:UDim}?):UICorner
	instance = instance or game
	cVal = cVal or {}
	local corner = Instance.new("UICorner")
	corner.CornerRadius = cVal.Radius or UDim.new(0.02,0)
	corner.Parent=instance
	return corner
end

return PerfaUi
