local passiveStates = {}
local passiveCooldowns = {}

local function notify(src, msg)
    TriggerClientEvent('lrp_passive:notify', src, msg)
end

local function hasPermission(src)
    if not Config.UsePermissions then
        return true
    end

    return IsPlayerAceAllowed(src, Config.AcePermission)
end

local function getRemainingCooldown(src)
    local expires = passiveCooldowns[src]
    if not expires then return 0 end

    local now = os.time()
    local remaining = expires - now

    if remaining <= 0 then
        passiveCooldowns[src] = nil
        return 0
    end

    return remaining
end

local function formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60

    if minutes > 0 then
        return string.format("%d minute(s) and %d second(s)", minutes, secs)
    end

    return string.format("%d second(s)", secs)
end

local function togglePassive(src)
    if not hasPermission(src) then
        notify(src, 'You do not have permission to use passive mode.')
        return
    end

    local currentlyPassive = passiveStates[src] == true

    if not currentlyPassive then
        local remaining = getRemainingCooldown(src)
        if remaining > 0 then
            notify(src, ('You must wait %s before using passive mode again.'):format(formatTime(remaining)))
            return
        end

        passiveStates[src] = true
        TriggerClientEvent('lrp_passive:setPassive', src, true)
        notify(src, 'Passive mode enabled.')
    else
        passiveStates[src] = false
        passiveCooldowns[src] = os.time() + Config.CooldownSeconds
        TriggerClientEvent('lrp_passive:setPassive', src, false)
        notify(src, ('Passive mode disabled. You cannot use it again for %d minute(s).'):format(math.floor(Config.CooldownSeconds / 60)))
    end
end

RegisterCommand(Config.Command, function(source)
    if source == 0 then
        print('[lrp_passive] This command can only be used in-game.')
        return
    end

    togglePassive(source)
end, false)

RegisterNetEvent('lrp_passive:requestToggle', function()
    local src = source
    togglePassive(src)
end)

RegisterNetEvent('lrp_passive:disableFromClient', function()
    local src = source

    if passiveStates[src] then
        passiveStates[src] = false
        passiveCooldowns[src] = os.time() + Config.CooldownSeconds
        TriggerClientEvent('lrp_passive:setPassive', src, false)
        notify(src, ('Passive mode disabled. You cannot use it again for %d minute(s).'):format(math.floor(Config.CooldownSeconds / 60)))
    end
end)

AddEventHandler('playerDropped', function()
    passiveStates[source] = nil
    passiveCooldowns[source] = nil
end)