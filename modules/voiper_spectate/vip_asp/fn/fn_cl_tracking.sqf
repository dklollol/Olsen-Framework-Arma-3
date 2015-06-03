/*
	Author: voiper

	Description: Unit tracking.
	
	Parameters (Init):
		0: Bool; true to begin tracking, false to stop and erase record.
		
	Returns:
	None.
*/

_init = [_this, 0, true, [false]] call bis_fnc_param;

if (_init) then {

	addMissionEventHandler ["Ended", {
		if (!isNil "vip_asp_var_cl_trackingArray") then {[false] call vip_asp_fnc_cl_tracking};
	}];

	//begin unit tracking
	vip_asp_var_cl_trackingArray = [];

	[] spawn {
	
		waitUntil {time > 2};
		//add PFH
		vip_asp_var_cl_eh_trackingLast = false;
		
		["vip_asp_eh_tracking", "onEachFrame", {
			if (floor diag_ticktime mod 20 == 0) then {
				if (!vip_asp_var_cl_eh_trackingLast) then {
					call vip_asp_fnc_cl_trackUnits;
					vip_asp_var_cl_eh_trackingLast = true;
				};
			} else {vip_asp_var_cl_eh_trackingLast = false};
		}] call BIS_fnc_addStackedEventHandler;
		
		call vip_asp_fnc_cl_trackUnits;
	};
	
} else {
	["vip_asp_eh_tracking", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	vip_asp_var_cl_trackingArray = nil;
	vip_asp_var_cl_eh_trackingLast = nil;
};