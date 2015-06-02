/*
	Author: voiper
	
	Description: Very simple random 2D position.
	
	Parameters:
		0: Array; position to start from (position2D, position, positionASL, positionATL).
		1: Scalar; distance from starting position to search.

	Returns:
		Array; position2D.
		
	Example:
		_newPos = [getPos player, 100] call vip_cmn_fnc_cl_randomPos;
		_newPos set [2, 0]; //set position's Z to ground/water surface		
*/

_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
_dist = [_this, 1, 1, [0]] call BIS_fnc_param;

if (count _pos < 2) exitWith {["Inputted position is not valid."] call BIS_fnc_error};
if (_dist < 0) exitWith {["Input distance is less than 0."] call BIS_fnc_error};

_ret = [(_pos select 0) + (_dist - (random(2 * _dist))), (_pos select 1) + (_dist - (random(2 * _dist)))];

_ret