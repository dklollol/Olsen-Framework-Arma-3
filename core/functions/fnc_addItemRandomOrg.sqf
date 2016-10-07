/*
 * Author: Olsen
 *
 * Add random item to unit.
 *
 * Arguments:
 * 0: unit <object> and loadout name <string> <array>
 * 1: items <array>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

private ["_unit", "_loadoutType", "_items", "_amount", "_position", "_randomPick"];

_unit = (_this select 0) select 0;
_loadoutType = (_this select 0) select 1;

_items = _this select 1;

_amount = 1;
_position = "NONE";

if (count _items > 1) then {

    if (typeName (_items select 1) == "ARRAY") then {

        _position = "ARRAY";

    } else {

        if (typeName (_items select 1) == "SCALAR") then {

            _amount = _items select 1;

            if (count _items > 2) then {

                _position = _items select 2;

            };

            _items = _items select 0;

        };
    };
};

_randomPick = (_items select (([1, count _items] call FNC_RandomRange) - 1));

if (_position == "ARRAY") then {

    if (typeName (_randomPick select 0) == "ARRAY") then {

        {

            ([_unit, _loadoutType] + _x) call FNC_AddItemOrg;

        } forEach _randomPick;

    } else {

        ([_unit, _loadoutType] + _randomPick) call FNC_AddItemOrg;

    };

} else {

    [_unit, _loadoutType, _randomPick, _amount, _position] call FNC_AddItemOrg;

};