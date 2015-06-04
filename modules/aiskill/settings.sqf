//Description
//Sets Aiskill to VALUE for all AI if all CONDITIONS are met
//EXAMPLE:["aimingspeed", 1] call FNC_setAISkill;
//		  ["aimingspeed", 0.9,["Distance",200,GAMELOGIC1]] call FNC_setAISkill;
//[STRING,VALUE,CONDITIONS] call FNC_setAISkill
//CONDITIONSARRAY currently supports side and distance
//HOW to use CONDITIONS ["Distance",RANGE,POSITION];
//			 			["Side",SIDE];
//it is possible to chain unlimited Conditions
//Example: ["aimingspeed", 0.9,["Distance",200,GAMELOGIC1],["Side",west]] call FNC_setAISkill;
//Comments:
//Value = number between 0.2 and 1
//Leave Conditions out to change all AI ["aimingspeed", 1] call FNC_setAISkill;
//
//
//"aimingspeed"				Affects how well the AI can lead a target
//							Affects how accurately the AI estimate range and calculates bullet drop
//							Affects how well the AI compensates for weapon dispersion
//							Affects how much the AI will know to compensate for recoil (Higher value = more controlled fire)
//							Affects how certain the AI must be about its aim on target before opening fire

//"aimingshake" 			Affects how steadily the AI can hold a weapon (Higher value = less weapon sway)

//"aimingaccuracy" 			Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error)

//"commanding" 				Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)

//"courage" 				Affects unit's subordinates' morale (Higher value = more courage)

//"general" 				Raw "Skill", value is distributed to sub-skills unless defined otherwise. Affects the AI's decision making.

//"reloadspeed" 			Affects the delay between switching or reloading a weapon (Higher value = less delay)

//"spotdistance" 			Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot)
//							Affects the accuracy of the information (Higher value = more accurate information)

//"spottime" 				Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction)
//