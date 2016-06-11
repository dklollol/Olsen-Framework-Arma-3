if (isServer) then {
	
	private ["_TimeLimit"];
	
	_TimeLimit = "TimeLimit" call BIS_fnc_getParamValue;
	
	if (_TimeLimit == -1) then {
		
		FW_TimeLimit = 0;
		
	} else {
	
		if ((FW_TimeLimit + _TimeLimit) > 0) then {
		
			FW_TimeLimit = FW_TimeLimit + _TimeLimit;
		
		} else {
		
			"Time limit was negative and therefore not changed." call FNC_DebugMessage;
		
		}
	};
};