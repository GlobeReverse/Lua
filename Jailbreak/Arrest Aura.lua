--[[
  [-] - First time really checking out jailbreak, looking to make more misc things like this soon maybe a auto farm
]]

--// Services
local Players: Players = game:GetService("Players");
local RunService: RunService = game:GetService("RunService");

--// Variables
local client: Player = Players.LocalPlayer;

local converstion: { [string]: string } = {
    ["EnterVehicle"] = ("q" .. "" .. ("m1dpq1mw"):sub(2, 4):reverse():reverse():reverse() .. "" .. "" .. ("cv0z8hd4"):sub(5, 6):reverse():reverse():reverse() .. "" .. "fy"),
    ["ArrestPlayer"] = ("s" .. "" .. ("hfenz"):sub(4, 4):reverse() .. "" .. "" .. ("lp3idhr5"):sub(2, 4):reverse() .. "" .. "" .. ("frpwfhd"):sub(3, 3):reverse() .. "" .. "" .. ("h3k"):sub(2, 2):reverse() .. "" .. "b")
}

--// Garbage Collector
for _, value: any in pairs(getgc(true)) do 
    if (typeof(value) == "table") then 
        local fireServer: any = rawget(value, "FireServer");

        if fireServer then 
            fireTable = value;
        end
    end
end

--// Functions
local function arrestPlayer(player: Player): ()
    print("Arrested", player.Name);

    fireTable:FireServer(converstion.ArrestPlayer, player.Name);
end

local function canArrest(player: Player): boolean
    if (player.Team.Name == "Criminal") then return true end;
    if (player.Team.Name == "Police") then return false end;

    return (#player.Folder:GetChildren() ~= 0);
end

local function closetPlayer(max: number): Player
    local target; 
    local maxDistance = max;

    for _, player in pairs(Players:GetPlayers()) do 
        if (player == client) then continue end;
        if (not player.Character) or (not player.Character:FindFirstChild("HumanoidRootPart")) then continue end;
        if (not canArrest(player)) then continue end; 

        local distance: number = client:DistanceFromCharacter(player.Character.HumanoidRootPart.Position);

        if (distance < maxDistance) then 
            target = player;
            maxDistance = distance;
        end
    end

    return target;
end

--// Handling
RunService.RenderStepped:Connect(function(): ()
    local target = closetPlayer(20);

    if target then 
        arrestPlayer(target);
    end
end)
