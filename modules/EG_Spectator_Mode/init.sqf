["EG Spectator Mode", "Replaces the Olsen Framework spectator script with the Vanilla Spectator.", "BI &amp; Perfk"] call FNC_RegisterModule;

if (!isDedicated) then {

	FNC_SpectatePrep = {

		private ["_respawnName", "_respawnPoint", "_text", "_loadout", "_pos", "_dir", "_cam"];

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
			
			player remoteExecCall ["hideObject", 0];
			player remoteExecCall ["hideObjectGlobal", 2];
			
			player setCaptive true;
			player allowdamage false;
 			[player, true] remoteExec ["setCaptive", 2];
            [player, false] remoteExec ["allowdamage", 2];

			player call FNC_RemoveAllGear;

			player addWeapon "itemMap";

			player setPos [0, 0, 0];
			[player] join grpNull;

			if (!(player getVariable ["FW_Spectating", false])) then {

				player setVariable ["FW_Spectating", true, true];

				[true] call acre_api_fnc_setSpectator;

				call BIS_fnc_VRFadeIn;
				
				#include "settings.sqf"
				
				
				_pos = [2000, 2000, 100];
				_dir = 0;
				
				if (getMarkerColor Spectator_Marker == "") then {
					if (!isNull (_this select 1)) then {
							_pos = [(getpos (_this select 1)) select 0, (getpos (_this select 1)) select 1, ((getposATL (_this select 1)) select 2)+1.8]; //set camera pos on player body
							_dir = getDir (_this select 1);
						};
				} else {
					_pos = getmarkerpos Spectator_Marker;
				};

				["Initialize", [player, Whitelisted_Sides, Ai_Viewed_By_Spectator, Free_Camera_Mode_Available, Third_Person_Perspective_Camera_mode_Available, Show_Focus_Info_Widget, Show_Camera_Buttons_Widget, Show_Controls_Helper_Widget, Show_Header_Widget, Show_Entities_And_Locations_Lists]] call BIS_fnc_EGSpectator;
				
				_cam = missionNamespace getVariable ["BIS_EGSpectatorCamera_camera", objNull];
				
				if (_cam != objNull) then {
					_cam setposATL _pos;
					_cam setDir _dir;
				};
				
				titleText ["\n\nPress SHIFT, ALT or SHIFT+ALT to modify camera speed.\nYou can open map and click somewhere to move camera to that postion.\n\nSpectator controls can be customized in controls settings in Camera tab.", "PLAIN", 1, true];
				
				[] spawn {
					while {(player getVariable ["FW_Spectating", false])} do {
						player setOxygenRemaining 1;
						sleep 0.25;
					};
				};

			} else {

				call BIS_fnc_VRFadeIn;

			};

		};



	};
};