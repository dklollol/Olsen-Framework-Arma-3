["Start with earplugs", "Automatically puts earplugs on players.", "Olsen"] call FNC_RegisterModule;

if (!isDedicated) then {

	"" spawn {

		sleep 0.01;
		
		if ("ACE_EarPlugs" in items player) then {
		
			[player] call ace_hearing_fnc_putInEarPlugs;
			
		};
	};
};