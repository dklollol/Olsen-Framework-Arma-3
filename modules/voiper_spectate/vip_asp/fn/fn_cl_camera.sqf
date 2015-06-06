/*
	Author: voiper, derived from code by Karel Moricky

	Description: Spectator camera and UI, based on Splendid camera.
	
	Parameters:
		0: String; mode; for mission making purposes, "Init" is the only one relevant one
		1: Array (optional):
			0: Bool (optional); whether camera is permanent (set to true for permadeath spectator; false for singleplayer photography sessions)
			1: Scalar (optional); unit path tracking mode; 0 for none; 1 for temporary (while camera is active); 2 for always on
			2: Bool (optional); whether to allow AI spectating
		
	Example:
		//camera isn't permanent, tracking is on while camera is on, AI on
		["Init", [false, 1, true]] call vip_asp_fnc_cl_camera;

	Returns:
	None.
*/

#define DIK_ESCAPE          0x01
#define DIK_1               0x02
#define DIK_2               0x03
#define DIK_3               0x04
#define DIK_4               0x05
#define DIK_5               0x06
#define DIK_6               0x07
#define DIK_7               0x08
#define DIK_8               0x09
#define DIK_9               0x0A
#define DIK_0               0x0B
#define DIK_MINUS           0x0C    /* - on main keyboard */
#define DIK_EQUALS          0x0D
#define DIK_BACKSPACE       0x0E    /* backspace */
#define DIK_LBRACKET        0x1A    /* [ */
#define DIK_RBRACKET        0x1B    /* ] */
#define DIK_BACKSLASH       0x2B    /* \ */
#define DIK_TAB             0x0F
#define DIK_Q               0x10
#define DIK_W               0x11
#define DIK_E               0x12
#define DIK_R               0x13
#define DIK_T               0x14
#define DIK_Y               0x15
#define DIK_U               0x16
#define DIK_I               0x17
#define DIK_O               0x18
#define DIK_P               0x19
#define DIK_LBRACKET        0x1A
#define DIK_RBRACKET        0x1B
#define DIK_RETURN          0x1C    /* Enter on main keyboard */
#define DIK_LCONTROL        0x1D
#define DIK_A               0x1E
#define DIK_S               0x1F
#define DIK_D               0x20
#define DIK_F               0x21
#define DIK_G               0x22
#define DIK_H               0x23
#define DIK_J               0x24
#define DIK_K               0x25
#define DIK_L               0x26
#define DIK_SEMICOLON       0x27
#define DIK_APOSTROPHE      0x28
#define DIK_GRAVE           0x29    /* accent grave */
#define DIK_LSHIFT          0x2A
#define DIK_BACKSLASH       0x2B
#define DIK_Z               0x2C
#define DIK_X               0x2D
#define DIK_C               0x2E
#define DIK_V               0x2F
#define DIK_B               0x30
#define DIK_N               0x31
#define DIK_M               0x32
#define DIK_COMMA           0x33
#define DIK_PERIOD          0x34    /* . on main keyboard */
#define DIK_SLASH           0x35    /* / on main keyboard */
#define DIK_RSHIFT          0x36
#define DIK_MULTIPLY        0x37    /* * on numeric keypad */
#define DIK_LMENU           0x38    /* left Alt */
#define DIK_SPACE           0x39
#define DIK_CAPITAL         0x3A
#define DIK_F1              0x3B
#define DIK_F2              0x3C
#define DIK_F3              0x3D
#define DIK_F4              0x3E
#define DIK_F5              0x3F
#define DIK_F6              0x40
#define DIK_F7              0x41
#define DIK_F8              0x42
#define DIK_F9              0x43
#define DIK_F10             0x44
#define DIK_F11             0x57
#define DIK_F12             0x58
#define DIK_NUMLOCK         0x45
#define DIK_SCROLL          0x46    /* Scroll Lock */
#define DIK_NUMPAD7         0x47
#define DIK_NUMPAD8         0x48
#define DIK_NUMPAD9         0x49
#define DIK_SUBTRACT        0x4A    /* - on numeric keypad */
#define DIK_NUMPAD4         0x4B
#define DIK_NUMPAD5         0x4C
#define DIK_NUMPAD6         0x4D
#define DIK_ADD             0x4E    /* + on numeric keypad */
#define DIK_NUMPAD1         0x4F
#define DIK_NUMPAD2         0x50
#define DIK_NUMPAD3         0x51
#define DIK_NUMPAD0         0x52
#define DIK_NUMPADDECIMAL   0x53    /* . on numeric keypad */
#define DIK_NUMPADENTER     0x9C    /* Enter on numeric keypad */
#define DIK_NUMPADDIVIDE    0xB5    /* / on numeric keypad */
#define DIK_NUMPADMULTIPLY  0x37        /* * on numeric keypad */
#define DIK_END             0xCF    /* End on arrow keypad */
#define DIK_PRIOR           0xC9    /* PgUp on arrow keypad */
#define DIK_DELETE          0xD3    /* Delete on arrow keypad */
#define DIK_LEFT            0xCB    /* LeftArrow on arrow keypad */
#define DIK_RIGHT           0xCD    /* RightArrow on arrow keypad */
#define DIK_UP              0xC8    /* UpArrow on arrow keypad */
#define DIK_DOWN            0xD0    /* DownArrow on arrow keypad */

disableSerialization;
_mode = [_this, 0, "Init", [displayNull, ""]] call BIS_fnc_param;
_this = [_this, 1, []] call BIS_fnc_param;

switch _mode do {

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Init": {
	
		if (isNull findDisplay 46) exitWith {
			_this spawn {
				waitUntil {!isNull findDisplay 46};
				["Init", _this] call vip_asp_fnc_cl_camera;
			};		
		};
		
		vip_asp_var_cl_noEscape = if (count _this > 0) then {_this select 0} else {false};
		_tracking = if (count _this > 1) then {_this select 1} else {0};
		vip_asp_var_cl_ai = if (count _this > 2) then {_this select 2} else {false};
		
		vip_asp_var_cl_alwaysTracking = switch (_tracking) do {
			case 0;
			case 1: {false};
			case 2: {true};
		};
		
		if (_tracking > 0) then {
			if (isNil "vip_asp_var_cl_trackingArray") then {[true] call vip_asp_fnc_cl_tracking};
		};
		
		call vip_asp_fnc_cl_penPos;

		//camera
		_camPos = if (!isNil "vip_asp_var_cl_startingPos") then {
			vip_asp_var_cl_startingPos
		} else {
			if (!vip_asp_var_cl_noEscape) then {
				getPos cameraOn
			} else {
				[(vip_asp_var_cl_penPos select 0) / 2, (vip_asp_var_cl_penPos select 0) / 2, 0]
			};
		};
		_camPos set [2, (_camPos select 2) + 2];
		_cam = missionnamespace getVariable ["vip_asp_obj_cl_cam", "camera" camCreate _camPos];
		_cam cameraEffect ["internal", "back"];
		_cam camSetFocus [-1, -1];
		_cam camCommit 0;
		showCinemaBorder false;
		cameraEffectEnableHUD true;
		setViewDistance 3000;
		
		//variables
		vip_asp_obj_cl_cam = _cam;
		vip_asp_var_cl_LMB = false;
		vip_asp_var_cl_RMB = false;		
		vip_asp_var_cl_vector = [0,0,0];
		vip_asp_var_cl_fov = 0.7;
		vip_asp_var_cl_vision = 0;
		vip_asp_var_cl_moveScale = 0.1;
		vip_asp_var_cl_cameraOn = true;
		vip_asp_var_cl_focus = [-1, -1];
		vip_asp_var_cl_lock = [-1];
		vip_asp_var_cl_attach = objNull;
		vip_asp_var_cl_unit = objNull;
		vip_asp_var_cl_mouseBusy = false;
		vip_asp_var_cl_markers = 3;
		vip_asp_var_cl_accTime = 1;
		vip_asp_var_cl_third = false;
		
		//define only if doesn't exist (to preserve saved spots from a previous cam session)
		if (isNil "vip_asp_var_cl_savedSpots") then {
			vip_asp_var_cl_savedSpots = [];
			for "_i" from 0 to 11 do {vip_asp_var_cl_savedSpots set [_i, []]};
		};
		
		if (isNil "vip_asp_var_cl_savedUnits") then {
			vip_asp_var_cl_savedUnits = [];
			for "_i" from 0 to 9 do {vip_asp_var_cl_savedUnits set [_i, objNull]};
		};
		
		vip_asp_var_cl_keys = [];
		_DIKcodes = true call BIS_fnc_keyCode;
		_DIKlast = _DIKcodes select (count _DIKcodes - 1);
		for "_i" from 0 to (_DIKlast - 1) do {
			vip_asp_var_cl_keys set [_i, false];
		};
		
		_display = findDisplay 46;
		
		vip_asp_eh_draw3D = addMissionEventhandler ["Draw3D", {['Draw3D', _this] call vip_asp_fnc_cl_camera}];
		addMissionEventHandler ["Ended", {if (!isNil "vip_asp_obj_cl_cam") then {["Exit"] call vip_asp_fnc_cl_camera}}];
		vip_asp_eh_key1 = _display displayAddEventHandler ["keyDown", {['KeyDown', _this] call vip_asp_fnc_cl_camera}];
		vip_asp_eh_key2 = _display displayAddEventHandler ["keyUp", {['KeyUp', _this] call vip_asp_fnc_cl_camera}];
		vip_asp_eh_key3 = _display displayAddEventHandler ["mouseButtonDown", {['MouseButtonDown', _this] call vip_asp_fnc_cl_camera}];
		vip_asp_eh_key4 = _display displayAddEventHandler ["mouseButtonUp", {['MouseButtonUp',_this] call vip_asp_fnc_cl_camera}];
		vip_asp_eh_key5 = _display displayAddEventHandler ["mouseZChanged", {['MouseZChanged',_this] call vip_asp_fnc_cl_camera}];
		vip_asp_eh_key6 = _display displayAddEventHandler ["mouseMoving", {['Mouse',_this] call vip_asp_fnc_cl_camera}];
		vip_asp_eh_key7  =_display displayAddEventHandler ["mouseHolding", {['Mouse',_this] call vip_asp_fnc_cl_camera}];

		//remove mission layer
		_displayMission = [] call (uiNamespace getVariable "BIS_fnc_displayMission");
		_control = _displayMission displayCtrl 11400;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;

		//kill layers
		cutText ["", "Plain"];
		titleText ["", "Plain"];
		_layers = missionNamespace getVariable ["BIS_fnc_rscLayer_list",[]];

		for "_i" from 1 to (count _layers - 1) step 2 do {
			(_layers select _i) cutText ["", "Plain"];
		};
		clearRadio;
		
		//crosshair
		_layer = ["vip_asp_rsc_crosshair"] call BIS_fnc_rscLayer;
		_layer cutRsc ["vip_asp_rsc_crosshair", "PLAIN", 2, true];
		
		//compass
		_layer = ["vip_asp_rsc_compass"] call BIS_fnc_rscLayer;
		_layer cutRsc ["vip_asp_rsc_compass", "PLAIN", 2, true];
		
		//status
		_layer = ["vip_asp_rsc_status"] call BIS_fnc_rscLayer;
		_layer cutRsc ["vip_asp_rsc_status", "PLAIN", 2, true];
		
		//help
		_layer = ["vip_asp_rsc_help"] call BIS_fnc_rscLayer;
		preloadTitleRsc ["vip_asp_rsc_help", "PLAIN", 0, true];
		
		if (isClass (configFile >> "CfgPatches" >> "ace_nametags")) then {
			vip_asp_var_cl_ACEtags = [ace_nametags_showPlayerNames, ace_nametags_showNamesForAI];
			ace_nametags_showPlayerNames = 0;
			ace_nametags_showNamesForAI = false;
		};
		
		if (isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
			["vip_asp_aceInteract", {false}] call ace_common_fnc_addCanInteractWithCondition;
		};
		
		["Press H for Controls", 0, 1] spawn BIS_fnc_dynamicText;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Mouse": {
		_mapOn = uiNamespace getVariable "vip_asp_dlg_map";
		if (!isNull _mapOn) exitWith {};
		
		_keys = vip_asp_var_cl_keys;
		_cam = vip_asp_obj_cl_cam;
		_dir = vip_asp_var_cl_vector select 0;
		_pitch = vip_asp_var_cl_vector select 1;
		_bank = vip_asp_var_cl_vector select 2;
		_camPos = getPosASL _cam;
		_coef = (vip_asp_var_cl_moveScale * (((getPosATL _cam) select 2) / 2)) min 50 max 0.001;
		
		_move = {
			_inPos = _this;
			if (_inPos select 2 > 20000) then {_inPos set [2, 20000]};
			_obj = vip_asp_var_cl_attach;
			if !(isNull _obj) then {
				if ((vip_asp_var_cl_lock select 0) < 0) then {
					_modelPos = _obj worldToModel (ASLtoATL _inPos);
					_cam attachTo [_obj, _modelPos];
				};
			} else {
				_cam setPosASL _inPos;
			};
		};
		
		if (vip_asp_var_cl_LMB || vip_asp_var_cl_RMB) then {
			if (vip_asp_var_cl_mouseBusy) exitWith {};
			_mX = (_this select 1) * (vip_asp_var_cl_accTime max 0.05);
			_mY = (_this select 2) * (vip_asp_var_cl_accTime max 0.05);

			if (vip_asp_var_cl_RMB) then {

				_dX = _mX;
				_dY = -_mY;
				
				_camPos = [_camPos, _dY, getDir _cam] call BIS_fnc_relPos;
				_camPos = [_camPos, _dX, getDir _cam + 90] call BIS_fnc_relPos;
				
				_camPos call _move;

			} else {
				if (vip_asp_var_cl_lock select 0 > -1) exitWith {};
				_dX = _mX / 50 * 180 * vip_asp_var_cl_fov;
				_dY = -_mY / 50 * 180 * vip_asp_var_cl_fov;

				if (_keys select DIK_LSHIFT) then {
					_pitch = (_pitch + _dY) max -180 min 180;
					_bank = (_bank + _dX) max -181 min 181;
					if (_bank <= -181) then {_bank = 180} else {if (_bank >= 181) then {_bank = -180}};
				} else {
					_dir = _dir + _dX;
					_pitch = (_pitch + _dY) max -90 min 90;
				};
				vip_asp_var_cl_vector = [_dir, _pitch, _bank];
				[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
			};
		};		

		_camMove = {
			_dX = _this select 0;
			_dY = _this select 1;
			_dZ = _this select 2;
			_pos = getPosASL _cam;
			_moveDir = (getDir _cam) + _dX * 90;
			_camPos = [
				(_pos select 0) + ((sin (_moveDir)) * _coef * _dY),
				(_pos select 1) + ((cos (_moveDir)) * _coef * _dY),
				(_pos select 2) + _dZ * _coef / 1.5
			];
			//for some reason, at visual height = 0, cameras report 10cm higher than they actually are
			_camPos set [2, (_camPos select 2) max (getTerrainHeightASL _camPos + 0.1)]; 

			_camPos call _move;
		};
		
		_camRotate = {
			if ((vip_asp_var_cl_lock select 0) > -1) exitWith {};
			_dX = (_this select 0) * vip_asp_var_cl_fov * _rotMod;
			_dY = (_this select 1) * vip_asp_var_cl_fov * _rotMod;
			_pitch = ((vip_asp_var_cl_vector select 1) + _dY) max -90 min 90;
			_bank = vip_asp_var_cl_vector select 2;
			_dir = _dir + _dX;
			vip_asp_var_cl_vector = [_dir, _pitch, _bank];
			[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
		};
		
		_camBank = {
			if ((vip_asp_var_cl_lock select 0) > -1) exitWith {};
			_dZ = (_this select 0) * _rotMod;
			_pitch = vip_asp_var_cl_vector select 1;
			_bank = ((vip_asp_var_cl_vector select 2) + _dZ) max -181 min 181;
			if (_bank == -181) then {_bank = 180} else {if (_bank == 181) then {_bank = -180}};
			vip_asp_var_cl_vector = [_dir, _pitch, _bank];
			[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
		};
		
		_numPad0 = _keys select DIK_NUMPAD0;
		_numPadDel = _keys select DIK_NUMPADDECIMAL;
		_rotMod = if (_numPad0 && !_numPadDel) then {
			5
		} else {
			if (!_numPad0 && _numPadDel) then {0.1} else {1};
		};

		if (_keys select DIK_W) then {[0,1,0] call _camMove};
		if (_keys select DIK_S) then {[0,-1,0] call _camMove};
		if (_keys select DIK_A) then {[-1,1,0] call _camMove};
		if (_keys select DIK_D) then {[1,1,0] call _camMove};

		if (_keys select DIK_Q) then {[0,0,1] call _camMove};
		if (_keys select DIK_Z) then {[0,0,-1] call _camMove};

		if (_keys select DIK_NUMPAD1) then {[-1,-1,0] call _camRotate};
		if (_keys select DIK_NUMPAD2) then {[+0,-1,0] call _camRotate};
		if (_keys select DIK_NUMPAD3) then {[+1,-1,0] call _camRotate};
		if (_keys select DIK_NUMPAD4) then {[-1,+0,0] call _camRotate};
		if (_keys select DIK_NUMPAD6) then {[+1,+0,0] call _camRotate};
		if (_keys select DIK_NUMPAD7) then {[-1,+1,0] call _camRotate};
		if (_keys select DIK_NUMPAD8) then {[+0,+1,0] call _camRotate};
		if (_keys select DIK_NUMPAD9) then {[+1,+1,0] call _camRotate};
		if (_keys select DIK_NUMPADDIVIDE) then {[-1] call _camBank};
		if (_keys select DIK_NUMPADMULTIPLY) then {[+1] call _camBank};

		if (_keys select DIK_ADD) then {
			vip_asp_var_cl_fov = vip_asp_var_cl_fov - (vip_asp_var_cl_fov / 50 * _rotMod) max 0.01;
			_cam camPrepareFOV vip_asp_var_cl_fov;
			_cam camCommitPrepared 0;
		};
		if (_keys select DIK_SUBTRACT) then {
			vip_asp_var_cl_fov = vip_asp_var_cl_fov + (vip_asp_var_cl_fov / 50 * _rotMod) min 2;
			_cam camPrepareFOV vip_asp_var_cl_fov;
			_cam camCommitPrepared 0;
		};
		
		if (_keys select DIK_NUMPADENTER) then {
			vip_asp_var_cl_fov = 0.7;
			_cam camPrepareFOV vip_asp_var_cl_fov;
			_cam camCommitPrepared 0;
		};
		
		if (_keys select DIK_MINUS) then {
			_cur = vip_asp_var_cl_focus select 0;
			if (_cur < 0) then {_cur = 1};
			_cur = _cur - (_cur / 25) max 0.25;
			vip_asp_var_cl_focus = [_cur, 1.5];
			_cam camSetFocus vip_asp_var_cl_focus;
			_cam camCommit 0;
		};
		
		if (_keys select DIK_EQUALS) then {
			_cur = vip_asp_var_cl_focus select 0;
			if (_cur < 0) then {_cur = 1};
			_cur = _cur + (_cur / 25) min 5000;
			vip_asp_var_cl_focus = [_cur, 1.5];
			_cam camSetFocus vip_asp_var_cl_focus;
			_cam camCommit 0;
		};
		
		if (_keys select DIK_LBRACKET)then {
			if (!isMultiplayer) then {
				_cur = vip_asp_var_cl_accTime;
				_cur = _cur - (_cur / 25) max 0;
				vip_asp_var_cl_accTime = _cur;
				setAccTime vip_asp_var_cl_accTime;
			};
		};
		
		if (_keys select DIK_RBRACKET)then {
			if (!isMultiplayer) then {
				_cur = vip_asp_var_cl_accTime;
				_cur = _cur + (_cur / 25) min 4;
				vip_asp_var_cl_accTime = _cur;
				setAccTime vip_asp_var_cl_accTime;
			};
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonDown": {
		_mapOn = uiNamespace getVariable "vip_asp_dlg_map";
		if (!isNull _mapOn) exitWith {};

		_button = _this select 1;
		_mX = _this select 2;
		_mY = _this select 3;
		_shift = _this select 4;
		_ctrl = _this select 5;
		_alt = _this select 6;

		switch (_button) do {
			case 0: {vip_asp_var_cl_LMB = true};
			case 1: {vip_asp_var_cl_RMB = true};
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonUp": {
		_mapOn = uiNamespace getVariable "vip_asp_dlg_map";
		if (!isNull _mapOn) exitWith {};
		
		_button = _this select 1;
		switch (_button) do {
			case 0: {vip_asp_var_cl_LMB = false};
			case 1: {vip_asp_var_cl_RMB = false};
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseZChanged": {
		_mapOn = uiNamespace getVariable "vip_asp_dlg_map";
		if (!isNull _mapOn) exitWith {};
		
		_diff = _this select 1;
		if (_diff > 0) then {
			vip_asp_var_cl_moveScale = vip_asp_var_cl_moveScale + (vip_asp_var_cl_moveScale / 10) min 1;
		} else {
			vip_asp_var_cl_moveScale = vip_asp_var_cl_moveScale - (vip_asp_var_cl_moveScale / 10) max 0.001;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyDown": {
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		_return = false;

		vip_asp_var_cl_keys set [_key, true];

		_cam = vip_asp_obj_cl_cam;
		_camOn = vip_asp_var_cl_cameraOn;
		_unit = vip_asp_var_cl_unit;
		_lock = vip_asp_var_cl_lock select 0;

		_camPos = [getPos _cam, vip_asp_var_cl_vector, vip_asp_var_cl_fov, vip_asp_var_cl_focus];
		
		_camSaveSpot = {
			_num = _this select 0;
			if (!isNull vip_asp_var_cl_attach) then {
				_vector = _camPos select 1;
				_dir = _vector select 0;
				_vector set [0, _dir - (getDir vip_asp_var_cl_attach)];
				_camPos set [1, _vector];
			};
			vip_asp_var_cl_savedSpots set [_num, _camPos];		
		};
		
		_camLoadSpot = {
			_num = _this select 0;
			_arr = vip_asp_var_cl_savedSpots select _num;
			if (count (_arr) > 0) then {
				if (!_camOn) then {["Camera", ["Free"]] call vip_asp_fnc_cl_camera;};
				call _detach;
				_cam setPos (_arr select 0);
				_vector = _arr select 1;
				[_cam, _vector] call BIS_fnc_setObjectRotation;
				_cam camPrepareFOV (_arr select 2);
				_cam camPrepareFocus (_arr select 3);
				_cam camCommitPrepared 0;
				vip_asp_var_cl_vector = _vector;
			};	
		};
		
		_camSaveUnit = {
			_num = _this select 0;
			
			if (!isNull _unit) then {
				_alreadySaved = vip_asp_var_cl_savedUnits find _unit;
				if (_alreadySaved > -1) then {
					vip_asp_var_cl_savedUnits set [_alreadySaved, objNull];
				};
				vip_asp_var_cl_savedUnits set [_num, _unit]
			};
		};
		
		_camLoadUnit = {
			_num = _this select 0;
			_unit = vip_asp_var_cl_savedUnits select _num;
			if (!isNull _unit) then {
				if (_lock > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_camera};
				if (vip_asp_var_cl_unit == _unit) then {
					call _detach;
					if (_camOn) then {
						["Camera", ["Third"]] call vip_asp_fnc_cl_camera;
					} else {
						["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_camera;
					};
				} else {
				
					vip_asp_var_cl_unit = _unit;
					if ((vip_asp_var_cl_lock select 0) > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_camera};
					if (!_camOn) then {
						call _detach;
						["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_camera;
					};
				};
			};	
		};
		
		_detach = {
			if (!isNull vip_asp_var_cl_attach) then {
				["Camera", ["Attach"]] call vip_asp_fnc_cl_camera;
			};
		};
		
		switch (_key) do {

			case (DIK_F1): {if (_ctrl) then {[0] call _camSaveSpot} else {[0] call _camLoadSpot}; _return = true};
			case (DIK_F2): {if (_ctrl) then {[1] call _camSaveSpot} else {[1] call _camLoadSpot}; _return = true};
			case (DIK_F3): {if (_ctrl) then {[2] call _camSaveSpot} else {[2] call _camLoadSpot}; _return = true};
			case (DIK_F4): {if (_ctrl) then {[3] call _camSaveSpot} else {[3] call _camLoadSpot}; _return = true};
			case (DIK_F5): {if (_ctrl) then {[4] call _camSaveSpot} else {[4] call _camLoadSpot}; _return = true};
			case (DIK_F6): {if (_ctrl) then {[5] call _camSaveSpot} else {[5] call _camLoadSpot}; _return = true};
			case (DIK_F7): {if (_ctrl) then {[6] call _camSaveSpot} else {[6] call _camLoadSpot}; _return = true};
			case (DIK_F8): {if (_ctrl) then {[7] call _camSaveSpot} else {[7] call _camLoadSpot}; _return = true};
			case (DIK_F9): {if (_ctrl) then {[8] call _camSaveSpot} else {[8] call _camLoadSpot}; _return = true};
			case (DIK_F10): {if (_ctrl) then {[9] call _camSaveSpot} else {[9] call _camLoadSpot}; _return = true};
			case (DIK_F11): {if (_ctrl) then {[10] call _camSaveSpot} else {[10] call _camLoadSpot}; _return = true};
			case (DIK_F12): {if (_ctrl) then {[11] call _camSaveSpot} else {[11] call _camLoadSpot}; _return = true};

			case (DIK_1): {if (_ctrl) then {[0] call _camSaveUnit} else {[0] call _camLoadUnit}; _return = true};
			case (DIK_2): {if (_ctrl) then {[1] call _camSaveUnit} else {[1] call _camLoadUnit}; _return = true};
			case (DIK_3): {if (_ctrl) then {[2] call _camSaveUnit} else {[2] call _camLoadUnit}; _return = true};
			case (DIK_4): {if (_ctrl) then {[3] call _camSaveUnit} else {[3] call _camLoadUnit}; _return = true};
			case (DIK_5): {if (_ctrl) then {[4] call _camSaveUnit} else {[4] call _camLoadUnit}; _return = true};
			case (DIK_6): {if (_ctrl) then {[5] call _camSaveUnit} else {[5] call _camLoadUnit}; _return = true};
			case (DIK_7): {if (_ctrl) then {[6] call _camSaveUnit} else {[6] call _camLoadUnit}; _return = true};
			case (DIK_8): {if (_ctrl) then {[7] call _camSaveUnit} else {[7] call _camLoadUnit}; _return = true};
			case (DIK_9): {if (_ctrl) then {[8] call _camSaveUnit} else {[8] call _camLoadUnit}; _return = true};
			case (DIK_0): {if (_ctrl) then {[9] call _camSaveUnit} else {[9] call _camLoadUnit}; _return = true};
			
			case (DIK_NUMPAD5): {
				_dir = getDir _cam;
				if (!isNull vip_asp_var_cl_attach) then {_dir = _dir - getDir vip_asp_var_cl_attach};
				vip_asp_var_cl_vector =  [_dir, 0, 0];
				[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
				vip_asp_var_cl_fov = 0.7;
				_cam camPrepareFOV vip_asp_var_cl_fov;
				_cam camCommitPrepared 0;
			};
			
			case (DIK_NUMPADENTER): {_return = true};
			
			case (DIK_NUMPAD0): {_return = true};
			
			case (DIK_NUMPADDEL): {_return = true};
			
			case (DIK_BACKSPACE): {
				vip_asp_var_cl_focus = if (!_shift) then {
					[-1, 1];
				} else {
					[-1, -1];
				};
				_cam camPrepareFocus vip_asp_var_cl_focus;
				_cam camCommitPrepared 0;
				_return = true;
			};
			
			case (DIK_BACKSLASH): {
				if (!isMultiplayer) then {
					vip_asp_var_cl_accTime = 1;
					setAccTime vip_asp_var_cl_accTime;
				};
			};
			
			case (DIK_GRAVE): {_return = true};
			
			case (DIK_SPACE): {
				if (!_camOn) exitWith {};
				if (_ctrl) then {
					["Camera", ["Attach"]] call vip_asp_fnc_cl_camera;
				} else {
					["Camera", ["Lock"]] call vip_asp_fnc_cl_camera;
				};
			};
			
			case (DIK_LEFT): {
				["Camera", ["NewUnit", -1]] call vip_asp_fnc_cl_camera
			};
			
			case (DIK_RIGHT): {
				["Camera", ["NewUnit", 1]] call vip_asp_fnc_cl_camera
			};
			
			case (DIK_UP): {
				if (isNull vip_asp_var_cl_unit) exitWith {};
				if (_lock > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_camera};
				call _detach;
				if (_camOn) then {
					["Camera", ["Third"]] call vip_asp_fnc_cl_camera;
				} else {
					if (vip_asp_var_cl_third) then {
						["Camera", ["First"]] call vip_asp_fnc_cl_camera;
					};
				};
			};
			
			case (DIK_DOWN): {
				if (isNull vip_asp_var_cl_unit) exitWith {};
				if (_lock > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_camera};
				call _detach;
				if (!_camOn) then {
					if (!vip_asp_var_cl_third) then {
						["Camera", ["Third"]] call vip_asp_fnc_cl_camera;
					} else {
						["Camera", ["Free"]] call vip_asp_fnc_cl_camera;
					};
				};
			};
			
			case (DIK_T): {
				vip_asp_var_cl_markers = vip_asp_var_cl_markers + 1;
				if (vip_asp_var_cl_markers > 3) then {vip_asp_var_cl_markers = 0};
				if (vip_asp_var_cl_markers == 0) then {clearRadio};
			};
			
			case (DIK_U): {
				_map = uiNameSpace getVariable ["vip_asp_dlg_map", findDisplay 12202];
				if (!isNull _map) exitWith {};
			
				_overlay = uiNamespace getVariable ["vip_asp_dlg_overlay", findDisplay 12200];
				if (isNull _overlay) then {
					createDialog "vip_asp_dlg_overlay";
				} else {
					closeDialog 0;
				};
			};
			
			case (DIK_X): {
				_layer = ["vip_asp_rsc_crosshair"] call BIS_fnc_rscLayer;
				_xhair = uiNamespace getVariable "vip_asp_rsc_crosshair";
				if (isNull _xhair) then {
					_layer cutRsc ["vip_asp_rsc_crosshair", "PLAIN", 0, true];
					["CrosshairColour"] call vip_asp_fnc_cl_camera;
				} else {
					_layer cutText ["", "PLAIN"];
				};
			};
			
			case (DIK_C): {
				_layer = ["vip_asp_rsc_compass"] call BIS_fnc_rscLayer;
				if (isNull (uiNamespace getVariable "vip_asp_rsc_compass")) then {
					_layer cutRsc ["vip_asp_rsc_compass", "PLAIN", 0, true];
				} else {
					_layer cutText ["", "PLAIN"];
				};
			};

			case (DIK_V): {
				_layer = ["vip_asp_rsc_status"] call BIS_fnc_rscLayer;
				if (isNull (uiNamespace getVariable "vip_asp_rsc_status")) then {
					_layer cutRsc ["vip_asp_rsc_status", "PLAIN", 0, true];
				} else {
					_layer cutText ["", "PLAIN"];
				};
			};
				
			case (DIK_G): {
				_vd = uiNamespace getVariable ["vip_asp_dlg_vd", findDisplay 12201];
				if (isNull _vd) then {createDialog "vip_asp_dlg_vd"};
			};
			
			case (DIK_H): {
				_layer = ["vip_asp_rsc_help"] call BIS_fnc_rscLayer;
				if (isNull (uiNamespace getVariable "vip_asp_rsc_help")) then {
					_layer cutRsc ["vip_asp_rsc_help", "PLAIN", 0, true];
				} else {
					_layer cutText ["", "PLAIN"];
				};					
			};
			
			case (DIK_M): {
				_map = uiNameSpace getVariable ["vip_asp_dlg_map", findDisplay 12202];
				if (isNull _map) then {
					createDialog "vip_asp_dlg_map";
				} else {
					closeDialog 0;
				};
			};

			case (DIK_N): {
				vip_asp_var_cl_vision = vip_asp_var_cl_vision + 1;
				if (vip_asp_var_cl_vision > 4) then {vip_asp_var_cl_vision = 0};
				switch (vip_asp_var_cl_vision) do {
					case 0: {
						camUseNVG false;
						false SetCamUseTi 0;
					};
					case 1: {
						camUseNVG true;
						false SetCamUseTi 0;
					};
					case 2: {
						camUseNVG false;
						true SetCamUseTi 0;
					};
					case 3: {
						camUseNVG false;
						true SetCamUseTi 1;
					};
					
					case 4: {
						camUseNVG false;
						true SetCamUseTi 4;
					};
				};
			};

			case (DIK_ESCAPE): {
				if (!vip_asp_var_cl_noEscape) then {
					_return = true;
					_this spawn {
						disableSerialization;
						_display = _this select 0;
						_message = ["Do you want to exit camera mode?", "Adapted Spectator Platform", nil, true, _display] call BIS_fnc_guiMessage;
						if (_message) then {["Exit"] call vip_asp_fnc_cl_camera};
					};
				};
			};
			default {};
		};
		
		_return
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyUp": {
		vip_asp_var_cl_keys set [_this select 1, false];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Camera": {
	
		_mode = _this select 0;
		
		_cam = vip_asp_obj_cl_cam;
		_camOn = vip_asp_var_cl_cameraOn;
		_unit = vip_asp_var_cl_unit;
		_lock = vip_asp_var_cl_lock select 0;
		
		_findTarget = {
		
			_ret = [];
			_screenPos = screenToWorld [0.5,0.5];
			_camPosASL = getPosASL _cam;
			_camPosReal = getPos _cam;
			_endPosASL = [_screenPos select 0, _screenPos select 1, getTerrainHeightASL _screenPos];
			_endPosReal = if (surfaceIsWater _endPosASL) then {_endPosASL} else {ASLtoATL _endPosASL};
			_objs = lineIntersectsWith [_camPosASL, _endPosASL, objNull, objNull, true];
			
			if (count _objs > 0) then { //if vehicle/object found
				_obj = _objs select (count _objs - 1);
				_ret = _obj;
			} else { //check for units near endpoint instead
				_units = allUnits;
				if (count _units > 0) then {
					_nearestUnit = _units select 0;		
					{if (_endPosReal distance _x < _endPosReal distance _nearestUnit) then {_nearestUnit = _x}} forEach _units;
					_intersect = [_nearestUnit, "FIRE"] intersect [_camPosReal, _endPosReal];
					if (count (_intersect) > 0) then {
						_ret = _nearestUnit;
					} else { //check for units near camera instead
						_nearestUnit = _units select 0;
						{if (_cam distance _x < _cam distance _nearestUnit) then {_nearestUnit = _x}} forEach _units;
						_intersect = [_nearestUnit, "FIRE"] intersect [_camPosReal, _endPosReal];
						if (count _intersect > 0) then {
							_ret = _nearestUnit;
						} else { //if nothing else, point at ground position
							_ret = _endPosReal;
						};
					};
				};				
			};
			_ret
		};
		
		switch (_mode) do {
		
			case "Free": {
				vip_asp_var_cl_cameraOn = true;
				vip_asp_var_cl_third = false;
				detach _cam;
				player switchCamera "Internal";
				_cam cameraEffect ["Internal", "Back"];
				cameraEffectEnableHUD true;
				_dir = getDir _unit;
				_pos = [_unit, -5, _dir] call BIS_fnc_relPos;
				_pos set [2, ((getPos _unit) select 2) + 2];
				_cam setPos _pos;
				vip_asp_var_cl_vector set [0, _dir];
				[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
			};
			
			case "First": {
				if (_unit == player) exitWith {};
				vip_asp_var_cl_cameraOn = false;
				vip_asp_var_cl_third = false;
				_cam attachTo [vehicle _unit, [0,0.1,0]];
				_cam cameraEffect ["Terminate", "Back"];
				vehicle _unit switchCamera "Internal";
			};
			
			case "Third": {
				if (_unit == player) exitWith {};
				vip_asp_var_cl_third = true;
				vip_asp_var_cl_cameraOn = false;
				if (!difficultyEnabled "3rdPersonView") then {
					player switchCamera "Internal";
					_cam cameraEffect ["Internal", "Back"];
					cameraEffectEnableHUD true;
					if (vehicle _unit == _unit) then {
						_cam attachTo [_unit, [0.1, -2.4, 0.6], "head"];
					} else {
						_cam attachTo [vehicle _unit, [0, -7, 1.5]];
					};
				} else {
					_cam attachTo [vehicle _unit, [0,0.1,0]];
					_cam cameraEffect ["Terminate", "Back"];
					vehicle _unit switchCamera "External";
				};
			};
			
			case "NewUnit": {
			
				_increment = _this select 1;
				_units = [];
				{
					if (alive _x) then {_units pushBack _x};
				} forEach vip_asp_var_cl_units;
				
				_count = count _units;
				
				if (_count > 0) then {

					_index = _units find _unit;
					_index = _index + _increment;
					if (_index < 0) then {_index = _count - 1};
					if (_index > (_count - 1)) then {_index = 0};
				
					vip_asp_var_cl_unit = _units select _index;
					if (!_camOn) then {["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_camera};
				};		
			};
			
			case "SwitchUnit": {
				if (!vip_asp_var_cl_third) then {
					["Camera", ["First"]] call vip_asp_fnc_cl_camera;
				} else {
					["Camera", ["Third"]] call vip_asp_fnc_cl_camera;
				};
			};
			
			case "Lock": {
				if (_lock < 0) then {
		
					_target = call _findTarget;
					
					if (typeName _target == "OBJECT") then {
						vip_asp_var_cl_lock = [1, _target];
					} else {
						if (count _target > 0) then {
							vip_asp_var_cl_lock = [1, _target];
						};
					};
					
					_cam camPrepareTarget (vip_asp_var_cl_lock select 1);
					_cam camCommitPrepared 0;
					["CrosshairColour"] call vip_asp_fnc_cl_camera;
				} else {

					_dir = getDir _cam;
					_pitchBank = _cam call BIS_fnc_getPitchBank;
					vip_asp_var_cl_lock = [-1];
					_cam cameraEffect ["Terminate", "Back"];
					camDestroy _cam;
					_cam = "camera" camCreate (_camPos select 0);
					[_cam, _camPos select 1] call BIS_fnc_setObjectRotation;
					_cam camPrepareFOV (_camPos select 2);
					_cam camPrepareFocus vip_asp_var_cl_focus;
					_cam camCommitPrepared 0;
					_cam cameraEffect ["Internal", "Back"];
					cameraEffectEnableHUD true;
					vip_asp_obj_cl_cam = _cam;
					_obj = vip_asp_var_cl_attach;
					if !(isNull _obj) then {
						_modelPos = _obj worldToModel (_camPos select 0);
						_cam attachTo [_obj, _modelPos];
						_dir = _dir - getDir _obj;
					};
					vip_asp_var_cl_vector = [_dir, _pitchBank select 0, 0];
					[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
					["CrosshairColour"] call vip_asp_fnc_cl_camera;				
				};
			};
			
			case "Attach": {
				_dir = getDir _cam;
				_pitchBank = _cam call BIS_fnc_getPitchBank;
				if (isNull vip_asp_var_cl_attach) then {
					_target = call _findTarget;
					if (typeName _target == "OBJECT") then {
						if (_target isKindOf "AllVehicles") then {
							_dir = _dir - getDir _target;
							_cam attachTo [_target];
							vip_asp_var_cl_attach = _target;
							["CrosshairColour"] call vip_asp_fnc_cl_camera;
						};
					};
				} else {
					detach _cam;
					vip_asp_var_cl_attach = objNull;
					["CrosshairColour"] call vip_asp_fnc_cl_camera;
				};
				vip_asp_var_cl_vector = [_dir, _pitchBank select 0, _pitchBank select 1];
				[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
			};
		};
		
		["CrosshairColour"] call vip_asp_fnc_cl_camera;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Draw3D": {
		
		_map = uiNameSpace getVariable "vip_asp_dlg_map";
		if (!isNull _map) exitWith {};

		_compass = uiNamespace getVariable "vip_asp_rsc_compass";
		_status = uiNamespace getVariable "vip_asp_rsc_status";
		if (!isNull _compass) then {[_compass] call vip_asp_fnc_cl_compass};
		if (!isNull _status) then {[_status] call vip_asp_fnc_cl_status};
		
		if (vip_asp_var_cl_markers > 0) then {
			call vip_asp_fnc_cl_drawMines3D;
			call vip_asp_fnc_cl_drawUnits3D;
		};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "CrosshairColour": {
	
		_xhair = uiNamespace getVariable "vip_asp_rsc_crosshair";
		if (!isNull _xhair) then {
			_colour = if ((vip_asp_var_cl_lock select 0) > -1) then {[1,0,0,0.8]} else {
				if (!isNull vip_asp_var_cl_attach) then {[1,1,0,0.8]} else {[1,1,1,0.8]};
			};
			(_xhair displayCtrl 0) ctrlSetTextColor _colour;
		};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Help": {
		
		_dialog = _this;
	
_c1Action = parseText "<t align='left'>
<t underline='true'>Camera:</t><br />
<br />
Move<br />
Pitch, Yaw<br />
Roll<br />
Slide<br />
Speed Multiplier<br />
Camera Mode<br />
Track Pos or Object<br />
Lock to Object<br />
Save Pos<br />
Recall Pos<br />
Optic Mode<br />
Focus<br />
Autofocus<br />
Disable Focus<br />
Pitch and Yaw<br />
Roll<br />
Pitch/Roll Reset<br />
Zoom<br />
Reset Zoom<br />
P/Y/R/Z Fast<br />
P/Y/R/Z Slow<br />
</t>
";

_c1Control = parseText "<t align='left'>
<br />
<br />
W, A, S, D<br />
LMB + Mouse<br />
Shift + LMB + Mouse<br />
RMB + Mouse<br />
MouseWheel Up, Down<br />
Arrow Up, Down<br />
Space<br />
Ctrl + Space<br />
Ctrl + F1...F12<br />
F1...F12<br />
N<br />
Keyboard - and +<br />
Backspace<br />
Shift + Backspace<br />
Numpad 1...9<br />
Numpad / and *<br />
Numpad 5<br />
Numpad - and +<br />
Numpad Enter<br />
Numpad 0<br />
Numpad Decimal<br />
</t>
";

_c2Action = parseText "<t align='left'>
<t underline='true'>Units:</t><br />
<br />
Cycle Unit<br />
Save Unit<br />
Recall Unit<br />
Unit List<br />
<br />
<t underline='true'>Display:</t><br />
<br />
Toggle Crosshair<br />
Toggle Compass<br />
Toggle Status<br />
View Distance Dialog<br />
Cycle Marker Mode<br />
Toggle Help<br />
</t>
";

_c2Control = parseText "<t align='left'>
<br />
<br />
Arrow Left, Right<br />
Ctrl + 1...10<br />
1...10<br />
U<br />
<br />
<br />
<br />
X<br />
C<br />
V<br />
G<br />
T<br />
H<br />
</t>
";

if (!isMultiplayer) then {

_add1 = parseText "<t align='left'>
<br />
<t underline='true'>Time:</t><br />
<br />
Faster, Slower<br />
Reset
</t>
";

_add2 = parseText "<t align='left'>
<br />
<br />
<br />
[ and ]<br />
\<br />
</t>
";

	_c2Action = composeText [_c2Action, _add1];
	_c2Control = composeText [_c2Control, _add2];
};
	
		(_dialog displayCtrl 1) ctrlSetStructuredText _c1Action;
		(_dialog displayCtrl 2) ctrlSetStructuredText _c1Control;
		(_dialog displayCtrl 3) ctrlSetStructuredText _c2Action;
		(_dialog displayCtrl 4) ctrlSetStructuredText _c2Control;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Exit": {
		
		if (!isNil "vip_asp_var_cl_trackingArray") then {
			if (!vip_asp_var_cl_alwaysTracking) then {
				[false] call vip_asp_fnc_cl_tracking;
			};
		};
		
		if (isClass (configFile >> "CfgPatches" >> "ace_nametags")) then {
			ace_nametags_showPlayerNames = vip_asp_var_cl_ACEtags select 0;
			ace_nametags_showNamesForAI = vip_asp_var_cl_ACEtags select 1;
			vip_asp_var_cl_ACEtags = nil;
		};
		
		if (isClass (configFile >> "CfgPatches" >> "ace_hearing")) then {
			ace_hearing_disableVolumeUpdate = false;
		};
		
		if (isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
			["vip_asp_aceInteract"] call ace_common_fnc_removeCanInteractWithCondition;
		};

		_cam = vip_asp_obj_cl_cam;
		_cam cameraEffect ["terminate", "back"];
		camUseNVG false;
		false SetCamUseTi 0;
		camDestroy _cam;
		clearRadio;
		
		vip_asp_var_cl_noEscape = nil;
		vip_asp_var_cl_alwaysTracking = nil;
		vip_asp_obj_cl_cam = nil;
		vip_asp_var_cl_LMB = nil;
		vip_asp_var_cl_RMB = nil;
		vip_asp_var_cl_vector = nil;
		vip_asp_var_cl_fov = nil;
		vip_asp_var_cl_vision = nil;
		vip_asp_var_cl_moveScale = nil;
		vip_asp_var_cl_cameraOn = nil;
		vip_asp_var_cl_focus = nil;
		vip_asp_var_cl_lock = nil;
		vip_asp_var_cl_attach = nil;
		vip_asp_var_cl_unit = nil;
		vip_asp_var_cl_mouseBusy = nil;
		vip_asp_var_cl_markers = nil;
		vip_asp_var_cl_keys = nil;
		vip_asp_fnc_cl_sideColour = nil;
		vip_asp_var_cl_accTime = nil;

		_display = findDisplay 46;
		
		removeMissionEventHandler ["Draw3D", vip_asp_eh_draw3D];
		_display displayRemoveEventHandler ["keyDown", vip_asp_eh_key1];
		_display displayRemoveEventHandler ["keyUp", vip_asp_eh_key2];
		_display displayRemoveEventHandler ["mouseButtonDown", vip_asp_eh_key3];
		_display displayRemoveEventHandler ["mouseButtonUp", vip_asp_eh_key4];
		_display displayRemoveEventHandler ["mouseZChanged", vip_asp_eh_key5];
		_display displayRemoveEventHandler ["mouseMoving", vip_asp_eh_key6];
		_display displayRemoveEventHandler ["mouseHolding", vip_asp_eh_key7];
		vip_asp_eh_draw3D = nil;
		vip_asp_eh_key1 = nil;
		vip_asp_eh_key2 = nil;
		vip_asp_eh_key3 = nil;
		vip_asp_eh_key4 = nil;
		vip_asp_eh_key5 = nil;
		vip_asp_eh_key6 = nil;
		vip_asp_eh_key7 = nil;

		_layers = missionNamespace getVariable ["BIS_fnc_rscLayer_list",[]];

		for "_i" from 1 to (count _layers - 1) step 2 do {
			(_layers select _i) cutText ["", "Plain"];
		};
		
		if (!isMultiplayer) then {setAccTime 1};
		player switchCamera "Internal";
	};
};