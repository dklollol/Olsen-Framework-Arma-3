// Module by Starfox64 (STEAM_0:1:37636871) //

FW_MissionCalls = [];
FW_COC = [];

if (isServer) then {

	FNC_CallMission = {

		private ["_player", "_callID"];

		_player = _this select 0;
		_callID = _this select 1;

		{

			if ((_x select 0) == _callID && leader group _player == _player) exitWith {
				["Calling mission...", "hint", _player] call BIS_fnc_MP;
				(_x select 3) call FNC_EndMission;
			};

		} forEach FW_MissionCalls;

	};

	FW_CallMissionEh = ["frameworkCallMission", {_this spawn FNC_CallMission;}] call CBA_fnc_addEventHandler;

	[] spawn {

		private ["_coc", "_group"];

		while {true} do {
			{

				_coc = _x;

				{

					_group = _x;

					if (_group != grpNull) then {

						{

							if ((groupID _group) == _x && (side leader _group) == (_coc select 0)) exitWith {

								[(leader _group), "FNC_UpdateCO", (side leader _group)] call BIS_fnc_MP;

							};

						} forEach (_coc select 1);

					};

				} forEach allGroups;

			} forEach FW_COC;

			sleep(30);
		};
	};

};

if (!isDedicated) then {

	FW_CallActions = [];

	FNC_AddCallMenu = {

		private ["_actionID"];

		if (({(_x select 1) == side player} count FW_MissionCalls) == 0) exitWith {};

		_actionID = player addAction ["<t color='#FBB829'>Call Mission Menu</t>", "[] call FNC_ClearCallActions; [] call FNC_AddCallOptions;", nil, 0];
		FW_CallActions set [count FW_CallActions, _actionID];

	};

	FNC_AddCallOptions = {

		private ["_actionID"];

		{
			if ((_x select 1) == side player) then {
				_actionID = player addAction ["<t color='#19C819'>" + (_x select 2) + "</t>", "['frameworkCallMission', [player, '" + (_x select 0) + "']] call CBA_fnc_globalEvent; [] call FNC_ClearCallActions; [] call FNC_AddCallMenu;", nil, 0];
				FW_CallActions set [count FW_CallActions, _actionID];
			};

		} forEach FW_MissionCalls;

		_actionID = player addAction ["<t color='#C84646'>Close Menu</t>", "[] call FNC_ClearCallActions; [] call FNC_AddCallMenu;", nil, 0];
		FW_CallActions set [count FW_CallActions, _actionID];

	};

	FNC_ClearCallActions = {

		{player removeAction _x} forEach FW_CallActions;
		FW_CallActions = [];

	};

	FNC_UpdateCO = {

		private ["_newCO"];

		_newCO = _this;

		if (_this == player) then {

			if (count FW_CallActions == 0) then {

				hint "You are the CO, you may call this mission at any time using the [Call Mission Menu] action.";

				[] call FNC_AddCallMenu;

			};

		} else {

			[] call FNC_ClearCallActions;

		};

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

#include "settings.sqf"