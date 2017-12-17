if (!isDedicated) then {
	
	private ["_modules", "_module"];

	_modules = "<font size='18'>Olsen Framework Modules</font><br/><br/>";

	for "_i" from 0 to count FW_Modules - 1 do {
	
		_module = FW_Modules select _i;

		_modules = _modules + "<font size='16'>" + (_module select 0) + "</font><br/>Description: " + (_module select 1) + "<br/>by " + (_module select 2);

		if (_i < count FW_Modules) then {
		
			_modules = _modules + "<br/><br/>";

		};
	};
	
	player createDiaryRecord ["FW_Menu", ["Modules", _modules]];
	
	private ["_respawnName", "_respawnPoint", "_temp", "_text"];
	
	if (FW_RespawnTickets > 0) then {
		
		_respawnName = toLower(format ["fw_%1_respawn", side player]);
		_respawnPoint = missionNamespace getVariable [_respawnName, objNull];

		if (isNull(_respawnPoint)) then {
			
			_temp = format ["Ticketed respawn feature:<br></br>Warning game logic ""%1"" does not exist.", _respawnName];
			_temp call FNC_DebugMessage;
			
		};
		
		_text = "respawns left";
		
		if (FW_RespawnTickets == 1) then {
			
			_text = "respawn left";
			
		};
		
		_text spawn {

			sleep 5;
			cutText [format ['%1 %2', FW_RespawnTickets, _this], 'PLAIN DOWN'];

		};

	};
};