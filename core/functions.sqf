FNC_CASUALTYCHECK = {
	
	private["_temp", "_tempStart", "_tempCurrent", "_tempText"];

	_temp = 0;
	
	{ 
		if ((_x select 0) == _this select 0) exitWith {
		
			_tempStart = (_x select 1);
			_tempCurrent = (_x select 2);
			
			if (_tempStart == 0) then {
			
				_tempText = format ["Casualty check:<br></br>Warning no units on team ""%1"", in file ""customization\endConditions.sqf"".", _x select 0];
				[_tempText] call FNC_DEBUG_MESSAGE;
				
			} else {
			
				_temp = (_tempStart - _tempCurrent) / (_tempStart * 0.01);
				
			};
		};
	} forEach FW_TEAMS;
	
	_temp
	
};

//CASUALTYCHECK returns the casualty percentage of TEAM
#define CASUALTYCHECK(TEAM) \
[TEAM] call FNC_CASUALTYCHECK;