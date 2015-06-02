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
		["Init", [false, 1, true]] call vip_asp_fnc_cl_newCamera;

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
				["Init", _this] call vip_asp_fnc_cl_newCamera;
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

		if (isNil "vip_asp_var_cl_respawnPos") then {
			_mapSize = (configFile >> "CfgWorlds" >> worldName >> "mapSize");
			_worldEdge = if (isNumber _mapSize) then {getNumber _mapSize} else {32768};
			vip_asp_var_cl_respawnPos = [_worldEdge, _worldEdge];
		};

		//camera
		_camPos = if (!isNil "vip_asp_var_cl_startingPos") then {
			vip_asp_var_cl_startingPos
		} else {
			if (!vip_asp_var_cl_noEscape) then {
				getPos cameraOn
			} else {
				[(vip_asp_var_cl_respawnPos select 0) / 2, (vip_asp_var_cl_respawnPos select 0) / 2, 0]
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
		vip_asp_var_cl_targets = [];
		vip_asp_var_cl_attach = objNull;
		vip_asp_var_cl_unit = objNull;
		vip_asp_var_cl_unitCount = 0;
		vip_asp_var_cl_deadList = [];
		vip_asp_var_cl_mouseBusy = false;
		vip_asp_var_cl_displayMarkers = 3;
		vip_asp_var_cl_eh_listLast = false;
		vip_asp_var_cl_accTime = 1;
		
		//define only if doesn't exist (to preserve saved spots from a previous cam session)
		if (isNil "vip_asp_var_cl_savedSpots") then {
			vip_asp_var_cl_savedSpots = [];
			for "_i" from 0 to 11 do {vip_asp_var_cl_savedSpots set [_i, []]};
		};
		
		if (isNil "vip_asp_var_cl_savedUnits") then {
			vip_asp_var_cl_savedUnits = [];
			for "_i" from 0 to 9 do {vip_asp_var_cl_savedUnits set [_i, []]};
		};
		
		vip_asp_var_cl_keys = [];
		_DIKcodes = true call BIS_fnc_keyCode;
		_DIKlast = _DIKcodes select (count _DIKcodes - 1);
		for "_i" from 0 to (_DIKlast - 1) do {
			vip_asp_var_cl_keys set [_i, false];
		};
		
		//functions
		vip_asp_fnc_cl_sideColour = {
			_side = _this select 0;
			_b = 1;
			_d = 0.35;
			switch (_side) do {
				case 1: {[0.45, 0.45, _b, 0.9]};
				case 0: {[_b, _d, _d, 0.9]};
				case 2: {[_d, _b, _d, 0.9]};
				case 3: {[_b, _b, _b, 0.9]};
			};
		};

		_display = findDisplay 46;
		
		vip_asp_eh_draw3D = addMissionEventhandler ["Draw3D", {['Draw3D', _this] call vip_asp_fnc_cl_newCamera}];
		addMissionEventHandler ["Ended", {if (!isNil "vip_asp_obj_cl_cam") then {["Exit"] call vip_asp_fnc_cl_newCamera}}];
		vip_asp_eh_key1 = _display displayAddEventHandler ["keyDown", {['KeyDown', _this] call vip_asp_fnc_cl_newCamera}];
		vip_asp_eh_key2 = _display displayAddEventHandler ["keyUp", {['KeyUp', _this] call vip_asp_fnc_cl_newCamera}];
		vip_asp_eh_key3 = _display displayAddEventHandler ["mouseButtonDown", {['MouseButtonDown', _this] call vip_asp_fnc_cl_newCamera}];
		vip_asp_eh_key4 = _display displayAddEventHandler ["mouseButtonUp", {['MouseButtonUp',_this] call vip_asp_fnc_cl_newCamera}];
		vip_asp_eh_key5 = _display displayAddEventHandler ["mouseZChanged", {['MouseZChanged',_this] call vip_asp_fnc_cl_newCamera}];
		vip_asp_eh_key6 = _display displayAddEventHandler ["mouseMoving", {['Mouse',_this] call vip_asp_fnc_cl_newCamera}];
		vip_asp_eh_key7  =_display displayAddEventHandler ["mouseHolding", {['Mouse',_this] call vip_asp_fnc_cl_newCamera}];

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
		
		//apply marker settings for units already dead
		{
			if (true) then {
				if (!vip_asp_var_cl_ai && (_x getVariable ["vip_asp_isAI", true])) exitWith {};
				_name = _x getVariable ["vip_asp_deadName", ""];
				_side = [_x] call vip_cmn_fnc_cl_getSide;
				_icon = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "Icon");
				_colour = [_side] call vip_asp_fnc_cl_sideColour;
				_x setVariable ["vip_asp_draw", [true, _name, _side, _icon, _colour]];
				["Killed", [_x, objNull]] call vip_asp_fnc_cl_newCamera;
			};
		} forEach allDead;
		
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
		_coef = (vip_asp_var_cl_moveScale * (((getPosATL _cam) select 2) / 2)) min 15 max 0.001;
		
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
			_camPos set [2, (_camPos select 2) max (getTerrainHeightASL _camPos + 0.1)]; //for some reason, cameras reports 10cm higher than they actually are (without visual change for those 10cm)

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
			vip_asp_var_cl_fov = vip_asp_var_cl_fov - (vip_asp_var_cl_fov / 50) max 0.01;
			_cam camPrepareFOV vip_asp_var_cl_fov;
			_cam camCommitPrepared 0;
		};
		if (_keys select DIK_SUBTRACT) then {
			vip_asp_var_cl_fov = vip_asp_var_cl_fov + (vip_asp_var_cl_fov / 50) min 2;
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
			vip_asp_var_cl_moveScale = vip_asp_var_cl_moveScale + (vip_asp_var_cl_moveScale / 10) min 5;
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
				if (!_camOn) then {["Camera", ["Free"]] call vip_asp_fnc_cl_newCamera;};
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
			if (!isNull _unit) then {vip_asp_var_cl_savedUnits set [_num, [_unit]]};
		};
		
		_camLoadUnit = {
			_num = _this select 0;
			_arr = vip_asp_var_cl_savedUnits select _num;
			if (count (_arr) > 0) then {
				_unit = _arr select 0;
				if (_lock > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_newCamera};
				if (vip_asp_var_cl_unit == _unit) then {
					call _detach;
					if (_camOn) then {
						["Camera", ["Third"]] call vip_asp_fnc_cl_newCamera;
					} else {
						["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_newCamera;
					};
				} else {
				
					vip_asp_var_cl_unit = _unit;
					if ((vip_asp_var_cl_lock select 0) > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_newCamera};
					if (!_camOn) then {
						call _detach;
						["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_newCamera;
					};
				};
			};	
		};
		
		_detach = {
			if (!isNull vip_asp_var_cl_attach) then {
				["Camera", ["Attach"]] call vip_asp_fnc_cl_newCamera;
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
					["Camera", ["Attach"]] call vip_asp_fnc_cl_newCamera;
				} else {
					["Camera", ["Lock"]] call vip_asp_fnc_cl_newCamera;
				};
			};
			
			case (DIK_LEFT): {
				["Camera", ["NewUnit", -1]] call vip_asp_fnc_cl_newCamera
			};
			
			case (DIK_RIGHT): {
				["Camera", ["NewUnit", 1]] call vip_asp_fnc_cl_newCamera
			};
			
			case (DIK_UP): {
				if (isNull vip_asp_var_cl_unit) exitWith {};
				if (_lock > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_newCamera};
				call _detach;
				if (_camOn) then {
					["Camera", ["Third"]] call vip_asp_fnc_cl_newCamera;
				} else {
					if (cameraView == "EXTERNAL") then {
						["Camera", ["First"]] call vip_asp_fnc_cl_newCamera;
					};
				};
			};
			
			case (DIK_DOWN): {
				if (isNull vip_asp_var_cl_unit) exitWith {};
				if (_lock > -1) then {["Camera", ["Lock"]] call vip_asp_fnc_cl_newCamera};
				call _detach;
				if (!_camOn) then {
					if (cameraView == "INTERNAL" || cameraView == "GUNNER") then {
						["Camera", ["Third"]] call vip_asp_fnc_cl_newCamera;
					} else {
						["Camera", ["Free"]] call vip_asp_fnc_cl_newCamera;
					};
				};
			};
			
			case (DIK_T): {
				vip_asp_var_cl_displayMarkers = vip_asp_var_cl_displayMarkers + 1;
				if (vip_asp_var_cl_displayMarkers > 3) then {vip_asp_var_cl_displayMarkers = 0};
				if (vip_asp_var_cl_displayMarkers == 0) then {clearRadio};
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
					["CrosshairColour"] call vip_asp_fnc_cl_newCamera;
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
						if (_message) then {["Exit"] call vip_asp_fnc_cl_newCamera};
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
				if (vip_asp_var_cl_unit == player) exitWith {};
				vip_asp_var_cl_cameraOn = false;
				_cam attachTo [vehicle _unit, [0,0.1,0]];
				_cam cameraEffect ["Terminate", "Back"];
				if (vehicle _unit != _unit) then {
					vehicle _unit switchCamera "Internal"
				} else {
					_unit switchCamera "Internal";
				};
			};
			
			case "Third": {
				if (vip_asp_var_cl_unit == player) exitWith {};
				vip_asp_var_cl_cameraOn = false;
				_cam attachTo [vehicle _unit, [0,0.1,0]];
				_cam cameraEffect ["Terminate", "Back"];
				if (vehicle _unit != _unit) then {
					vehicle _unit switchCamera "External"
				} else {
					_unit switchCamera "External";
				};
			};
			
			case "NewUnit": {
			
				_increment = _this select 1;
				if (count allUnits > 0) then {
					_allUnits = allUnits;
					{
						if !((_x getVariable "vip_asp_draw") select 0) then {_allUnits deleteAt _forEachIndex};
					} forEach allUnits;
					
					_count = count _allUnits;
					if (count _allUnits < 1) exitWith {};
					_index = _allUnits find _unit;
					_index = _index + _increment;
					if (_index < 0) then {_index = _count - 1};
					if (_index > (_count - 1)) then {_index = 0};
					
					vip_asp_var_cl_unit = _allUnits select _index;
					if (!_camOn) then {["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_newCamera};
				};		
			};
			
			case "SwitchUnit": {
				if (cameraView == "INTERNAL" || cameraView == "GUNNER") then {
					["Camera", ["First"]] call vip_asp_fnc_cl_newCamera;
				} else {
					["Camera", ["Third"]] call vip_asp_fnc_cl_newCamera;
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
					["CrosshairColour"] call vip_asp_fnc_cl_newCamera;
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
					["CrosshairColour"] call vip_asp_fnc_cl_newCamera;				
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
							["CrosshairColour"] call vip_asp_fnc_cl_newCamera;
						};
					};
				} else {
					detach _cam;
					vip_asp_var_cl_attach = objNull;
					["CrosshairColour"] call vip_asp_fnc_cl_newCamera;
				};
				vip_asp_var_cl_vector = [_dir, _pitchBank select 0, _pitchBank select 1];
				[_cam, vip_asp_var_cl_vector] call BIS_fnc_setObjectRotation;
			};
		};
		
		["CrosshairColour"] call vip_asp_fnc_cl_newCamera;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Draw3D": {
	
		_cam = vip_asp_obj_cl_cam;		
		_overlay = uiNamespace getVariable "vip_asp_dlg_overlay";
		_compass = uiNamespace getVariable "vip_asp_rsc_compass";
		_status = uiNamespace getVariable "vip_asp_rsc_status";
		_map = uiNameSpace getVariable "vip_asp_dlg_map";
		
		if (floor(diag_ticktime) mod 2 == 0) then {
			if (vip_asp_var_cl_eh_listLast) exitWith {};
			_allUnitsCount = count allUnits;
			if (_allUnitsCount != vip_asp_var_cl_unitCount) then {
				vip_asp_var_cl_unitCount = _allUnitsCount;
				_unitsToList = [];
				{if (!(_x getVariable ["vip_asp_listed", false]) && alive _x) then {_unitsToList pushBack _x}} forEach allUnits;
				if (count _unitsToList > 0) then {
					{
						_x setVariable ["vip_asp_listed", true];
						[_x] call vip_asp_fnc_cl_objectVar2;
						
						if (_x distance vip_asp_var_cl_respawnPos > 200) then {
							_name = name _x;
							_side = [_x] call vip_cmn_fnc_cl_getSide;
							_icon = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "Icon");
							_colour = [_side] call vip_asp_fnc_cl_sideColour;
							_x setVariable ["vip_asp_draw", [true, _name, _side, _icon, _colour]];
						} else {_x setVariable ["vip_asp_draw", [false]]};
						
						_x addEventHandler ["Killed", {["Killed", _this] call vip_asp_fnc_cl_newCamera}];
						_x addEventHandler ["Respawn", {["Respawn", _this] call vip_asp_fnc_cl_newCamera}];
					} forEach _unitsToList;
				};
				//overlay list
				if (!isNull _overlay) then {["OverlayList", _overlay] call vip_asp_fnc_cl_newCamera};
			};
			vip_asp_var_cl_eh_listLast = true;
		} else {vip_asp_var_cl_eh_listLast = false};
		
		if (!isNull _map) exitWith {};
		
		if (vip_asp_var_cl_displayMarkers > 0) then {
		
			_topIcon = [];
			_scale = safeZoneH / 100;
			_list = allUnits;
			_list append vip_asp_var_cl_deadList;
			_textMax = (1.5 * _scale);
			_textMin = 6 * _scale;
			_iconMax = (30 * _scale);
			_iconMin = (120 * _scale);
			
			{
				_unit = _x;
				_draw = _unit getVariable "vip_asp_draw";
				
				if (_draw select 0) then {
				
					//exit if we don't display AI
					if (alive _unit && !vip_asp_var_cl_ai && !isPlayer _unit) exitWith {};
				
					_veh = vehicle _unit;
					_inVeh = (_veh != _unit);
					_cmdr = if (_inVeh && (_unit == ((crew _veh) select 0))) then {true} else {false};
					
					_toPos = if (_inVeh && _cmdr) then {_veh} else {_unit};
					_pos = if (surfaceIsWater getPos _toPos) then {getPosASLVisual _toPos} else {getPosATLVisual _toPos};
					
					if (count (worldToScreen _pos) > 0) then {
					
						_name = _draw select 1;
						_side = _draw select 2;
	
						_icon = "";
						_iconSize = 0;
						
						_text = "";
						_textSize = 0;
						
						_colour = _draw select 4;
						_pos set [2, (_pos select 2) + 3];
						_dist = (_cam distance _pos) + 0.1;
						_distScaled = _scale / sqrt(_dist);
						
						_iconScale = 300 * _distScaled;
						_iconSize = _iconScale max _iconMax min _iconMin;
						
						_showText = (_dist < 2000 && vip_asp_var_cl_displayMarkers >= 2);
						if (_showText) then {
							_textScale = 10 * _distScaled;
							_textSize = _textScale max _textMax min _textMin;
						};
						
						if (_inVeh) then {
							if (_cmdr) then {
								_icon = getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "Icon");
								_text = if (_showText) then {
									"[" + (getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName")) + "] " + _name
								} else {""};
								_pos set [2, (_pos select 2) + 3];
							} else {
								_iconSize = 0;
								_text = if (_showText) then {_name} else {""};
								_textSize = if (_dist < 25) then {_textSize / 1.5} else {0};
							};
						} else {
							_icon = _draw select 3;
							_text = if (_showText) then {_name} else {""};
						};
						
						if (vip_asp_var_cl_displayMarkers > 2) then {
							_text = _text + " [" + str ceil(_dist) + "]";
						};
						
						if (_unit == vip_asp_var_cl_unit) exitWith {
							_topIcon = [_icon, [1,1,0,1], _pos, _iconSize, _iconSize, 0, _text, 2, _textSize, "PuristaBold", "CENTER", true];
						};
						
						drawIcon3D [_icon, _colour, _pos, _iconSize, _iconSize, 0, _text, 2, _textSize, "PuristaMedium"];
					};
				};
			} forEach _list;
			
			if ((count _topIcon > 0) && vip_asp_var_cl_cameraOn) then {drawIcon3D _topIcon};
			
			if (vip_asp_var_cl_displayMarkers > 2) then {
			
				_iconSize = (20 * _size) max _scale min _min;
				_mines = allMines;
			
				{
					_pos = getPos _x;
					_dist = (_cam distance _pos) + 0.1;
					_distScaled = _scale / sqrt(_dist);
						
					_iconScale = 300 * _distScaled;
					_iconSize = _iconScale max _iconMax min _iconMin;
					
					_textSize = 0;
					_showText = (_dist < 2000 && vip_asp_var_cl_displayMarkers >= 2);
					if (_showText) then {
						_textScale = 10 * _distScaled;
						_textSize = _textScale max _textMax min _textMin;
					};
						
					_name = switch (typeOf _x) do {
					
						case "APERSTripMine_Wire_Ammo": {"Tripwire Mine"};
						case "APERSBoundingMine_Range_Ammo": {"Bounding Mine"};
						case "ClaymoreDirectionalMine_Remote_Ammo";
						case "ClaymoreDirectionalMine_Remote_Ammo_Scripted": {"Claymore Mine"};
						case "DemoCharge_Remote_Ammo";
						case "DemoCharge_Remote_Ammo_Scripted": {"Demo Charge"};
						case "SatchelCharge_Remote_Ammo";
						case "SatchelCharge_Remote_Ammo_Scripted": {"Satchel Charge"};
						case "APERSMine_Range_Ammo": {"APERS Mine"};
						case "ATMine_Range_Ammo": {"AT Mine"};
						case "SLAMDirectionalMine_Wire_Ammo": {"SLAM"};
					};
					
					drawIcon3D ["\A3\ui_f\data\map\markers\military\triangle_CA.paa", [1,1,0,1], getPos _x, _iconSize, _iconSize, 0, _name, 1, _textSize, "PuristaMedium"];
				} forEach _mines;
			};
		};
		
		if (!isNull _compass) then {["Compass", [_compass]] call vip_asp_fnc_cl_newCamera};
		if (!isNull _status) then {["Status", _status] call vip_asp_fnc_cl_newCamera};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Compass": {
	
		_dialog = _this select 0;
		_cam = vip_asp_obj_cl_cam;
		_unit = vip_asp_var_cl_unit;

		_Q1 = _dialog displayCtrl 1;
		_Q2 = _dialog displayCtrl 2;
		_Q3 = _dialog displayCtrl 3;
		_Q4 = _dialog displayCtrl 4;
		_qOrder = [];

		_RESUNITS_X = safeZoneW / 100;
		_CENTRE = safeZoneX + safeZoneW / 2;
		_COMPASS_W = _RESUNITS_X * 20;
		_COMPASS_H = _COMPASS_W / 15;
		_COMPASS_X = _CENTRE - _COMPASS_W / 2;
		_y = safeZoneY;
		_ARC_W = _COMPASS_W / 2;
		_degUnit = _COMPASS_W / 180;

		_dir = if (vip_asp_var_cl_cameraOn) then {getDir _cam} else {getDir _unit};
		_angleFromCentre = _dir - floor(_dir / 90) * 90;
		_leftEdgePos = _angleFromCentre * _degUnit;

		_positions = [
			[_CENTRE - _leftEdgePos - _ARC_W, _y],
			[_CENTRE - _leftEdgePos, _y],
			[_CENTRE - _leftEdgePos + _ARC_W, _y],
			[0, _y - 1]
		];

		switch (true) do {

			case ((_dir >= 0) && (_dir < 90)): {_qOrder = [_Q4, _Q1, _Q2, _Q3]};
			case ((_dir >= 90) && (_dir < 180)): {_qOrder = [_Q1, _Q2, _Q3, _Q4]};
			case ((_dir >= 180) && (_dir < 270)): {_qOrder = [_Q2, _Q3, _Q4, _Q1]};
			case (_dir >= 270): {_qOrder = [_Q3, _Q4, _Q1, _Q2]};
		};

		{
			_x ctrlSetPosition (_positions select _forEachIndex);
			_x ctrlCommit 0;
		} forEach _qOrder;
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
	case "OverlayList": {
	
		_overlay = _this;
		_ctrl = _overlay displayCtrl 0;
		_count = _ctrl tvCount [];
		for "_i" from 0 to _count do {
			_ctrl tvDelete [_x];
		};
		
		vip_asp_overlayClose = false;
		
		_ctrl tvAdd [[], "Opfor"];
		_ctrl tvAdd [[], "Blufor"];
		_ctrl tvAdd [[], "Indfor"];
		_ctrl tvAdd [[], "Civilian"];
		
		_unitList = [];
		
		{
			_units = units _x;
			private ["_groupNum"];
			{
				if (_x getVariable ["vip_asp_listed", false]) then {
					_arr = _x getVariable "vip_asp_draw";
					if (_arr select 0) then {
						_name = _arr select 1;
						_side = _arr select 2;
						_icon = _arr select 3;
						_picture = "\a3\ui_f\data\map\VehicleIcons\" + _icon + "_ca.paa";
						_treeIndex = [];
						_unitList pushBack _x;
						
						if (_forEachIndex == 0) then {
							_groupNum = _ctrl tvAdd [[_side], _name];
							_treeIndex = [_side, _groupNum];
						} else {
							_num = _ctrl tvAdd [[_side, _groupNum], _name];
							_treeIndex = [_side, _groupNum, _num];
						};

						_ctrl tvSetPicture [_treeIndex, _picture];
						_ctrl tvSetData [_treeIndex, [_x] call vip_asp_fnc_cl_objectVar2];
						_unitList pushBack _treeIndex;
					};
				};
			} forEach _units;
		} forEach allGroups;
		
		if (!isNull vip_asp_var_cl_unit) then {
			_treeIndex = _unitList select ((_unitList find vip_asp_var_cl_unit) + 1);
			_ctrl tvSetCurSel _treeIndex;
		};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "OverlaySelect": {
	
		_ctrl = _this select 0;
		_selection = _this select 1;
		if (count _selection < 2) exitWith {};
		
		_str = _ctrl tvData _selection;
		_unit = missionNamespace getVariable _str;
		vip_asp_var_cl_unit = _unit;
		if (vip_asp_var_cl_cameraOn) then {
			["Camera", ["Third"]] call vip_asp_fnc_cl_newCamera;
		} else {
			["Camera", ["SwitchUnit"]] call vip_asp_fnc_cl_newCamera;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Status": {
	
		_display = _this;
		_speedText = (str ([vip_asp_var_cl_moveScale, 4] call BIS_fnc_cutDecimals)) + "v";
		(_display displayCtrl 0) ctrlSetText _speedText;
		_name = "";
		_colour = [1,1,1,1];
		if (!isNull vip_asp_var_cl_unit) then {
			_arr = vip_asp_var_cl_unit getVariable "vip_asp_draw";
			_name = _arr select 1;
			_colour = _arr select 4;
			_colour set [3, 1];
		};
		(_display displayCtrl 1) ctrlSetText _name;
		(_display displayCtrl 1) ctrlSetTextColor _colour;
		_mode = if (vip_asp_var_cl_cameraOn) then {
			if (isNull vip_asp_var_cl_attach) then {"FREE"} else {"ATTACH"};
		} else {
			if (cameraView == "INTERNAL") then {"FIRST"} else {"THIRD"};
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
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "ViewDistance": {
		_dialog = if (count _this > 1) then {ctrlParent (_this select 0)} else {_this select 0};
		_dist = if (count _this > 1) then {_this select 1} else {-1};
		_text = _dialog displayCtrl 1;
		_slider = _dialog displayCtrl 2;
		
		if (_dist < 0) then {
			_slider slidersetRange [1000,20000];
			_slider sliderSetSpeed [1000,1000,1000];
			_slider sliderSetPosition viewDistance;
		} else {
			setViewDistance _dist;
		};

		_text ctrlSetText str viewDistance;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "MapInit": {

		_map = _this displayCtrl 1;

		if (isNil "vip_asp_mapPos") then {
			vip_asp_mapPos = [(vip_asp_var_cl_respawnPos select 0) / 2, (vip_asp_var_cl_respawnPos select 1) / 2];
		};

		if (isNil "vip_asp_mapZoom") then {
			vip_asp_mapZoom = 0.75;
		};

		_map ctrlMapAnimAdd [0, vip_asp_mapZoom, vip_asp_mapPos];
		ctrlMapAnimCommit _map;
		setMousePosition [0.5, 0.5];

		_map ctrlAddEventHandler ["Draw", {['MapDraw', _this] call vip_asp_fnc_cl_newCamera}];
		_map ctrlAddEventHandler ["MouseButtonDblClick", {['MapClick', _this] call vip_asp_fnc_cl_newCamera}];	
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "MapClose": {
		_map = _this displayCtrl 1;
		vip_asp_mapPos = _map ctrlMapScreenToWorld [0.5,0.5];
		vip_asp_mapZoom = ctrlMapScale _map;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "MapDraw": {
	
		_map = _this select 0;
		_zoom = ctrlMapScale _map;
		_scale = 5 * safeZoneH / 100;
		_size = _scale / _zoom;
		_min = 300 * _scale;
		_textSize = (1/4 * _size) max (_scale / 2) min (_scale / 1.5);
			
		if (vip_asp_var_cl_displayMarkers > 0) then {
			
			_topIcon = [];
			_list = allUnits;
			_list append vip_asp_var_cl_deadList;
			{
				_unit = _x;
				_draw = _unit getVariable "vip_asp_draw";
				
				if (_draw select 0) then {
					//exit if we don't display AI
					if (alive _unit && !vip_asp_var_cl_ai && !isPlayer _unit) exitWith {};
					
					_veh = vehicle _unit;
					_inVeh = (_veh != _unit);
					if (_inVeh && !(_unit == ((crew _veh) select 0))) exitWith {};
					
					_toPos = if (_inVeh) then {_veh} else {_unit};
					_pos = getPosVisual _toPos;
					_dir = getDir _toPos;
					
					_name = _draw select 1;
					_side = _draw select 2;
					_icon = "";
					_iconSize = 0;
					_iconText = "";
					_colour = _draw select 4;

					if (_inVeh) then {
						_icon = getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "Icon");
						_iconSize = (50 * _size) max _scale min (_min * 2);
						_iconText = "[" + (getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName")) + "] " + _name;
					} else {
						_icon = _draw select 3;
						_iconSize = (50 * _size) max _scale min _min;
						_iconText = _name;
					};
					
					if (vip_asp_var_cl_displayMarkers < 2) then {_iconText = ""};
					
					if (_unit == vip_asp_var_cl_unit) exitWith {_topIcon = [_icon, [1,1,0,1], _pos, _iconSize, _iconSize, _dir, _iconText, 1, _textSize, "PuristaBold", "RIGHT"]};
					
					_map drawIcon [_icon, _colour, _pos, _iconSize, _iconSize, _dir, _iconText, 1, _textSize, "PuristaMedium", "RIGHT"];
				};
			} forEach _list;
			
			if (count _topIcon > 0) then {_map drawIcon _topIcon};
			
			if (vip_asp_var_cl_displayMarkers > 2) then {
			
				_iconSize = (20 * _size) max _scale min _min;
				_mines = allMines;
			
				{
					_name = switch (typeOf _x) do {
					
						case "APERSTripMine_Wire_Ammo": {"Tripwire Mine"};
						case "APERSBoundingMine_Range_Ammo": {"Bounding Mine"};
						case "ClaymoreDirectionalMine_Remote_Ammo";
						case "ClaymoreDirectionalMine_Remote_Ammo_Scripted": {"Claymore Mine"};
						case "DemoCharge_Remote_Ammo";
						case "DemoCharge_Remote_Ammo_Scripted": {"Demo Charge"};
						case "SatchelCharge_Remote_Ammo";
						case "SatchelCharge_Remote_Ammo_Scripted": {"Satchel Charge"};
						case "APERSMine_Range_Ammo": {"APERS Mine"};
						case "ATMine_Range_Ammo": {"AT Mine"};
						case "SLAMDirectionalMine_Wire_Ammo": {"SLAM"};
					};
					
					_map drawIcon ["\A3\ui_f\data\map\markers\military\triangle_CA.paa", [1,1,0,1], getPos _x, _iconSize, _iconSize, getDir _x, _name, 1, _textSize / 2, "PuristaMedium"];
				} forEach _mines;
				
				{
					_unit = _x select 0;
					_draw = _unit getVariable ["vip_asp_draw", []];
					if (count _draw > 1) then {
						_colour = _draw select 4;
						if (!vip_asp_var_cl_cameraOn) then {
							if (_unit == vip_asp_var_cl_unit) then {_colour = [1,1,0,1]};
						};
						_positions = _x select 1;
						_count = count _positions;
						_step = floor (10 * _zoom) min 3 max 1;
						_lastIndex = 0;

						if (_count > 1) then {
							for "_i" from 0 to (_count - 1) step _step do {;
								if (_i > 0 && _i < _count) then {
									_pos1 = _positions select _i;
									_pos2 = _positions select (_i - _step);
									_lastIndex = _i;
									_map drawLine [_pos1, _pos2, _colour];
								};
							};
						};
						//((_count - _step + _count mod _step) max 0)
						if (alive _unit) then {_map drawLine [_positions select _lastIndex, getPosVisual _unit, _colour]};
					};
				} forEach vip_asp_var_cl_trackingArray;
			};
		};
		
		if (vip_asp_var_cl_cameraOn) then {
			_map drawIcon ["\A3\ui_f\data\gui\Rsc\RscDisplayMissionEditor\iconcamera_ca.paa", [1,1,1,1], getPos vip_asp_obj_cl_cam, 500 * _scale, 500 * _scale, getDir vip_asp_obj_cl_cam, "", 0, 0, "PuristaMedium"];
		};
		
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MapClick": {
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
			_units = nearestObjects [_mapPos, ["CAManBase"], _radius];
			_vehs = nearestObjects [_mapPos, ["LandVehicle", "Air"], _radius];
			
			if (count _units > 0) then {
				{
					if ((_x getVariable "vip_asp_draw") select 0) exitWith {
						_newUnit = _units select _forEachIndex;
					};
				} forEach _units;
			};
			
			if (isNull _newUnit) then {
				if (count _vehs > 0) then {
					{
						if (!isNull _newUnit) exitWith {};
						_crew = crew _x;
						if (count _crew > 0) then {
							{
								if ((_x getVariable "vip_asp_draw") select 0) exitWith {
									_newUnit = _crew select _forEachIndex;
								};
							} forEach _crew;
						};
					} forEach _vehs;
				};			
			};
			
			if (!isNull _newUnit) then {
				vip_asp_var_cl_unit = _newUnit;
				if (vip_asp_var_cl_cameraOn) then {
					["Camera", ["Third"]] call vip_asp_fnc_cl_newCamera;
				} else {
					if (cameraView == "EXTERNAL") then {
						["Camera", ["Third"]] call vip_asp_fnc_cl_newCamera;
					} else {
						["Camera", ["First"]] call vip_asp_fnc_cl_newCamera;
					};
				};
			} else {
			
				if (!vip_asp_var_cl_cameraOn) then {
					["Camera", ["Free"]] call vip_asp_fnc_cl_newCamera;
				};
				_mapPos set [2, 10];
				vip_asp_obj_cl_cam setPosATL _mapPos;
			};
		};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "MapKeyDown": {
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
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Killed": {
		_unit = _this select 0;
		_killer = _this select 1;
		_arr = _unit getVariable "vip_asp_draw";
		_colour = _arr select 4;
		{_colour set [_forEachIndex, _x / 2.5]} forEach _colour;
		_colour set [3, 0.8];
		_arr set [4, _colour];
		_unit setVariable ["vip_asp_draw", _arr];
		vip_asp_var_cl_deadList pushBack _unit;

		if (!isNull _killer) then {
			if (vip_asp_var_cl_displayMarkers > 2) then {
				_text = if (_killer == _unit) then {
					format ["%1 died", name _unit]
				} else {
					format ["%2 killed %1", name _unit, name _killer]
				};
				systemChat _text;
			};
		};
		
		if (_unit == vip_asp_var_cl_unit && !vip_asp_var_cl_cameraOn) then {
			["Camera", ["Free"]] call vip_asp_fnc_cl_newCamera;
			vip_asp_var_cl_unit = objNull;
		};
		
		if (!isNil "vip_asp_var_cl_trackingArray") then {
			_pos = getPos _unit;
			_pos resize 2;
			_index = -1;
			{if ((_x select 0) == _unit) then {_index = _forEachIndex}} forEach vip_asp_var_cl_trackingArray;
			_unitArray = vip_asp_var_cl_trackingArray select _index;
			_trackingArray = _unitArray select 1;
			_trackingArray pushBack _pos;
			_unitArray set [1, _trackingArray];
			vip_asp_var_cl_trackingArray set [_index, _unitArray];
		};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "Respawn": {
		_unit = _this select 0;
		_unit setVariable ["vip_asp_listed", false];
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
Pitch/Yaw/Roll Fast<br />
Pitch/Yaw/Roll Slow<br />
Zoom<br />
Reset Zoom<br />
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
Numpad 0<br />
Numpad Decimal<br />
Numpad - and +<br />
Numpad Enter<br />
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
	case "Tracking": {
		{
			_unit = _x;

			if (_unit distance vip_asp_var_cl_respawnPos > 200) then {
			
				if (alive _unit && !vip_asp_var_cl_ai && !isPlayer _unit) exitWith {};
				_pos = getPos _unit;
				_pos resize 2;
				
				_index = -1;
				{if ((_x select 0) == _unit) then {_index = _forEachIndex}} forEach vip_asp_var_cl_trackingArray;
				if (_index == -1) exitWith {vip_asp_var_cl_trackingArray pushBack [_unit, [_pos]]};
					_unitArray = vip_asp_var_cl_trackingArray select _index;
					_trackingArray = _unitArray select 1;
					_latestIndex = (count _trackingArray) - 1;
					_latestPos = _trackingArray select _latestIndex;
					_diffX = abs((_latestPos select 0) - (_pos select 0));
					_diffY = abs((_latestPos select 1) - (_pos select 1));
					if !((_diffX < 20) && (_diffY < 20)) then {
						_trackingArray pushBack _pos;		
						_unitArray set [1, _trackingArray];
						vip_asp_var_cl_trackingArray set [_index, _unitArray];
					};
			};
		} forEach allUnits;
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
		vip_asp_var_cl_targets = nil;
		vip_asp_var_cl_attach = nil;
		vip_asp_var_cl_unit = nil;
		vip_asp_var_cl_unitCount = nil;
		vip_asp_var_cl_deadList = nil;
		vip_asp_var_cl_mouseBusy = nil;
		vip_asp_var_cl_displayMarkers = nil;
		vip_asp_var_cl_keys = nil;
		vip_asp_fnc_cl_sideColour = nil;
		vip_asp_var_cl_eh_listLast = nil;
		vip_asp_var_cl_accTime = nil;
		vip_asp_var_cl_ai = nil;

		_display = findDisplay 46;
		
		removeMissionEventhandler ["Draw3D", vip_asp_eh_draw3D];
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