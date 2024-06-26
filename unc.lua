local RunService = game:GetService("RunService")

local opairs = pairs;

pairs = function(t)
    return opairs(t or {})
end

local fti = {}

RunService.Heartbeat:Connect(function()
    for part, data in pairs(fti) do
        if data["Skip"] then
            continue
        end

        part.CanCollide = false
        part.Size = Vector3.one * 0.1
        part.CFrame = data["Part"].CFrame
        part.Transparency = 1
    end
end)

firetouchinterest = function(part, part2, state)
    if part:IsA("TouchInterest") then
        part = part.Parent
    end

    if state == 0 then
        fti[part] = {
            ["CFrame"] = part.CFrame,
            ["Size"] = part.Size,
            ["CanCollide"] = part.CanCollide,
            ["Transparency"] = part.Transparency,
            ["Part"] = part2
        }
    elseif fti[part] then
        fti[part]["Skip"] = true;

        
        part.Transparency = fti[part].Transparency
        part.Size = fti[part].Size
        part.CanCollide = fti[part].CanCollide
        part.CFrame = fti[part].CFrame

        fti[part] = nil;
    end

    task.wait();
end
