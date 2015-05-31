FNC_StackNames = {
	
	private ["_array", "_foundArray", "_newArray", "_string", "_count"];
	
	_array = _this;
	_foundArray = [];
	_newArray = [];
	
	{
		
		if (!(_x in _foundArray)) then {
			
			_string = _x;
			
			_foundArray set [count _foundArray, _string];
			
			_count = 0;
			
			{
				
				if (_string == _x) then {
					
					_count = _count + 1;
					
				};
				
			} forEach _array;

			_newArray set [count _newArray, format ["%1 X %2", _count, _string]];
			
		};
		
	} forEach _array;
	
	_newArray
	
};

FNC_GetDamagedAssets = {
	
	private ["_team", "_disabledAssets", "_destroyedAssets"];
	
	_team = _this;

	_disabledAssets = [];
	_destroyedAssets = [];
	
	{
		
		if (_x getVariable "frameworkAssetTeam" == _team) then {
		
			if (alive _x) then {
			
				if (!canMove _x && !canFire _x) then {
					
					_disabledAssets set [count _disabledAssets, _x getVariable "frameworkAssetName"];
					
				};
			
			} else {
				
				_destroyedAssets set [count _destroyedAssets, _x getVariable "frameworkAssetName"];
				
			};
		};
		
	} forEach vehicles;
	
	_destroyedAssets = _destroyedAssets call FNC_StackNames;
	_disabledAssets = _disabledAssets call FNC_StackNames;
	
	[_disabledAssets, _destroyedAssets]
	
};

//FNC_CreateRespawnMarker will make a respawn marker for _team at coordinate 0, 0, 0
FNC_CreateRespawnMarker = {
	
	private ["_team", "_markerName", "_marker"];
	
	_team = _this;
	
	_markerName = format ["respawn_%1", _team];
	
	_marker = createMarker [_markerName, [0, 0, 0]];
	_marker setMarkerShape "ICON";
	_markerName setMarkerType "EMPTY";
	
};

//FNC_InArea(UNIT, MARKER) checks if the UNIT is within the area of MARKER, supports all shapes
FNC_InArea = {

	private ["_unit", "_marker", "_pos", "_xSize", "_ySize", "_radius", "_result", "_x", "_y", "_temp"];

	_unit = _this select 0;
	_marker = _this select 1;

	_pos = markerPos _marker;

	_xSize = (markerSize _marker) select 0;
	_ySize = (markerSize _marker) select 1;

	_radius = _xSize;

	if (_ySize > _xSize) then {

		_radius = _ySize;
		
	};

	_result = false;

	if ((_unit distance _pos) <= (_radius * 1.5)) then {

		_x = (getPosASL _unit) select 0;
		_y = (getPosASL _unit) select 1;

		_angle = markerDir _marker;

		_x = _x - (_pos select 0);
		_y = _y - (_pos select 1);
			
		if (_angle != 0) then {

			_temp = _x * cos(_angle) - _y * sin(_angle);
			_y = _x * sin(_angle) + _y * cos(_angle);
			_x = _temp;

		};	
		
		if ((markerShape _marker) == "ELLIPSE") then {

			if (_xSize == _ySize) then {
			
				if ((_unit distance _pos) <= _radius) then {
				
					_result = true;	
			
				};
			
			} else {
			
				if (((_x ^ 2) / (_xSize ^ 2) + (_y ^ 2) / (_ySize ^ 2)) <= 1) then {
					
					_result = true;
					
				};

			};

		} else {
		

			if ((abs _x) <= _xSize && (abs _y) <= _ySize) then {
				
				_result = true;
				
			};

		};

	};

	_result

};

//FNC_EndMission(SCENARIO) will end the mission
//Sends the team stats, time limit, scenario and executes "endScreen" on all players machines
FNC_EndMission = {
	
	private ["_scenario", "_team"];
	
	_scenario = _this;
	
	FW_MissionEnded = true;
	
	{
	
		_team = (_x select 0);
		
		_assets = _team call FNC_GetDamagedAssets;
		
		SETTEAMVARIABLE(_team, 3, _assets select 0);
		SETTEAMVARIABLE(_team, 4, _assets select 1);
	
	} forEach FW_Teams;

	["endScreen", [_scenario, timeLimit, FW_Teams]] call CBA_fnc_globalEvent;

};

//FNC_CasualtyPercentage(TEAM) returns the casualty percentage of TEAM
FNC_CasualtyPercentage = {
	
	private ["_team", "_temp", "_tempStart", "_tempCurrent", "_tempText"];

	_team = _this;
	
	_temp = 0;
	
	{ 
		if ((_x select 0) == _team) exitWith {
		
			_tempStart = (_x select 1);
			_tempCurrent = (_x select 2);
			
			if (_tempStart == 0) then {
			
				_tempText = format ["Casualty percentage:<br></br>Warning no units on team ""%1"".", _team];
				_tempText call FNC_DebugMessage;
				
			} else {
			
				_temp = (_tempStart - _tempCurrent) / (_tempStart * 0.01);
				
			};
		};
		
	} forEach FW_Teams;
	
	_temp
	
};

//FNC_CasualtyCount(TEAM) returns the casualty count of TEAM
FNC_CasualtyCount = {
	
	private ["_team", "_temp", "_tempStart", "_tempCurrent", "_tempText"];

	_team = _this;
	
	_temp = 0;
	
	{ 
		if ((_x select 0) == _team) exitWith {
		
			_tempStart = (_x select 1);
			_tempCurrent = (_x select 2);
			
			if (_tempStart == 0) then {
			
				_tempText = format ["Casualty count:<br></br>Warning no units on team ""%1"".", _team];
				_tempText call FNC_DebugMessage;
				
			} else {
			
				_temp = _tempStart - _tempCurrent;
				
			};
		};
		
	} forEach FW_Teams;
	
	_temp
	
};

//FNC_Alive(UNIT) checks if the framework considers the UNIT alive
FNC_Alive = {
	
	private ["_unit"];
	
	_unit = _this;
	
	(alive _unit) && !(_unit getVariable ["frameworkDead", false]) && !(_unit getVariable ["ACE_isUnconscious", false])
	
};

//FNC_HasEmptyPositions(VEHICLE) checks if the VEHICLE has any empty positions
FNC_HasEmptyPositions = {
	
	private ["_vehicle"];
	
	_vehicle = _this;
	
	(_vehicle emptyPositions "Cargo" != 0 || _vehicle emptyPositions "Gunner" != 0 || _vehicle emptyPositions "Commander" != 0 || _vehicle emptyPositions "Driver" != 0)
	
};

//FNC_InVehicle(UNIT) checks if the UNIT is in a vehicle
FNC_InVehicle = {
	
	private ["_unit"];
	
	_unit = _this;
	
	((vehicle _unit) != _unit)
	
};

//FNC_AddPlayableTeam(SIDE, NAME) adds an playable team of SIDE with NAME to be tracked by the framework
FNC_AddPlayableTeam = {
	
	private ["_side", "_name"];

	_side = _this select 0;
	_name = _this select 1;
	
	if (isMultiplayer) then {
	
		FW_Teams set [count FW_Teams, [_name, 0, 0, [], []]];
		
		CURRENTCOUNT set [count CURRENTCOUNT, [_name, _side, "startPlayable"]];
		CURRENTCOUNT set [count CURRENTCOUNT, [_name, _side, "currentPlayable"]];
		
	} else {
	
		[_side, _name] call FNC_AddAiTeam;
		
	};

};


//FNC_SpectateCheck() displays the appropriate message when the player dies
FNC_SpectateCheck = {
	
	if (respawnTickets > 0) then {
		
		titleText ["You are dead.\nRespawning...", "BLACK", 0.2];
		
	} else {
		
		titleText ["You are dead.\nEntering spectator mode...", "BLACK", 0.2];
		
	};
};

//FNC_SpectatePrep() checks and handles if the player should respawn or begin spectating
FNC_SpectatePrep = {
	
	private ["_respawnName", "_respawnPoint", "_text", "_loadout"];
	
	if (respawnTickets > 0) then {
		
		_respawnName = toLower(format ["fw_%1_respawn", side player]);
		_respawnPoint = missionNamespace getVariable [_respawnName, objNull];

		_loadout = (player getVariable ["frameworkLoadout", ""]);
		
		if (_loadout != "") then {
			
			[player, _loadout] call FNC_GearScript;
			
		};
		
		if (!isNull(_respawnPoint)) then {
		
			player setPos getPosATL _respawnPoint;
			
		};
		
		respawnTickets = respawnTickets - 1;
		
		_text = "respawns left";
		
		if (respawnTickets == 1) then {
			
			_text = "respawn left";
			
		};
		
		titleText ["You are dead.\nRespawning...", "BLACK IN", 0.2];
		
		cutText [format ['%1 %2', respawnTickets, _text], 'PLAIN DOWN'];
		
		player setVariable ["frameworkBody", player, true];
		
	} else {

		player setVariable ["frameworkDead", true, true]; //Tells the framework the player is dead

		player setCaptive true;
		player allowdamage false;

		removeHeadgear player;
		removeGoggles player;
		removeVest player;
		removeBackpack player;
		removeUniform player;
		removeAllWeapons player;
		removeAllAssignedItems player;
		
		player addWeapon "itemMap";
		
		player setPos [0, 0, 0];
		[player] join grpNull;
		
		if (!(player getVariable ["frameworkSpectating", false])) then {
		
			player setVariable ["frameworkSpectating", true, true];
			
			[true] call acre_api_fnc_setSpectator;
			"" execVM "core\spectate.sqf";
			
			
		} else {
		
			titleText ["You are dead.\nEntering spectator mode...", "BLACK IN", 0.2];
		
		};
	};
};

//FNC_AddAiTeam(SIDE, NAME) adds an ai team of SIDE with NAME to be tracked by the framework
FNC_AddAiTeam = {
	
	private ["_side", "_name"];

	_side = _this select 0;
	_name = _this select 1;
	
	FW_Teams set [count FW_Teams, [_name, 0, 0, [], []]];
	
	STARTCOUNT set [count STARTCOUNT, [_name, _side, "startAi"]];
	CURRENTCOUNT set [count CURRENTCOUNT, [_name, _side, "currentAi"]];

};