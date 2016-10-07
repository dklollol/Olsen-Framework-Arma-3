/*
 * Author: Olsen
 *
 * Checks if unit is within area of marker, supports all shapes.
 *
 * Arguments:
 * 0: unit <object>
 * 1: marker <string>
 *
 * Return Value:
 * is unit in marker <bool>
 *
 * Public: Yes
 */

params [
    ["_unit", objNull, [objNull]],
    ["_marker", "", [""]]
];

private _pos = markerPos _marker;

private _xSize = (markerSize _marker) select 0;
private _ySize = (markerSize _marker) select 1;

private _radius = _xSize;

if (_ySize > _xSize) then {

    _radius = _ySize;

};

_result = false;

if ((_unit distance _pos) <= (_radius * 1.5)) then {

    private _pos_x = (getPosASL _unit) select 0;
    private _pos_y = (getPosASL _unit) select 1;

    _angle = markerDir _marker;

    private _pos_x = _pos_x - (_pos select 0);
    private _pos_y = _pos_y - (_pos select 1);

    if (_angle != 0) then {

        private _temp = _pos_x * cos(_angle) - _pos_y * sin(_angle);
        _pos_y = _pos_x * sin(_angle) + _pos_y * cos(_angle);
        _pos_x = _temp;

    };

    if ((markerShape _marker) == "ELLIPSE") then {

        if (_xSize == _ySize) then {

            if ((_unit distance _pos) <= _radius) then {

                _result = true;

            };

        } else {

            if (((_pos_x ^ 2) / (_xSize ^ 2) + (_pos_y ^ 2) / (_ySize ^ 2)) <= 1) then {

                _result = true;

            };

        };

    } else {


        if ((abs _pos_x) <= _xSize && (abs _pos_y) <= _ySize) then {

            _result = true;

        };

    };

};

_result