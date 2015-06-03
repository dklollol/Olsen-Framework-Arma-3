_unit = _this select 0;

_name = if (_unit getVariable ["vip_asp_name", ""] != "") then {
	_unit getVariable "vip_asp_name"
} else {
	if (alive _unit) then {
		name _unit;
	} else {
		"";
	};
};

_side = [_unit] call vip_cmn_fnc_cl_getSide;
_colour = [_side] call vip_asp_fnc_cl_sideColour;

if (!alive _unit) then {
	{_colour set [_forEachIndex, _x / 2.5]} forEach _colour;
	_colour set [3, 0.8];
};

[_name, _side, _colour]