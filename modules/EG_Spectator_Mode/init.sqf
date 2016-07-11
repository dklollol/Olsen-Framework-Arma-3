["EG_Spectator_Mode", "Replaces the standard spectate script with the Vanilla Spectator script.", "BI &amp; Perfk"] call FNC_RegisterModule;

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

			player setCaptive true;
			player allowdamage false;

			player call FNC_RemoveAllGear;

			player addWeapon "itemMap";

			player setPos [0, 0, 0];
			[player] join grpNull;

			hideObjectGlobal player;

			if (!(player getVariable ["FW_Spectating", false])) then {

				player setVariable ["FW_Spectating", true, true];

				[true] call acre_api_fnc_setSpectator;

				call BIS_fnc_VRFadeIn;
				
				#include "settings.sqf"

				player setpos getmarkerpos Spectator_Marker;

				["Initialize", [player, Whitelisted_Sides, Ai_Viewed_By_Spectator, Free_Camera_Mode_Available, Third_Person_Perspective_Camera_mode_Available, Show_Focus_Info_Widget, Show_Camera_Buttons_Widget, Show_Controls_Helper_Widget, Show_Header_Widget, Show_Entities_And_Locations_Lists]] call BIS_fnc_EGSpectator;
				
				//["Initialize", [player, [], true, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;

				player setPos [0, 0, 0];

			} else {

				call BIS_fnc_VRFadeIn;

			};
		};
	};
};