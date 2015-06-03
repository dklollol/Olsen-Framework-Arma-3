_unit = _this select 0;
_killer = _this select 1;

if (isNil "_unit") exitWith {};
if (isNil "vip_asp_obj_cl_cam") exitWith {};
if (isNull _unit) exitWith {};

if (!isNull _killer) then {
	if (vip_asp_var_cl_markers > 2 && !difficultyEnabled "deathMessages") then {
		_nameUnit = name _unit;
		_nameKiller = name _killer;
		
		_text = if (_killer == _unit) then {
			format ["%1 died", _nameUnit]
		} else {
			format ["%2 killed by %1", _nameUnit, _nameKiller]
		};
		systemChat _text;
	};
};

if (_unit == vip_asp_var_cl_unit && !vip_asp_var_cl_cameraOn) then {
	["Camera", ["Free"]] call vip_asp_fnc_cl_camera;
	vip_asp_var_cl_unit = objNull;
};

_savedUnit = vip_asp_var_cl_savedUnits find _unit;
if (_savedUnit > -1) then {
	vip_asp_var_cl_savedUnits set [_savedUnit, objNull];
};

if (!isNil "vip_asp_var_cl_trackingArray") then {
	_pos = getPos _unit;
	_pos resize 2;
	_index = -1;
	{if ((_x select 0) == _unit) then {_index = _forEachIndex}} forEach vip_asp_var_cl_trackingArray;
	_unitArray = vip_asp_var_cl_trackingArray select _index;
	_tracks = _unitArray select 1;
	_tracks pushBack _pos;
	_unitArray set [1, _tracks];
	vip_asp_var_cl_trackingArray set [_index, _unitArray];
};