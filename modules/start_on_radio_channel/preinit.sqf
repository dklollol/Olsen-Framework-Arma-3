FNC_SetRadio = {
	
	private ["_unit", "_radio", "_channel", "_channels"];
	
	_unit = _this select 0;
	_radio = _this select 1;
	_channel = _this select 2;
	
	_channels = _unit getVariable ["FW_Channels", []];
	
	_channels set [count _channels, [_radio, _channel]];
	
	_unit setVariable ["FW_Channels", _channels, false];
	
};