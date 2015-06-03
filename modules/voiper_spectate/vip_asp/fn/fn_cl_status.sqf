_display = _this select 0;
_speedText = (str ([vip_asp_var_cl_moveScale, 4] call BIS_fnc_cutDecimals)) + "v";
(_display displayCtrl 0) ctrlSetText _speedText;
_name = "";
_colour = [1,1,1,1];
if (!isNull vip_asp_var_cl_unit) then {
	_info = [vip_asp_var_cl_unit] call vip_asp_fnc_cl_unitInfo;
	_name = _info select 0;
	_side = _info select 1;
	_colour = _info select 2;
	_colour set [3, 1];
};
(_display displayCtrl 1) ctrlSetText _name;
(_display displayCtrl 1) ctrlSetTextColor _colour;
_mode = if (vip_asp_var_cl_cameraOn) then {
	if (isNull vip_asp_var_cl_attach) then {"FREE"} else {"ATTACH"};
} else {
	if (vip_asp_var_cl_third) then {"THIRD"} else {"FIRST"};
};
(_display displayCtrl 2) ctrlSetText _mode;

_timeText = [dayTime] call BIS_fnc_timeToString;
(_display displayCtrl 3) ctrlSetText _timeText;

_fovText = (str ([vip_asp_var_cl_fov, 3] call BIS_fnc_cutDecimals)) + "a";
(_display displayCtrl 4) ctrlSetText _fovText;

_timeAccText = (str ([vip_asp_var_cl_accTime, 4] call BIS_fnc_cutDecimals)) + "x";
(_display displayCtrl 5) ctrlSetText _timeAccText;

_focusDist = [vip_asp_var_cl_focus select 0, 1] call BIS_fnc_cutDecimals;
_focusBlur = vip_asp_var_cl_focus select 1;

_focusText = if (_focusDist == -1 && _focusBlur == 1) then {"Auto"} else {if (_focusDist < 0) then {toString [8734]} else {str _focusDist + "m"}};
(_display displayCtrl 6) ctrlSetText _focusText;