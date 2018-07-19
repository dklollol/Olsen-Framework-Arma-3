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
		
		[] spawn {
			sleep 5;
			
			private _p = "";
			if (FW_RespawnTickets != 1) then {
				_p = "s";
			};
			private _message2 = format ["you can respawn %1 time%2", FW_RespawnTickets, _p];

			private _sideTickets = 0;
			switch (side player) do {
				case west: {
					_sideTickets = FW_RespawnTicketsWest;
				};
				case east: {
					_sideTickets = FW_RespawnTicketsEast;
				};
				case independent: {
					_sideTickets = FW_RespawnTicketsInd;
				};
				case civilian: {
					_sideTickets = FW_RespawnTicketsCiv;
				};
			};
			private _p2 = "";
			if (_sideTickets != 1) then {
				_p2 = "s";
			};
			cutText [format ['Your side has %1 ticket%2 left, %3', _sideTickets, _p2, _message2], 'PLAIN DOWN'];
		};
	};
};