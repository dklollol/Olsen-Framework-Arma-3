#include "settings.sqf"

FW_EndStats = "";

if (isServer) then {

	if (!ENABLE_A3_ENDSCREEN) exitWith {};

	//FNC_EndMission(END_TYPE, WIN, TARGET) will end the mission
	//Sends the team stats, time limit, endType and executes "BIS_fnc_endMission" on all players machines
	FNC_EndMission = {

		private ["_endType", "_win", "_target", "_time", "_team", "_casualties", "_assets", "_disabled", "_destroyed"];

		_endType = _this select 0;
		_win = _this select 1;
		_target = playableUnits;

		if (count _this > 2) then {
			_target = _this select 2;
		};

		if (FW_EndStats == "") then {

			_time = ceil(time / 60);

			if (_time >= FW_TimeLimit) then {_time = FW_TimeLimit;};

			FW_EndStats = format ["<t font='PuristaBold' size='1'>Mission duration: %1 out of %2 minutes.</t><br/><br/>", _time, FW_TimeLimit];

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

		[[_endType, _win], "BIS_fnc_endMission", _target] call BIS_fnc_MP;
		FW_MissionEnded = true;

	};
};