// Module by Starfox64 (STEAM_0:1:37636871) //

// Call Mission Configuration
//
// RegisterMissionCall:
// This section is used to add an option to call the mission as a CO.
//
// Syntax:
// [string CALL_IDENTIFIER, side SIDE_WITH_ACCESS, string ACTION_TEXT, any FNC_EndMission ARGUMENT] call FNC_RegisterMissionCall;
//
// Examples:
// COOP
// ["CALLVIC", west, "Call Victory", "The CO called the mission a victory!"] call FNC_RegisterMissionCall;
// ["CALLFAIL", west, "Call Failure", "The CO called the mission a failure!"] call FNC_RegisterMissionCall;
//
// TVT
// ["OPFORVIC", west, "Surrender (OPFOR Victory)", "The BLUFOR CO surrendered!"] call FNC_RegisterMissionCall;
// ["BLUFORVIC", east, "Surrender (BLUFOR Victory)", "The BLUFOR CO surrendered!"] call FNC_RegisterMissionCall;
//
// NOTE:
// If you are using the a3_endmission module replace the last argument (end scenario) with this syntax:
//
// TVT
// [[west, "OPFOREliminated", true], [east, "OPFOREliminated", false]]
//
// COOP
// ["OPFOREliminated", true]



// RegisterCOC:
// The module needs to know the chain of command to find the acting CO of a side.
// The module identifies groups by using their given groupID, to assign a groupID to a unit use this command: (group _unit) setGroupID "GroupName"; (This command will need to be applied on every unit of a group, not just the leader.)
//
// Syntax:
// [side TARGET_SIDE, array ARRAY_OF_GROUPID_IN_COC_ORDER] call FNC_RegisterCOC;
//
// Examples:
// [west, ["1'6", "1'1", "1'2", "1'3"]] call FNC_RegisterCOC;
// [east, ["232", "232'Alpha", "232'Bravo", "232'Charlie"]] call FNC_RegisterCOC;