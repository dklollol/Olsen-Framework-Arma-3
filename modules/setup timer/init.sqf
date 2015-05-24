#define ADDSETUPMARKER(SIDE, TIME, NAME) \
if !(markerType NAME == "") then { \
	_markers set [count _markers, [SIDE, TIME, NAME]]; \
} else { \
	_temp = format ["Setup timer module:<br></br>Warning marker ""%1"", in file ""modules\setup timer\settings.sqf"" does not exist.", NAME]; \
	[_temp] call FNC_DebugMessage; \
};

if (!isDedicated) then {

	_markers = [];

	#include "settings.sqf"
	
	if ((count _markers) > 0) then {
	
		[_markers] spawn {
			
			_marker = [];
			
			{
				if (((_x select 0) == (side player)) && [(vehicle player), (_x select 2)] call FNC_InArea) then {
				
					_marker = [(_x select 1), (_x select 2)];
					
				} else {
				
					(_x select 2) setMarkerAlphaLocal 0;
					
				};
				
			} forEach (_this select 0);
			
			_pos = getPosATL (vehicle player);
			
			while {(count _marker) > 0} do {
			
				_vehicle = (vehicle player);
			
				if ([_vehicle, (_marker select 1)] call FNC_InArea) then {
				
					_pos = getPosATL _vehicle;
					
				} else {
				
					_vehicle setPos _pos;
					
				};
				
				hintSilent format ["Seconds remaining: %1", round((_marker select 0) - time)];
				
				if (time >= (_marker select 0)) then {
				
					hint "Setup timer expired";
					(_marker select 1) setMarkerAlphaLocal 0;
					_marker = [];
					
				};
				
				sleep(0.1);
				
			};
		};
	};
};