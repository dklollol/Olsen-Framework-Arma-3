["Environment / Mission Parameters", "Allows the admin to choose between different weather parameters.", "Starfox64, Olsen"] call FNC_RegisterModule;

#include "settings.sqf"

if (isMultiplayer) then {
	
	private ["_TimeParam", "_WeatherParam", "_WindParam", "_FogParam", "_date", "_overcast", "_wind", "_fog"];

	if (isServer) then {
		
		_TimeParam = "TimeOfDay" call BIS_fnc_getParamValue;
        
        private _t = -1;
        
        if (_TimeParam in [-2,-3,-4,-5]) then {
            
            _sunsetSunrise = [] call BIS_fnc_sunriseSunsetTime;
            if (_sunsetSunrise in [[-1,0],[0,-1]]) then {
                _t = -1;
            } else {
            
                switch (_TimeParam) do {
                    case -2: {
                        _t = (_sunsetSunrise select 0) - 1.25;
                    };
                    case -3: {
                        _t = (_sunsetSunrise select 0) - 0.75;
                    };
                    case -4: {
                        _t = (_sunsetSunrise select 1);
                    };
                    case -5: {
                        _t = (_sunsetSunrise select 1) + 0.5;
                    };
                };
            };
        } else {
            _t = _TimeParam;
        };
        if (_t == -10) then {
            _t = random 23.9;
        };
        
        if (_t != -1) then {
            _t = [floor _t, floor ((_t % 1) * 60)];

			_date = date;
			_date set [3, _t select 0];
			_date set [4, _t select 1];
			[_date] call BIS_fnc_setDate;
			
		};
	};

	_WeatherParam = "Weather" call BIS_fnc_getParamValue;

	if (_WeatherParam != -1) then {
		
		_overcast = _WeatherParam;
        if (_overcast == -10) then {
            _overcast = random 10;
        };
		0 setOvercast (_overcast / 10);

	};

	_WindParam = "Wind" call BIS_fnc_getParamValue;

	if (_WindParam != -1) then {
		
		_wind = _WindParam;
        if (_wind == -10) then {
            _wind = random 10;
        };
		0 setWindStr (_wind / 10);

		if ((_wind / 10) * 1.25 > 1) then {

			0 setGusts 1;

		} else {

			0 setGusts ((_wind / 10) * 1.25);

		};
	};

	_FogParam = "Fog" call BIS_fnc_getParamValue;

	if (_FogParam != -1) then {
        
        if (_FogParam == -10) then {
            _FogParam = (floor random [0, 10, 30]) / 10;
        };
        
		if (defaultFogType) then {
			_fog = _FogParam;
			0 setFog (_fog / 3.2);
		}
		else {
			_fog = (fogArrays select _FogParam);
			if (count _fog == 0) then {
				_fog = [0,0,0];
			};
			0 setFog _fog;
		};
		
	};
};