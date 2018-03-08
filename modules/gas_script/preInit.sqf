//Gas script implementation by TinfoilHate

	if (isNil "FW_GAS_ACTIVE") then {FW_GAS_ACTIVE = true};
	if (isNil "FW_GAS_AREALIST") then {FW_GAS_AREALIST = []};
	if (isNil "FW_GAS_INHOTAREA") then {FW_GAS_INHOTAREA = false};

	if (isNil "FW_GAS_INTENSITY") then {FW_GAS_INTENSITY = 0};
	if (isNil "FW_GAS_BLURSTEP") then {FW_GAS_BLURSTEP = 0};
	if (isNil "FW_GAS_COUGHING") then {FW_GAS_COUGHING = false};
	if (isNil "FW_GAS_ANIMEH") then {FW_GAS_ANIMEH = -1};
	if (isNil "FW_GAS_GEAREH") then {FW_GAS_GEAREH = -1};
	if (isNil "FW_GAS_DOWN") then {FW_GAS_DOWN = false};
	if (isNil "FW_GAS_HASMASK") then {FW_GAS_HASMASK = false};
	if (isNil "FW_GAS_GASLOGICS") then {FW_GAS_GASLOGICS = []};

	FW_GAS_AIMASK = "skn_m04_gas_mask_bare_dry";
	FW_GAS_MASKLIST = [
		"skn_m04_gas_mask_blu",
		"skn_m04_gas_mask_blk",
		"skn_m04_gas_mask_gre",
		"skn_m04_gas_mask_bare_dry",
		"skn_s10_balaclava_blue_dry",
		"skn_s10_balaclava_red_dry",
		"skn_s10_balaclava_yellow_dry",
		"skn_s10_balaclava_white_dry",
		"skn_m50_gas_mask_hood",
		"skn_m50_gas_mask",
		"skn_m50_gas_mask_hood_wd"
	];

	FW_GAS_BLUR = ppEffectCreate ["dynamicBlur", -13501];

	FNC_GAS_FIREMISSION = {	//Example, to be run only once, SERVER ONLY: ["FW_GAS_FIREMISSION",[position player,50,3,1,5,300]] call CBA_fnc_serverEvent;
		_this spawn {
			params ["_target","_dispersion","_shotFreq","_shotRounds","_shotArea","_timeOut"];

			if (isNil "_timeOut") then {_timeOut = -1};
			_timeOutStart = _timeOut;

			_shotCount = 0;
			while {_shotCount < _shotRounds} do {
				if (_timeOut != -1) then {_timeOut = time + _timeOutStart};

				_shotPos = [[[_target,_dispersion]],[]] call BIS_fnc_randomPos;

				//_gasLogic = "Sign_Sphere100cm_F" createVehicle _shotPos;
				_gasLogic = "Land_HelipadEmpty_F" createVehicle _shotPos;
				_gasLogic setPosATL _shotPos;

				_sound = selectRandom ["mortar1","mortar2"];
				[_gasLogic, [_sound,500]] remoteExec ["say3D"];

				sleep 2;

				"rhs_rpg7v2_pg7vl" createVehicle _shotPos;

				_gasLogic setVariable ["FW_GAS_SHOTAREA",_shotArea,true];
				_gasLogic setVariable ["FW_GAS_TIMEOUT",_timeOut,true];

				FW_GAS_GASLOGICS set [count FW_GAS_GASLOGICS,_gasLogic];

				["FW_GAS_GASZONES",_gasLogic] spawn CBA_fnc_globalEvent;
				["FW_GAS_GASPARTICLES",_shotPos] spawn CBA_fnc_globalEvent;

				_shotCount = _shotCount + 1;

				sleep _shotFreq;
			};
		};
	};
	["FW_GAS_FIREMISSION", FNC_GAS_FIREMISSION] call CBA_fnc_addEventHandler;

	FNC_GAS_FAKEMISSION = {	//Example, to be run only once, SERVER ONLY: ["FW_GAS_FAKEMISSION",[position player,50,3,1,5,300]] call CBA_fnc_serverEvent;
		_this spawn {
			params ["_target","_dispersion","_shotFreq","_shotRounds","_shotArea","_timeOut"];

			if (isNil "_timeOut") then {_timeOut = -1};
			_timeOutStart = _timeOut;

			_shotCount = 0;
			while {_shotCount < _shotRounds} do {
				if (_timeOut != -1) then {_timeOut = time + _timeOutStart};

				_shotPos = [[[_target,_dispersion]],[]] call BIS_fnc_randomPos;

				//_gasLogic = "Sign_Sphere100cm_F" createVehicle _shotPos;
				_gasLogic = "Land_HelipadEmpty_F" createVehicle _shotPos;
				_gasLogic setPosATL _shotPos;

				_sound = selectRandom ["mortar1","mortar2"];
				[_gasLogic, [_sound,500]] remoteExec ["say3D"];

				sleep 2;

				"rhs_rpg7v2_pg7vl" createVehicle _shotPos;

				deleteVehicle _gasLogic;

				sleep _shotFreq;
			};
		};
	};
	["FW_GAS_FAKEMISSION", FNC_GAS_FAKEMISSION] call CBA_fnc_addEventHandler;

	FNC_GAS_CREATEHOTZONE = {	//Example, to be run only once, SERVER ONLY: ["FW_GAS_CREATEHOTZONE",[position player,100,300]] call CBA_fnc_serverEvent;
		_this spawn {
			params ["_target","_shotArea","_timeOut"];

			if (isNil "_timeOut") then {_timeOut = -1};
			_timeOutStart = _timeOut;

			_gasLogic = "Land_HelipadEmpty_F" createVehicle _target;
			_gasLogic setPosATL _target;

			_gasLogic setVariable ["FW_GAS_SHOTAREA",_shotArea,true];
			_gasLogic setVariable ["FW_GAS_TIMEOUT",_timeOut,true];

			FW_GAS_GASLOGICS set [count FW_GAS_GASLOGICS,_gasLogic];

			["FW_GAS_GASZONES",_gasLogic] spawn CBA_fnc_globalEvent;
		};
	};
	["FW_GAS_CREATEHOTZONE", FNC_GAS_CREATEHOTZONE] call CBA_fnc_addEventHandler;

	FNC_GAS_GASZONES = {
		if (!isDedicated && hasInterface) then {
			params ["_gasLogic"];

			_shotPos = getPosATL _gasLogic;
			_gasTrig = objNull;

			waitUntil {_test = _gasLogic getVariable "FW_GAS_SHOTAREA"; !isNil "_test";};
			waitUntil {_test = _gasLogic getVariable "FW_GAS_TIMEOUT"; !isNil "_test";};

			_shotArea = _gasLogic getVariable "FW_GAS_SHOTAREA";
			_timeOut = _gasLogic getVariable "FW_GAS_TIMEOUT";

			if (_timeOut == -1 || _timeOut > time) then {
				_gasTrig = createTrigger ["EmptyDetector",_shotPos,false];
				_gasTrig setTriggerArea [_shotArea,_shotArea,0,false,_shotArea];
				_gasTrig setTriggerActivation ["ANYPLAYER","PRESENT",true];
				_gasTrig setTriggerStatements ["player in thisList || (vehicle player) in thisList","FW_GAS_AREALIST set [count FW_GAS_AREALIST,thisTrigger];","FW_GAS_AREALIST = FW_GAS_AREALIST - [thisTrigger];"];
			};

			if (_timeOut != -1 && _timeOut > time) then {
				[{
					(_this select 1) <= time
				}, {
					FW_GAS_AREALIST = FW_GAS_AREALIST - [(_this select 0)];
					deleteVehicle (_this select 0);
				}, [_gasTrig,_timeOut]] call CBA_fnc_waitUntilAndExecute;
			};
		};
	};
	["FW_GAS_GASZONES", FNC_GAS_GASZONES] call CBA_fnc_addEventHandler;

	FNC_GAS_JIPSEND = {
		{
			["FW_GAS_GASZONES",_x] spawn CBA_fnc_globalEvent;
			sleep 0.25;
		} forEach FW_GAS_GASLOGICS;
	};
	["FW_GAS_JIPSEND", FNC_GAS_JIPSEND] call CBA_fnc_addEventHandler;

	FNC_GAS_GASPARTICLES = {
		if (!isDedicated && hasInterface) then {
			drop [["\ca\Data\ParticleEffects\Universal\Universal",16,8,0,0], "", "Billboard", 1, 18.5, _this, [0, 0, 0.5], 0, 10, 7.9, 0.275, [8.5, 10.5], [[1, 1, 0.25, 0],[1, 1, 0.25, 0.6],[1, 1, 0.25, 0.25],[1, 1, 0.25, 0.15], [1, 1, 0.25, 0.05], [1, 1, 0.25, 0]], [1], 1, 0, "", "", ""];
		};
	};
	["FW_GAS_GASPARTICLES", FNC_GAS_GASPARTICLES] call CBA_fnc_addEventHandler;

	FNC_GAS_VEHICLESIREN = {
		if (!isServer) exitWith {};

		sleep 0.5 + (random 5);

		_veh = _this select 0;
		_veh setVariable ["FW_GAS_VEHALARM_ON",true,true];

		while {alive _veh} do {
			{
				_shotArea = _x getVariable ["FW_GAS_SHOTAREA",0];
				_timeOut = _x getVariable ["FW_GAS_TIMEOUT",-1];

				if (_timeOut == -1 || _timeOut > time) then {
					if (_veh distance _x < _shotArea) then {
						if (_veh getVariable "FW_GAS_VEHALARM_ON") then {
							[_veh, ["ABCA_M42",50]] remoteExec ["say3D"];
						};

						sleep 0.75;
					};
				};
			} forEach FW_GAS_GASLOGICS;
		};
	};