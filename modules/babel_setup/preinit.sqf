FNC_SetLanguages = {
	
	private ["_unit", "_languages"];
	
	_unit = _this select 0;
	_languages = _this select 1;
	
	_unit setVariable ["FW_Languages", _languages, false];
	
};