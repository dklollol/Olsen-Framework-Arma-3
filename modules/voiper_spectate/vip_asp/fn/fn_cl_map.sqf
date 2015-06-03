_mode = _this select 0;
_this = _this select 1;

switch _mode do {
	
	case "Init": {

		_map = _this displayCtrl 1;

		if (isNil "vip_asp_mapPos") then {
			vip_asp_mapPos = [(vip_asp_var_cl_penPos select 0) / 4, (vip_asp_var_cl_penPos select 1) / 4];
		};

		if (isNil "vip_asp_mapZoom") then {
			vip_asp_mapZoom = 0.75;
		};

		_map ctrlMapAnimAdd [0, vip_asp_mapZoom, vip_asp_mapPos];
		ctrlMapAnimCommit _map;
		setMousePosition [0.5, 0.5];

		_map ctrlAddEventHandler ["Draw", {['Draw', _this] call vip_asp_fnc_cl_map}];
		_map ctrlAddEventHandler ["MouseButtonDblClick", {['Click', _this] call vip_asp_fnc_cl_map}];	
	};
	
	case "Close": {
		_map = _this displayCtrl 1;
		vip_asp_mapPos = _map ctrlMapScreenToWorld [0.5,0.5];
		vip_asp_mapZoom = ctrlMapScale _map;
	};
	
	case "Draw": {
	
		_map = _this select 0;
		_zoom = ctrlMapScale _map;
		
		if (vip_asp_var_cl_markers > 0) then {
			if (vip_asp_var_cl_markers > 2) then {
				[_map, _zoom] call vip_asp_fnc_cl_drawTracks2D;
			};
			[_map, _zoom] call vip_asp_fnc_cl_drawMines2D;
			[_map, _zoom] call vip_asp_fnc_cl_drawUnits2D;
		};
		
		if (vip_asp_var_cl_cameraOn) then {
			_scale = 5 * safeZoneH / 100;
			_map drawIcon ["\A3\ui_f\data\gui\Rsc\RscDisplayMissionEditor\iconcamera_ca.paa", [1,1,1,1], getPos vip_asp_obj_cl_cam, 500 * _scale, 500 * _scale, getDir vip_asp_obj_cl_cam, "", 0, 0, "PuristaMedium"];
		};
	};

	case "Click": {
		_map = _this select 0;
		_button = _this select 1;
		_shift = _this select 4;
		_mapPos = _map ctrlMapScreenToWorld [_this select 2, _this select 3];

		if (_shift) then {
			if (vip_asp_var_cl_cameraOn) then {
				_dir = [getPos vip_asp_obj_cl_cam, _mapPos] call BIS_fnc_dirTo;
				vip_asp_var_cl_vector set [0, _dir];
				[vip_asp_obj_cl_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;				
			};
		} else {
		
			_newUnit = objNull;
		
			_scale = ctrlMapScale _map;
			_radius = _scale * 250;
			_units = [];
			
			//find units near spot, ignoring height (necessary since nearestObjects takes height into account)
			{
				if (alive _x) then {
					_pos = getPos _x;
					_pos set [2, 0];
					if (_pos distance _mapPos <= _radius) then {
						_units pushBack _x;
					};
				};
			} forEach vip_asp_var_cl_units;
			
			//find closest unit to spot
			if (count _units > 0) then {
				_nearest = 0;
				for "_i" from 1 to (count _units - 1) do {
					if (((_units select _i) distance _mapPos) < ((_units select _nearest) distance _mapPos)) then {
						_nearest = _i;
					};
				};
				_newUnit = _units select _nearest;
			};
			
			if (!isNull _newUnit) then {
			
				if (vehicle _newUnit != _newUnit) then {
					_crew = crew (vehicle _newUnit);
					_newUnit = _crew select 0;
				};
				
				vip_asp_var_cl_unit = _newUnit;
				if (vip_asp_var_cl_cameraOn) then {
					["Camera", ["Third"]] call vip_asp_fnc_cl_camera;
				} else {
					if (vip_asp_var_cl_third) then {
						["Camera", ["Third"]] call vip_asp_fnc_cl_camera;
					} else {
						["Camera", ["First"]] call vip_asp_fnc_cl_camera;
					};
				};
			} else {
			
				if (!vip_asp_var_cl_cameraOn) then {
					["Camera", ["Free"]] call vip_asp_fnc_cl_camera;
				};
				_mapPos set [2, 10];
				vip_asp_obj_cl_cam setPosATL _mapPos;
			};
		};
	};
	
	case "KeyDown": {
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		_return = false;
	
		switch (_key) do {
			case (DIK_DELETE): {_return = true};
		};
		
		_return
	};
};