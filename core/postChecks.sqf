if (!isDedicated) then {
	
	if (respawnTickets > 0) then {
		
		_respawnName = toLower(format ["fw_%1_respawn", side player]);
		_respawnPoint = missionNamespace getVariable [_respawnName, objNull];

		if (isNull(_respawnPoint)) then {
			
			_temp = format ["Ticketed respawn feature:<br></br>Warning game logic ""%1"" does not exist.", _respawnName];
			_temp call FNC_DebugMessage;
			
		};
		
		_text = "respawns left";
		
		if (respawnTickets == 1) then {
			
			_text = "respawn left";
			
		};
		
		cutText [format ['%1 %2', respawnTickets, _text], 'PLAIN DOWN'];

	};
};