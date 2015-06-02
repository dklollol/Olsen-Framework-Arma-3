/*
	Author: voiper
	
	Description: Prepare or immediately start spectator.
	
	Parameters:
		0: String; "Init" (to prepare for when player dies) or "Spectate" (to start immediately)
		1: Array (optional):
			0: Bool (optional); whether to enable unit tracking
			1: Bool (optional); whether to enable spectating of AI
			2: Array (optional); initial positionASL for camera
			
	Example:
		["Init", [false, true]] call compile preprocessfilelinenumbers "vip_asp\vip_asp_init.sqf";
		["Start", [true]] call compile preprocessfilelinenumbers "vip_asp\vip_asp_init.sqf";
			
	Returns:
	None.
*/

if (isDedicated) exitWith {};

//prevent people from calling this pre-init
if (isNull player) exitWith {_this spawn {waitUntil {!isNull player}; _this call compile preProcessFileLineNumbers "modules\voiper_spectate\vip_asp\vip_asp_init.sqf"}};

//prevent this from working when respawn isn't set up properly
_fail = if (getNumber (missionConfigFile >> "respawn") != 3 && getText (missionConfigFile >> "respawn") != "Base") then {true} else {false};
if (_fail) exitWith {
	_text = "[ASP] ERROR: This mission is not set up for proper respawn. Add ""respawn=3"" or ""respawn=""base"""" to description.ext.";
	[_text] call BIS_fnc_error;
	if (getnumber (missionconfigfile >> "allowFunctionsLog") == 0 && !cheatsEnabled) then {diag_log text _text};
};

_mode = [_this, 0, "Init", [""]] call BIS_fnc_param;
_this = [_this, 1, [false, false]] call BIS_fnc_param;

switch (_mode) do {

	case "Init": {
	
		_tracking = _this select 0;
		vip_asp_var_cl_ai = if (count _this > 1) then {_this select 1} else {false};
		vip_asp_var_cl_startingPos = if (count _this > 2) then {_this select 2} else {nil};
	
		_mapSize = (configFile >> "CfgWorlds" >> worldName >> "mapSize");
		_worldEdge = if (isNumber _mapSize) then {getNumber _mapSize} else {32768};
		vip_asp_var_cl_respawnPos = [_worldEdge, _worldEdge];

		vip_asp_var_cl_respawnDelay = getNumber (missionConfigFile >> "respawnDelay");

		if (_tracking) then {[true] call vip_asp_fnc_cl_tracking};

		player addEventHandler ["Respawn", {
			if (!isNil "vip_asp_obj_cl_cam") then {["Exit"] call vip_asp_fnc_cl_newCamera};
			["Start"] call compile preprocessFileLineNumbers "modules\voiper_spectate\vip_asp\vip_asp_init.sqf"
		}];

		player addEventHandler ["Killed", {
			[player] joinSilent grpNull;
			if (isClass (configFile >> "CfgPatches" >> "ace_hearing")) then {ace_hearing_disableVolumeUpdate = true};
			vip_asp_var_cl_respawnDelay fadeSound 0;
			99999 cutText ["", "BLACK", vip_asp_var_cl_respawnDelay];
		}];
		
		{_x setVariable ["vip_asp_deadName", name _x]; _x setVariable ["vip_asp_isAI", !isPlayer _x]} forEach allUnits;
	};
	
	case "Start": {
	
		if (isNil "vip_asp_var_cl_respawnDelay") then {["Init", _this] call compile preprocessFileLineNumbers "modules\voiper_spectate\vip_asp\vip_asp_init.sqf"};
		if (isClass (configFile >> "CfgPatches" >> "ace_hearing")) then {ace_hearing_disableVolumeUpdate = true};
		if (isClass (configFile >> "CfgPatches" >> "acre_sys_radio")) then {[true] call acre_api_fnc_setSpectator};
		0 fadeSound 0;
		player addEventHandler ["HandleDamage", {0}];
		[player] joinSilent grpNull;
		removeAllWeapons player;
		removeAllItems player;
		removeAllAssignedItems player;
		removeUniform player;
		removeVest player;
		player linkItem "ItemMap";
		player linkItem "ItemRadio";
		hideObjectGlobal player;
		
		if (surfaceisWater vip_asp_var_cl_respawnPos) then {
			player forceAddUniform "U_B_Wetsuit";
			player addVest "V_RebreatherB";
			vip_asp_var_cl_respawnPos set [2, -1.4];
			player setPosASL vip_asp_var_cl_respawnPos;
		} else {
			vip_asp_var_cl_respawnPos set [2, 0];
			player setPosATL vip_asp_var_cl_respawnPos;
		};
		
		99999 cutText ["", "BLACK FADED"];
		
		[] spawn {
			_tracking = if (!isNil "vip_asp_var_cl_trackingArray") then {2} else {0};
			["Init", [true, _tracking, vip_asp_var_cl_ai]] call vip_asp_fnc_cl_newCamera;
			sleep 1;
			99999 cutText ["", "BLACK IN", 2];
			2 fadeSound 1;
		};
	};
};