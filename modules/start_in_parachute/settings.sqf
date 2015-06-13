/*
	Start in Parachute module by Briland
	V1.0
	This module starts all defined players inside a parachute at a defined altitude
	Does not work for AI
	
	Syntax:
	[target, altitude, altituderandom, parachuteisstearable] call FNC_DOPARACHUTE;

	Paramaters:
	target: either the SIDE, UNIT, or ARRAY of units that you want to parachute when they spawn
	altitude: the elevation above terrain level that the parachute will open
	(optional) altituderandom: A random number between 0 and altituderandom will be added to altitude for the effect to look better. default is 100
	(optional) parachuteisstearable: true for parachute to be stearable, false for nonstearable. false by default	
	
	Examples:
	[west, 300] call FNC_DOPARACHUTE;
	[east, 200, 150] call FNC_DOPARACHUTE;
	[[coUnit, unit2], 200, 20, true] call FNC_DOPARACHUTE;

*/

[west, 300] call FNC_DOPARACHUTE;