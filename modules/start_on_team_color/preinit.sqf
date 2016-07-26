FNC_SetTeamColor = {
	
	private ["_unit", "_color"];
	
	_unit = _this select 0;
	_color = _this select 1;
	
	_unit setVariable ["FW_TeamColor", _color, false];
	
};