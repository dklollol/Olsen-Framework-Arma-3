// Call Mission Configuration
//
// RegisterMissionCall:
// This section is used to add an option to call the mission as a CO.
//
// Syntax:
// [string CALL_IDENTIFIER, side SIDE_WITH_ACCESS, string ACTION_TEXT, code CODE_TO_EXECUTE] call FNC_RegisterMissionCall;
//
// Examples:
// COOP
// ["CALLVIC", west, "Call Victory", {["MissionCalled", true] call FNC_EndMission;}] call FNC_RegisterMissionCall;
// ["CALLFAIL", west, "Call Failure", {["MissionCalled", false] call FNC_EndMission;}] call FNC_RegisterMissionCall;
//
// TVT
// ["OPFORVIC", west, "Surrender (OPFOR Victory)", {["MissionCalled", true, east] call FNC_EndMission; ["MissionCalled", false, west] call FNC_EndMission;}] call FNC_RegisterMissionCall;
// ["BLUFORVIC", east, "Surrender (BLUFOR Victory)", {["MissionCalled", false, east] call FNC_EndMission; ["MissionCalled", true, west] call FNC_EndMission;}] call FNC_RegisterMissionCall;

["OPFORVIC", west, "Surrender (OPFOR Victory)", {["MissionCalled", true, east] call FNC_EndMission; ["MissionCalled", false, west] call FNC_EndMission;}] call FNC_RegisterMissionCall;
["BLUFORVIC", east, "Surrender (BLUFOR Victory)", {["MissionCalled", false, east] call FNC_EndMission; ["MissionCalled", true, west] call FNC_EndMission;}] call FNC_RegisterMissionCall;


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

[west, ["1'6", "1'1", "1'2", "1'3", "1'1 Sierra", "1'2 Sierra", "1'3 Sierra"]] call FNC_RegisterCOC;
[east, ["Receptionist", "Maid 1", "Maid 2", "Goupil"]] call FNC_RegisterCOC;