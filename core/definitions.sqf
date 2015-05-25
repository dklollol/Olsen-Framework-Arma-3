//Definitions are essentially functions so this is the Olsen framework code library

//QUERY will take an ARRAY and filter it based on the CONDITION 
//and store the result in VARNAME
#define QUERY(ARRAY, CONDITION, VARNAME) \
_temp = []; \
{if (CONDITION) then {_temp set [count _temp, _x];};} forEach ARRAY; \
VARNAME = _temp;

//FILTER does the same as QUERY but it removes the result from the original array
#define FILTER(ARRAY, CONDITION, VARNAME) \
QUERY(ARRAY, CONDITION, VARNAME); \
ARRAY = ARRAY - VARNAME;

//GETVARIABLES will take an ARRAY and return the VARIABLE of each object in
//ARRAY and store it in VARNAME
#define GETVARIABLES(ARRAY, VARIABLE, VARNAME) \
_temp = []; \
{_temp set [count _temp, (_x getVariable VARIABLE)];} forEach ARRAY; \
VARNAME = _temp;

//COUNTPLAYABLEUNITS will count the ammount of remaining alive players of SIDE who 
//are alive and stores the result in VARNAME
#define COUNTPLAYABLEUNITS(SIDE, VARNAME) \
QUERY(playableUnits, side _x == SIDE, _countQuery); \
QUERY(_countQuery, _x call FNC_Alive, _countQuery); \
VARNAME = count _countQuery;

//COUNTAIUNITS will count the ammount of remaining alive ai units of SIDE 
//and stores the result in VARNAME
#define COUNTAIUNITS(SIDE, VARNAME) \
QUERY(allUnits, side _x == SIDE, _countQuery); \
VARNAME = count _countQuery;

//STACKNAMES takes an array of strings and stacks the names to shorten the array
//Example: ["abc", "abc", "abc", "ab", "c", "c"] becomes ["3 X abc", "1 X ab", "2 X c"]
#define STACKNAMES(ARRAY, VARNAME) \
_namesTemp = []; \
while {count ARRAY != 0} do { \
	FILTER(ARRAY, (ARRAY select 0) == _x, _names); \
	_namesTemp set [count _namesTemp, (format ["%1 X %2", (count _names), (_names select 0)])]; \
}; \
VARNAME = _namesTemp;

//SETTEAMVARIABLE edits the variable of TEAM at POS with the new VALUE
#define SETTEAMVARIABLE(TEAM, POS, VALUE) \
{ \
	if ((_x select 0) == TEAM) then { \
		_x set [POS, VALUE]; \
	}; \
} forEach FW_Teams;

//COUNTUNITS processes the counting commands it is given
//Example: [["WEST", west, "startPlayable"],["WEST", west, "currentPlayable"]]
#define COUNTUNITS(ARRAY) \
{ \
	_team = (_x select 0); \
	_side = (_x select 1); \
	switch ((_x select 2)) do { \
		case "startAi": { \
			COUNTAIUNITS(_side, _countTemp); \
			SETTEAMVARIABLE(_team, 1, _countTemp); \
		}; \
		case "currentAi": { \
			COUNTAIUNITS(_side, _countTemp); \
			SETTEAMVARIABLE(_team, 2, _countTemp); \
		}; \
		case "startPlayable": { \
			_countTemp = playersNumber _side; \
			SETTEAMVARIABLE(_team, 1, _countTemp); \
		}; \
		case "currentPlayable": { \
			COUNTPLAYABLEUNITS(_side, _countTemp); \
			SETTEAMVARIABLE(_team, 2, _countTemp); \
		}; \
	}; \
} forEach ARRAY;

//GETDAMAGEDASSETNAMES will get all of the tracked assets of SIDE and stores them
//respectably in DISABLEDVAR and DESTROYEDVAR
#define GETDAMAGEDASSETNAMES(SIDE, DISABLEDVAR, DESTROYEDVAR) \
QUERY(vehicles, !(_x getVariable "vehName" == "<null>"), _vehicleQuery); \
QUERY(_vehicleQuery, (_x getVariable "vehTeam" == SIDE), _vehicleQuery); \
FILTER(_vehicleQuery, !alive _x, _destroyedVehicleQuery); \
QUERY(_vehicleQuery, !canMove _x, _vehicleQuery); \
QUERY(_vehicleQuery, !canFire _x, _disabledVehicleQuery); \
GETVARIABLES(_disabledVehicleQuery, "vehName", _disabledVehicleQuery); \
GETVARIABLES(_destroyedVehicleQuery, "vehName", _destroyedVehicleQuery); \
STACKNAMES(_disabledVehicleQuery, DISABLEDVAR); \
STACKNAMES(_destroyedVehicleQuery, DESTROYEDVAR);

//CreateRespawnMarker will make a respawn marker for team STRING at coordinate 0, 0, 0
#define CreateRespawnMarker(STRING) \
_marker = createMarker [STRING, [0, 0, 0]]; \
_marker setMarkerShape "ICON"; \
STRING setMarkerType "EMPTY";

#define ADDMODULE(NAME) \
call compile preprocessFileLineNumbers ("modules\" + NAME + "\init.sqf");

FNC_SPECTATE = compile preprocessFileLineNumbers "core\spectate.sqf";