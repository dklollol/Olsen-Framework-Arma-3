//This module contains functions to handle AI behaviour, e.g. get up, get down under fire, etc.
//Written by TinfoilHate
//Updated: July 19, 2017

	FNC_aiCover = {
		params ["_unit","_down","_up"];	//[OBJECT,[0.5,"DOWN"],[0.6,"MIDDLE"]] call FNC_aiCover;

		if (!local _unit) exitWith {};

		_unit setVariable ["aiCover_morale_down",_down select 0,false];
		_unit setVariable ["aiCover_state_down",_down select 1,false];

		_unit setVariable ["aiCover_morale_up",_up select 0,false];
		_unit setVariable ["aiCover_state_up",_up select 1,false];

		[_unit] call FNC_addCover;
	};

	FNC_addRecover = {
		params ["_unit"]; private ["_morale","_state"];

		_morale	= _unit getVariable "aiCover_morale_up";
		_state	= _unit getVariable "aiCover_state_up";

		if (alive _unit) then {
			[{morale (_this select 0) >= (_this select 1) || !alive (_this select 0)},{
				params ["_unit","_morale","_state"];

				_unit setUnitPos _state;
				[_unit] call FNC_addCover;
			},[_unit,_morale,_state]] call CBA_fnc_waitUntilAndExecute;
		};
	};

	FNC_addCover = {
		params ["_unit"]; private ["_morale","_state"];

		_morale	= _unit getVariable "aiCover_morale_down";
		_state	= _unit getVariable "aiCover_state_down";

		if (alive _unit) then {
			[{morale (_this select 0) < (_this select 1) || !alive (_this select 0)},{
				params ["_unit","_morale","_state"];

				_unit setUnitPos _state;
				[_unit] call FNC_addRecover;
			},[_unit,_morale,_state]] call CBA_fnc_waitUntilAndExecute;
		};
	};