
//Example:["east",[west,east],[300,10]] call FNC_setCaptureZone;
//Author:		Sacher

//Definition:	[MARKERNAME,[SIDES],[WINS]] call FNC_setCaptureZone;

//				
//Description: 	This will make a rectangle or eliptical Marker into a capturezone.

// 				MARKERNAME is Name of marker in quotes
//				SIDES is an array of the sides which can capture the zone
//				Example: [west,east,civilian] 
//				Default: all sides
//				WIN has the same layout as SIDES basically 
//				SIDES = [west,east,civilian] --> WIN = [time for west,time for east,time for civilian];
//				SIDES = [resistance,east,west] --> WIN = [time for resistance,time for east,time for west];
//				Default is 300 for every side.

//Comments: In endConditions.sqf add MARKERNAMEINQUOTES call FNC_isCaptured;
//			will return "EAST","WEST","CIVILIAN","RESISTANCE","NONE" depending on who captured it
// 			Example:if("EAST" == "marker" call FNC_isCaptured) exitWith {};
//Additional:
// SECONDS call FNC_setIntervall;
// time between checks if people have entered the capturezone
// use under your own discretion
// Default: 15
// [BLUCOLOR,EASTCOLOR,RESISTANCECOLOR,CIVILIAN,CONDESTEDCOLOR,UNCONDESTEDCOLOR] call FNC_setColors;
// will set Capturezone colors
// Default: ["ColorBlue","ColorRed","ColorGreen","ColorYellow","ColorWhite","ColorKhaki"];
// Example ["ColorBlue","ColorRed","ColorGreen","ColorYellow","ColorWhite","ColorKhaki"] call FNC_setColors;

// [BLUSTRING,EASTSTRING,RESISTANCESTRING,CIVLIANSTRIN,CONTESTEDSTRING,UNCONDESTEDSTRING] call FNC_setMessages;
// will set hints which are displayed when the zone is being captured
// Default: ["Blufor is capturing the zone","Opfor is capturing the zone","Resistance is capturing the zone","Civilian is capturing the  zone","The zone is contested","The zone is uncontested"]; If a side isn't in the mission just use "" to make it shorter;
// Example ["Blufor is capturing the zone","Opfor is capturing the zone","Resistance is capturing the zone","Civilian is capturing the zone","The zone is contested","The zone is uncontested"] call FNC_setMessages;


//["","","","","",""] call FNC_setMessages;