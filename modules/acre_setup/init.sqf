["ACRE setup", "Module for all ACRE settings.", "BlackHawk"] call FNC_RegisterModule;

#include "settings.sqf"

if(!isDedicated) then {
	[] spawn {
		waitUntil { !isNull acre_player };

		private _side = side player;
        private _customSide = (player getVariable ["FW_CustomScramble", nil]);
        private _preset = "default";
        
        if (isNil "_customSide") then {
            _side = _customSide;
        };
        
        
        if (FW_enable_scramble) then {
            switch _side do { 
                case east: { 
                    _preset = "default2";
                };
                case west: { 
                    _preset = "default3";
                };
                case independent: { 
                    _preset = "default4";
                };
                default { 
                    _preset = "default";
                };
            };
            
            ["ACRE_PRC343", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC77", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC117F", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC152", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC148", _preset ] call acre_api_fnc_setPreset;
        };
        
        if (FW_enable_channel_names) then {
            FW_ChannelName params ["_cn_radioName", "_cn_channel", "_cn_label", "_cn_name"];
            [_cn_radioName, _preset, _cn_channel, _cn_label, _cn_name] remoteExecCall ["acre_api_fnc_setPresetChannelField", 0, true];
        };

        private _languages = player getVariable ["FW_Languages", []];
        
        if (FW_enable_babel) then {
            FW_Languages call acre_api_fnc_babelSetSpokenLanguages;
        };
        
        if (count _languages > 0) then {
            
            _languages call acre_api_fnc_babelSetSpokenLanguages;
            
        };

        private _channels = player getVariable ["FW_Channels", []];

        private _radioID;
        {
            _x params [
                ["_radio", ""],
                ["_channel", 1],
                ["_spatial", "CENTER"]
            ];
            _radioID = [_radio] call acre_api_fnc_getRadioByType;
            
            if (!isNil "_radioID") then {
                [_radioID, _channel] call acre_api_fnc_setRadioChannel;
                [_radioID, _spatial] call acre_api_fnc_setRadioSpatial;
            };
        } foreach _channels;
		
		FW_RadioScrambler = true;
	};
    
};