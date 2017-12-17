FNC_SetTeamColor = {

	params [
		["_unit", objNull, [objNull]],
		["_color", "", [""]]
	];

	_unit setVariable ["FW_TeamColor", _color, false];

};
