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
		
		GETDAMAGEDASSETNAMES(_team, _disabledTemp, _destroyedTemp);
		SETTEAMVARIABLE(_team, 3, _disabledTemp);
		SETTEAMVARIABLE(_team, 4, _destroyedTemp);
	
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
				[_tempText] call FNC_DebugMessage;
				
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
				[_tempText] call FNC_DebugMessage;
				
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
	
	(alive _unit) && !(_unit getVariable ["frameworkDead", false])
	
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

//ADDPLAYABLETEAM(SIDE, NAME) adds an playable team of SIDE with NAME to be tracked by the framework
FNC_AddPlayableTeam = {
	
	private {"_side", "_name"];

	_side = _this select 0;
	_name = _this select 0;
	
	if (isMultiplayer) then {
	
		FW_Teams set [count FW_Teams, [_name, 0, 0, [], []]];
		
		CURRENTCOUNT set [count CURRENTCOUNT, [_name, _side, "startPlayable"]];
		CURRENTCOUNT set [count CURRENTCOUNT, [_name, _side, "currentPlayable"]];
		
	} else {
	
		ADDAITEAM(_side, _name);
		
	};

};


//ADDAITEAM(SIDE, NAME) adds an ai team of SIDE with NAME to be tracked by the framework
FNC_AddPlayableTeam = {
	
	private {"_side", "_name"];

	_side = _this select 0;
	_name = _this select 0;
	
	FW_Teams set [count FW_Teams, [_name, 0, 0, [], []]];
	
	STARTCOUNT set [count STARTCOUNT, [_name, _side, "startAi"]];
	CURRENTCOUNT set [count CURRENTCOUNT, [_name, _side, "currentAi"]];

};