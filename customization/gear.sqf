#include "core\gearCore.sqf" //DO NOT REMOVE

// Call this with [this, "LOADOUT", "GROUPNAME"] call FNC_GearScript; in the Init field of the unit
// Example:
// [this, "SL", "1'1"] call FNC_GearScript;\
//
// more info: https://github.com/dklollol/Olsen-Framework-Arma-3/wiki/gear.sqf

_unit call FNC_RemoveAllGear;
["ItemMap"] call FNC_AddItem;

switch (_type) do {

	case "SL": {
	
		["rhsusf_assault_eagleaiii_coy"] call FNC_AddItem;
		
		// [["rhs_mag_30Rnd_556x45_M855A1_Stanag", random(2, 6)], ["rhs_30Rnd_762x39mm", random(1, 4)]] call FNC_AddItemRandom;
		[["rhs_weap_m4a1_grip2", "rhs_weap_akm"], 2, "backpack"] call FNC_AddItemRandom;
		// [[["rhs_mag_30Rnd_556x45_M855A1_Stanag", random(2, 6)], ["rhs_weap_m4a1_grip2"]], [["rhs_30Rnd_762x39mm", random(1, 4)], ["rhs_weap_akm"]]] call FNC_AddItemRandom;

	};

};