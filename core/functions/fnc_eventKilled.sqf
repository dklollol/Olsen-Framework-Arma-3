/*
 * Author: Olsen
 *
 * Triggered by unit death. Decreases number of alive units on a set side in FW_Teams.
 *
 * Arguments:
 * 0: unit that has died <object>
 * 1: killer of the unit <object> (OPTIONAL)
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

params [
    ["_unit", objNull, [objNull]],
    ["_killer", objNull, [objNull]]
];

if (_unit getVariable ["FW_Tracked", false]) then {

    {
        _x params ["", "_side", "_type", "", "_current"];

        if (_unit getVariable "FW_Side" == _side and ((_type != "ai" && isPlayer _unit) || (_type == "ai"))) exitWith {

            _x set [4, _current - 1];

        };

    } forEach FW_Teams;
};