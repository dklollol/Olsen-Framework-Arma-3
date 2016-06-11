["Environment / Mission Parameters", "Allows the admin to choose between different weather parameters.", "Starfox64, Olsen"] call FNC_RegisterModule;

private ["_TimeOfDayParam", "_WeatherParam", "_WindParam", "_FogParam", "_date", "_overcast", "_wind", "_fog"];

if (isServer) then {
	
	_TimeOfDayParam = "TimeOfDay" call BIS_fnc_getParamValue;
	
	if (_TimeOfDayParam != -1) then {

		_date = date;
		_date set [3, _TimeOfDayParam];
		_date set [4, 0];
		[_date] call BIS_fnc_setDate;
		
	};
};

_WeatherParam = "Weather" call BIS_fnc_getParamValue;

if (_WeatherParam != -1) then {
	
	_overcast = _WeatherParam;
	0 setOvercast (_overcast / 10);

};

_WindParam = "Wind" call BIS_fnc_getParamValue;

if (_WindParam != -1) then {
	
	_wind = _WindParam;
	0 setWindStr (_wind / 10);

	if ((_wind / 10) * 1.25 > 1) then {

		0 setGusts 1;

	} else {

		0 setGusts ((_wind / 10) * 1.25);

	};
};

_FogParam = "Fog" call BIS_fnc_getParamValue;

if (_FogParam != -1) then {

	_fog = _FogParam;
	0 setFog (_fog / 10);
	
};