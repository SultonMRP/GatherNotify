# GatherNotify

Notifies you when Mining, Herbalism, or Skinning unlocks a new node or creature level. Adds the required skill (and your current skill, if you are short) to herb, ore, and skinnable-corpse tooltips, and improves `Requires Mining 150`-style errors.

**Backported to WotLK 3.3.5a. Added TipTac compatibility.**

## Install

Copy the `GatherNotify` folder to `Interface\AddOns` and `/reload`.

## Commands

| Command | Effect |
| --- | --- |
| `/gn` | Help |
| `/gn mining` | Highest node you can mine |
| `/gn herbalism` | Highest herb you can pick |
| `/gn skinning` | Highest creature level you can skin |
| `/gn version` | Addon version |

`/gnotify` and `/gathernotify` work the same.

## TipTac

Load after TipTac (`OptionalDeps: TipTac`). Unit-tooltip skill text is applied after TipTac rebuilds the tip.

If herb and ore tooltips never appear, turn **off Hide World Tips** in TipTac. That option hides world-object tooltips, so there is nothing for GatherNotify to annotate.

## Notes

- English client skill-up and node names
- Gathering cap 450 (WotLK)
