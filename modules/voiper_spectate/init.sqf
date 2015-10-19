["Voiper Spectate", "Replaces the standard spectate script with Voiper's spectator script.", "Voiper &amp; Olsen"] call FNC_RegisterModule;

if (!isDedicated) then {

	FNC_SpectatePrep = {

		private ["_respawnName", "_respawnPoint", "_text", "_loadout"];

		if (FW_RespawnTickets > 0) then {

			_respawnName = toLower(format ["fw_%1_respawn", side player]);
			_respawnPoint = missionNamespace getVariable [_respawnName, objNull];

			_loadout = (player getVariable ["FW_Loadout", ""]);

			if (_loadout != "") then {

				[player, _loadout] call FNC_GearScript;

			};

			if (!isNull(_respawnPoint)) then {

				player setPos getPosATL _respawnPoint;

			};

			FW_RespawnTickets = FW_RespawnTickets - 1;

			_text = "respawns left";

			if (FW_RespawnTickets == 1) then {

				_text = "respawn left";

			};

			call BIS_fnc_VRFadeIn;

			cutText [format ['%1 %2', FW_RespawnTickets, _text], 'PLAIN DOWN'];

			player setVariable ["FW_Body", player, true];

		} else {

			player setVariable ["FW_Dead", true, true]; //Tells the framework the player is dead
			player setVariable ["FW_Spectating", true, true]; //Tells the framework the player is spectating

			player removeEventHandler ["Killed", FW_KilledEh];
			player removeEventHandler ["Respawn", FW_RespawnEh];

			[true] call ace_spectator_fnc_setSpectator;

			call BIS_fnc_VRFadeIn;

		};
	};
};