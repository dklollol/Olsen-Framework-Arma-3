/*
 * Author: BlackHawk
 *
 * Count alive units in a team.
 *
 * Arguments:
 * 0: team name <string>
 *
 * Return Value:
 * unit count, -1 if team not found <number>
 *
 * Public: Yes
 */

private _team = _this;

private _count = -1;

{
    _x params ["_name", "_side", "_type", "_total", "_current"];
    
    if (_name isEqualTo _team) exitWith {
        _count = _current;
    };
} forEach FW_Teams;

_count