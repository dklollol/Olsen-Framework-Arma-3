["Marker Control", "Allows the mission maker to create markers visible to a single side.", "Olsen"] call FNC_RegisterModule;

#define SYSTEM sideLogic

#define ADDMARKER(SIDE, NAME) \
if !(markerType NAME == "") then { \
	_markers set [count _markers, [SIDE, NAME]]; \
} else { \
	_temp = format ["Marker control module:<br></br>Warning marker ""%1"", in file ""modules\marker control\settings.sqf"" does not exist.", NAME]; \
	_temp call FNC_DebugMessage; \
};

if (!isDedicated) then {
	
	private ["_markers"];

	_markers = [];

	#include "settings.sqf"

	{
		if ((_x select 0) != (side player)) then {
			(_x select 1) setMarkerAlphaLocal 0;
		};
	} forEach _markers;
};