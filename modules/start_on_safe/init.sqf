if (!isDedicated) then {
	
	if (currentWeapon player != "") then {
	
		[player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety;
	
	};
};