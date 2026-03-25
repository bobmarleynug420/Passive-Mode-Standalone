# 🛡️ LRP Passive Mode

A standalone Passive Mode system for FiveM with built-in cooldowns and anti-abuse protections.  
Designed to work with ESX, QBCore, or standalone servers.

---

## 📌 Features

- ACE permission system (lrp.passivemode)
- /passive command toggle
- 5-minute cooldown after disabling
- Full invincibility protection
- Disables shooting, melee, and drive-bys
- Optional transparency effect
- Clears and blocks wanted level
- Anti-abuse protections (death / vehicle checks)
- Notification support (chat or okokNotify)
- Framework independent

---

## 📦 Installation

1. Place the folder into:
resources/[standalone]/lrp_passive

2. Add to server.cfg:
ensure lrp_passive

3. Add permission:
add_ace group.admin "lrp.passivemode" allow

(Optional)
add_principal identifier.discord:YOURDISCORDID group.admin

---

### Permissions
The resource includes an optional ACE permission system.

In `config.lua`:

Config.UsePermissions = true
Config.AcePermission = 'lrp.passivemode'

---

## 🎮 Usage

/passive

- Enables passive mode
- Run again to disable
- After disabling → 5-minute cooldown

---

## ⏱️ Cooldown System

- Players cannot re-enable passive until cooldown ends
- Cooldown triggers when:
  - Passive is manually turned off
  - Passive is force-disabled (death, etc.)

---

## ⚙️ Configuration

Edit config.lua:

Config.Command = 'passive'
Config.CooldownSeconds = 300
Config.Notify = 'chat'

---

## 🔔 Notifications

- chat (default)
- okokNotify

Set:
Config.Notify = 'okok'

---

## ⚠️ Notes

- Fully standalone
- Safe for any server

---

## 🛠️ Troubleshooting

Command not working?
- Check ACE permissions
- Ensure resource is started

Players still taking damage?
- Another script may be overriding invincibility

---

## ❤️ Credits

Created for FiveM servers needing a clean passive system.
