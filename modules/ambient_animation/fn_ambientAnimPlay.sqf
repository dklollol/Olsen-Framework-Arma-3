	private["_unit","_anims","_anim","_available","_time","_linkedUnits","_linkedAnims","_xTime","_interpolate"];

	if (isNull _this) exitWith {};
	if !(alive _this && canMove _this) exitWith {};

	_unit = _this;
	_anims 	= _unit getVariable ["ambientAnimMonitor_anims",[]];

	if (count _anims == 0) exitWith {
		["Unit '%1' doesn't have defined ambient anims!",_unit,_anims] call BIS_fnc_logFormat;
	};

	_linkedUnits = _unit getVariable ["ambientAnimMonitor_linked",[]];

	//find animations that are being played on linked units
	_linkedAnims = [];

	_time = time - 10;

	{
		_xTime = _x getVariable ["ambientAnimMonitor_time",_time];

		if (_xTime > _time) then {
			_linkedAnims = _linkedAnims + [animationState _x];
		};
	}
	forEach _linkedUnits;

	//get animations available for player = not recently played by linked units
	_available = _anims - _linkedAnims;

	if (count _available == 0) then {
		["Unit '%1' doesn't have an available/free animation to play",_unit] call BIS_fnc_logFormat;

		_available = _anims;
	};

	//select a random anim from the pool of available animations and play it
	_anim = _available call BIS_fnc_selectRandom;

	_interpolate = _unit getVariable ["ambientAnimMonitor_interpolate",false];

	if (_interpolate) then {
		//_unit playMoveNow _anim;
		[_unit,_anim] remoteExec ['playMoveNow'];
	} else {
		//_unit switchMove _anim;
		[_unit,_anim] remoteExec ['switchMove'];
	};