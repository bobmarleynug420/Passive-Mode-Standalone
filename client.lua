local passive = false

local function notify(msg)
    if Config.Notify == 'okok' then
        exports['okokNotify']:Alert('Passive Mode', msg, 4000, 'info')
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 215, 0},
            args = {'Passive Mode', msg}
        })
    end
end

RegisterNetEvent('lrp_passive:notify', function(msg)
    notify(msg)
end)

RegisterNetEvent('lrp_passive:setPassive', function(state)
    passive = state

    local ped = PlayerPedId()

    if passive then
        SetPlayerCanDoDriveBy(PlayerId(), false)
        SetPedCanRagdoll(ped, not Config.DisableRagdoll)

        if Config.MakePedSemiTransparent then
            SetEntityAlpha(ped, Config.PassiveAlpha, false)
        end

        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    else
        ResetEntityAlpha(ped)
        SetPlayerInvincible(PlayerId(), false)
        SetEntityInvincible(ped, false)
        SetPedCanRagdoll(ped, true)
        SetPlayerCanDoDriveBy(PlayerId(), true)
    end
end)

CreateThread(function()
    while true do
        if passive then
            local ped = PlayerPedId()
            local player = PlayerId()

            if Config.BlockWhenDead and IsEntityDead(ped) then
                passive = false
                ResetEntityAlpha(ped)
                SetPlayerInvincible(player, false)
                SetEntityInvincible(ped, false)
                TriggerServerEvent('lrp_passive:disableFromClient')
                Wait(1000)
            elseif Config.DisableOnEnterVehicle and IsPedInAnyVehicle(ped, false) then
                passive = false
                ResetEntityAlpha(ped)
                SetPlayerInvincible(player, false)
                SetEntityInvincible(ped, false)
                TriggerServerEvent('lrp_passive:disableFromClient')
                Wait(1000)
            else
                if Config.DisablePlayerDamage then
                    SetPlayerInvincible(player, true)
                    SetEntityInvincible(ped, true)
                end

                if Config.ClearWantedLevel then
                    ClearPlayerWantedLevel(player)
                    SetMaxWantedLevel(0)
                end

                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                DisablePlayerFiring(player, true)

                if Config.DisableGunFire then
                    DisableControlAction(0, 24, true)
                    DisableControlAction(0, 25, true)
                    DisableControlAction(0, 68, true)
                    DisableControlAction(0, 69, true)
                    DisableControlAction(0, 70, true)
                    DisableControlAction(0, 91, true)
                    DisableControlAction(0, 92, true)
                    DisableControlAction(0, 114, true)
                    DisableControlAction(0, 257, true)
                    DisableControlAction(0, 263, true)
                    DisableControlAction(0, 264, true)
                end

                if Config.DisableMelee then
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 141, true)
                    DisableControlAction(0, 142, true)
                    DisableControlAction(0, 143, true)
                end

                if Config.DisableVehicleWeaponFire then
                    DisableControlAction(0, 69, true)
                    DisableControlAction(0, 70, true)
                    DisableControlAction(0, 92, true)
                    DisableControlAction(0, 114, true)
                end
            end

            Wait(0)
        else
            Wait(500)
        end
    end
end)