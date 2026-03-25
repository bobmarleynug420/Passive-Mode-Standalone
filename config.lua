Config = {}

-- Command players/admins use
Config.Command = 'passive'

-- Permission system
Config.UsePermissions = true
Config.AcePermission = 'lrp.passivemode'

-- Notification system:
-- 'chat' = default chat messages
-- 'okok' = okokNotify
Config.Notify = 'okok'

-- Passive mode behavior
Config.DisablePlayerDamage = true
Config.DisableMelee = true
Config.DisableGunFire = true
Config.DisableVehicleWeaponFire = true
Config.ClearWantedLevel = true
Config.MakePedSemiTransparent = true
Config.PassiveAlpha = 180 -- 0 to 255

-- Optional: block ragdoll while passive
Config.DisableRagdoll = true

-- Optional: prevent passive mode while dead
Config.BlockWhenDead = true

-- Optional: disable passive automatically when entering a vehicle
Config.DisableOnEnterVehicle = false

-- Cooldown after disabling passive mode
Config.CooldownSeconds = 300 -- 5 minutes