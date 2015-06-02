/*
	Author: voiper
	
	Description: Roll a dice of arbitrary sides. Think DnD.
	
	Parameters:
		0: Number; number of sides of the dice (e.g. input of 5 will give 1/5 roll).
		
	Returns:
		Bool; true for success or false for failure.
	
	Example:
		_result = [6] call vip_cmn_fnc_cl_diceRoll;
*/

_sides = [_this, 0, 1, [1]] call BIS_fnc_param;

if (_sides < 1) exitWith {["Inputted number less than 1."] call BIS_fnc_error};

_chance = round(_sides) - 1;
_result = false;
_roll = round(random(_chance));
if (_roll == _chance) then {_result = true};

_result