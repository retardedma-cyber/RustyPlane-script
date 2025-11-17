-- ✈️ Rusty Plane v10 — by RENC
-- full modern menu: Tools / Player / Op

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
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

------------------------------------------------------
-- Разблокировка камеры для работы с меню
------------------------------------------------------
plr.CameraMaxZoomDistance = 99999
plr.CameraMode = Enum.CameraMode.Classic

-- Уведомление о разблокировке (исправлено)
task.spawn(function()
	task.wait(0.5)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Camera Unlocked";
			Text = "Third-person view is now available";
			Duration = 3;
		})
	end)
end)

local panel=Instance.new("Frame",gui)
panel.Size=UDim2.new(0,440,1,0)
panel.Position = UDim2.new(1,-440,0,0)
panel.BackgroundColor3=Color3.fromRGB(18,18,20)
panel.BorderSizePixel=0
panel.BackgroundTransparency=0.05
Instance.new("UICorner",panel).CornerRadius=UDim.new(0,16)

-- Тень для панели
local shadow=Instance.new("ImageLabel",panel)
shadow.Size=UDim2.new(1,30,1,30)
shadow.Position=UDim2.new(0,-15,0,-15)
shadow.BackgroundTransparency=1
shadow.Image="rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3=Color3.fromRGB(0,0,0)
shadow.ImageTransparency=0.5
shadow.ZIndex=0

local grad=Instance.new("UIGradient",panel)
grad.Color=ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(70,50,35)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(28,28,32)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(20,20,22))
}
grad.Rotation=90

-- Акцентная линия слева
local accent=Instance.new("Frame",panel)
accent.Size=UDim2.new(0,4,1,0)
accent.Position=UDim2.new(0,0,0,0)
accent.BorderSizePixel=0
local accentGrad=Instance.new("UIGradient",accent)
accentGrad.Color=ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(255,180,100)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(200,120,60)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(255,180,100))
}
accentGrad.Rotation=90

------------------------------------------------------
-- header
------------------------------------------------------
local header=Instance.new("TextLabel",panel)
header.Size=UDim2.new(1,-120,0,50)
header.Position=UDim2.new(0,25,0,8)
header.BackgroundTransparency=1
header.Font=Enum.Font.GothamBold
header.TextSize=32
header.TextColor3=Color3.fromRGB(255,210,140)
header.Text="✈ RUSTY PLANE ✈"
header.TextStrokeTransparency=0.8
header.TextStrokeColor3=Color3.fromRGB(0,0,0)

local subtitle=Instance.new("TextLabel",panel)
subtitle.Size=UDim2.new(1,-120,0,20)
subtitle.Position=UDim2.new(0,25,0,52)
subtitle.BackgroundTransparency=1
subtitle.Font=Enum.Font.GothamMedium
subtitle.TextSize=14
subtitle.TextColor3=Color3.fromRGB(200,160,100)
subtitle.Text="By RENC"
subtitle.TextTransparency=0.3

local closeBtn=Instance.new("TextButton",panel)
closeBtn.Size=UDim2.new(0,42,0,42)
closeBtn.Position=UDim2.new(1,-52,0,15)
closeBtn.BackgroundColor3=Color3.fromRGB(85,30,30)
closeBtn.Font=Enum.Font.GothamBold
closeBtn.Text="×"
closeBtn.TextSize=26
closeBtn.TextColor3=Color3.fromRGB(255,220,200)
closeBtn.AutoButtonColor=false
Instance.new("UICorner",closeBtn).CornerRadius=UDim.new(0,10)
local closeBtnStroke=Instance.new("UIStroke",closeBtn)
closeBtnStroke.Color=Color3.fromRGB(120,40,40)
closeBtnStroke.Thickness=1.5
closeBtnStroke.Transparency=0.5

local minimizeBtn=Instance.new("TextButton",panel)
minimizeBtn.Size=UDim2.new(0,42,0,42)
minimizeBtn.Position=UDim2.new(1,-105,0,15)
minimizeBtn.BackgroundColor3=Color3.fromRGB(50,50,55)
minimizeBtn.Font=Enum.Font.GothamBold
minimizeBtn.Text="–"
minimizeBtn.TextSize=26
minimizeBtn.TextColor3=Color3.fromRGB(255,230,200)
minimizeBtn.AutoButtonColor=false
Instance.new("UICorner",minimizeBtn).CornerRadius=UDim.new(0,10)
local minBtnStroke=Instance.new("UIStroke",minimizeBtn)
minBtnStroke.Color=Color3.fromRGB(80,80,90)
minBtnStroke.Thickness=1.5
minBtnStroke.Transparency=0.5

-- Hover эффекты для кнопок
closeBtn.MouseEnter:Connect(function()
	tween(closeBtn,0.2,{BackgroundColor3=Color3.fromRGB(120,40,40)})
end)
closeBtn.MouseLeave:Connect(function()
	tween(closeBtn,0.2,{BackgroundColor3=Color3.fromRGB(85,30,30)})
end)

minimizeBtn.MouseEnter:Connect(function()
	tween(minimizeBtn,0.2,{BackgroundColor3=Color3.fromRGB(70,70,75)})
end)
minimizeBtn.MouseLeave:Connect(function()
	tween(minimizeBtn,0.2,{BackgroundColor3=Color3.fromRGB(50,50,55)})
end)

-- Кнопка восстановления (показывается когда панель минимизирована)
local restoreBtn = Instance.new("TextButton", gui)
restoreBtn.Size = UDim2.new(0, 50, 0, 50)
restoreBtn.Position = UDim2.new(1, -60, 0.5, -25)
restoreBtn.BackgroundColor3 = Color3.fromRGB(90, 60, 35)
restoreBtn.Font = Enum.Font.GothamBold
restoreBtn.Text = "✈"
restoreBtn.TextSize = 24
restoreBtn.TextColor3 = Color3.fromRGB(255, 220, 180)
restoreBtn.Visible = false
restoreBtn.AutoButtonColor = false
Instance.new("UICorner", restoreBtn).CornerRadius = UDim.new(0, 12)
local restoreStroke = Instance.new("UIStroke", restoreBtn)
restoreStroke.Color = Color3.fromRGB(200, 120, 60)
restoreStroke.Thickness = 2

-- Hover эффект для кнопки восстановления
restoreBtn.MouseEnter:Connect(function()
	tween(restoreBtn, 0.2, {BackgroundColor3 = Color3.fromRGB(120, 80, 45)})
end)
restoreBtn.MouseLeave:Connect(function()
	tween(restoreBtn, 0.2, {BackgroundColor3 = Color3.fromRGB(90, 60, 35)})
end)

-- Обработчики кнопок
local panelVisible = true
closeBtn.MouseButton1Click:Connect(function()
	tween(panel, 0.3, {Position = UDim2.new(1, 50, 0, 0)})
	task.wait(0.3)
	gui:Destroy()
end)

minimizeBtn.MouseButton1Click:Connect(function()
	panelVisible = not panelVisible
	if panelVisible then
		tween(panel, 0.4, {Position = UDim2.new(1, -440, 0, 0)})
		minimizeBtn.Text = "–"
		restoreBtn.Visible = false
	else
		tween(panel, 0.4, {Position = UDim2.new(1, 0, 0, 0)})
		minimizeBtn.Text = "+"
		task.wait(0.4)
		restoreBtn.Visible = true
	end
end)

restoreBtn.MouseButton1Click:Connect(function()
	panelVisible = true
	restoreBtn.Visible = false
	tween(panel, 0.4, {Position = UDim2.new(1, -440, 0, 0)})
	minimizeBtn.Text = "–"
end)

------------------------------------------------------
-- tabs
------------------------------------------------------
local tabHolder=Instance.new("Frame",panel)
tabHolder.Size=UDim2.new(1,-30,0,55)
tabHolder.Position=UDim2.new(0,15,0,85)
tabHolder.BackgroundTransparency=1

local content=Instance.new("Frame",panel)
content.Size=UDim2.new(1,-30,1,-180)
content.Position=UDim2.new(0,15,0,150)
content.BackgroundTransparency=1

local function makeTab(name,pos)
	local b=Instance.new("TextButton",tabHolder)
	b.Size=UDim2.new(0.33,-8,1,-8)
	b.Position=UDim2.new(pos,6,0,4)
	b.BackgroundColor3=(pos==0) and Color3.fromRGB(90,60,35) or Color3.fromRGB(45,45,50)
	b.TextColor3=Color3.fromRGB(255,230,180)
	b.Font=Enum.Font.GothamBold
	b.TextSize=21
	b.Text=name
	b.AutoButtonColor=false
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)

	-- Обводка для вкладок
	local stroke=Instance.new("UIStroke",b)
	stroke.Color=Color3.fromRGB(100,70,50)
	stroke.Thickness=1
	stroke.Transparency=0.6

	-- Hover эффект
	b.MouseEnter:Connect(function()
		if b.BackgroundColor3~=Color3.fromRGB(90,60,35) then
			tween(b,0.2,{BackgroundColor3=Color3.fromRGB(55,55,60)})
		end
	end)
	b.MouseLeave:Connect(function()
		if b.BackgroundColor3~=Color3.fromRGB(90,60,35) then
			tween(b,0.2,{BackgroundColor3=Color3.fromRGB(45,45,50)})
		end
	end)

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

	local activeColor=Color3.fromRGB(90,60,35)
	local inactiveColor=Color3.fromRGB(45,45,50)

	tween(toolsBtn,0.2,{BackgroundColor3=(tab=="Tools") and activeColor or inactiveColor})
	tween(playerBtn,0.2,{BackgroundColor3=(tab=="Player") and activeColor or inactiveColor})
	tween(opBtn,0.2,{BackgroundColor3=(tab=="Op") and activeColor or inactiveColor})
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
	if fly and char:FindFirstChild("HumanoidRootPart") and bv and bg then
		local root=char.HumanoidRootPart
		local cam=workspace.CurrentCamera
		local dir=Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir+=cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir-=cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir-=cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir+=cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir+=Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir-=Vector3.new(0,1,0) end
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

RunService.RenderStepped:Connect(function(deltaTime)
	if tpWalk and char:FindFirstChild("HumanoidRootPart")then
		local hrp=char.HumanoidRootPart
		local move=Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W) then move+=workspace.CurrentCamera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then move-=workspace.CurrentCamera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then move-=workspace.CurrentCamera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then move+=workspace.CurrentCamera.CFrame.RightVector end
		if move.Magnitude>0 then
			hrp.CFrame = hrp.CFrame + (move.Unit * tpSpeed * deltaTime)
		end
	end
end)

------------------------------------------------------
-- Op Tab (CheatPanel + End Game)
------------------------------------------------------
local cheatBtn = Instance.new("TextButton", opFrame)
cheatBtn.Size = UDim2.new(1, -10, 0, 50)
cheatBtn.Position = UDim2.new(0, 5, 0, 20)
cheatBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
cheatBtn.TextColor3 = Color3.fromRGB(255, 230, 180)
cheatBtn.Font = Enum.Font.GothamBold
cheatBtn.TextSize = 22
cheatBtn.Text = "Open CheatPanel"
Instance.new("UICorner", cheatBtn).CornerRadius = UDim.new(0, 8)

local hideCheatBtn = Instance.new("TextButton", opFrame)
hideCheatBtn.Size = UDim2.new(1, -10, 0, 50)
hideCheatBtn.Position = UDim2.new(0, 5, 0, 80)
hideCheatBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
hideCheatBtn.TextColor3 = Color3.fromRGB(255, 230, 180)
hideCheatBtn.Font = Enum.Font.GothamBold
hideCheatBtn.TextSize = 22
hideCheatBtn.Text = "Hide CheatPanel"
Instance.new("UICorner", hideCheatBtn).CornerRadius = UDim.new(0, 8)

-- End Game button (заменяем Fix Fire)
local endGameBtn = Instance.new("TextButton", opFrame)
endGameBtn.Size = UDim2.new(1, -10, 0, 50)
endGameBtn.Position = UDim2.new(0, 5, 0, 140)
endGameBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
endGameBtn.TextColor3 = Color3.fromRGB(255, 230, 180)
endGameBtn.Font = Enum.Font.GothamBold
endGameBtn.TextSize = 22
endGameBtn.Text = "Set Points [IN LOBBY!]"
Instance.new("UICorner", endGameBtn).CornerRadius = UDim.new(0, 8)

cheatBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		local PlayerGui = plr:WaitForChild("PlayerGui")

		print("------- [ GUI SHOW DEBUG START ] -------")

		-- Ищем CheatPanel в StarterGui
		local template = StarterGui:FindFirstChild("CheatPanel")
		if not template then
			warn("⚠ Not found in StarterGui: CheatPanel")
			cheatBtn.Text = "⚠ CheatPanel not found"
			task.wait(1.5)
			cheatBtn.Text = "Open CheatPanel"
			return
		end

		-- Проверяем, есть ли уже в PlayerGui
		local existing = PlayerGui:FindFirstChild("CheatPanel")

		if existing then
			-- Если уже есть, просто включаем
			existing.Enabled = true

			-- Показываем все GuiObject
			for _, v in ipairs(existing:GetDescendants()) do
				if v:IsA("GuiObject") then
					v.Visible = true
				end
			end

			print("🟢 Enabled: CheatPanel")
		else
			-- Клонируем из StarterGui в PlayerGui
			local clone = template:Clone()
			clone.Parent = PlayerGui
			clone.Enabled = true

			-- Показываем все GuiObject
			for _, v in ipairs(clone:GetDescendants()) do
				if v:IsA("GuiObject") then
					v.Visible = true
				end
			end

			print("🆕 Cloned & Enabled: CheatPanel")
		end

		print("📌 Total target GUIs loaded: 1")
		print("------- [  GUI SHOW DEBUG END  ] -------\n")

		cheatBtn.Text = "✅ CheatPanel Opened"
		cheatBtn.BackgroundColor3 = Color3.fromRGB(70, 45, 25)
		task.wait(1.5)
		cheatBtn.Text = "Open CheatPanel"
		cheatBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end)

	if not success then
		warn("CheatPanel loading failed:", err)
		cheatBtn.Text = "⚠ Error!"
		task.wait(1.5)
		cheatBtn.Text = "Open CheatPanel"
	end
end)

hideCheatBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		local PlayerGui = plr:WaitForChild("PlayerGui")

		print("------- [ GUI HIDE DEBUG START ] -------")

		-- Ищем CheatPanel в PlayerGui
		local cheatPanel = PlayerGui:FindFirstChild("CheatPanel")

		if cheatPanel then
			-- Скрываем панель
			cheatPanel.Enabled = false

			print("🙈 Disabled: CheatPanel")

			hideCheatBtn.Text = "✅ CheatPanel Hidden"
			hideCheatBtn.BackgroundColor3 = Color3.fromRGB(70, 45, 25)
		else
			warn("⚠ CheatPanel not found in PlayerGui")
			hideCheatBtn.Text = "⚠ Not found"
		end

		print("------- [  GUI HIDE DEBUG END  ] -------\n")

		task.wait(1.5)
		hideCheatBtn.Text = "Hide CheatPanel"
		hideCheatBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end)

	if not success then
		warn("CheatPanel hiding failed:", err)
		hideCheatBtn.Text = "⚠ Error!"
		task.wait(1.5)
		hideCheatBtn.Text = "Hide CheatPanel"
	end
end)

-- End Game functionality
endGameBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		local PlayerGui = plr:WaitForChild("PlayerGui")

		print("------- [ END GAME DEBUG START ] -------")

		-- Ищем EndCutscene в StarterGui
		local template = StarterGui:FindFirstChild("SetPointsCheat")
		if not template then
			warn("⚠ Not found in StarterGui: EndCutscene")
			endGameBtn.Text = "⚠ EndCutscene not found"
			task.wait(1.5)
			endGameBtn.Text = "Set Points [IN LOBBY!]"
			return
		end

		-- Проверяем, есть ли уже в PlayerGui
		local existing = PlayerGui:FindFirstChild("SetPointsCheat")

		if existing then
			-- Если уже есть, просто включаем
			existing.Enabled = true

			-- Показываем все GuiObject
			for _, v in ipairs(existing:GetDescendants()) do
				if v:IsA("GuiObject") then
					v.Visible = true
				end
			end

			print("🎬 Enabled: EndCutscene")
		else
			-- Клонируем из StarterGui в PlayerGui
			local clone = template:Clone()
			clone.Parent = PlayerGui
			clone.Enabled = true

			-- Показываем все GuiObject
			for _, v in ipairs(clone:GetDescendants()) do
				if v:IsA("GuiObject") then
					v.Visible = true
				end
			end

			print("🎬 Cloned & Enabled: SetPointsCheat")
		end

		print("📌 SetPointsCheat activated")
		print("------- [  END GAME DEBUG END  ] -------\n")

		endGameBtn.Text = "✅ SetPointsCheat opened"
		endGameBtn.BackgroundColor3 = Color3.fromRGB(70, 45, 25)
		task.wait(1.5)
		endGameBtn.Text = "Set Points [IN LOBBY!]"
		endGameBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end)

	if not success then
		warn("End Game failed:", err)
		endGameBtn.Text = "⚠ Error!"
		task.wait(1.5)
		endGameBtn.Text = "Set Points [IN LOBBY!]"
	end
end)
