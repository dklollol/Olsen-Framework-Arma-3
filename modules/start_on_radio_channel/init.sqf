if (!isDedicated) then {
	
	FNC_RadioEhHandler = {
	
		private ["_player", "_class", "_returnIdNumber", "_replacementId", "_channels"];
		
		_player = _this select 0;
		_class = _this select 1;
		
		if (_player == player) then {
			
			_channels = player getVariable ["frameworkChannels", []];
			
			{
				
				if (([_class] call acre_api_fnc_getBaseRadio) == (_x select 0)) exitWith {
					
					[_class, (_x select 1)] call acre_api_fnc_setRadioChannel;
					hint _class;
				};
				
			} forEach _channels;
		};
	};
	
	radioEh = ["acre_sys_radio_returnRadioId", {_this call FNC_RadioEhHandler;}] call CBA_fnc_addEventHandler;

};