//This module shares target information between AI groups based on their radios.
//Written by TinfoilHate
//Updated: June 06, 2017

["AI link", "Shares targeting information between AI groups based on radios.", "TinfoilHate"] call FNC_RegisterModule;

#include "settings.sqf"

if (!hasInterface) then {
	[{call tin_aiLink},[],tin_aiLink_startDelay] call CBA_fnc_waitAndExecute;
};