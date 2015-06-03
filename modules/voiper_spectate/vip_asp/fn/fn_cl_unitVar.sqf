/*
	Author: Karel Moricky, modified by voiper

	Description: Set or return an unique object variable (client only).

	Parameter(s):
		0: OBJECT

	Returns:
	STRING
*/

private ["_object","_var"];

_object = [_this, 0, objnull, [objnull]] call BIS_fnc_param;

if (isNull _object) exitwith {""};

_var = _object getVariable ["vip_objectVar", ""];

if (_var == "") then {
	_var = vehicleVarname _object;
	
	if (_var == "") then {
		_var = [_this, 1, "vip_obj", [""]] call BIS_fnc_param;
		_varID = [_var, 1] call BIS_fnc_counter;
		_var = _var + str _varID;
	};
	
	_object setVariable ["vip_objectVar", _var];
	missionNamespace setVariable [_var,_object];
	_object setVehicleVarname _var;
};

_var