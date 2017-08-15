/*
 * Author: Olsen
 *
 * Ends mission in orderly fashion and displays end screen.
 * Sends the team stats, time limit, scenario and executes "FW_EndMission" on all players machines.
 *
 * Arguments:
 * 0: text to display in end screen <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

private _scenario = _this;

if (time > 0) then {

    FW_MissionEnded = true;

    {

        private _team = (_x select 0);

        private _assets = _team call FNC_GetDamagedAssets;

        [_team, 5, _assets select 0] call FNC_SetTeamVariable;
        [_team, 6, _assets select 1] call FNC_SetTeamVariable;

    } forEach FW_Teams;

    ["FW_EndMission", [_scenario, FW_TimeLimit, FW_Teams]] call CBA_fnc_globalEvent;
    
} else {
    "End Conditions have just been triggered. Mission is broken!" remoteExec ["systemChat", 0, false];
};