/*
 * Author: BlackHawk
 *
 * Creates array on the server containing all units with missing gear type
 *
 * Arguments:
 * 0: class <string>
 * 1: unit <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

params ["_class", "_unit"];

if (isNil "FW_missing_gear") then {
    FW_missing_gear = [];
    [{time > 0}, {publicVariable "FW_missing_gear"}] call CBA_fnc_waitUntilAndExecute;
};

private _index = -1;

{
    if ((_x select 0) == _class) exitWith {_index = _forEachIndex};
} foreach FW_missing_gear;

if (_index != -1) then {
    ((FW_missing_gear select _index) select 1) pushBackUnique _unit;
} else {
    FW_missing_gear pushBack [_class, [_unit]];
};

if (time > 0) then {
    publicVariable "FW_missing_gear";
};