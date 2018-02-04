#include "core\gearCore.sqf" //DO NOT REMOVE

// Call this with [this, "LOADOUT", (optional) "GROUPNAME"] call FNC_GearScript; in the Init field of the unit
// Example:
// [this, "SL", "1'1"] call FNC_GearScript;\
//
// more info: https://github.com/dklollol/Olsen-Framework-Arma-3/wiki/gear.sqf

//when set to false, facewear types that are whitelisted will not be removed
FW_force_remove_facewear = false;
FW_enableOverfill = false;

_unit call FNC_RemoveAllGear;

switch (_type) do {
	
	//#include "loadouts\USMCRiflePlatoon.sqf"
	//#include "loadouts\RURiflePlatoon.sqf"
	//#include "loadouts\BAF.sqf"
	//#include "loadouts\1989USARMY.sqf"
	//#include "loadouts\1989VDV.sqf"
	//#include "loadouts\2000MSV.sqf"
};