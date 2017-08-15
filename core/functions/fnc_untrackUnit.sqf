/*
 * Author: Olsen
 *
 * Stop tracking of unit by framework.
 *
 * Arguments:
 * 0: unit <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

private _unit = _this;

if (_unit getVariable ["FW_Tracked", false]) then {

    {
        _x params ["", "_side", "_type", "", "_current"];

        if (_unit getVariable "FW_Side" == _side and ((_type != "ai" && isPlayer _unit) || (_type == "ai"))) exitWith {

            if (_unit call FNC_Alive) then {

                _x set [3, _total - 1];
                _x set [4, _current - 1];

            };

        };

    } forEach FW_Teams;

    _unit setVariable ["FW_Side", nil];
    _unit setVariable ["FW_Tracked", nil];

};