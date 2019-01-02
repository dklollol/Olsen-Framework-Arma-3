["Remove Maps", "Removes maps and compasses from specific gear cases.", "TinfoilHate"] call FNC_RegisterModule;

	[{time > 1}, {
		#include "settings.sqf"

		_keepMapClasses = _keepMapClasses + _keepCompassClasses;
		
		{
			_unit = _x;
			_gear = _unit getVariable ["FW_Loadout", ""];

			if (local _unit) then {
				if (_gear in _keepMapClasses) then {
					if (_gear in _keepCompassClasses) then {
						_unit unlinkItem "ItemMap";
					} else {
						//Hooray, you're important!
					};
				} else {
					_unit unlinkItem "ItemMap";
					_unit unlinkItem "ItemCompass";
				};
			};
		} forEach allUnits;
	}] call CBA_fnc_waitUntilAndExecute;