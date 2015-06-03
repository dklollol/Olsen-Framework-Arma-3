_units = allUnits;
_units append allDead;
vip_asp_var_cl_units = [];

{

	if (!isNil "vip_asp_obj_cl_cam") then {
		_listed = _x getVariable ["vip_asp_listed", false];

		if (!_listed) then {
			[_x] call vip_asp_fnc_cl_unitVar;
			_x addEventHandler ["Killed", {_this call vip_asp_fnc_cl_killed}];
			_x addEventHandler ["Respawn", {_this call vip_asp_fnc_cl_respawn}];
			_x setVariable ["vip_asp_listed", true];
		};
	};
	
	if ([_x] call vip_asp_fnc_cl_canSpec) then {vip_asp_var_cl_units pushback _x};

} forEach _units;