["Start in Parachute", "Starts players in parachutes", "Briland"] call FNC_RegisterModule;

FNC_DOPARACHUTE = {

	private ["_target", "_elev", "_rand", "_stear", "_class"];	

	if (!isDedicated) then {
	
		_target = _this select 0;
		_elev = _this select 1;
		_rand = 100;
		_stear = false;
		_class = "NonSteerable_Parachute_F";
		_doPara = false;

		if (count _this > 2) then {
			
			_rand = _this select 2;
			
		};

		if (count _this > 3) then {
			
			_stear = _this select 3;
			
		};

		if (_stear) then {

			_class = "Steerable_Parachute_F";

		};

		if (typeName _target == "SIDE") then {

			if (side player isEqualTo _target) then {

				_doPara = true;

			};

		};

		if (typeName _target == "ARRAY") then {

			{
				if (player isEqualTo _x) then {

					_doPara = true;

				};

			} foreach _target;
			
		};

		if (typeName _target == "OBJECT") then {

			if (player isEqualTo _target) then {

				_doPara = true;

			};
		
		};

		if (!_doPara) exitwith {};

		[_elev, _rand, _class] spawn {

			_elevation = _this select 0;
			_randelev = _this select 1;
			_classname = _this select 2;

			waitUntil {!isnull player};
			_random = floor (random _randelev);
			_chute = _classname createVehicle [0,0,0]; 
			_chute setPosATL [getPosatl player select 0, getPosatl player select 1, _elevation + _random]; 
			player moveIndriver _chute;

		};

	};

};

#define DOPARACHUTE(TARGET, ELEVATION, RAND, STEAR) \
[TARGET, ELEVATION, RAND, STEAR] call FNC_DOPARACHUTE;

#include "settings.sqf"