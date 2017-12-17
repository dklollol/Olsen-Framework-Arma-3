
	private["_unit","_ehAnimDone","_ehKilled","_detachCode"];

	if (typeName _this == typeName []) exitWith {
		{
			_x call FNC_ambientAnimTerminate;
		} forEach _this;
	};

	if (typeName _this != typeName objNull) exitWith {};

	if (isNull _this) exitWith {};

	_unit = _this;

	//enable the unit "intelligence"
	{_unit enableAI _x} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"];

	//remove the event handlers
	_ehAnimDone = _unit getVariable ["ambientAnimMonitor_EhAnimDone",-1];
	_ehKilled 	= _unit getVariable ["ambientAnimMonitor_EhKilled",-1];

	if (_ehAnimDone != -1) then {
		_unit removeEventHandler ["AnimDone",_ehAnimDone];
		_unit setVariable ["ambientAnimMonitor_EhAnimDone",-1];
	};
	if (_ehKilled != -1) then {
		_unit removeEventHandler ["Killed",_ehKilled];
		_unit setVariable ["ambientAnimMonitor_EhKilled",-1];
	};

	_detachCode = {
		private["_logic"];

		//exit if object/unit doesn't exist
		if (isNull _this) exitWith {};

		_logic = _this getVariable ["ambientAnimMonitor_logic",objNull];

		//delete the game logic
		if !(isNull _logic) then {
			deleteVehicle _logic;
		};

		_terpSets = ["STAND","STAND_IA","SIT_LOW","KNEEL","LEAN","WATCH","WATCH1","WATCH2"];
		if (alive _this) then {
			if ((_this getVariable ["ambientAnimMonitor_animset",""]) in _terpSets && (behaviour _this == "COMBAT" || behaviour _this == "AWARE")) then {
				[_this,"AmovPercMstpSrasWrflDnon"] remoteExec ['playMoveNow'];

			} else {
				[_this,""] remoteExec ['switchMove'];
			};
		};

		_this setVariable ["ambientAnimMonitor_attached",nil];
		_this setVariable ["ambientAnimMonitor_animset",nil];
		_this setVariable ["ambientAnimMonitor_anims",nil];
		_this setVariable ["ambientAnimMonitor_interpolate",nil];
		_this setVariable ["ambientAnimMonitor_time",nil];
		_this setVariable ["ambientAnimMonitor_logic",nil];
		_this setVariable ["ambientAnimMonitor_helper",nil];
		//_this setVariable ["ambientAnimMonitor_weapon",nil];
		_this setVariable ["ambientAnimMonitor_linked",nil];

		//detach unit, so it can freely move
		detach _this;
	};

	if (time > 0) then {
		_unit call _detachCode;
	} else {
		[_unit,_detachCode] spawn {
			sleep 0.3; (_this select 0) call (_this select 1);
		};
	};
