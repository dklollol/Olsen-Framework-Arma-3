["Radio channel names", "Sets custom names for the long range radio channels, per side.", "Olsen"] call FNC_RegisterModule;

if (!isDedicated) then {
	
	FNC_SetChannelName = {
	
		private ["_channel", "_name"];
		
		_channel = _this select 0;
		_name = _this select 1;
		
		["ACRE_PRC152", _preset, _channel, "description", _name] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC148", _preset, _channel, "label", _name] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC117F", _preset, _channel, "name", _name] call acre_api_fnc_setPresetChannelField;
		
	};
	
	"" spawn {
	
		private ["_side", "_preset"];
		
		sleep 0.01;
		
		if (!(isNil("FW_RadioScrambler"))) then {
			
			waitUntil {FW_RadioScrambler};
			
			{
				
				_side = _x select 0;
				_preset = _x select 1;
				
				#include "settings.sqf"
				
				if (_side == (side player)) then {
					
					_preset call FNC_SetRadioPresetAll;
			
				};
				
			} forEach FW_PresetChannels;
			
		} else {
			
			_side = side player;
			_preset = ["ACRE_PRC343"] call acre_api_fnc_getPreset;
			
			#include "settings.sqf"
			
			_preset call FNC_SetRadioPresetAll;
			
		};
	};
};