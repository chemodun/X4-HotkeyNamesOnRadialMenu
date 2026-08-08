# Hotkey Names on Radial Menu

An add-on for X4: Foundations that makes hotkeys registered through the *Native Hotkey API* show their real names on the radial (compass) menu, instead of the internal `(Debug)A` style placeholders.

## Overview

X4's `INPUT_ACTION_*` list is compiled into the game and cannot be extended, so the *Native Hotkey API* hands out otherwise-unused debug action slots to the mods that register with it. Every part of the game that names a control by looking it up in the game's own text database therefore shows those slots under their built-in placeholder names - `(Debug)A`, `(Debug)F12` and so on.

The radial menu is the one place where this is visible in normal play. Assign a mod hotkey to a radial menu position and the wheel labels it `(Debug)A`, with no clue which action it actually triggers.

This mod fixes that one label. The wheel is drawn by `ui/core/lua/compass.lua`, which runs in the game's isolated core UI environment - it can reach neither the *Native Hotkey API*'s registry nor any other mod's Lua. This add-on substitutes that file and gives it a channel to ask, so each radial position shows the name the registering mod actually chose.

Nothing else changes: the key shown next to the name, which positions are filled, and what pressing one does are all untouched. Positions holding vanilla controls are untouched too, and any slot with no hotkey registered on it keeps its original label.

There is nothing to configure. Install it and the radial menu starts using real names.

## Requirements

- **X4: Foundations**: Version **8.00** or higher (the 8.00 build of this mod) or **9.00** or higher (the 9.00 build).
- **Native Hotkey API**: Version **8.00.09** or higher by [Chem O`Dun](https://next.nexusmods.com/profile/chemodun?gameId=2659).
  - Available on Steam Workshop: [Native Hotkey API](https://steamcommunity.com/sharedfiles/filedetails/?id=3750545906)
  - Available on Nexus Mods: [Native Hotkey API](https://www.nexusmods.com/x4foundations/mods/2181)
- **Print Extension List**: Version **1.01** or higher by [Chem O`Dun](https://next.nexusmods.com/profile/chemodun?gameId=2659).
  - Available on Nexus Mods: [Print Extension List](https://www.nexusmods.com/x4foundations/mods/2172)

## Installation

Extract the archive into your X4: Foundations `extensions` folder, keeping the folder name.

Pick the build matching your game version - the 8.00 and 9.00 builds contain different copies of the game file they replace and are not interchangeable.

## How to use it

- Register a hotkey as usual - any mod built on the *Native Hotkey API* already does this for you.
- Open **Settings > Controls**, find the hotkey, and use the radial menu drop-down at the end of its row to assign it to a position on one of the two wheels.
- Open that wheel in flight. The position now carries the hotkey's own name.

Names are re-read whenever the set of registered hotkeys changes, so installing, removing or disabling a hotkey mod is reflected the next time the wheel is opened.

## Limitations

- This mod replaces the whole of `ui/core/lua/compass.lua`, because the game offers no way to extend a core UI script. **It is incompatible with any other mod that replaces the same file.**
- Because it is a full copy of a game file, it has to be rebuilt against each new game version. A version it was not built for may break the radial menu until this mod is updated.
- Only the radial menu is affected. Anywhere else the game names these slots from its own text database still shows the built-in placeholder.

## Credits

- [Chem O`Dun](https://next.nexusmods.com/profile/chemodun?gameId=2659) - author.

## Changelog

### [9.00.01] / [8.00.01] - 2026-08-08

- **Added**
  - Initial release. Hotkeys registered through the *Native Hotkey API* show their registered names on the radial menu instead of the built-in `(Debug)` placeholders.
