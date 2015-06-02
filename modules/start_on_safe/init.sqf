if (!isDedicated) then {
	
	"" spawn {

		sleep 0.01;
		
		if (currentWeapon player != "") then {
		
			[player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety;
		
		};
	};
};