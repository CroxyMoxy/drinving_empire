local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local camera = workspace.CurrentCamera

local Auto_Farm_ATM = true
local Auto_Farm_Config = {
	["Teleport_Speed"] = 1,
}

local ATM_path = workspace.Game.Jobs.CriminalATMSpawners

local function CameraMove()
	local positionDeDepart = camera.CFrame.Position
	local nouveauPoint = Vector3.new(positionDeDepart.X, 0, positionDeDepart.Z)
	local distanceDeZoom = 20

	camera.CFrame = CFrame.new(nouveauPoint + Vector3.new(0, distanceDeZoom, 0), nouveauPoint)
end


local function FarmATM()

	local targetATM = function()
		local ATMs = ATM_path:GetChildren()
		if #ATMs == 0 then 
			print("No ATMs") 
			return nil
		end

		for _, v in ipairs(ATMs) do
			if v:IsA("Part") and v:FindFirstChild("CriminalATM") then
				if v.CriminalATM:GetAttribute("State") == "Normal" then
					return v
				end
			end
		end
		return nil
	end

	local atm = targetATM()

	if not atm then 
		humanoidRootPart.CFrame = CFrame.new(Vector3.new(-2542.31591796875, 16, 4030.148681640625))

		wait(1)

		humanoidRootPart.CFrame = CFrame.new(Vector3.new(-2522.47705078125, 50, 4016.7724609375))
		return 
	end

	local Teleportation = TweenService:Create(
		humanoidRootPart,
		TweenInfo.new(Auto_Farm_Config.Teleport_Speed, Enum.EasingStyle.Linear),
		{ CFrame = atm.CFrame + Vector3.new(0, 1, 0)}
	)
	Teleportation:Play()
	wait(Auto_Farm_Config.Teleport_Speed + 0.5)

	CameraMove()


	local ProximityPrompt = atm.CriminalATM.ATM.PromptAttachment.ProximityPrompt

	wait(0.5)

	ProximityPrompt:InputHoldBegin()
	wait(6)
	ProximityPrompt:InputHoldEnd()

	wait(1)
end


while true do
	for i = 1, 5 do
		FarmATM()
		wait(1)
	end
end
