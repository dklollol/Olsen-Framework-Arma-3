["Start on radio channel", "Allows the mission maker to set the channel of ACRE radios.", "Olsen"] call FNC_RegisterModule;

if (!isDedicated) then {
	
	FNC_RadioEhHandler = {
	
		private ["_player", "_class", "_channels"];
		
		_player = _this select 0;
		_class = _this select 1;
		
		if (_player == player) then {
			
			_channels = player getVariable ["FW_Channels", []];
			
			if (count _channels > 0) then {
				
				{

					if (([_class] call acre_api_fnc_getBaseRadio) == (_x select 0)) exitWith {
						
						[_class, "setCurrentChannel", (_x select 1) - 1] call acre_sys_data_fnc_dataEvent;
						
					};
					
				} forEach _channels;
			};
		};
	};
	
	if (count (player getVariable ["FW_Channels", []]) > 0) then {
		
		FW_RadioEh = ["acre_sys_radio_returnRadioId", {_this spawn FNC_RadioEhHandler;}] call CBA_fnc_addEventHandler;
		
	};
};