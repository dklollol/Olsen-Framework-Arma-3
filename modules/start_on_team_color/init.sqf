["Start on team color", "Allows the mission maker to set the team colors in squads on start.", "Olsen"] call FNC_RegisterModule;

if (!isDedicated) then {
	
	"" spawn {
		
		private ["_color"];
		
		_color = player getVariable ["FW_TeamColor", "NONE"];
		
		sleep 0.01;
		
		if (_color != "NONE") then {
			
			["CBA_teamColorChanged", [player, _color]] call CBA_fnc_globalEvent;
			
			player setVariable ["FW_TeamColor", nil, false];
			
		};
		
	};
	
};