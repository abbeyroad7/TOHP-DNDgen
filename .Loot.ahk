;v2.7.0
;# Restructure
;Rewrite code to loop through tags
;# Bugs
;If category prompt is entered, it does not exit the mode correctly
;# Todo
;Tag identifiers to signal qty, FRUIT.3
;Animal mixer
;A hyperlink tag
;A hover GUI to show original bank
;A true dice roller, grab digits from pattern
;Banks: food, food ingredients, religions
;Items, 5e.tools
;Weapons, seperate from general db, prompt-only
;Combine names and loot.ahk
;edit nouns for loot, queue\nouns1
;Fill out race names db
;Natural language syntax, for words ending in s, a/an, etc.
;GUI input
;GUI to regen certain aspects
;Loop tags
;Icons, export snapshot to clipboard
;combining icon+color+material as an overlay in GUI, experiment w/ transparency masks
;Foundry importer
Debug = 0	;1=off
Level = 4	;Specify player's current level
Habitat = Temperate	;Specify your world's habitat
;Import
{	;collapse import
#Requires AutoHotkey v1.1+
#SingleInstance Force
Vars:
Dir = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Loot
NamesDir = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names

If Debug = 0
	{
		Loop, Read, %Dir%\0_Test.txt	;testing purposes
			0_Lines = %A_Index%
	}
Loop, Read, %Dir%\Banks\.Colors.ini
   C_Lines = %A_Index%
Loop, Read, %Dir%\1_Mundane.txt
   1_Lines = %A_Index%
Loop, Read, %Dir%\2_Common.txt
   2_Lines = %A_Index%
Loop, Read, %Dir%\3_Uncommon.txt
   3_Lines = %A_Index%
Loop, Read, %Dir%\4_Rare.txt
   4_Lines = %A_Index%
Loop, Read, %Dir%\5_VeryRare.txt
   5_Lines = %A_Index%
Loop, Read, %Dir%\6_Legendary.txt
   6_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Nouns\Nouns1.txt
   N1_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Nouns\Nouns2.txt
   N2_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Nouns\Nouns3.txt
   N3_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Nouns\Nouns4.txt
   N4_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Nouns\Nouns5.txt
   N5_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Nouns\Nouns6.txt
   N6_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj1.txt
   Adj1_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj2.txt
   Adj2_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj3.txt
   Adj3_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj4.txt
   Adj4_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj5.txt
   Adj5_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj6.txt
   Adj6_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj7.txt
   Adj7_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj8.txt
   Adj8_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj9.txt
   Adj9_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj10.txt
   Adj10_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj11.txt
   Adj11_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Adj\Adj12.txt
   Adj12_Lines = %A_Index%
Loop, Read, %Dir%\Banks\Races.txt
   Race_Lines = %A_Index%
Loop, Read, %Dir%\Banks\RaceNames.txt
   RaceNames_Lines = %A_Index%
}
Start:
NC = 0
Inputbox, QtyMax,,,,200,100
	Modes:
	{
		If QtyMax = Coast
			Habitat = Coast
		If QtyMax = Temperate
			Habitat = Temperate
		If QtyMax < 1
			Exit
	}
	If (InStr(QtyMax, A_Space))
		{
			QtyMaxPrompt := StrSplit(QtyMax, A_Space)
			QtyMax := QtyMaxPrompt.1
			Prompt := QtyMaxPrompt.2
			;Msgbox %Prompt%	;Debug
		}
QtyMin := Ceil(QtyMax / 2)
;Msgbox %QtyMin%
Random, Qty, %QtyMin%, %QtyMax%

Loop, %Qty%
{
	;Condition
	{	;Collapse
	Random, CondRnd, 1, 34
		If CondRnd = 1
			Condition = Mint
		If CondRnd between 2 and 3
			Condition = Excellent
		If CondRnd between 4 and 6
			Condition = Very Good
		If CondRnd between 7 and 10
			Condition = Good
		If CondRnd between 11 and 14
			Condition = Light Wear
		If CondRnd between 15 and 20
			Condition = Medium Wear
		If CondRnd between 21 and 25
			Condition = Heavy Wear
		If CondRnd between 26 and 27
			Condition = Bloodstained
		If CondRnd between 28 and 31
			Condition = Tattered
		If CondRnd between 32 and 33
			Condition = Destroyed
		If CondRnd = 34
			Condition = Barely Recognizable
		;Msgbox %Condition%
	}
	
	If (Prompt != "")	;Prompt is not empty
		{
			If (Instr(Prompt, "book"))
				{
					Random, BookRnd, 1, 52
						If BookRnd between 1 and 3
							Loot = {CASE}Almanac	Reads 'The Almanac of {ADJ} {NOUN}'
						If BookRnd between 4 and 6
							Loot = {CASE}Dictionary	Reads 'The Dictionary of {ADJ} {NOUN}'
						If BookRnd between 7 and 10
							Loot = {CASE}Book	Reads '{ADJ} {NOUN}'
						If BookRnd between 11 and 14
							Loot = {CASE}Book	Reads '{RACE} {NOUN}'
						If BookRnd between 15 and 18
							Loot = {CASE}Book	Reads '{COLOR} {NOUN}'
						If BookRnd between 19 and 21
							Loot = {CASE}Biography	Reads 'The Biography of {NAME}'
						If BookRnd between 22 and 24
							Loot = {CASE}Book	Reads 'Tales of {SUBJECT}'
						If BookRnd between 25 and 26
							Loot = {CASE}Book	Reads 'The Legend of {SUBJECT}'
						If BookRnd between 27 and 30
							Loot = {CASE}Book	Reads 'The History of {SUBJECT}'
						If BookRnd between 31 and 33
							Loot = {CASE}Book	Reads 'The Short Stories of {SUBJECT}'
						If BookRnd between 34 and 42
							Loot = {CASE}Book	Reads 'The {SUBJECT}'
						If BookRnd between 43 and 48
							Loot = {CASE}Book	Reads '{SUBJECT}s'
						If BookRnd between 49 and 50
							Loot = {CASE}Book	Reads 'The {LOC} {BEAST}'
						If BookRnd between 51 and 52
							Loot = {CASE}Book	Reads 'The Study of {SUBJECT}'
				}
			If (Instr(Prompt, "gp"))
				{
					Loot = {1d20} gold pieces
				}
			If (Instr(Prompt, "sp"))
				{
					Loot = {1d50} silver pieces
				}
			If (Instr(Prompt, "copper"))
				{
					Loot = {1d100} copper pieces
				}
			If (Instr(Prompt, "name"))
				{
					Loot = {NAME}
					NC = 1
				}
			Goto, Randomize	;Skip rarity tables
		}
	
	;Rarity	
	{	;Collapse
	Random, RarityRnd, 1, 100
		If Debug = 0	;Debug
			RarityRnd = 150
			
		If RarityRnd = 150
		{
			Rarity = 0_Test.txt
			fLines = %0_Lines%
		}
		If RarityRnd between 1 and 45
		{
			Rarity = 1_Mundane.txt
			fLines = %1_Lines%
		}
		If RarityRnd between 46 and 79
		{
			Rarity = 2_Common.txt
			fLines = %2_Lines%
		}
		If RarityRnd between 80 and 90
		{
			Rarity = 3_Uncommon.txt
			fLines = %3_Lines%
		}
		If RarityRnd between 91 and 96
		{
			Rarity = 4_Rare.txt
			fLines = %4_Lines%
		}
		If RarityRnd between 97 and 99
		{
			Rarity = 5_VeryRare.txt
			fLines = %5_Lines%
		}
		If RarityRnd = 100
		{
			Rarity = 6_Legendary.txt
			fLines = %6_Lines%
		}	
	}	
	
	Randomize:
	{
		Random, FirstRnd, 1, %fLines%
		Random, ColorRnd, 1, %C_Lines%
		Random, RaceRnd, 1, %Race_Lines%
		Random, RaceNamesRnd, 1, %RaceNames_Lines%
		If (Prompt = "")	;Empty prompt grabs from rarity table
			FileReadLine, Loot, %Dir%\%Rarity%, %FirstRnd%
			FileReadLine, COLOR, %Dir%\Banks\.Colors.ini, %ColorRnd%
			FileReadLine, RaceNames, %Dir%\Banks\RaceNames.txt, %RaceNamesRnd%
			COLOR := StrSplit(COLOR, A_Tab)
			Random, 1d100, 1, 100
			Random, 1d50, 1, 50
			Random, 1d20, 1, 20
			Random, 1d12, 1, 12
			Random, 1d8, 1, 8
			Random, 1d6, 1, 6
			Random, 1d4, 1, 4
			Random, 1d2, 1, 2
			Random, NounsRnd, 1, N%1d6%_Lines
			Random, AdjRnd, 1, Adj%1d12%_Lines
			FileReadLine, Noun, %Dir%\Banks\Nouns\Nouns%1d6%.txt, NounsRnd	;Banks
			FileReadLine, Adj, %Dir%\Banks\Adj\Adj%1d12%.txt, AdjRnd
			FileReadLine, Race, %Dir%\Banks\Races.txt, RaceRnd
			;Msgbox Race:%Race% Noun:%Noun% Adj:%Adj%	;Testing
	}
		IfStatements:
		{	;Collapse
			If (InStr(Loot, "{SUBJECT}"))
			{
					Random, SubjectRnd, 1, 8
						If SubjectRnd between 1 and 3
							Subject = {NOUN}
						If SubjectRnd between 4 and 5
							Subject = {NAME}
						If SubjectRnd = 6
							Subject = {LOC}
						If SubjectRnd between 7 and 8
							Subject = {BEAST}
					Loot := StrReplace(Loot, "{SUBJECT}", Subject)
				}
			If (InStr(Loot, "{NAME}"))
			{
					GenderRnd:
					{
						Random, MF, 1, 2
						if (MF = "1")
							Gender = m
						if (MF = "2")
							Gender = f
					}
					NameImport:
					{	;Collapse
						NameDir = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names
						RaceNames = Human	;Debug
						FirstFile = %NameDir%\%RaceNames%\%RaceNames%_%Gender%.txt
						LastFile_0 = %NameDir%\%RaceNames%\%RaceNames%_s0.txt
						LastFile_1 = %NameDir%\%RaceNames%\%RaceNames%_s1.txt
						LastFile_2 = %NameDir%\%RaceNames%\%RaceNames%_s2.txt
						;Msgbox %FirstFile% %LastFile_2%	;Debug
					}
					CountNames:
					{	;Collapse
						Loop, Read, %FirstFile%
							firstLines = %A_Index%
						;Msgbox firstLines %firstLines%
						If FileExist(LastFile_0)
						{
							Loop, Read, %LastFile_0%
							s0Lines = %A_Index%
							Sur0 = true
						}
						Loop, Read, %LastFile_1%
							s1Lines = %A_Index%
						Loop, Read, %LastFile_2%
							s2Lines = %A_Index%
					}
					GenName:
					{	;Collapse
						Random, FirstRnd, 1, %firstLines%
						Random, LastRnd_0, 1, %s0Lines%
						Random, LastRnd_1, 1, %s1Lines%
						Random, LastRnd_2, 1, %s2Lines%
						
						Read:
						FileReadLine, FirstName, %FirstFile%, %FirstRnd%
							;Msgbox %First%
						If FileExist(LastFile_0)
							FileReadLine, Last_0, %LastFile_0%, %LastRnd_0%
						FileReadLine, Last_1, %LastFile_1%, %LastRnd_1%
						FileReadLine, Last_2, %LastFile_2%, %LastRnd_2%
							StringLower, Last_2b, Last_2
						
						Output:
						If FileExist(LastFile_0)
						{
							Random, LastA, 1, 2
							if (LastA = 1)
								Goto, Combine
							Loop, Read, %LastFile_0%
							s0Lines = %A_Index%
							Name = %FirstName% %Last_0%
							Goto, End
						}
						Combine:
						Name = %FirstName% %Last_1%%Last_2b%
						;Msgbox %Name%
					}
					End:
					Loot := StrReplace(Loot, "{NAME}", Name)
				}
			If (InStr(Loot, "{PATTERN}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\.Patterns.ini
					Patterns_Lines = %A_Index%
				Random, PatternsRnd, 1, Patterns_Lines
				FileReadLine, Patterns, %Dir%\Banks\.Patterns.ini, PatternsRnd
				;Msgbox %Patterns%	;Debug
				Loot := StrReplace(Loot, "{PATTERN}", Patterns)
			}
			If (InStr(Loot, "{FABRIC}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\.Fabrics.ini
					Fabric_Lines = %A_Index%
				Random, FabricRnd, 1, Fabric_Lines
				FileReadLine, Fabrics, %Dir%\Banks\.Fabrics.ini, FabricRnd
				;Msgbox %Patterns%	;Debug
				Loot := StrReplace(Loot, "{FABRIC}", Fabrics)
			}
			If (InStr(Loot, "{LANGUAGE}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\.LANGUAGEs.ini
					LANGUAGE_Lines = %A_Index%
				Random, LANGUAGERnd, 1, LANGUAGE_Lines
				FileReadLine, LANGUAGEs, %Dir%\Banks\.LANGUAGEs.ini, LANGUAGERnd
				;Msgbox %Patterns%	;Debug
				Loot := StrReplace(Loot, "{LANGUAGE}", LANGUAGEs)
			}
			If (InStr(Loot, "{BEAST}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\.Global.txt
					Beastiary_Lines = %A_Index%
				Random, BeastiaryRnd, 1, Beastiary_Lines
				FileReadLine, Beastiary, %Dir%\Banks\Beastiary\.Global.txt, BeastiaryRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{BEAST}", Beastiary)
			}
			If (InStr(Loot, "{Amphibian}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Amphibian\%Habitat%.ini
					Amphibian_Lines = %A_Index%
				Random, AmphibianRnd, 1, Amphibian_Lines
				FileReadLine, Amphibian, %Dir%\Banks\Beastiary\Amphibian\%Habitat%.ini, AmphibianRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{Amphibian}", Amphibian)
			}
			If (InStr(Loot, "{Aquatic}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Aquatic\%Habitat%.ini
					Aquatic_Lines = %A_Index%
				Random, AquaticRnd, 1, Aquatic_Lines
				FileReadLine, Aquatic, %Dir%\Banks\Beastiary\Aquatic\%Habitat%.ini, AquaticRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{Aquatic}", Aquatic)
			}
			If (InStr(Loot, "{Bird}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Birds\%Habitat%.ini
					Bird_Lines = %A_Index%
				Random, BirdRnd, 1, Bird_Lines
				FileReadLine, Bird, %Dir%\Banks\Beastiary\Birds\%Habitat%.ini, BirdRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{Bird}", Bird)
			}
			If (InStr(Loot, "{Fish}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Fish\%Habitat%.ini
					Fish_Lines = %A_Index%
				Random, FishRnd, 1, Fish_Lines
				FileReadLine, Fish, %Dir%\Banks\Beastiary\Fish\%Habitat%.ini, FishRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{Fish}", Fish)
			}
			If (InStr(Loot, "{Insect}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Insects\%Habitat%.ini
					Insect_Lines = %A_Index%
				Random, InsectRnd, 1, Insect_Lines
				FileReadLine, Insect, %Dir%\Banks\Beastiary\Insects\%Habitat%.ini, InsectRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{Insect}", Insect)
			}
			If (InStr(Loot, "{Flora}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Flora\%Habitat%.ini
					Flora_Lines = %A_Index%
				Random, FloraRnd, 1, Flora_Lines
				FileReadLine, Flora, %Dir%\Banks\Beastiary\Flora\%Habitat%.ini, FloraRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{Flora}", Flora)
			}
			If (InStr(Loot, "{Monstrosity}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Monstrosities\%Habitat%.ini
					Monstrosity_Lines = %A_Index%
				Random, MonstrosityRnd, 1, Monstrosity_Lines
				FileReadLine, Monstrosity, %Dir%\Banks\Beastiary\Monstrosities\%Habitat%.ini, MonstrosityRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{Monstrosity}", Monstrosity)
			}
			If (InStr(Loot, "{REPTILE}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Reptiles\%Habitat%.ini
					Reptile_Lines = %A_Index%
				Random, ReptileRnd, 1, Reptile_Lines
				FileReadLine, Reptile, %Dir%\Banks\Beastiary\Reptiles\%Habitat%.ini, ReptileRnd
				;Msgbox %Reptile%	;Debug
				Loot := StrReplace(Loot, "{REPTILE}", Reptile)
			}
			If (InStr(Loot, "{MAMMAL}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Beastiary\Mammals\%Habitat%.ini
					Mammal_Lines = %A_Index%
				Random, MammalRnd, 1, Mammal_Lines
				FileReadLine, Mammal, %Dir%\Banks\Beastiary\Mammals\%Habitat%.ini, MammalRnd
				;Msgbox %Mammals%	;Debug
				Loot := StrReplace(Loot, "{MAMMAL}", Mammal)
			}
			If (InStr(Loot, "{RACENAME}"))
			{	;Collapse
				FileReadLine, RaceName, %Dir%\Banks\RaceNames.txt, RaceNamesRnd
				Loot := StrReplace(Loot, "{RACENAME}", RaceName)
			}
			If (InStr(Loot, "{LOC}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\.Locations.ini
					Loc_Lines = %A_Index%
				Random, LocRnd, 1, Loc_Lines
				FileReadLine, Location, %Dir%\Banks\.Locations.ini, LocRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{LOC}", Location)
			}
			If (InStr(Loot, "{REGION}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\.Regions.ini
					Region_Lines = %A_Index%
				Random, RegionRnd, 1, Region_Lines
				FileReadLine, Region, %Dir%\Banks\.Regions.ini, RegionRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{Region}", Region)
			}
			If (InStr(Loot, "{BEVERAGE}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Foods\.Beverages.ini
					BEVERAGE_Lines = %A_Index%
				Random, BEVERAGERnd, 1, BEVERAGE_Lines
				FileReadLine, BEVERAGE, %Dir%\Banks\Foods\.BEVERAGEs.ini, BEVERAGERnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{BEVERAGE}", BEVERAGE)
			}
			If (InStr(Loot, "{FLAVOR}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\.Flavors.ini
					Flavors_Lines = %A_Index%
				Random, FlavorsRnd, 1, Flavors_Lines
				FileReadLine, Flavors, %Dir%\Banks\.Flavors.ini, FlavorsRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{FLAVOR}", Flavors)
			}
			If (InStr(Loot, "{GEM}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\.Gems.ini
					Gems_Lines = %A_Index%
				Random, GemsRnd, 1, Gems_Lines
				FileReadLine, Gems, %Dir%\Banks\.Gems.ini, GemsRnd
				;Msgbox %Gems%	;Debug
				Loot := StrReplace(Loot, "{GEM}", Gems)
			}
			If (InStr(Loot, "{CHEESE}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Foods\.Cheese.ini
					cheeseLines = %A_Index%
				Random, cheeseRnd, 1, cheeseLines
				FileReadLine, Cheese, %Dir%\Banks\Foods\.Cheese.ini, cheeseRnd
				;Msgbox %Cheese%	;Debug
				Loot := StrReplace(Loot, "{cheese}", Cheese)
			}
			If (InStr(Loot, "{SPICE}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Foods\.spices.ini
					spiceLines = %A_Index%
				Random, spiceRnd, 1, spiceLines
				FileReadLine, spice, %Dir%\Banks\Foods\.spices.ini, spiceRnd
				;Msgbox %spice%	;Debug
				Loot := StrReplace(Loot, "{spice}", spice)
			}
			If (InStr(Loot, "{FRUIT}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Foods\.FRUITs.ini
					FRUIT_Lines = %A_Index%
				Random, FRUITRnd, 1, FRUIT_Lines
				FileReadLine, FRUIT, %Dir%\Banks\Foods\.FRUITs.ini, FRUITRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{FRUIT}", FRUIT)
			}
			If (InStr(Loot, "{MATERIAL}"))
			{	;Collapse
				Random, MaterialRnd, 1, 18
					If MaterialRnd = 1
						Material = gold
					If MaterialRnd between 2 and 3
						Material = silver
					If MaterialRnd = 4
						Material = platinum
					If MaterialRnd between 5 and 6
						Material = copper
					If MaterialRnd = between 7 and 8
						Material = bronze
					If MaterialRnd = 9
						Material = obsidian
					If MaterialRnd = 10
						Material = imitation gold
					If MaterialRnd = 11
						Material = diamond
					If MaterialRnd between 12 and 13
						Material = steel
					If MaterialRnd between 14 and 15
						Material = metal
					If MaterialRnd between 16 and 18
						Material = wood
					If MaterialRnd = 19
						Material = platinum
					If MaterialRnd = 20
						Material = bone
				Loot := StrReplace(Loot, "{MATERIAL}", Material)
			}
			If (InStr(Loot, "{SPELL}"))
			{	;Collapse
				Random, SpellRnd, 0, 100
				{	;Collapse
					If SpellRnd between 0 and 50
						SpellTable = 0
					If SpellRnd between 51 and 64
						SpellTable = 1
					If SpellRnd between 65 and 74
						SpellTable = 2
					If SpellRnd between 75 and 81
						SpellTable = 3
					If SpellRnd between 82 and 87
						SpellTable = 4
					If SpellRnd between 88 and 92
						SpellTable = 5
					If SpellRnd between 93 and 96
						SpellTable = 6
					If SpellRnd between 97 and 98
						SpellTable = 7
					If SpellRnd = 99
						SpellTable = 8
					If SpellRnd = 100
						SpellTable = 9
				}
				
				Loop, Read, %Dir%\Banks\Spells\%SpellTable%.ini
					SPELL_Lines = %A_Index%
				Random, SPELLRnd, 1, SPELL_Lines
				FileReadLine, SPELL, %Dir%\Banks\Spells\%SpellTable%.ini, SPELLRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{SPELLTABLE}", SpellTable)
				Loot := StrReplace(Loot, "{SPELL}", SPELL)
			}
			If (InStr(Loot, "{EFFECT}"))
			{	;Collapse
				Random, EFFECTRnd, 0, 100
				{	;Collapse
					If EFFECTRnd between 0 and 70
						EFFECTTable = Effect
					If EFFECTRnd between 61 and 94
						EFFECTTable = Condition
					If EFFECTRnd between 95 and 100
						EFFECTTable = Disease
				}
				Loop, Read, %Dir%\Banks\EFFECTs\%EFFECTTable%.ini
					EFFECT_Lines = %A_Index%
				Random, EFFECTRnd, 1, EFFECT_Lines
				FileReadLine, EFFECT, %Dir%\Banks\EFFECTs\%EFFECTTable%.ini, EFFECTRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{EFFECT}", EFFECT)
			}
			If (InStr(Loot, "{DURATION}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Effects\Duration.ini
					DURATION_Lines = %A_Index%
				Random, DURATIONRnd, 1, DURATION_Lines
				FileReadLine, DURATION, %Dir%\Banks\Effects\Duration.ini, DURATIONRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{DURATIONTABLE}", DURATIONTable)
				Loot := StrReplace(Loot, "{DURATION}", DURATION)
			}
			If (InStr(Loot, "{ABILITY}"))
			{	;Collapse
				Loop, Read, %Dir%\Banks\Effects\ABILITY.ini
					ABILITY_Lines = %A_Index%
				Random, ABILITYRnd, 1, ABILITY_Lines
				FileReadLine, ABILITY, %Dir%\Banks\Effects\ABILITY.ini, ABILITYRnd
				;Msgbox %Beastiary%	;Debug
				Loot := StrReplace(Loot, "{ABILITYTABLE}", ABILITYTable)
				Loot := StrReplace(Loot, "{ABILITY}", ABILITY)
			}
			LootReplacements:
			{	;Collapse
				Loot := StrReplace(Loot, "{1d100}", 1d100)
				Loot := StrReplace(Loot, "{1d50}", 1d50)
				Loot := StrReplace(Loot, "{1d20}", 1d20)
				Loot := StrReplace(Loot, "{1d12}", 1d12)
				Loot := StrReplace(Loot, "{1d8}", 1d8)
				Loot := StrReplace(Loot, "{1d6}", 1d6)
				Loot := StrReplace(Loot, "{1d4}", 1d4)
				Loot := StrReplace(Loot, "{1d2}", 1d2)
				Loot := StrReplace(Loot, "{COLOR}", COLOR.1)
				Loot := StrReplace(Loot, "{COLOR}", COLOR.1)
				Loot := StrReplace(Loot, "{NOUN}", Noun)
				Loot := StrReplace(Loot, "{ADJ}", Adj)
				Loot := StrReplace(Loot, "{RACE}", Race)
				Loot := StrReplace(Loot, A_Tab, "`n`n")
			}
			If (InStr(Loot, "{hp}"))
			{	;Collapse
				Random, hpRnd, 1, %Level%
				hp := Round(hpRnd * 7 / 2.6)
				;Msgbox %hp%
				
				Loot := StrReplace(Loot, "{hp}", hp)
			}
			If (InStr(Loot, "{CASE}"))	;Mixed case, use for titles
				{
					Loot := StrReplace(Loot, "{CASE}")
					StringUpper, Loot, Loot, T
				}
			If (InStr(Loot, "{UP}"))	;Use to uppercase individual tags
				{
					RegExMatch(Loot, "\{UP\}." , LetterPos, 1)	;Match
						;Msgbox %LetterPos%	;debug
					UpString := StrSplit(LetterPos, "{UP}")
						;Msgbox % NextLetter.2	;debug
					NextLetter := UpString.2
					StringUpper, NextLetter, NextLetter, T	;uppercase
					Loot := StrReplace(Loot, LetterPos, NextLetter)
				}
			If (InStr(Loot, "`t"))	;Tab
				{
					Loot := StrReplace(Loot, A_TAB, "`n`n")
				}
		}
		If NC = 0
		{
			Msgbox {%Condition%} %Loot%
			Clipboard = {%Condition%} %Loot%
		}
		If NC = 1
		{
			Msgbox %Loot%
			Clipboard = %Loot%
		}
}

Goto, Start

;MainGUI:
;	GUI_Color := StrReplace(Color.2, "#")
;	Gui, Add, Text,, Enter command:
;	Gui, Add, Edit, vLoot
;	Gui, Add, Button, default, OK
;	
;	Gui, Color, %GUI_Color%
;	Gui -Caption
;	Gui,Show
;
;Exit