# 🛡️ SpecCheck WeakAura

A custom WeakAura script for **World of Warcraft** that helps players avoid costly mistakes during ready checks.  
When a ready check is initiated, this WeakAura **greys out the ready button** to prevent mindless clicking, and **displays your current talent build** in the ready check box — making it easy to double-check you're using the right spec before starting difficult content like Mythic+ dungeons or raids.

## 📷 Demo

![Demo](demo.gif)  

## 🎯 Why I Built This

In high-level content, forgetting to swap talent builds or specializations can easily ruin a pull.  
I made this WeakAura for my guild after noticing many players (including myself) would habitually click "Ready" without confirming if they had the correct talents active.

This simple reminder saves wipes, frustration, and most importantly; repair bills. 😅


## 🔎 Features

- **Greyed-Out Ready Button**  
  Prevents accidental "Ready" clicks during ready checks. Becomes active after using holds down ctrl for 1 second.

- **Build Name Broadcast**  
  Automatically displays your current talent loadout name in your ready check frame.

- **Change Talents Button**
  Provides a button to change talents in the ready check box so the player doesn't have to open it themselves.

- **Lightweight & Non-Intrusive**  
  Zero performance impact. Only activates during ready checks. Only loads once on startup.

- **Customizable**  
  Easy to modify if you want to tweak the message or style.

## 👨‍💻 Code Overview

The Lua script listens for a ready check event and:
- Disables the ready button visually.
- Retrieves the player's active talent loadout name.
- Prints a custom message with the build name in the ready check box.
- Creates a button for players to change talents.

## 📦 Requirements

- World of Warcraft (Retail version tested)
- WeakAuras 2 Addon installed

## 🛠️ How to Install

1. **Open WeakAuras** in World of Warcraft (`/wa` command).
2. **Import Aura** Import from this link here: [SpecCheck Weakaura](https://wago.io/eD5sDN_g9) by copying the import string.
3. **Relog** and it will now load everytime you log in. That's it!

## 📬 Contact
Mikail Deveden
[Github](https://github.com/MikailMichael)
[LinkedIn](https://www.linkedin.com/in/mikail-deveden/)