["Weather Parameters", "Allows the admin to choose between different weather parameters.", "Starfox64"] call FNC_RegisterModule;

private ["_date", "_overcast", "_wind", "_fog"];

if (isServer) then {

	_date = date;
	_date set [3, ("TimeOfDay" call BIS_fnc_getParamValue)];
	_date set [4, 0];
	[_date] call BIS_fnc_setDate;

};

_overcast = "Weather" call BIS_fnc_getParamValue;
0 setOvercast (_overcast / 10);

_wind = "Wind" call BIS_fnc_getParamValue;
0 setWindStr (_wind / 10);

if ((_wind / 10) * 1.25 > 1) then {

	0 setGusts 1;

} else {

	0 setGusts ((_wind / 10) * 1.25);

};

_fog = "Fog" call BIS_fnc_getParamValue;
0 setFog (_fog / 10);