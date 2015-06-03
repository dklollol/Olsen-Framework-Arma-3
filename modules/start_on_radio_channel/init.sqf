["Start on radio channel", "Allows the mission maker to set the channel of ACRE radios.", "Olsen"] call FNC_RegisterModule;

if (!isDedicated) then {
	
	FNC_RadioEhHandler = {
	
		private ["_player", "_class", "_channels", "_newChannels"];
		
		_player = _this select 0;
		_class = _this select 1;
		
		if (_player == player) then {
			
			_channels = player getVariable ["FW_Channels", []];
			
			_newChannels = [];
			
			if (count _channels > 0) then {
				
				{
					
					if (([_class] call acre_api_fnc_getBaseRadio) == (_x select 0)) then {
						
						[_class, "setCurrentChannel", (_x select 1) - 1] call acre_sys_data_fnc_dataEvent;
						
					} else {
						
						_newChannels set [count _newChannels, _x];
						
					};
					
				} forEach _channels;
				
			};
			
			if (count _newChannels == 0) then {
				
				player setVariable ["FW_Channels", nil, false];
				["acre_sys_radio_returnRadioId", FW_RadioEh] call CBA_fnc_removeEventHandler;
			
			} else {
				
				player setVariable ["FW_Channels", _newChannels, false];	
				
			};
		};
	};
	
	private ["_channels", "_newChannels"];
	
	_channels = player getVariable ["FW_Channels", []];
	
	_newChannels = [];
	
	{
	
		if ((_x select 0) in (items player)) then {
			
			_newChannels set [count _newChannels, _x];
			
		};
		
	} forEach _channels;
	
	if (count _newChannels == 0) then {
		
		player setVariable ["FW_Channels", nil, false];
	
	} else {
		
		player setVariable ["FW_Channels", _newChannels, false];	
		
		FW_RadioEh = ["acre_sys_radio_returnRadioId", {_this spawn FNC_RadioEhHandler;}] call CBA_fnc_addEventHandler;
		
	};
};