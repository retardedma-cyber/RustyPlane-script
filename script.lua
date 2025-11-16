-- ✈️ Rusty Plane v10 — by RENC
-- full modern menu: Tools / Player / Op

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

------------------------------------------------------
-- helpers
------------------------------------------------------
local function tween(o,t,p)
	TweenService:Create(o,TweenInfo.new(t,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p):Play()
end
local function unlockCursor(state)
	pcall(function()
		UIS.MouseBehavior = state and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
		UIS.MouseIconEnabled = state
	end)
end
unlockCursor(true)

------------------------------------------------------
-- gui root
------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name="RustyPlaneV10"
gui.IgnoreGuiInset=true
gui.ResetOnSpawn=false
gui.Parent=game.CoreGui

local panel=Instance.new("Frame",gui)
panel.Size=UDim2.new(0,420,1,0)
panel.Position = UDim2.new(1,-420,0,0)
panel.BackgroundColor3=Color3.fromRGB(22,22,22)
panel.BorderSizePixel=0
Instance.new("UICorner",panel).CornerRadius=UDim.new(0,14)
local grad=Instance.new("UIGradient",panel)
grad.Color=ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(60,45,30)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(25,25,25))
}

------------------------------------------------------
-- header
------------------------------------------------------
local header=Instance.new("TextLabel",panel)
header.Size=UDim2.new(1,-120,0,60)
header.Position=UDim2.new(0,20,0,5)
header.BackgroundTransparency=1
header.Font=Enum.Font.GothamBold
header.TextSize=30
header.TextColor3=Color3.fromRGB(255,200,120)
header.Text="✈ RUSTY PLANE ✈"

local closeBtn=Instance.new("TextButton",panel)
closeBtn.Size=UDim2.new(0,40,0,40)
closeBtn.Position=UDim2.new(1,-50,0,10)
closeBtn.BackgroundColor3=Color3.fromRGB(70,25,25)
closeBtn.Font=Enum.Font.GothamBold
closeBtn.Text="×"
closeBtn.TextSize=24
closeBtn.TextColor3=Color3.fromRGB(255,200,180)
Instance.new("UICorner",closeBtn).CornerRadius=UDim.new(0,8)

local minimizeBtn=Instance.new("TextButton",panel)
minimizeBtn.Size=UDim2.new(0,40,0,40)
minimizeBtn.Position=UDim2.new(1,-100,0,10)
minimizeBtn.BackgroundColor3=Color3.fromRGB(45,45,45)
minimizeBtn.Font=Enum.Font.GothamBold
minimizeBtn.Text="–"
minimizeBtn.TextSize=24
minimizeBtn.TextColor3=Color3.fromRGB(255,220,180)
Instance.new("UICorner",minimizeBtn).CornerRadius=UDim.new(0,8)

------------------------------------------------------
-- tabs
------------------------------------------------------
local tabHolder=Instance.new("Frame",panel)
tabHolder.Size=UDim2.new(1,-20,0,50)
tabHolder.Position=UDim2.new(0,10,0,70)
tabHolder.BackgroundTransparency=1

local content=Instance.new("Frame",panel)
content.Size=UDim2.new(1,-20,1,-160)
content.Position=UDim2.new(0,10,0,130)
content.BackgroundTransparency=1

local function makeTab(name,pos)
	local b=Instance.new("TextButton",tabHolder)
	b.Size=UDim2.new(0.33,-10,1,-10)
	b.Position=UDim2.new(pos,10,0,5)
	b.BackgroundColor3=(pos==0) and Color3.fromRGB(80,50,30) or Color3.fromRGB(40,40,40)
	b.TextColor3=Color3.fromRGB(255,220,160)
	b.Font=Enum.Font.GothamBold
	b.TextSize=20
	b.Text=name
	b.AutoButtonColor=false
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
	return b
end

local toolsBtn=makeTab("Tools",0)
local playerBtn=makeTab("Player",0.33)
local opBtn=makeTab("Op",0.66)

------------------------------------------------------
-- frames
------------------------------------------------------
local toolsFrame=Instance.new("Frame",content)
toolsFrame.Size=UDim2.new(1,0,1,0)
toolsFrame.BackgroundTransparency=1
toolsFrame.Visible=true

local playerFrame=Instance.new("Frame",content)
playerFrame.Size=UDim2.new(1,0,1,0)
playerFrame.BackgroundTransparency=1
playerFrame.Visible=false

local opFrame=Instance.new("Frame",content)
opFrame.Size=UDim2.new(1,0,1,0)
opFrame.BackgroundTransparency=1
opFrame.Visible=false

------------------------------------------------------
-- tab switching
------------------------------------------------------
local function switchTab(tab)
	toolsFrame.Visible=(tab=="Tools")
	playerFrame.Visible=(tab=="Player")
	opFrame.Visible=(tab=="Op")
	toolsBtn.BackgroundColor3=(tab=="Tools") and Color3.fromRGB(80,50,30) or Color3.fromRGB(40,40,40)
	playerBtn.BackgroundColor3=(tab=="Player") and Color3.fromRGB(80,50,30) or Color3.fromRGB(40,40,40)
	opBtn.BackgroundColor3=(tab=="Op") and Color3.fromRGB(80,50,30) or Color3.fromRGB(40,40,40)
end
toolsBtn.MouseButton1Click:Connect(function() switchTab("Tools") end)
playerBtn.MouseButton1Click:Connect(function() switchTab("Player") end)
opBtn.MouseButton1Click:Connect(function() switchTab("Op") end)

------------------------------------------------------
-- Tools
------------------------------------------------------
local scroll=Instance.new("ScrollingFrame",toolsFrame)
scroll.Size=UDim2.new(1,-10,1,-120)
scroll.Position=UDim2.new(0,5,0,5)
scroll.BackgroundColor3=Color3.fromRGB(15,15,15)
scroll.BackgroundTransparency=0.2
scroll.ScrollBarThickness=6
Instance.new("UICorner",scroll).CornerRadius=UDim.new(0,10)
local list=Instance.new("UIListLayout",scroll)
list.Padding = UDim.new(0,6)
list.SortOrder=Enum.SortOrder.LayoutOrder

local selectedTool
local function refreshTools()
	for _,c in ipairs(scroll:GetChildren())do if c:IsA("TextButton")then c:Destroy()end end
	for _,tool in ipairs(RS:GetChildren())do
		if tool:IsA("Tool")then
			local b=Instance.new("TextButton",scroll)
			b.Size=UDim2.new(1,-10,0,42)
			b.BackgroundColor3=Color3.fromRGB(40,30,20)
			b.TextColor3=Color3.fromRGB(255,200,140)
			b.Font=Enum.Font.GothamMedium
			b.TextSize=22
			b.Text=tool.Name
			b.AutoButtonColor=false
			Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
			b.MouseButton1Click:Connect(function()
				for _,bb in ipairs(scroll:GetChildren())do
					if bb:IsA("TextButton")then bb.BackgroundColor3=Color3.fromRGB(40,30,20)end
				end
				b.BackgroundColor3=Color3.fromRGB(120,70,40)
				selectedTool=tool
			end)
		end
	end
	scroll.CanvasSize=UDim2.new(0,0,0,list.AbsoluteContentSize.Y+5)
end
refreshTools()

local getBtn=Instance.new("TextButton",toolsFrame)
getBtn.Size=UDim2.new(0.48,-7,0,45)
getBtn.Position=UDim2.new(0,5,1,-55)
getBtn.BackgroundColor3=Color3.fromRGB(70,45,25)
getBtn.TextColor3=Color3.fromRGB(255,230,180)
getBtn.Font=Enum.Font.GothamBold
getBtn.TextSize=22
getBtn.Text="Get Tool"
Instance.new("UICorner",getBtn).CornerRadius=UDim.new(0,8)

local clearBtn=Instance.new("TextButton",toolsFrame)
clearBtn.Size=UDim2.new(0.48,-7,0,45)
clearBtn.Position=UDim2.new(0.52,0,1,-55)
clearBtn.BackgroundColor3=Color3.fromRGB(90,35,35)
clearBtn.TextColor3=Color3.fromRGB(255,230,180)
clearBtn.Font=Enum.Font.GothamBold
clearBtn.TextSize=22
clearBtn.Text="Clear Inventory"
Instance.new("UICorner",clearBtn).CornerRadius=UDim.new(0,8)

getBtn.MouseButton1Click:Connect(function()
	if selectedTool then
		local clone=selectedTool:Clone()
		clone.Parent=plr.Backpack
		getBtn.Text="✅ "..selectedTool.Name
		task.wait(1.2)
	else
		getBtn.Text="⚠ Select Tool"
		task.wait(1)
	end
	getBtn.Text="Get Tool"
end)
clearBtn.MouseButton1Click:Connect(function()
	for _,v in ipairs(plr.Backpack:GetChildren())do if v:IsA("Tool")then v:Destroy()end end
	clearBtn.Text="🧹 Cleared!";task.wait(1);clearBtn.Text="Clear Inventory"
end)

------------------------------------------------------
-- Player tab (Fly + Prompt + TPWalk)
------------------------------------------------------
local function makeSlider(parent,y,label,min,max,start,callback)
	local t=Instance.new("TextLabel",parent)
	t.Size=UDim2.new(1,-10,0,30)
	t.Position=UDim2.new(0,5,0,y)
	t.BackgroundTransparency=1
	t.Font=Enum.Font.GothamSemibold
	t.TextSize=18
	t.TextColor3=Color3.fromRGB(255,200,140)
	t.Text=label..": "..start
	local back=Instance.new("Frame",parent)
	back.Size=UDim2.new(1,-10,0,10)
	back.Position=UDim2.new(0,5,0,y+30)
	back.BackgroundColor3=Color3.fromRGB(50,35,25)
	Instance.new("UICorner",back).CornerRadius=UDim.new(0,5)
	local fill=Instance.new("Frame",back)
	fill.Size=UDim2.new((start-min)/(max-min),0,1,0)
	fill.BackgroundColor3=Color3.fromRGB(255,190,120)
	Instance.new("UICorner",fill).CornerRadius=UDim.new(0,5)
	local dragging=false
	back.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
	UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
	UIS.InputChanged:Connect(function(i)
		if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
			local pos=math.clamp((i.Position.X-back.AbsolutePosition.X)/back.AbsoluteSize.X,0,1)
			fill.Size=UDim2.new(pos,0,1,0)
			local val=math.floor(min+pos*(max-min))
			t.Text=label..": "..val
			callback(val)
		end
	end)
end

-- Fly
local fly=false;local speed=80;local bv,bg
local flyBtn=Instance.new("TextButton",playerFrame)
flyBtn.Size=UDim2.new(1,-10,0,45)
flyBtn.Position=UDim2.new(0,5,0,5)
flyBtn.BackgroundColor3=Color3.fromRGB(45,45,45)
flyBtn.Font=Enum.Font.GothamBold
flyBtn.TextColor3=Color3.fromRGB(255,230,180)
flyBtn.TextSize=22
flyBtn.Text="Enable Fly"
Instance.new("UICorner",flyBtn).CornerRadius=UDim.new(0,8)

flyBtn.MouseButton1Click:Connect(function()
	fly=not fly
	if fly then
		local root=char:WaitForChild("HumanoidRootPart")
		bg=Instance.new("BodyGyro",root)
		bv=Instance.new("BodyVelocity",root)
		bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
		bv.MaxForce=Vector3.new(9e9,9e9,9e9)
	else
		if bg then bg:Destroy()end;if bv then bv:Destroy()end
	end
	flyBtn.Text=fly and "Disable Fly" or "Enable Fly"
	flyBtn.BackgroundColor3=fly and Color3.fromRGB(70,45,25)or Color3.fromRGB(45,45,45)
end)

RunService.RenderStepped:Connect(function()
	if fly and char:FindFirstChild("HumanoidRootPart")then
		local root=char.HumanoidRootPart
		local cam=workspace.CurrentCamera
		local dir=Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir+=cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir-=cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir-=cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir+=cam.CFrame.RightVector end
		bv.Velocity=dir*speed
		bg.CFrame=cam.CFrame
	end
end)

makeSlider(playerFrame,60,"Fly Speed",30,250,speed,function(v)speed=v end)

-- Prompt control
local proxActive=false;local promptSpeed=1
local proxBtn=Instance.new("TextButton",playerFrame)
proxBtn.Size=UDim2.new(1,-10,0,40)
proxBtn.Position=UDim2.new(0,5,0,130)
proxBtn.BackgroundColor3=Color3.fromRGB(45,45,45)
proxBtn.TextColor3=Color3.fromRGB(255,230,180)
proxBtn.Font=Enum.Font.GothamBold
proxBtn.TextSize=20
proxBtn.Text="No Proximity Limits"
Instance.new("UICorner",proxBtn).CornerRadius=UDim.new(0,6)
proxBtn.MouseButton1Click:Connect(function()
	proxActive=not proxActive
	proxBtn.BackgroundColor3=proxActive and Color3.fromRGB(70,45,25)or Color3.fromRGB(45,45,45)
	for _,pp in ipairs(workspace:GetDescendants())do
		if pp:IsA("ProximityPrompt")then
			pp.MaxActivationDistance=proxActive and 9999 or 10
		end
	end
end)

makeSlider(playerFrame,180,"Prompt Speed",0,3,promptSpeed,function(v)
	promptSpeed=v
	for _,pp in ipairs(workspace:GetDescendants())do
		if pp:IsA("ProximityPrompt")then pp.HoldDuration=v end
	end
end)

-- TP walk
local tpWalk=false;local tpSpeed=3
local tpBtn=Instance.new("TextButton",playerFrame)
tpBtn.Size=UDim2.new(1,-10,0,40)
tpBtn.Position=UDim2.new(0,5,0,250)
tpBtn.BackgroundColor3=Color3.fromRGB(45,45,45)
tpBtn.TextColor3=Color3.fromRGB(255,230,180)
tpBtn.Font=Enum.Font.GothamBold
tpBtn.TextSize=20
tpBtn.Text="Enable TP-Walk"
Instance.new("UICorner",tpBtn).CornerRadius=UDim.new(0,6)
tpBtn.MouseButton1Click:Connect(function()
	tpWalk=not tpWalk
	tpBtn.BackgroundColor3=tpWalk and Color3.fromRGB(70,45,25)or Color3.fromRGB(45,45,45)
	tpBtn.Text=tpWalk and "Disable TP-Walk" or "Enable TP-Walk"
end)
makeSlider(playerFrame,300,"TP-Walk Speed",1,30,tpSpeed,function(v)tpSpeed=v end)

RunService.RenderStepped:Connect(function()
	if tpWalk and char:FindFirstChild("HumanoidRootPart")then
		local hrp=char.HumanoidRootPart
		local move=Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W) then move+=workspace.CurrentCamera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then move-=workspace.CurrentCamera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then move-=workspace.CurrentCamera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then move+=workspace.CurrentCamera.CFrame.RightVector end
		if move.Magnitude>0 then
			hrp.CFrame+=move.Unit*tpSpeed*RunService.RenderStepped:Wait()
		end
	end
end)

------------------------------------------------------
-- Op Tab (Admin)
------------------------------------------------------
local grantBtn = Instance.new("TextButton", opFrame)
grantBtn.Size = UDim2.new(1, -10, 0, 50)
grantBtn.Position = UDim2.new(0, 5, 0, 20)
grantBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
grantBtn.TextColor3 = Color3.fromRGB(255, 230, 180)
grantBtn.Font = Enum.Font.GothamBold
grantBtn.TextSize = 22
grantBtn.Text = "Grant Admin Access"
Instance.new("UICorner", grantBtn).CornerRadius = UDim.new(0, 8)

grantBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		local ui = plr.PlayerGui:FindFirstChild("AdminPanelUI") or workspace:FindFirstChild("AdminPanelUI")
		if not ui then
			grantBtn.Text = "⚠ No AdminPanelUI found"
			task.wait(1.5)
			grantBtn.Text = "Grant Admin Access"
			return
		end

		local allowed = ui:FindFirstChild("AllowedUsers")
		if allowed then
			for _, v in ipairs(allowed:GetChildren()) do
				v:Destroy()
			end
			local val = Instance.new("StringValue", allowed)
			val.Name = tostring(plr.UserId)
		end

		-- ✅ Без VirtualInputManager: просто показываем панель
		local openFrame = ui:FindFirstChild("AdminFrame")
		if openFrame and openFrame:IsA("Frame") then
			openFrame.Visible = true
		end

		grantBtn.Text = "✅ Access granted"
		grantBtn.BackgroundColor3 = Color3.fromRGB(70, 45, 25)
		task.wait(1.5)
		grantBtn.Text = "Grant Admin Access"
		grantBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end)

	if not success then
		warn("Admin panel injection failed:", err)
		grantBtn.Text = "⚠ Error!"
		task.wait(1.5)
		grantBtn.Text = "Grant Admin Access"
	end
end)
