["AI_Attack", "Allows for continious ai attack", "Sacher"] call FNC_RegisterModule;

FNC_AtkRegisterPath =
{
	private ["_group", "_units", "_array", "_wps"];

	_group = group (_this select 1);

	_units = units _group;
	_wps = waypoints _group;

	_array = [];
	{
		_array = _array + [[waypointType _x, waypointTimeout _x, waypointStatements _x, waypointSpeed _x, waypointScript _x, waypointPosition _x, waypointHousePosition _x, waypointFormation _x, waypointCombatMode _x, waypointBehaviour _x, waypointCompletionRadius _x]];
	} forEach _wps;

	{
		_x call FNC_NotTrackUnit;
		deleteVehicle _x;
	} forEach _units;

	deleteGroup _group;

	ATKcachedPaths pushBack (_this select 0);
	ATKcachedPaths pushBack _array;
};
//example unit call FNC_AtkRegisterPath;


FNC_AtkSpawnCustomUnit =
{
	private ["_newGroup","_unitToSpawn","_pos"];
	_newGroup = _this select 0;
	_pos = _this select 1;
	_unitToSpawn = _this select 2;
	_new = [_newGroup,_unitToSpawn select 0,([[[_pos,5]],[]] call BIS_fnc_randomPos)] call FNC_spawnAI;

	if( count _unitToSpawn >= 2) then
	{

		if(_unitToSpawn select 1 != "") then {[_new, _unitToSpawn select 1] call FNC_GearScript;};
	};
	if( count _unitToSpawn >= 3) then
	{

		_new setSkill (_unitToSpawn select 2);
	};
	_unitsSpawned pushBack _new;
	_new
};
FNC_AtkRegisterUnit =
{
	ATKcachedUnits pushBack (_this select 0);
	_this deleteAt 0;
	ATKcachedUnits pushBack _this;

};
FNC_AtkRegisterVehicle =
{
	ATKcachedVehicles pushBack (_this select 0);
	_this deleteAt 0;
	ATKcachedVehicles pushBack _this;

};
//example ["Ins_Rif","O_Soldier_F","Ins_Rif"] call FNC_AtkRegisterUnit; [name,soldierclass,gearscript];
FNC_AtkRandomStart =
{
	ATKcachedAttacks pushBack (_this select 0);
	_handle = _this spawn
	{
		private["_paths","_units","_side","_minSpawn", "_maxSpawn","_maxAmmount","_delay","_spawnDelay","_shouldClean","_unitsSpawned","_found"];

		_paths = [];
		_units = [];
		_side = _this select 3;
		_minSpawn = _this select 4;
		_maxSpawn = _this select 5;
		_maxAmmount = _this select 6;
		_delay = _this select 7;
		_spawnDelay = _this select 8;
		_shouldClean = true;
		if((_this select 9) == 0) then {_shouldClean = false; };

		{
				_found = ATKcachedPaths find _x;
				if(_found < 0) then
				{
					_temp = format ["AI Attack module:<br></br>Warning path ""%1"", in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
					_temp call FNC_DebugMessage;
				}
				else
				{
						_paths pushBack (ATKcachedPaths select (_found + 1));
				};
		}forEach (_this select 1);

		{
				_found = ATKcachedUnits find _x;
				if(_found < 0) then
				{
					_temp = format ["AI Attack module:<br></br>Warning unit ""%1"", in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
					_temp call FNC_DebugMessage;
				}
				else
				{
						_units pushBack (ATKcachedUnits select (_found + 1));
				};
		}forEach ( _this select 2);


		//internal vars;

		_unitsSpawned = [];
		sleep _delay ;
		//do some checks
		if(count _paths <= 0) then
		{
				_temp = format ["AI Attack module:<br></br>Warning no paths in Attack, in file ""modules\ai_attack\settings.sqf"" "];
				_temp call FNC_DebugMessage;
		};
		{
			if(count _x <= 0) then
			{
					_temp = format ["AI Attack module:<br></br>Warning paths with no wayPoints specified in Attack, in file ""modules\ai_attack\settings.sqf"" "];
					_temp call FNC_DebugMessage;
			};
		}forEach _paths;

		if(count _units <= 0) then
		{
				_temp = format ["AI Attack module:<br></br>Warning no units in Attack, in file ""modules\ai_attack\settings.sqf"" "];
				_temp call FNC_DebugMessage;
		};

		while{true} do
		{
			//cleanup all dead

				{
					if (!alive _x && !isNull _x) then
					{
						_unitsSpawned = _unitsSpawned - [_x];
						if(_shouldClean)	then {deleteVehicle _x;};

					};
				} forEach _unitsSpawned;


			{
				if (count units _x < 1) then {deleteGroup _x};
			} forEach allGroups;

			while{count _unitsSpawned < _maxAmmount} do
			{

					//select a Path
					_grpPath = _paths call BIS_fnc_selectRandom;
					_grpPos		= _grpPath select 0 select 5;
					_newGroup 	= createGroup _side;

					_ammountToSpawn = floor(random (_maxSpawn -_minSpawn)) + _minSpawn;

					for "_i" from 0 to _ammountToSpawn do
					{
							[_newGroup,_grpPos,_units call BIS_fnc_selectRandom] call FNC_AtkSpawnCustomUnit;
							sleep 0.25;
					};
					{
						_wp = _newGroup addWaypoint [(_x select 5), 0];
						_wp setWaypointType (_x select 0);
						_wp setWaypointTimeout (_x select 1);
						_wp setWaypointStatements (_x select 2);
						_wp setWaypointSpeed (_x select 3);
						_wp setWaypointScript (_x select 4);
						_wp setWaypointHousePosition (_x select 6);
						_wp setWaypointFormation (_x select 7);
						_wp setWaypointCombatMode (_x select 8);
						_wp setWaypointBehaviour (_x select 9);
						_wp setWaypointCompletionRadius (_x select 10);
					} forEach _grpPath;
					sleep 1;
			};
				sleep(_spawnDelay);
		};

	};
	ATKcachedAttacks pushBack _handle;

};

FNC_AtkStart =
{
	ATKcachedAttacks pushBack (_this select 0);
	_handle = _this spawn
	{
		private["_paths","_units","_side","_minSpawn", "_maxSpawn","_maxAmmount","_delay","_spawnDelay","_shouldClean","_unitsSpawned","_found"];

		_paths = [];
		_units = [];
		_side = _this select 3;
		_minSpawn = _this select 4;
		_maxSpawn = _this select 5;
		_delay = _this select 6;
		_spawnDelay = _this select 7;
		_shouldClean =_this select 8;

		{
				_found = ATKcachedPaths find _x;
				if(_found < 0) then
				{
					_temp = format ["AI Attack module:<br></br>Warning path ""%1"", in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
					_temp call FNC_DebugMessage;
				}
				else
				{
						_paths pushBack (ATKcachedPaths select (_found + 1));
				};
		}forEach (_this select 1);

		{
				_found = ATKcachedUnits find _x;
				if(_found < 0) then
				{
					_temp = format ["AI Attack module:<br></br>Warning unit ""%1"", in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
					_temp call FNC_DebugMessage;
				}
				else
				{
						_units pushBack (ATKcachedUnits select (_found + 1));
				};
		}forEach ( _this select 2);


		//internal vars;

		_unitsSpawned = [];
		sleep _delay ;
		//do some checks
		if(count _paths <= 0) then
		{
				_temp = format ["AI Attack module:<br></br>Warning no paths in Attack, in file ""modules\ai_attack\settings.sqf"" "];
				_temp call FNC_DebugMessage;
		};
		{
			if(count _x <= 0) then
			{
					_temp = format ["AI Attack module:<br></br>Warning paths with no wayPoints specified in Attack, in file ""modules\ai_attack\settings.sqf"" "];
					_temp call FNC_DebugMessage;
			};
		}forEach _paths;

		if(count _units <= 0) then
		{
				_temp = format ["AI Attack module:<br></br>Warning no units in Attack, in file ""modules\ai_attack\settings.sqf"" "];
				_temp call FNC_DebugMessage;
		};

		while{true} do
		{
			//cleanup all dead

				{
					if (!alive _x && !isNull _x) then
					{
						_unitsSpawned = _unitsSpawned - [_x];
						if(_shouldClean)	then {deleteVehicle _x;};

					};
				} forEach _unitsSpawned;


			{
				if (count units _x < 1) then {deleteGroup _x};
			} forEach allGroups;

			_ammountToSpawn = floor(random (_maxSpawn -_minSpawn)) + _minSpawn;
			for "_i" from 0 to _ammountToSpawn do
			{

					//select a Path
					_grpPath = _paths call BIS_fnc_selectRandom;
					_grpPos		= _grpPath select 0 select 5;
					_newGroup 	= createGroup _side;

					{
							[_newGroup,_grpPos,_x] call FNC_AtkSpawnCustomUnit;
							sleep 0.25;
					}forEach _units;
					{
						_wp = _newGroup addWaypoint [(_x select 5), 0];
						_wp setWaypointType (_x select 0);
						_wp setWaypointTimeout (_x select 1);
						_wp setWaypointStatements (_x select 2);
						_wp setWaypointSpeed (_x select 3);
						_wp setWaypointScript (_x select 4);
						_wp setWaypointHousePosition (_x select 6);
						_wp setWaypointFormation (_x select 7);
						_wp setWaypointCombatMode (_x select 8);
						_wp setWaypointBehaviour (_x select 9);
						_wp setWaypointCompletionRadius (_x select 10);
					} forEach _grpPath;
					sleep 1;
			};
				sleep(_spawnDelay);
		};

	};
	ATKcachedAttacks pushBack _handle;

};

FNC_AtkVehicleStart =
{
	ATKcachedAttacks pushBack (_this select 0);
	_handle = _this spawn
	{
		private["_paths","_num","_units","_side","_minSpawn", "_maxSpawn","_maxAmmount","_delay","_spawnDelay","_shouldClean","_unitsSpawned","_found","_unitsSpawned"];
		_paths = [];
		_units = [];
		_side = _this select 3;
		_minSpawn = _this select 4;
		_maxSpawn = _this select 5;
		_delay = _this select 6;
		_spawnDelay = _this select 7;
		_shouldClean =_this select 8;


		//cache paths
		{
				_found = ATKcachedPaths find _x;
				if(_found < 0) then
				{
					_temp = format ["AI Attack module:<br></br>Warning path ""%1"", in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
					_temp call FNC_DebugMessage;
				}
				else
				{
						_paths pushBack (ATKcachedPaths select (_found + 1));
				};
		}forEach (_this select 1);
		//cache vehicles
		{
				_newVehicle = [];
				_found = ATKcachedVehicles find _x;
				_newVehicle pushBack ((ATKcachedVehicles select (_found + 1)) select 0);
				_newUnits = [];
				if(_found < 0) then
				{
					_temp = format ["AI Attack module:<br></br>Warning vehicle ""%1"", in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
					_temp call FNC_DebugMessage;
				}
				else
				{

					{
						_inffound = ATKcachedUnits find _x;
						if(_found < 0) then
						{
							_temp = format ["AI Attack module:<br></br>Warning vehicle crew ""%1"", in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
							_temp call FNC_DebugMessage;
						}
						else
						{
							_newUnits pushBack (ATKcachedUnits select (_inffound + 1));
						};
					}forEach ((ATKcachedVehicles select (_found + 1)) select 1);

					_newVehicle pushBack _newUnits;
					_units pushBack _newVehicle;
				};
		}forEach ( _this select 2);


		//internal vars;
		sleep _delay ;
		//do some checks
		if(count _paths <= 0) then
		{
				_temp = format ["AI Attack module:<br></br>Warning no paths in Attack, in file ""modules\ai_attack\settings.sqf"" "];
				_temp call FNC_DebugMessage;
		};
		{
			if(count _x <= 0) then
			{
					_temp = format ["AI Attack module:<br></br>Warning paths with no wayPoints specified in Attack, in file ""modules\ai_attack\settings.sqf"" "];
					_temp call FNC_DebugMessage;
			};
		}forEach _paths;

		if(count _units <= 0) then
		{
				_temp = format ["AI Attack module:<br></br>Warning no vehicles in Attack, in file ""modules\ai_attack\settings.sqf"" "];
				_temp call FNC_DebugMessage;
		};
		_unitsSpawned = [];
		while{true} do
		{
			//cleanup all dead

				{
					if (!alive _x && !isNull _x) then
					{
						_unitsSpawned = _unitsSpawned - [_x];
						if(_shouldClean)	then {deleteVehicle _x;};

					};
				} forEach _unitsSpawned;
				//check if vehicles are down


			{
				if (count units _x < 1) then {deleteGroup _x};
			} forEach allGroups;

			_ammountToSpawn = floor(random (_maxSpawn -_minSpawn)) + _minSpawn;
			for "_i" from 0 to _ammountToSpawn do
			{
				//select a Path
				_grpPath = selectRandom _paths;
				_grpPos		= _grpPath select 0 select 5;
				_newGroup 	= createGroup _side;

				 _unitToSpawn = _units call BIS_fnc_selectRandom;
				 _veh = [(_unitToSpawn select 0), _grpPos,_side] call FNC_spawnVehicle;
				 _crew = _unitToSpawn select 1;

				 if(count _crew >= 1) then
				 {
				 		_new = [_newGroup,_grpPos, _crew select 0] call FNC_AtkSpawnCustomUnit;
						_new moveInDriver _veh;
						_new assignAsDriver _veh;
				 };

				 if(count _crew >= 2) then
				 {
						_new = [_newGroup,_grpPos, _crew select 1] call FNC_AtkSpawnCustomUnit;
						_new moveInGunner _veh;
						_new assignAsGunner _veh;
				 };
				 if(count _crew >= 3) then
					{
						_new =  [_newGroup,_grpPos, _crew select 2] call FNC_AtkSpawnCustomUnit;
						 _new moveInCommander _veh;
						 _new assignAsCommander _veh;
					};
					for "_i" from 3 to ((count _crew ) - 1) do
					{
						_new = [_newGroup,_grpPos, _crew select _i] call FNC_AtkSpawnCustomUnit;
					  _new moveInCargo _veh;
					  _new assignAsCargo _veh;
					};
					{
						_wp = _newGroup addWaypoint [(_x select 5), 0];
						_wp setWaypointType (_x select 0);
						_wp setWaypointTimeout (_x select 1);
						_wp setWaypointStatements (_x select 2);
						_wp setWaypointSpeed (_x select 3);
						_wp setWaypointScript (_x select 4);
						_wp setWaypointHousePosition (_x select 6);
						_wp setWaypointFormation (_x select 7);
						_wp setWaypointCombatMode (_x select 8);
						_wp setWaypointBehaviour (_x select 9);
						_wp setWaypointCompletionRadius (_x select 10);
					} forEach _grpPath;
					sleep 1;
			};
				sleep(_spawnDelay);
		};

	};
	ATKcachedAttacks pushBack _handle;
};

FNC_AtkStopAttack =
{

	_found = ATKcachedAttacks find _this select 0;
	if(_found < 0) then
	{
		_temp = format ["AI Attack module:<br></br>Attack ""%1"" does not exist and therefore cannot be stopped, in file ""modules\ai_attack\settings.sqf"" does not exist.", _x];
		_temp call FNC_DebugMessage;
	}
	else
	{
			terminate ATKcachedAttacks select (_found +1);
	};

};


_strengthParam = ["AIAttackStrength",90] call BIS_fnc_getParamValue;
_skillParam = (["AIAttackSkill",70] call BIS_fnc_getParamValue) / 100;
_cleanUpParam = ["AIAttackCleanUp",1] call BIS_fnc_getParamValue;
_prepParam = ["AIAttackPrepTime",5] call BIS_fnc_getParamValue;


AIAttackStrength_Param = _strengthParam;
AIAttackSkill_Param = _skillParam;
AIAttackCleanUp_Param = _cleanUpParam;
AIAttackPrepTime_Param = _prepParam;

//expected [paths aviable,units aviable,min ammount of Units spawned, max ammount of units spawned,max ammount of units in the field,delay from mission start,delay between spawns,should clean]
if (isServer) then
{

	ATKcachedPaths = [];
	ATKcachedUnits = [];
	ATKcachedVehicles = [];
	ATKcachedAttacks = [];
	#include "settings.sqf"
};
