["Soft AO Limit", "Allows the mission maker to set AO limits to specific sides.", "Olsen &amp; Starfox64"] call FNC_RegisterModule;

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
				_air = _vehicle isKindOf "Air";
				_allowedOutside = (FW_AOTimer < 0 && !_air) || (FW_AOTimerAir < 0 && _air);
				_outSide = true;
			
				{
					if ([_vehicle, _x] call FNC_InArea) exitWith {
						_outSide = false;
					};
				} forEach _markers;

				_displayed = missionNamespace getVariable ["FW_AOL_Display", false];
				missionNamespace setVariable ["FW_AOL_Display", _outSide];
				
				if (_outSide) then {
					if (!(_allowedOutside) && !_displayed && (_vehicle call FNC_Alive)) then {
						_timeLeft = if (_air) then {FW_AOTimerAir} else {FW_AOTimer};

						missionNamespace setVariable ["FW_AOL_TimeLeft", _timeLeft];
						cutRsc ["RscAOLimit", "PLAIN", 0.5, false];
					};
				} else {
					_allowedOutside = false;
				};
				
				sleep(0.1);
				
			};

		};
	
	};
	
};
