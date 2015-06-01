//If you wish to use this EndScreen please use the following syntax to update endConditions.sqf

// FNC_EndMission Syntax:
// [string EndType (endTypes.hpp), bool isVictory, (optional) side/array/unit target] call FNC_EndMission;
//
// TVT Example:
// OPFOR Victory
// ["BLUFOREliminated", true, east] call FNC_EndMission;
// ["BLUFOREliminated", false, west] call FNC_EndMission;
//
// BLUFOR Victory
// ["OPFOREliminated", true, west] call FNC_EndMission;
// ["OPFOREliminated", false, east] call FNC_EndMission;
//
// COOP Examples:
// ["BLUFOREliminated", false] call FNC_EndMission;
// ["OPFOREliminated", true] call FNC_EndMission;
// ["TimeLimit", false] call FNC_EndMission;

//ENABLE_A3_ENDSCREEN
//Weither or not to use the ArmA 3 georgous EndScreen.
#define ENABLE_A3_ENDSCREEN false