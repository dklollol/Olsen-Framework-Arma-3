// Module by Starfox64 (STEAM_0:1:37636871) //

//If you wish to use this EndScreen please use the following syntax to update endConditions.sqf

// FNC_EndMission Syntax:
// COOP
// [string EndType (endTypes.hpp), bool isVictory] call FNC_EndMission;
//
// TVT
// [[side/array/unit Target, string EndType, bool isVictory], [side/array/unit Target, string EndType, bool isVictory]] call FNC_EndMission;
//
// TVT Example:
// OPFOR Victory
// [[west, "BLUFOREliminated", false], [east, "BLUFOREliminated", false]] call FNC_EndMission;
//
// BLUFOR Victory
// [[west, "OPFOREliminated", true], [east, "OPFOREliminated", false]] call FNC_EndMission;
//
// COOP Examples:
// ["BLUFOREliminated", false] call FNC_EndMission;
// ["OPFOREliminated", true] call FNC_EndMission;
// ["TimeLimit", false] call FNC_EndMission;

//ENABLE_A3_ENDSCREEN
//Whether or not to use the ArmA 3 gorgeous EndScreen.
#define ENABLE_A3_ENDSCREEN false