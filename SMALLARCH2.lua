local canceltp = false 

function tp(x, y, z, speed)
    local targetPosition = Vector3.new(x, y, z)
    local speed = speed
    local maxForce = Vector3.new(math.huge, math.huge, math.huge)
    local player = game.Players.LocalPlayer
    local character = player.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if not hrp then
        return
    end

    local velocity = Instance.new("BodyVelocity")
    velocity.MaxForce = maxForce
    velocity.Velocity = Vector3.new(0, 0, 0)
    velocity.Parent = hrp

    while true and velocity.Parent do
        if canceltp then
            canceltp = false
            velocity:Destroy()
            break
        end
        
        local currentPos = hrp.Position
        local direction = (targetPosition - currentPos).unit
        local distance = (targetPosition - currentPos).magnitude
        local distanceCheck = speed / 20
        
        if distance >= distanceCheck then
            velocity.Velocity = direction * speed
        else
            velocity:Destroy()
            
            for i = 1, 20 do
                if hrp and hrp.Parent then
                    hrp.CFrame = CFrame.new(targetPosition)
                    hrp.Velocity = Vector3.new(0, 0, 0)
                end
                task.wait()
            end
            break
        end
        wait()
    end
end


--Variables
local TPFastMode = false
local setuploops = 10
local goupspeed = 1200
local gountilspeed = 1200
local godownspeed = 1200

function aboveplayer(player, ignorecrim)
    ignorecrim = ignorecrim or true
    local character = player.Character
    local lp = game.Players.LocalPlayer.Character
    
    if character ~= nil and lp ~= nil then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            local filterInstances = {lp, character}
            local ignoreFolder = workspace:FindFirstChild("Ignore")
            if ignoreFolder then table.insert(filterInstances, ignoreFolder) end
            local vehiclesFolder = workspace:FindFirstChild("Vehicles")
            if vehiclesFolder then table.insert(filterInstances, vehiclesFolder) end
            local prisonItems = workspace:FindFirstChild("Prison") and workspace.Prison:FindFirstChild("Items")
            if prisonItems and prisonItems:FindFirstChild("ProhibitedAreas") then
                table.insert(filterInstances, prisonItems.ProhibitedAreas)
            end
            if ignorecrim then
                local crimBase = workspace:FindFirstChild("CriminalBase")
                if crimBase and crimBase:FindFirstChild("Shields") then
                    table.insert(filterInstances, crimBase.Shields)
                end
            end
            raycastParams.FilterDescendantsInstances = filterInstances
            local raycastResult = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, 1000, 0), raycastParams)
            if raycastResult then return true else return false end
        end
    end
    return false
end

function InstaTeleport(x, y, z, roofcheck, overridespeedup, overridespeeduntil, overridespeeddown, overrideloops, ignorenotify)
    roofcheck = roofcheck or false
    local LPRootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not LPRootPart then return end

    ignorenotify = ignorenotify or false
    if roofcheck and aboveplayer(game.Players.LocalPlayer, true) then
        if not ignorenotify then
            local AeroUtil = require(game:GetService("ReplicatedStorage").Aero.Shared.Util)
            if AeroUtil and AeroUtil.HeistDisplays then
                local message = "<font color='#FF008F'>Ignore me</font>"
                local autoHide = 3
                AeroUtil.HeistDisplays:ShowHeistInstruction(message, autoHide, math.random(1000,9999))
            end
        end
        canceltp = true
        repeat task.wait() until not LPRootPart.Parent -- blockiert das Script solange der TP abgebrochen wird
        return
    end

    if overridespeedup then
        tp(LPRootPart.CFrame.X, 1000, LPRootPart.CFrame.Z, overridespeedup, overrideloops)
        tp(x, 1000, z, overridespeeduntil, overrideloops)
        tp(x, y, z, overridespeeddown, overrideloops)
    else
        if TPFastMode then
            tp(LPRootPart.CFrame.X, 1000, LPRootPart.CFrame.Z, 1000000, setuploops)
            tp(x, 1000, z, 1000000, setuploops)
            tp(x, y, z, 1000000, setuploops)
        else
            tp(LPRootPart.CFrame.X, 1000, LPRootPart.CFrame.Z, goupspeed, setuploops)
            tp(x, 1000, z, gountilspeed, setuploops)
            tp(x, y, z, godownspeed, setuploops)
        end
    end
end

local cache = {}

for _, v in next, getgc(true) do
    if type(v) == "function" then
        for _, u in next, debug.getupvalues(v) do
            if type(u) == "table" and rawget(u, "ID") and typeof(u.Seconds) == "number" then
                table.insert(cache, v)
                break
            end
        end
    end
end

local vim = game:GetService("VirtualInputManager")

local function Click(key)
    vim:SendKeyEvent(true, key, false, game)
    task.wait()
    vim:SendKeyEvent(false, key, false, game)
end

task.spawn(function()
    while true do
        for _, func in next, cache do
            for _, u in next, debug.getupvalues(func) do
                if type(u) == "table" and rawget(u, "ID") and typeof(u.Seconds) == "number" then
                    u.Seconds = 1e-30
                end
            end
        end
        Click(Enum.KeyCode.E)
        task.wait(0.005)
    end
end)


--Settings
local slideSpeed = 9000000 
local waitTime = 0   


InstaTeleport(580, 117, 2086, true)


local coordinates_path0 = {
    Vector3.new(606, 117, 2146),
    Vector3.new(614, 117, 2174)
}


for i, pos in ipairs(coordinates_path0) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end


--Airport
local coordinates_path1 = {
    Vector3.new(642, 117, 2149),
    Vector3.new(693, 117, 2124),
    Vector3.new(727, 120, 2136),
    Vector3.new(754, 123, 2122),
    Vector3.new(839, 118, 2136),
    Vector3.new(893, 117, 2120),
    Vector3.new(830, 121, 2190),
    Vector3.new(791, 121, 2186),
    Vector3.new(771, 117, 2145),
    Vector3.new(768, 121, 2193),
    Vector3.new(713, 117, 2177),
    Vector3.new(702, 121, 2240),
    Vector3.new(664, 121, 2248),
    Vector3.new(643, 121, 2259),
    Vector3.new(566, 117, 2248),
    Vector3.new(504, 117, 2284),
    Vector3.new(494, 118, 2342),
    Vector3.new(475, 121, 2347),
    Vector3.new(453, 117, 2324),
    Vector3.new(412, 117, 2331),
    Vector3.new(399, 117, 2339),
    Vector3.new(397, 117, 2334),
    Vector3.new(402, 117, 2323),
    Vector3.new(446, 117, 2330),
    Vector3.new(492, 117, 2293),
    Vector3.new(474, 117, 2248),
    Vector3.new(531, 117, 2211),
    Vector3.new(572, 117, 2208),
    Vector3.new(583, 117, 2185),
    Vector3.new(615, 117, 2173),
    Vector3.new(579, 117, 2101),
    Vector3.new(544, 117, 2112)
}


for i, pos in ipairs(coordinates_path1) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end

--Shop 1
InstaTeleport(346, 25, 959, true)


local coordinates_path2 = {
    Vector3.new(363, 28, 1012),
    Vector3.new(377, 28, 1016),
    Vector3.new(372, 28, 1033),
    Vector3.new(356, 28, 1029),
    Vector3.new(339, 25, 974)
}


for i, pos in ipairs(coordinates_path2) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end

--Gasoline 1
InstaTeleport(-1497, 33, 1169, true)



local coordinates_path3 = {
    Vector3.new(-1526, 33, 1190),
    Vector3.new(-1524, 33, 1209),
    Vector3.new(-1547, 33, 1215),
    Vector3.new(-1557, 33, 1217),
    Vector3.new(-1568, 33, 1219),
    Vector3.new(-1551, 33, 1218),
    Vector3.new(-1525, 33, 1201),
    Vector3.new(-1529, 33, 1180),
    Vector3.new(-1486, 33, 1171)
}


for i, pos in ipairs(coordinates_path3) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end

--GunStore 2
InstaTeleport(-1786, 42, 1152, true)


local coordinates_path4 = {
    Vector3.new(-1815, 40, 1137),
    Vector3.new(-1840, 40, 1146),
    Vector3.new(-1843, 40, 1131),
    Vector3.new(-1861, 40, 1130),
    Vector3.new(-1833, 44, 1126),
    Vector3.new(-1804, 40, 1149),
    Vector3.new(-1775, 44, 1166)
}


for i, pos in ipairs(coordinates_path4) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end

--AppleStore
InstaTeleport(1338, 26, 789, true)


local coordinates_path5 = {
    Vector3.new(1344, 26, 784),
    Vector3.new(1356, 28, 746),
    Vector3.new(1375, 28, 749),
    Vector3.new(1388, 28, 731),
    Vector3.new(1411, 28, 787),
    Vector3.new(1389, 28, 784),
    Vector3.new(1373, 28, 790),
    Vector3.new(1391, 32, 825),
    Vector3.new(1404, 41, 816),
    Vector3.new(1428, 53, 805),
    Vector3.new(1431, 53, 799),
    Vector3.new(1418, 56, 790),
    Vector3.new(1393, 56, 781),
    Vector3.new(1379, 56, 745),
    Vector3.new(1391, 56, 728),
    Vector3.new(1365, 41, 713),
    Vector3.new(1332, 26, 726),
    Vector3.new(1346, 26, 785),
    Vector3.new(1322, 25, 797)
}


for i, pos in ipairs(coordinates_path5) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end

--Shop 2
InstaTeleport(899, 26, 904, true)


local coordinates_path6 = {
    Vector3.new(890, 26, 927),
    Vector3.new(902, 26, 957),
    Vector3.new(909, 26, 972),
    Vector3.new(901, 26, 975),
    Vector3.new(893, 26, 978),
    Vector3.new(881, 26, 950),
    Vector3.new(880, 26, 931),
    Vector3.new(901, 26, 907)
}


for i, pos in ipairs(coordinates_path6) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end

--Shop 3
InstaTeleport(891, 25, 841, true)


local coordinates_path7 = {
    Vector3.new(860, 26, 854),
    Vector3.new(843, 26, 860),
    Vector3.new(833, 26, 864),
    Vector3.new(843, 26, 860),
    Vector3.new(860, 26, 854),
    Vector3.new(891, 25, 841),
    Vector3.new(924, 25, 839)
}


for i, pos in ipairs(coordinates_path7) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end

--Casino
InstaTeleport(1701, 30, 942, true)


local coordinates_path8 = {
    Vector3.new(1702, 38, 835),
    Vector3.new(1707, 38, 782),
    Vector3.new(1713, 38, 737),
    Vector3.new(1686, 37, 719),
    Vector3.new(1640, 38, 635),
    Vector3.new(1604, 38, 603),
    Vector3.new(1613, 38, 581),
    Vector3.new(1615, 38, 559), --first coinbucket
    Vector3.new(1615, 38, 558), --Second CoinBucket & Money Pile
    Vector3.new(1607, 38, 529),
    Vector3.new(1599, 38, 495), --Money pile
    Vector3.new(1567, 38, 488),
    Vector3.new(1545, 38, 513),
    Vector3.new(1535, 38, 528), --Third Coinbucket
    Vector3.new(1514, 38, 544),
    Vector3.new(1524, 38, 564), --Money Pile
    Vector3.new(1514, 38, 544),
    Vector3.new(1535, 38, 528),
    Vector3.new(1572, 38, 537),
    Vector3.new(1620, 38, 542),
    Vector3.new(1640, 38, 568),
    Vector3.new(1680, 31, 559),
    Vector3.new(1741, 26, 539),
    Vector3.new(1759, 26, 557),
    Vector3.new(1774, 26, 573),
    Vector3.new(1751, 31, 600),
    Vector3.new(1713, 32, 703),
    Vector3.new(1697, 38, 794),
    Vector3.new(1705, 38, 839),
    Vector3.new(1701, 26, 928)
}


for i, pos in ipairs(coordinates_path8) do
    tp(pos.X, pos.Y, pos.Z, slideSpeed)
    task.wait(waitTime) 
end
