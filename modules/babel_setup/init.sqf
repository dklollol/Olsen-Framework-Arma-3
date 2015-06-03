if (!isDedicated) then {
	
	#include "settings.sqf"
	
	private ["_languages"];
	
	_languages = player getVariable ["FW_Languages", []];
	
	if (count _languages > 0) then {
		
		_languages call acre_api_fnc_babelSetSpokenLanguages;
		
	};

	player setVariable ["FW_Languages", nil, false];
	
};