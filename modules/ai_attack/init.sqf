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

FNC_AtkRegisterUnit =
{
	ATKcachedUnits pushBack (_this select 0);
	if(count _this >= 3) then
	{
		ATKcachedUnits pushBack [_this select 1, _this select 2];
	}
	else
	{
		ATKcachedUnits pushBack [_this select 1];
	};

};
//example ["Ins_Rif","O_Soldier_F","Ins_Rif"] call FNC_AtkRegisterUnit; [name,soldierclass,gearscript];
FNC_AtkStart =
{
	_handle = _this spawn
	{
		private["_paths","_units","_side","_minSpawn", "_maxSpawn","_maxAmmount","_delay","_spawnDelay","_shouldClean","_unitsSpawned","_found"];
		_paths = [];
		_units = [];
		_side = _this select 2;
		_minSpawn = _this select 3;
		_maxSpawn = _this select 4;
		_maxAmmount = _this select 5;
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
		}forEach (_this select 0);

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
		}forEach ( _this select 1);


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
					    _unitToSpawn = _units call BIS_fnc_selectRandom;
							_new = _newGroup createUnit [_unitToSpawn select 0,([[[_grpPos,5]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
							if( count _unitToSpawn >= 2) then
							{

								[_new, _unitToSpawn select 1] call FNC_GearScript;
							};
							_unitsSpawned pushBack _new;
							_new call FNC_TrackUnit;

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

};


//expected [paths aviable,units aviable,min ammount of Units spawned, max ammount of units spawned,max ammount of units in the field,delay from mission start,delay between spawns,should clean]
if (isServer) then
{

	ATKcachedPaths = [];
	ATKcachedUnits = [];
	#include "settings.sqf"
};
