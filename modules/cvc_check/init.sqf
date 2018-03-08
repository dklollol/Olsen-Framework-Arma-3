//Author:		TinfoilHate
//
//Description: 	Checks if the vehicle is the pilot or copilot of a tank or APC,
//				and swaps their hat for a CVC while retaining the original
//				headgear class, and swaps it back when they exit or go to cargo.
//
//Comments: 	Assigned to individual units, not the vehicles. UNIT need only
//				be the unit the EH is local to, and CVC is the class of the
//				CVC to add.
//
//Syntax:		[UNIT,CVC CLASS] call FNC_CVCCHECK;
//Example: 		[player, "rhsusf_cvc_green_helmet"] call FNC_CVCCHECK;

["cvcCheck", "Checks if a unit is a crewman in an armored vehicle, adds/removes CVC as appropriate.", "TinfoilHate"] call FNC_RegisterModule;

#include "settings.sqf"

#define PLAYERCLIENT (!isDedicated && hasInterface)

FNC_CVCCHECK = {
	private ["_unit","_cvcType","_veh"];

	_unit 		= _this select 0;
	_cvcType 	= _this select 1;
	_veh 		= vehicle _unit;

	_unit setVariable ["FW_CVCTYPE", _cvcType];
	_unit setVariable ["FW_HATTYPE", headgear _unit];

	if (_veh isKindOf "Tank" || _veh isKindOf "Wheeled_APC_F") then {
		if ((assignedVehicleRole _unit) select 0 != "cargo") then {
			if (headgear _unit != _cvcType) then {
				_unit setVariable ["FW_HATTYPE", headgear _unit];
				_unit addHeadgear _cvcType;
			};
		};
	};

	_unit addEventHandler ["GetInMan",{
		_unit = _this select 0;
		_pos = assignedVehicleRole _unit;
		_veh = _this select 2;
		_cvcType = _unit getVariable "FW_CVCTYPE";
		_hatType = _unit setVariable ["FW_HATTYPE", headgear _unit];

		if (_veh isKindOf "Tank" || _veh isKindOf "Wheeled_APC_F") then {
			if (_pos select 0 != "cargo") then {
				if (headgear _unit != _cvcType) then {
					_unit setVariable ["FW_HATTYPE", headgear _unit];
					_unit addHeadgear _cvcType;
				};
			} else {
				if (_hatType == "") then {removeHeadgear _unit} else {_unit addHeadgear _hatType};
			};
		};
	}];

	_unit addEventHandler ["GetOutMan",{
		_unit = _this select 0;
		_pos = assignedVehicleRole _unit;
		_veh = _this select 2;
		_cvcType = _unit getVariable "FW_CVCTYPE";
		_hatType = _unit getVariable "FW_HATTYPE";

		if (_veh isKindOf "Tank" || _veh isKindOf "Wheeled_APC_F") then {
			if (_pos select 0 != "cargo") then {
				if (_hatType == "") then {removeHeadgear _unit} else {_unit addHeadgear _hatType};
			};
		};
	}];

	_unit addEventHandler ["SeatSwitchedMan",{
		_unit = _this select 0;
		_pos = assignedVehicleRole _unit;
		_veh = _this select 2;
		_cvcType = _unit getVariable "FW_CVCTYPE";
		_hatType = _unit getVariable "FW_HATTYPE";

		if (_veh isKindOf "Tank" || _veh isKindOf "Wheeled_APC_F") then {
			if (_pos select 0 == "cargo") then {
				if (_hatType == "") then {removeHeadgear _unit} else {_unit addHeadgear _hatType};
			} else {
				if (headgear _unit != _cvcType) then {
					_unit setVariable ["FW_HATTYPE", headgear _unit];
					_unit addHeadgear _cvcType;
				};
			};
		};
	}];
};

if PLAYERCLIENT then {
	switch (side player) do {
		case west: {[player, WESTCVC] call FNC_CVCCHECK};
		case east: {[player, EASTCVC] call FNC_CVCCHECK};
		case resistance: {[player, GUERCVC] call FNC_CVCCHECK};
		default {[player, CIVCVC] call FNC_CVCCHECK};
	};
} else {
	{
		switch (side _x) do {
			case west: {[_x, WESTCVC] call FNC_CVCCHECK};
			case east: {[_x, EASTCVC] call FNC_CVCCHECK};
			case resistance: {[_x, GUERCVC] call FNC_CVCCHECK};
			default {[_x, CIVCVC] call FNC_CVCCHECK};
		};		
	} forEach AIUNITLIST;
};
