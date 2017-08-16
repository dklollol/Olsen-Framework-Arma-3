if (isServer) then {
	[{ time > 0 }, {
		{ _x call aCount_addEH; } forEach allMissionObjects "All";
	}] call CBA_fnc_waitUntilAndExecute;
};

if (!isDedicated && hasInterface) then {
	if (didJIP) then {
		[{!isNull player}, {
			["aCount_event_addEH", player] call CBA_fnc_serverEvent;
		}] call CBA_fnc_waitUntilAndExecute;
	};
};