/*
	Author: Karel Moricky, modified by voiper
	
	Description: Stripped down (faster) way of finding an object's default config side. Based on BIS_fnc_objectSide.
	
	Parameters:
		0: Object; object for which to find side.

	Returns:
		Number; side (0 for Opfor, 1 for Blufor, 2 for Independent).
	
	Example:
		_side = [player] call vip_cmn_fnc_cl_getSide;
*/

_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _obj) exitWith {["Inputted null object."] call BIS_fnc_error};

getNumber (configfile >> "cfgvehicles" >> typeof _obj >> "side")