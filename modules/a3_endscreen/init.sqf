// Module by Starfox64 (STEAM_0:1:37636871) //

["ArmA 3 End Screen", "Replaces the standard end screen with the default ArmA 3 end mission animation.", "Starfox64"] call FNC_RegisterModule;

#include "settings.sqf"

FW_EndStats = "";

if (isServer) then {

	if (!ENABLE_A3_ENDSCREEN) exitWith {};

	//FNC_EndMission(END_TYPE, WIN) will end the mission (see settings.sqf for advanced options)
	//Sends the team stats, time limit, endType and executes "BIS_fnc_endMission" on all players machines
	FNC_EndMission = {

		private ["_temp", "_time", "_team", "_casualties", "_assets", "_disabled", "_destroyed"];

		if (FW_EndStats == "") then {

			_time = ceil(time / 60);

			if (_time >= FW_TimeLimit) then {_time = FW_TimeLimit;};

			if (FW_TimeLimit == 0) then {

				FW_EndStats = format ["<t font='PuristaBold' size='1'>Mission duration: %1 minutes.</t><br/><br/>", _time];

			} else {

				FW_EndStats = format ["<t font='PuristaBold' size='1'>Mission duration: %1 out of %2 minutes.</t><br/><br/>", _time, FW_TimeLimit];

			};

			for "_i" from 0 to count FW_Teams -1 do {
				_team = FW_Teams select _i;
				_casualties = _team select 0 call FNC_CasualtyCount;

				FW_EndStats = FW_EndStats + format ["<t font='PuristaBold' size='1.6'>%1:</t><br/>Casualties: %2/%3", _team select 0, _casualties, _team select 3];

				_assets = (_team select 0) call FNC_GetDamagedAssets;
				_disabled = _assets select 0;
				_destroyed = _assets select 1;

				if (count _disabled > 0) then {
					FW_EndStats = FW_EndStats + "<br/><br/><t font='PuristaBold' size='1.2'>Disabled Assets:</t><br/>";

					for "_k" from 0 to count _disabled -1 do {
						FW_EndStats = FW_EndStats + format ["- %1", _disabled select _k];

						if (_k < count _disabled -1) then {
							FW_EndStats = FW_EndStats + "<br/>";
						};
					};
				};

				if (count _destroyed > 0) then {
					FW_EndStats = FW_EndStats + "<br/><br/><t font='PuristaBold' size='1.2'>Destroyed Assets:</t><br/>";

					for "_k" from 0 to count _destroyed -1 do {
						FW_EndStats = FW_EndStats + format ["- %1", _destroyed select _k];

						if (_k < count _destroyed -1) then {
							FW_EndStats = FW_EndStats + "<br/>";
						};
					};
				};

				if (_i < count FW_Teams -1) then {
					FW_EndStats = FW_EndStats + "<br/><br/><br/>";
				};
			};

			publicVariable "FW_EndStats";

		};

		FW_MissionEnded = true;

		if (typeName (_this select 0) == "STRING") exitWith {

			[[_this select 0, _this select 1], "BIS_fnc_endMission"] call BIS_fnc_MP;
			//[_this select 0, _this select 1] call BIS_fnc_endMission;

		};

		if (typeName (_this select 0) == "ARRAY") exitWith {

			{

				[[_x select 1, _x select 2], "BIS_fnc_endMission", _x select 0] call BIS_fnc_MP;

			} forEach _this;

			//_temp = _this select 0;

			//[_temp select 1, _temp select 2] call BIS_fnc_endMission;

		};

	};
};
