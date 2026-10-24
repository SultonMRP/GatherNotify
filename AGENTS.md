# GatherNotify

WotLK 3.3.5a backport of Foxthorn's GatherNotify. Shows required Mining / Herbalism / Skinning skill on tooltips, improves `Requires` errors, and announces new gather unlocks on skill-up.

## Client

- Target: WoW 3.3.5a only (`## Interface: 30300`)
- Lua 5.1. No `C_Timer`, no retail profession APIs
- Skills come from `GetNumSkillLines` / `GetSkillLineInfo`
- Skill-up text and node names are English

## Rules

- Do not add Cataclysm or later nodes (Obsidium, Elementium, Cinderbloom, etc.)
- Keep Classic names: Wintersbite, Plaguebloom
- Mining / herbalism required skills should match 3.3.5a wotlkdb values
- Skinning uses the WotLK curve (skull mobs are `UnitLevel` -1; parse the tooltip level or use the formula)
- Live Beast/Dragonkin that you can attack get an estimate line (`Est. Skinning 360`), not a guaranteed skin. Skip players, player-controlled units, and `minus`/`trivial` critters
- Confirmed `Skinnable` + exact requirement stays on corpses only
- Never create a cursor-anchored fallback tooltip. TipTac `hideWorldTips` hides world tips; a custom `ANCHOR_CURSOR` tip gets stuck
- Hook GameTooltip on `PLAYER_LOGIN` so TipTac (hooks on `VARIABLES_LOADED`) rewrites unit tips first
- Only edit `GameTooltip` while it is shown. Re-apply after `GameTooltip:Show()` because TipTac calls `Show()` after rebuilding unit tips
- Treat TipTac (`Interface/AddOns/TipTac`) as read-only. Do not edit it for GatherNotify fixes
- Keep slash commands: `/gn`, `/gnotify`, `/gathernotify` (`skinning` / `mining` / `herbalism` / `version`)
