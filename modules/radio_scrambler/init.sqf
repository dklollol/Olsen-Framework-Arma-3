#define random(MIN, MAX) \
([MIN, MAX] call FNC_RandomRange)

["Radio scrambler", "Randomizes the radio channels simply by using the 4 default presets.", "Olsen"] call FNC_RegisterModule;

if (isServer) then {
	
	private ["_presets", "_data"];
	
	_presets = ["default", "default2", "default3", "default4"];
	_data = [];
	
	{
		
		_data set [count _data, [_x, _presets deleteAt (random(1, count _presets) - 1)]];
		
	} forEach [west, east, resistance, civilian];

	["FW_PresetChannels", _data] call CBA_fnc_publicVariable;
	
};

if (!isDedicated) then {
	
	"" spawn {
	
		sleep 0.01;
	
		waitUntil {!(isNil("FW_PresetChannels"))};
		
		{
			
			if (_x select 0 == side player) exitWith {
			
				_preset = _x select 1;
				
				_preset call FNC_SetRadioPresetAll;			
				
			};
			
		} forEach FW_PresetChannels;
		
		FW_RadioScrambler = true;
		
	};
};