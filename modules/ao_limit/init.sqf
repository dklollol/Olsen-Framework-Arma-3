["AO Limit", "Allows the mission maker to set AO limits to specific sides.", "Olsen"] call FNC_RegisterModule;

#define ANY sideLogic

#define ADDAOMARKER(SIDE, NAME) \
if !(markerType NAME == "") then { \
	_markers set [count _markers, [SIDE, NAME]]; \
} else { \
	_temp = format ["AO limit module:<br></br>Warning marker ""%1"", in file ""modules\ao limit\settings.sqf"" does not exist.", NAME]; \
	_temp call FNC_DebugMessage; \
};

if (!isDedicated) then {

	_markers = [];

	#include "settings.sqf"

	if ((count _markers) > 0) then {
	
		[_markers] spawn {
			
			_markers = [];
			
			_allowedOutside = true;
			
			_vehicle = (vehicle player);
			_pos = getPosATL _vehicle;
			
			{
				if ((_x select 0) == (side player) || (_x select 0) == ANY) then {
					_markers set [count _markers, (_x select 1)];	
					
					if ([_vehicle, (_x select 1)] call FNC_InArea) then {
						_allowedOutside = false;
					};
				};
			} forEach (_this select 0);
			
			while {true} do {
			
				_vehicle = (vehicle player);
				
				if (!(_vehicle isKindOf "Air")) then {
			
					_outSide = true;
				
					{
						if ([_vehicle, _x] call FNC_InArea) exitWith {
							_outSide = false;
						};
					} forEach _markers;
					
					if (_outside) then {
						if (!(_allowedOutside) && (_vehicle call FNC_Alive)) then {
							_vehicle setPos _pos;
						};
					} else {
						_allowedOutside = false;
						_pos = getPosATL _vehicle;
					};
				
				} else {
					_allowedOutside = true;
				};
				
				sleep(0.1);
				
			};

		};
	
	};
	
};
