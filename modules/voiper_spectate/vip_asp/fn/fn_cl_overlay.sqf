_mode = _this select 0;
_this = _this select 1;

switch _mode do {
	
	case "Init": {
	
		_display = _this select 0;
		_ctrl = _display displayCtrl 0;
		_count = _ctrl tvCount [];
		for "_i" from 0 to _count do {
			_ctrl tvDelete [_x];
		};
		
		_ctrl tvAdd [[], "Opfor"];
		_ctrl tvAdd [[], "Blufor"];
		_ctrl tvAdd [[], "Indfor"];
		_ctrl tvAdd [[], "Civilian"];
		
		_unitList = [];
		
		{
			_units = units _x;
			private ["_groupNum"];
			{
				if ((vip_asp_var_cl_units find _x > -1) && alive _x) then {
					_info = [_x] call vip_asp_fnc_cl_unitInfo;
					_text = _info select 0;
					_side = _info select 1;
					
					_icon = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "Icon");
					_picture = "\a3\ui_f\data\map\VehicleIcons\" + _icon + "_ca.paa";
					_treeIndex = [];
					_unitList pushBack _x;
					
					_savedUnit = vip_asp_var_cl_savedUnits find _x;
					if (_savedUnit > -1) then {_text = _text + " (#" + str (_savedUnit + 1) + ")"};
							
					if (_forEachIndex == 0) then {
						_groupNum = _ctrl tvAdd [[_side], _text];
						_treeIndex = [_side, _groupNum];
					} else {
						_num = _ctrl tvAdd [[_side, _groupNum], _text];
						_treeIndex = [_side, _groupNum, _num];
					};

					_ctrl tvSetPicture [_treeIndex, _picture];
					_ctrl tvSetData [_treeIndex, [_x] call vip_asp_fnc_cl_unitVar];
					_unitList pushBack _treeIndex;
				};
			} forEach _units;
		} forEach allGroups;
		
		if (!isNull vip_asp_var_cl_unit) then {
			if (alive vip_asp_var_cl_unit) then {
				_treeIndex = _unitList select ((_unitList find vip_asp_var_cl_unit) + 1);
				_ctrl tvSetCurSel _treeIndex;
			};
		};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Select": {
	
		_ctrl = _this select 0;
		_selection = _this select 1;
		if (count _selection < 2) exitWith {};
		
		_str = _ctrl tvData _selection;
		_unit = missionNamespace getVariable _str;
		vip_asp_var_cl_unit = _unit;
		if (vip_asp_var_cl_cameraOn) then {
			["Camera", ["Third"]] call vip_asp_fnc_cl_camera;
		} else {
			["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_camera;
		};
	};
};