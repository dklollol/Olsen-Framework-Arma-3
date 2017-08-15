/*
 * Author: Olsen
 *
 * Retrieve variable for a set team from FW_Teams.
 *
 * Arguments:
 * 0: Team name <string>
 * 1: Index of variable to retrieve <number>
 *
 * Return Value:
 * 0 <number> if not found, var value <any> if found
 *
 * Public: No
 */

params [
    ["_team", "", [""]],
    ["_index", 0, [0]]
];

private _return = 0;
private _found = false;

{

    if ((_x select 0) == _team) exitWith {

        _return = (_x select _index);
        _found = true;

    };

} forEach FW_Teams;

if (!_found) then {

    private _tempText = format ["Critical:<br></br>Team ""%1"" does not exist.", _team];
    _tempText call FNC_DebugMessage;

};

_return