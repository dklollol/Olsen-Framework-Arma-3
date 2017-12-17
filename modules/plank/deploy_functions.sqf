#include "plank_macros.h"

plank_deploy_fnc_setFortDirection = {
	FUN_ARGS_3(_unit,_fort,_fortIndex);

	private "_direction";
	_direction = _unit getVariable ["plank_deploy_fortDirection", GET_FORT_DIRECTION(_fortIndex)];
	_fort setDir ((getDir _unit) + _direction);
};

plank_deploy_fnc_setFortPosition = {
	FUN_ARGS_2(_unit,_fort);

	private ["_heightMode", "_newPostion"];
	_heightMode = _unit getVariable ["plank_deploy_heightMode", RELATIVE_TO_UNIT];
	_newPostion = _unit modelToWorld [0, [_unit] call plank_deploy_fnc_getFortDistance, 0];
	call {
		if (_heightMode == RELATIVE_TO_TERRAIN) exitWith {
			_newPostion set [2, 0];
			_fort setPos _newPostion;
		};
		if (_heightMode == RELATIVE_TO_UNIT) exitWith {
			_newPostion set [2, ((getPosASL _unit) select 2) + (_unit getVariable ["plank_deploy_fortRelativeHeight", 0])];
			_fort setPosASL _newPostion;
		};
	};
};

plank_deploy_fnc_setFortVariables = {
	FUN_ARGS_7(_fortIndex,_fort,_relativeHeight,_direction,_distance,_pitch,_bank);
	
	_unit setVariable ["plank_deploy_fortIndex", _fortIndex, false];
	_unit setVariable ["plank_deploy_fort", _fort, false];
	_unit setVariable ["plank_deploy_fortRelativeHeight", _relativeHeight, false];
	_unit setVariable ["plank_deploy_fortDirection", _direction, false];
	_unit setVariable ["plank_deploy_fortDistance", _distance, false];
	_unit setVariable ["plank_deploy_fortPitch", _pitch, false];
	_unit setVariable ["plank_deploy_fortBank", _bank, false];
};

plank_deploy_fnc_setFortPitchAndBank = {
	FUN_ARGS_2(_unit,_fort);

	[_fort, _unit getVariable ["plank_deploy_fortPitch", 0], _unit getVariable ["plank_deploy_fortBank", 0]] call BIS_fnc_setPitchBank;
};

plank_deploy_fnc_getFortDistance = {
	FUN_ARGS_1(_unit);

	_unit getVariable ["plank_deploy_fortDistance", GET_FORT_DISTANCE((_unit getVariable "plank_deploy_fortIndex"))];
};

plank_deploy_fnc_createFortification = {
	FUN_ARGS_2(_unit,_fortIndex);

	private "_fort";
	_fort = createVehicle [GET_FORT_CLASS_NAME(_fortIndex), [0,0,0], [], 0, "NONE"];
	[_fortIndex, _fort, 0, GET_FORT_DIRECTION(_fortIndex), GET_FORT_DISTANCE(_fortIndex), 0, 0] call plank_deploy_fnc_setFortVariables;
	[_unit, _fort, _fortIndex] call plank_deploy_fnc_setFortDirection;
	[_unit, _fort] call plank_deploy_fnc_setFortPosition;

	_fort;
};

plank_deploy_fnc_addPlacementActions = {
	FUN_ARGS_1(_unit);

	private ["_confirmActionId", "_cancelActionId", "_openActionId"];
	_confirmActionId = _unit addAction ['<t color="#3748E3">Confirm Deployment</t>', "modules\plank\confirm_fort_action.sqf", [], 100, false, false, "", "driver _target == _this"];
	_cancelActionId = _unit addAction ['<t color="#FF0000">Cancel Deployment</t>', "modules\plank\cancel_fort_action.sqf", [], 99, false, false, "", "driver _target == _this"];
	_openActionId = _unit addAction ['<t color="#00FF00">Open Settings</t>', "modules\plank\open_settings_action.sqf", [], 98, false, false, "", "driver _target == _this"];
	_unit setVariable ["plank_deploy_confirmActionId", _confirmActionId, false];
	_unit setVariable ["plank_deploy_cancelActionId", _cancelActionId, false];
	_unit setVariable ["plank_deploy_openActionId", _openActionId, false];
};

plank_deploy_fnc_removePlacementActions = {
	FUN_ARGS_1(_unit);

	private "_actionIdNames";
	_actionIdNames = ["plank_deploy_confirmActionId", "plank_deploy_cancelActionId", "plank_deploy_openActionId"];
	{
		private "_actionId";
		_actionId = _unit getVariable _x;
		if (!isNil {_actionId}) then {
			_unit removeAction _actionId;
		};
	} foreach _actionIdNames;
};

plank_deploy_fnc_removeFortificationActions = {
	FUN_ARGS_1(_unit);

	private "_fortActionIds";
	_fortActionIds = _unit getVariable ["plank_deploy_fortActionIds", []];
	{
		if (!isNil {_x}) then {
			_unit removeAction _x;
		};
	} foreach _fortActionIds;
};

plank_deploy_fnc_updateFortPlacement = {
	FUN_ARGS_1(_unit);

	waitUntil {
		private ["_fort", "_fortIndex"];
		_fort = _unit getVariable "plank_deploy_fort";
		_fortIndex = _unit getVariable "plank_deploy_fortIndex";
		if (!isNil {_fort} && {!isNil {_fortIndex}}) then {
			[_unit, _fort, _fortIndex] call plank_deploy_fnc_setFortDirection;
			[_unit, _fort] call plank_deploy_fnc_setFortPosition;
			[_unit, _fort] call plank_deploy_fnc_setFortPitchAndBank;
		};

		_unit getVariable ["plank_deploy_placementState", STATE_PLACEMENT_INIT] != STATE_PLACEMENT_IN_PROGRESS;
	};
};

plank_deploy_fnc_startFortPlacement = {
	FUN_ARGS_3(_unit,_actionId,_fortIndex);

	if ((_unit getVariable ["plank_deploy_placementState", STATE_PLACEMENT_INIT]) != STATE_PLACEMENT_IN_PROGRESS) then {
		private "_fortActionIds";
		_fortActionIds = _unit getVariable ["plank_deploy_fortActionIds", []];
		_fortActionIds set [_fortIndex, nil];
		_unit removeAction _actionId;
		_unit setVariable ["plank_deploy_heightMode", RELATIVE_TO_UNIT, false];
		_unit setVariable ["plank_deploy_placementState", STATE_PLACEMENT_IN_PROGRESS, false];
		[_unit, _fortIndex] call plank_deploy_fnc_createFortification;
		[_unit] call plank_deploy_fnc_addPlacementActions;
		[_unit] spawn plank_deploy_fnc_updateFortPlacement;
	};
};

plank_deploy_fnc_deleteFort = {
	FUN_ARGS_1(_unit);

	deleteVehicle (_unit getVariable "plank_deploy_fort");
	[_unit] call plank_deploy_fnc_resetFort;
};

plank_deploy_fnc_resetFort = {
	FUN_ARGS_1(_unit);

	_unit setVariable ["plank_deploy_fortIndex", -1, false];
	private "_variableNames";
	_variableNames = ["plank_deploy_fort", "plank_deploy_fortRelativeHeight", "plank_deploy_fortRelativeHeight",
		"plank_deploy_fortDirection", "plank_deploy_fortDistance", "plank_deploy_fortPitch",
		"plank_deploy_fortBank", "plank_deploy_heightMode"
	];
	{
		_unit setVariable [_x, nil, false];
	} foreach _variableNames;
};

plank_deploy_fnc_reAddFortificationAction = {
	FUN_ARGS_2(_unit,_resetFunc);

	private ["_fortIndex", "_fortCounts"];
	_fortIndex = _unit getVariable ["plank_deploy_fortIndex", -1];
	_fortCounts = _unit getVariable ["plank_deploy_fortCounts", []];
	[_unit] call _resetFunc;
	[_unit, _fortCounts select _fortIndex, _fortIndex] call plank_deploy_fnc_addFortificationAction;
};

plank_deploy_fnc_cancelFortPlacement = {
	FUN_ARGS_1(_unit);

	_unit setVariable ["plank_deploy_placementState", STATE_PLACEMENT_CANCELLED, false];
	[_unit] call plank_deploy_fnc_removePlacementActions;
	[_unit, plank_deploy_fnc_deleteFort] call plank_deploy_fnc_reAddFortificationAction;
};

plank_delpoy_fnc_forceRemoveAllFortifications = {
	FUN_ARGS_1(_unit);

	[] call plank_ui_fnc_closeSettingsDialog;
	_unit setVariable ["plank_deploy_placementState", STATE_PLACEMENT_CANCELLED, false];
	[_unit] call plank_deploy_fnc_removePlacementActions;
	[_unit] call plank_deploy_fnc_removeFortificationActions;
	[_unit] call plank_deploy_fnc_deleteFort;
	_unit setVariable ["plank_deploy_fortCounts", nil, false];
};

plank_deploy_fnc_decreaseFortCount = {
	FUN_ARGS_1(_unit);

	private ["_fortIndex", "_fortCounts"];
	_fortIndex = _unit getVariable ["plank_deploy_fortIndex", -1];
	_fortCounts = _unit getVariable ["plank_deploy_fortCounts", []];
	if (_fortIndex != -1 && {count _fortCounts >= _fortIndex}) then {
		_fortCounts set [_fortIndex, (_fortCounts select _fortIndex) - 1];
	};
};

plank_deploy_fnc_confirmFortPlacement = {
	FUN_ARGS_1(_unit);

	_unit setVariable ["plank_deploy_placementState", STATE_PLACEMENT_DONE, false];
	[_unit] call plank_deploy_fnc_removePlacementActions;
	[_unit] call plank_deploy_fnc_decreaseFortCount;
	[_unit, _unit getVariable "plank_deploy_fort"] call GET_FORT_CODE((_unit getVariable "plank_deploy_fortIndex"));
	[_unit, plank_deploy_fnc_resetFort] call plank_deploy_fnc_reAddFortificationAction;
};

plank_deploy_fnc_addFortificationAction = {
	FUN_ARGS_3(_unit,_count,_fortIndex);

	if (_count > 0 && {_unit getVariable ["plank_deploy_fortIndex", -1] != _fortIndex}) then {
		private ["_actionId", "_fortActionIds"];
		_actionId = _unit addAction [format ["Place %1 (%2 left)", GET_FORT_DISPLAY_NAME(_fortIndex), _count], "modules\plank\place_fort_action.sqf", [_fortIndex], _fortIndex + 50, false, false, "", "driver _target == _this"];
		_fortActionIds = _unit getVariable ["plank_deploy_fortActionIds", []];
		_fortActionIds set [_fortIndex, _actionId];
	};
};

plank_deploy_fnc_addFortificationActions = {
	FUN_ARGS_1(_unit);

	{
		[_unit, _x, _forEachIndex] call plank_deploy_fnc_addFortificationAction;
	} foreach (_unit getVariable ["plank_deploy_fortCounts", []]);
};

plank_deploy_fnc_initUnitVariables = {
	FUN_ARGS_2(_unit,_fortifications);

	private "_fortActionIds";
	_fortActionIds = [];
	_fortActionIds set [(count _fortifications) - 1, nil];
	_unit setVariable ["plank_deploy_fortActionIds", _fortActionIds, false];
	_unit setVariable ["plank_deploy_fortCounts", _fortifications, false];
	[_unit] call plank_deploy_fnc_resetFort;
};

plank_deploy_fnc_init = {
	FUN_ARGS_2(_unit,_fortifications);

	[_unit] call plank_delpoy_fnc_forceRemoveAllFortifications;
	[_unit, _fortifications] call plank_deploy_fnc_initUnitVariables;
	[_unit] call plank_deploy_fnc_addFortificationActions;
};