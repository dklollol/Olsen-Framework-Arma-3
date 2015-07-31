["Anti ND", "Prevents negligent discharges at spawn.", "Starfox64"] call FNC_RegisterModule;

#include "settings.sqf"

if (isServer) then {

	missionNamespace setVariable ["FW_ND_Active", true];
	publicVariable "FW_ND_Active";

	[] spawn {

		waitUntil {time > ANTI_ND_TIME};

		missionNamespace setVariable ["FW_ND_Active", false];
		publicVariable "FW_ND_Active";

	};

};

if (!isDedicated) then {

	[] spawn {

		waitUntil {!isNull player};

		FW_SpawnPos = getPos player;

		FW_FiredEh = player addEventHandler ["Fired", {
			private ["_p"];

			_p = _this select 6;

			if ((FW_SpawnPos distance player) <= ANTI_ND_DIST || missionNamespace getVariable ["FW_ND_Active", false]) then {
				deleteVehicle _p;
				hintC "You are firing at base without approval. Cease your actions Immediately!";
			};
		}];

	};

};