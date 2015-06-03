/*
	Author: voiper

	Description: Check if unit is suitable to spectate. Needs to be as fast as possible.
	
	Parameters:
		0: Object; unit to check.
		
	Example:
		[unit] call vip_asp_fnc_cl_canSpec;

	Returns:
		Bool: whether is suitable to spectate.
*/

_unit = _this select 0;

if (_unit distance vip_asp_var_cl_penPos < 200) exitWith {false};
if (_unit distance [0,0,0] < 100) exitWith {false};
if (!vip_asp_var_cl_ai && !isPlayer _unit) exitWith {false};

true