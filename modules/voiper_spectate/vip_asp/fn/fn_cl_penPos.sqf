/*
	Author: voiper
	
	Description: Determine position for spec pen.
	
	Parameters:
		None.	
	
	Returns:
		None.
*/
if (isNil "vip_asp_var_cl_penPos") then {
	_mapSize = (configFile >> "CfgWorlds" >> worldName >> "mapSize");
	_worldEdge = if (isNumber _mapSize) then {getNumber _mapSize} else {32768};
	_pos = [_worldEdge * 2, _worldEdge * 2];
	
	if (surfaceisWater _pos) then {
		_pos set [2, -1.4];
		vip_asp_var_cl_penPos = ASLtoATL _pos;
	} else {
		_pos set [2, 0];
		vip_asp_var_cl_penPos = _pos;
	};
};