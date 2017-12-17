["Extract", "When called, the module will spawn an AI controlled vehicle and will wait until all players are mounted before extracting.", "Starfox64"] call FNC_RegisterModule;

FNC_Extract = {

	private ["_class", "_spawnLoc", "_alt", "_landLoc", "_waitFor", "_extractLoc", "_vehInit", "_spawnPos", "_landPos", "_extractPos", "_veh", "_isHelicopter", "_wpLand"];

	if (!isServer) exitWith {};

	_class = _this select 0;
	_spawnLoc = _this select 1;
	_alt = _this select 2;
	_landLoc = _this select 3;
	_waitFor = _this select 4;
	_extractLoc = _this select 5;

	_isHelicopter = false;

	if (count _this > 6) then {
		_vehInit = _this select 6;
	};

	switch (typeName _spawnLoc) do {
		case "STRING": {_spawnPos = getMarkerPos _spawnLoc};
		case "OBJECT": {_spawnPos = getPos _spawnLoc};
	};

	switch (typeName _landLoc) do {
		case "STRING": {_landPos = getMarkerPos _landLoc};
		case "OBJECT": {_landPos = getPos _landLoc};
	};

	switch (typeName _extractLoc) do {
		case "STRING": {_extractPos = getMarkerPos _extractLoc};
		case "OBJECT": {_extractPos = getPos _extractLoc};
	};

	_veh = createVehicle [_class, _spawnPos, [], 0, "FLY"];
	createVehicleCrew _veh;

	_veh setCaptive true;
	_veh allowDamage false;

	if (!isNil "_vehInit") then {
		_veh call compile _vehInit;
	};

	if (_veh isKindOf "Air") then {
		_isHelicopter = true;
	};

	_wpLand = (group driver _veh) addWaypoint [_landPos, 0];
	_wpLand setWaypointbehaviour "CARELESS";
	_wpLand setWaypointCombatMode "BLUE";

	if (_isHelicopter) then {
		_veh flyInHeight _alt;

		_wpLand setWaypointType "SCRIPTED";
		_wpLand setWaypointScript getText (configFile >> "CfgWaypoints" >> "A3" >> "Land" >> "file");
	} else {
		_wpLand setWaypointType "LOAD";
	};

	[_veh, _waitFor, _extractPos] spawn {

		private ["_veh", "_waitFor", "_extractPos", "_continue", "_wpExtract"];

		_veh = _this select 0;
		_waitFor = _this select 1;
		_extractPos = _this select 2;

		_continue = true;

		sleep(1);

		while {_continue} do {

			switch (typeName _waitFor) do {
				case "SIDE": {if ([_veh, _waitFor] call FNC_CheckSideInVeh) then {_continue = false}};
				case "OBJECT": {if (_waitFor in _veh || !(_waitFor call FNC_Alive)) then {_continue = false}};
				case "ARRAY": {if ([_veh, _waitFor] call FNC_CheckArrayInVeh) then {_continue = false}};
				case "STRING": {if (_veh call compile _waitFor) then {_continue = false}};
			};

			sleep(5);

		};

		_wpExtract = (group driver _veh) addWaypoint [_extractPos, 0];
		_wpExtract setWaypointType "LOITER";
		_wpExtract setWaypointSpeed "FULL";

	};

	_veh;

};

FNC_CheckArrayInVeh = {

	private ["_veh", "_units", "_total", "_inHeli"];

	_veh = _this select 0;
	_units = _this select 1;

	_total = {_x call FNC_Alive} count _units;
	_inHeli = {_x in _veh} count _units;

	if (_inHeli >= _total) then {
		true;
	} else {
		false;
	};

};

FNC_CheckSideInVeh = {

	private ["_veh", "_side", "_units", "_result"];

	_veh = _this select 0;
	_side = _this select 1;

	_units = [];

	{if (side _x == _side) then {_units set [count _units, _x]}} forEach playableUnits;

	_result = [_veh, _units] call FNC_CheckArrayInVeh;

	_result;

};
