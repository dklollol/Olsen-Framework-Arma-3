["Call Mission", "Adds a new sections to the framework menu that allows COs and admins to call the mission.", "Starfox64"] call FNC_RegisterModule;

FW_MissionCalls = [];
FW_COC = [];

if (isServer) then {

	FNC_CallMission = {

		private ["_player", "_callID"];

		_player = _this select 0;
		_callID = _this select 1;

		{

			if ((_x select 1) == sideUnknown && (_x select 0) == _callID) exitWith {

				["Calling mission...", "hint", _player] call BIS_fnc_MP;
				(_x select 3) call FNC_EndMission;

			};

			if ((_x select 0) == _callID) exitWith {


				if (_player getVariable ["FW_IsCO", false]) then {

					["Calling mission...", "hint", _player] call BIS_fnc_MP;
					(_x select 3) call FNC_EndMission;

				} else {
					["You must be the CO to call this mission.", "hint", _player] call BIS_fnc_MP;
				};

			};

		} forEach FW_MissionCalls;

	};

	FW_CallMissionEh = ["frameworkCallMission", {_this spawn FNC_CallMission;}] call CBA_fnc_addEventHandler;

	[] spawn {

		private ["_coc", "_groupID", "_group", "_found"];

		while {true} do {
			{

				_coc = _x;
				_found = false;

				{

					_groupID = _x;

					if (_found) exitWith {};

						{

							_group = _x;

							if (_group != grpNull && (groupID _group) == _groupID && (side leader _group) == (_coc select 0)) exitWith {

								if !((leader _group) getVariable ["FW_IsCO", false]) then {

									(leader _group) setVariable ["FW_IsCO", true, false];

									{

										if (((side _x) == (side leader _group)) && _x != (leader _group)) then {
											_x setVariable ["FW_IsCO", false, false];
										};

									} forEach playableUnits;
								};

								_found = true;

							};

						} forEach allGroups;

				} forEach (_coc select 1);

			} forEach FW_COC;

			sleep(60);
		};
	};

};

if (!isDedicated) then {

	FNC_CallMissionReq = {

		private ["_callID", "_reqAdmin"];

		_callID = _this select 0;
		_reqAdmin = _this select 1;

		if (_reqAdmin && !serverCommandAvailable "#kick") exitWith {
			hint "Only server admins may use this feature!";
		};

		["frameworkCallMission", [player, _callID]] call CBA_fnc_globalEvent;

	};

};

FNC_RegisterMissionCall = {

	private ["_callID", "_callSide", "_callName", "_callArgs"];

	_callID = _this select 0;
	_callSide = _this select 1;
	_callName = _this select 2;
	_callArgs = _this select 3;

	FW_MissionCalls set [count FW_MissionCalls, [_callID, _callSide, _callName, _callArgs]];

};

FNC_RegisterCOC = {

	private ["_side", "_coc"];

	_side = _this select 0;
	_coc = _this select 1;

	FW_COC set [count FW_COC, [_side, _coc]];

};

// Admin Call Options
["AdminBLUFOR", sideUnknown, "Call Mission BLUFOR Victory", [[west, "AdminCalled", true], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FNC_RegisterMissionCall;
["AdminOPFOR", sideUnknown, "Call Mission OPFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", true], [independent, "AdminCalled", false], [civilian, "AdminCalled", false]]] call FNC_RegisterMissionCall;
["AdminINDFOR", sideUnknown, "Call Mission INDFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", true], [civilian, "AdminCalled", false]]] call FNC_RegisterMissionCall;
["AdminCIVFOR", sideUnknown, "Call Mission CIVFOR Victory", [[west, "AdminCalled", false], [east, "AdminCalled", false], [independent, "AdminCalled", false], [civilian, "AdminCalled", true]]] call FNC_RegisterMissionCall;

#include "settings.sqf"

if (!isDedicated) then {
	[] spawn {
		sleep (0.1);
		#include "menu.sqf"
	};
};
