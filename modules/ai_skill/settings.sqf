

//Author:		Sacher

//Definition:	[AISKILLSTRING,VALUE,CONDITION,CONDITION,CONDITION....]

//Description: 	With this module you can change the sub-skills of the ai. Sub-skills are normally defined by the missions unit skill slider.
//				With this module you can setup 3 kinds of Conditions for changing the skill of the AI. You can chain Conditions together.
//Comments: VALUE needs to be between 0.2 and 1 to function correctly
//			You have to play around with the Values
//			On larger Missions don't go ham on Conditions since they have to be checked for every AI.
//			Normally up to 3 is acceptable for most missions
//			This Function can be called midgame to change AI. Usefull when Morale has been signifantly lowered.
//			Also do not look inside the init.sqf because its horrible but its working.(sqf is way too limiting)

//CONDITIONS:	["Distance",RANGE,OBJECT/GAMELOGIC]
//			 	["Side",SIDE]
//			  	["Group",GROUP]
//				["Vehicle"]
//				["Vehicle",Vehicle]
//Example: 	["aimingspeed", 1] call FNC_setAISkill;
// 			This is the most lightweight Example of setting Skills. It will change the Sub-Skill of all AI in the Mission.
//			Usecase: Simple change to all AI

//			["aimingspeed", 0.9,["Distance",200,GAMELOGIC1]] call FNC_setAISkill;
//			This Example uses 1 Condition to filter AI. It will only change AI which are withing 200m for GAMELOGIC1.
//			Usecase:AI defending a certain area will be changed

//			["aimingspeed", 0.9,["Distance",200,GENERAL]] call FNC_setAISkill;
//			This Example pretty much works like the one above but this time all Units within 200m of the unit General
//			Usecase: Bodyguard of General receives different skill

//			["aimingspeed", 0.9,["Side",west]] call FNC_setAISkill;
//			This example will change all AI which are on side west
//			Usecase: You have multiple AI sides in your mission andd only want to change Inurgents which are on side resistance

//			["aimingspeed", 0.9,["Group",group General]] call FNC_setAISkill;
//			This example will change all AI which are in the group of General
//			Usecase: Generals Bodyguard is the only one affected and other ai around him are not changed

//			["aimingspeed", 0.9,["Vehicle"]] call FNC_setAISkill;
//			This Example will change all AI which are inside a Vehicle
//			Usecase: Mechanized mounted forces receive different skills

//			["aimingspeed", 0.9,["Vehicle",Vehicle]] call FNC_setAISkill;
//			This Example will change all AI which are inside Vehicle1
//			Usecase: Certain Vehicle has a squad which has been servin for years and has better skills

//Chaining:	["aimingspeed", 0.9,["Distance",200,GAMELOGIC1],["Side",west],["Vehicle"]] call FNC_setAISkill;
//			This example will change all which are within 200m of GAMELOGIC1 and are on Side west and are mounted in an Vehicle


//AISKILLSTRINGS:
//"aimingaccuracy" 			Affects how well the AI can lead a target
//							Affects how accurately the AI estimate range and calculates bullet drop
//							Affects how well the AI compensates for weapon dispersion
//							Affects how much the AI will know to compensate for recoil (Higher value = more controlled fire)
//							Affects how certain the AI must be about its aim on target before opening fire

//"aimingshake" 			Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)

//"aimingspeed"			   Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)

//"commanding" 				Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)

//"courage" 				Affects unit's subordinates' morale (Higher value = more courage)

//"general" 				Raw "Skill", value is distributed to sub-skills unless defined otherwise. Affects the AI's decision making.
//							Basically the Skill-Slider equivalent.

//"reloadspeed" 			Affects the delay between switching or reloading a weapon (Higher value = less delay)

//"spotdistance" 			Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
//							Affects the accuracy of the information (Higher value = more accurate information)

//"spottime" 				Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
//
