FNC_SetRadio = {

	private ["_channels"];

	params [
		["_unit", objNull, [objNull]],
		["_radio", "", [""]],
		["_channel", 0, [0]]
	];

	_channels = _unit getVariable ["FW_Channels", []];

	_channels set [count _channels, [_radio, _channel]];

	_unit setVariable ["FW_Channels", _channels, false];

};
