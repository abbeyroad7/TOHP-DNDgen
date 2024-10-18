# Overview

I built these set of scripts and wordbanks as a means of curating my own generation tool. The various online ones offered very little customization and required me to keep a separate tab open in my browser so I set out to build one that solved these issues.

By uploading these tools, I'd like the Word Banks to grow with community-fed content, so DMs and players alike can have a repository to upload/generate ideas for homebrewed content.


--------------------------------------------------------------------------------------------------------------


# LootGen
A D&D Loot Generator with an emphasis on **"Theater of the Mind"** storytelling. Using AHK (Autohotkey) script, you can bind this utility to any hotkey of your choosing to overlay any Windows-based environment.

The script is built to randomly select a Prompt line from a loot table and swap out any present tag identifiers with a random line from a corresponding wordbank. Tag identifiers are read as {COLOR}, {RACE}, {BEAST} in the Table and can further add variety in the responses to yield a unique response every time the generator is run.

In addition, the script automatically copies generated text to your Clipboard for ease of use.

## ![Examples](https://github.com/abbeyroad7/TOHP-DNDgen/tree/main/Loot/.Screenshots)
{CONDITION} A tombstone  Reads 'Here lies {NAME}. Cause of death: {SUBJECT}'

![DeathByEveryone](https://github.com/abbeyroad7/TOHP-D-Dgen/blob/main/Loot/.Screenshots/DeathbyEveryone.png)

A quarter slice of {RACENAME} {cheese}

![AarokocraCheese](https://github.com/abbeyroad7/TOHP-DNDgen/blob/main/Loot/.Screenshots/AarokocraCheese.png)

{CONDITION} Flask of {RACE} beer  Tastes {FLAVOR}

![UrsineBeer](https://github.com/abbeyroad7/TOHP-D-Dgen/blob/main/Loot/.Screenshots/UrsineBeer.png)

An unlabeled {color} elixir. Smells of {spice}. {UP}{flavor} taste.	{effect}

![WildshapeElixir](https://github.com/abbeyroad7/TOHP-DNDgen/blob/main/Loot/.Screenshots/WildshapeElixir.png)

## Tags

Current tags include:
- {CONDITION} Generates different condition states for whatever the loot item is
- {NAME} Generates a random name across the available name tables
- {LOC} Generates a random country/city/town/province/landmark name from the World of Terra.
- {RACE} Generates a random Race description name. Example: Elvish, gnomish, dwarvish
- {RACENAME} Generates the base name of a random race. Example: Elf, gnome, dwarf
- {COLOR} Generates a random color and its associated Hex value
- {1d20} Various different dice rollers that can be used for quantities
- {BEAST} Generates a random name of a creature or monstrosity anywhere in the world
- {MAMMAL} Based on the global "Habitat" variable, a random mammal from that climate is selected
- {REPTILE}
- {BIRD}
- {AQUATIC}
- {INSECT}
- {FISH}
- {AMPHIBIAN}
- {MONSTROSITY}
- {MATERIAL} Generates a random material. Example: Gold, silver, steel
- {GEM} Generates a random gemstone. Example: Diamond, amber, ruby
- {FABRIC} Generates a random fabric. Example: Spidersilk, cotton, satin
- {PATTERN} Generates a random pattern. Example: Striped, checkered, dotted
- {NOUN} A random noun
- {ADJ} A random adjective
- {SUBJECT} Generates from {NAME}, {LOC}, {RACE}, {BEAST}
- {FLAVOR} Generates a descriptive word for food
- {CHEESE} Generates a random type of cheese
- {UP} Uppercases the next character in the sentence
- {CASE} Title case

--------------------------------------------------------------------------------------------------------------

# NameGen
Using a similar approach, the Name Generator is able to generate random names for 35 DND races currently, with plans to extend through to 72 official/homebrew races!

An InputBox will prompt you on which race you would like to prompt for. If you would like to specify gender, add a space followed by either "m" or "f". The generator will then output 3 names, which automatically copy to your Clipboard.

## Examples
Prompt: human m
1. Ljam Forrester
2. Josaeus Goodbrother
3. Domnac Furrs

Prompt: dwarf f
1. Gundra Ironale
2. Bronmora Lurdig
3. Rilda Broadick

# Installation
You will need a working install of Autohotkey which you can get [here](https://www.autohotkey.com/).

Download or clone the Github and launch either ".Loot.ahk" or ".Names.ahk".
