["Setup Timer", "Allows the mission maker to restrict the AO of a side for a set amount of time.", "Olsen"] call FNC_RegisterModule;

#define ADDSETUPMARKER(SIDE, TIME, NAME) \
if !(markerType NAME == "") then { \
	_markers set [count _markers, [SIDE, TIME, NAME]]; \
} else { \
	_temp = format ["Setup timer module:<br></br>Warning marker ""%1"", in file ""modules\setup timer\settings.sqf"" does not exist.", NAME]; \
	_temp call FNC_DebugMessage; \
};

if (isServer) then {
    [] spawn {
        waitUntil {time > 0};
        FW_setup_start_time = serverTime;
        publicVariable "FW_setup_start_time";
    };
};

if (!isServer) then {
	
	_markers = [];

	#include "settings.sqf"
	
	if ((count _markers) > 0) then {
	
		[_markers] spawn {
			
            private ["_pos", "_timeLeft", "_string"];
            params ["_markers"];
            
            waitUntil {!isNil "FW_setup_start_time"};
            _startTime = FW_setup_start_time;
            
			_marker = [];
			
			{
				if (((_x select 0) == (side player)) && [(vehicle player), (_x select 2)] call FNC_InArea) then {
				
					_marker = [(_x select 1), (_x select 2)];
					
				} else {
				
					(_x select 2) setMarkerAlphaLocal 0;
					
				};
				
			} forEach _markers;
			
			_pos = getPosATL (vehicle player);
			
			while {(count _marker) > 0} do {
			
				_vehicle = (vehicle player);
			
				if ([_vehicle, (_marker select 1)] call FNC_InArea) then {
				
					_pos = getPosATL _vehicle;
					
				} else {
				
					_vehicle setPos _pos;
					
				};
				
				_timeLeft = round(_startTime + (_marker select 0) - serverTime);
				
				if (_timeLeft < 0) then {
					
					_timeLeft = 0;
					
				};
				
				_string = "Time remaining: %1:%2";
				
				if (_timeLeft % 60 < 10) then {
					
					_string = "Time remaining: %1:0%2";
					
				};
				
				hintSilent format [_string, floor(_timeLeft / 60), _timeLeft % 60];
				
				if (_timeLeft == 0) then {
				
					hint "Setup timer expired";
					(_marker select 1) setMarkerAlphaLocal 0;
					_marker = [];
					
				};
				
				sleep(0.1);
				
			};
		};
	};
};