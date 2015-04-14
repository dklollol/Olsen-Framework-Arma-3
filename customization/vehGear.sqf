#include "core\vehGearCore.sqf" //DO NOT REMOVE

switch (_type) do {

	case "HUMMVEE": {
		CLEARCARGO;
		ADDWEAPONCARGO("ACE_M16A4_EOT", 3);
		ADDMAGAZINECARGO("ACE_30Rnd_556x45_S_Stanag", 20);
		ADDMAGAZINECARGO("HandGrenade_West", 10);
		ADDMAGAZINECARGO("SmokeShell", 10);
	};
	
	case "UAZ": {
		ADDWEAPONCARGO("ACE_AK74M_Kobra", 2);
		ADDMAGAZINECARGO("30Rnd_545x39_AK", 20);
		ADDMAGAZINECARGO("HandGrenade_East", 10);
	};
	
};