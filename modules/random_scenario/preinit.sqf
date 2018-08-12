	if (isServer) then {
		_adminParam = ["FW_ScenarioSelection",0] call BIS_fnc_getParamValue;

		r1		= false;
		r2		= false;
		r3		= false;
		r4		= false;
		r5		= false;

		switch (_adminParam) do {
			case 1: {missionNamespace setVariable ["r1",true];};
			case 2: {missionNamespace setVariable ["r2",true];};
			case 3: {missionNamespace setVariable ["r3",true];};
			case 4: {missionNamespace setVariable ["r4",true];};
			case 5: {missionNamespace setVariable ["r5",true];};
			default {	//Random Parameter
				_sel = [
					["r1","r2","r3","r4","r5"],
					[0.25,0.25,0.25,0.25,0.25]
				] call BIS_fnc_selectRandomWeighted;

				missionNamespace setVariable [_sel,true];
			};
		};
	};