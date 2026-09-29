--[[
    Dex: Eclipse
    Version 1.0

    Developed by Riley

    Dex: Eclipse is a revival of Moon's Dex
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local selection = {}
local nodes = {}

local cloneref = cloneref or function(instance)
    return instance
end

local function safeCloneRef(instance)
    if not instance then
        return nil
    end

    local success, result = pcall(cloneref, instance)

    if success and result then
        return result
    end

    return instance
end

local game = safeCloneRef(game)
local workspace = safeCloneRef(workspace)

local Services = {
    Players = safeCloneRef(Players),
    RunService = safeCloneRef(RunService),
    UserInputService = safeCloneRef(UserInputService),
    Workspace = workspace
}

local function getService(name)
    local service = Services[name]

    if service then
        return service
    end

    local success, result = pcall(function()
        return game:GetService(name)
    end)

    if success then
        result = safeCloneRef(result)
        Services[name] = result
        return result
    end

    return nil
end

local function safeCall(callback, ...)
    if type(callback) ~= "function" then
        return false, nil
    end

    return pcall(callback, ...)
end

local function addNode(instance)
    if not instance then
        return
    end

    nodes[instance] = true
end

local function removeNode(instance)
    if not instance then
        return
    end

    nodes[instance] = nil
end

local function clearNodes()
    table.clear(nodes)
end

local function addSelection(instance)
    if not instance then
        return
    end

    if not table.find(selection, instance) then
        table.insert(selection, instance)
    end
end

local function removeSelection(instance)
    local index = table.find(selection, instance)

    if index then
        table.remove(selection, index)
    end
end

local function clearSelection()
    table.clear(selection)
end

local function getSelection()
    return selection
end

local function isValidInstance(instance)
    return typeof(instance) == "Instance"
        and instance.Parent ~= nil
end

local function destroy()
    clearSelection()
    clearNodes()

    table.clear(Services)
end

return {
    Game = game,
    Workspace = workspace,
    LocalPlayer = LocalPlayer,

    Services = Services,
    GetService = getService,

    Selection = selection,
    Nodes = nodes,

    AddSelection = addSelection,
    RemoveSelection = removeSelection,
    ClearSelection = clearSelection,
    GetSelection = getSelection,

    AddNode = addNode,
    RemoveNode = removeNode,
    ClearNodes = clearNodes,

    IsValidInstance = isValidInstance,
    SafeCall = safeCall,
    SafeCloneRef = safeCloneRef,

    Destroy = destroy
}
