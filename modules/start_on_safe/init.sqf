["Start on safe", "Forces ACE Safety on all players when the mission starts.", "Olsen"] call FNC_RegisterModule;

if (!isDedicated) then {
	
	"" spawn {

		sleep 0.01;
		
		if (currentWeapon player != "") then {
		
			[player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety;
		
		};
	};
};