if (!isDedicated) then {
	
	FNC_RadioEhHandler = {
	
		private ["_player", "_class", "_channels", "_newChannels"];
		
		_player = _this select 0;
		_class = _this select 1;
		
		if (_player == player) then {
			
			_channels = player getVariable ["frameworkChannels", []];
			
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
				
				player setVariable ["frameworkChannels", nil, false];
				["acre_sys_radio_returnRadioId", radioEh] call CBA_fnc_removeEventHandler;
			
			} else {
				
				player setVariable ["frameworkChannels", _newChannels, false];	
				
			};
		};
	};
	
	radioEh = ["acre_sys_radio_returnRadioId", {_this spawn FNC_RadioEhHandler;}] call CBA_fnc_addEventHandler;

};