["ACRE setup", "Module for all ACRE settings.", "BlackHawk"] call FNC_RegisterModule;

FW_Presets = ["default2", "default3", "default4", "default"];

#include "settings.sqf"

if (isServer && FW_enable_channel_names) then {
    {
        _index = _forEachIndex;
        {
            _x params ["_channel", "_label", "_name"];
            {
                _label = [_x, _label] call acre_api_fnc_mapChannelFieldName;
                [_x, FW_Presets select _index, _channel, _label, _name] remoteExecCall ["acre_api_fnc_setPresetChannelField", 0, true];
            } forEach ["ACRE_PRC117F", "ACRE_PRC148", "ACRE_PRC152"];
        } foreach _x;
    } foreach FW_ChannelNames;
};

if(!isDedicated) then {
	[] spawn {
		waitUntil { !isNull acre_player };

		private _side = side player;
        private _customSide = (player getVariable ["FW_CustomScramble", nil]);

        if (!isNil "FW_Acre_Volume_Value") then {
            if ((abs FW_Acre_Volume_Value) > 2) then {
              FW_Acre_Volume_Value = 0;
            };
            private _v = 0.7;
            switch (FW_Acre_Volume_Value) do {
                case -2: {_v = 0.1;}; 
                case -1: {_v = 0.4;}; 
                case 0: {_v = 0.7;}; 
                case 1: {_v = 1.0;}; 
                case 2: {_v = 1.3;}; 
                default {_v = 0.7;}; 
            };
            [_v] call acre_api_fnc_setSelectableVoiceCurve;
            acre_sys_gui_VolumeControl_Level = FW_Acre_Volume_Value;
        };
        
        
        if (!isNil "_customSide") then {
            _side = _customSide;
        };
        
        private _side_i = 3;
        switch (_side) do { 
            case west: { 
                _side_i = 0;
            };
            case east: { 
                _side_i = 1;
            };
            case independent: { 
                _side_i = 2;
            };
            default { 
                _side_i = 3;
            };
        };
        
        if (FW_enable_scramble) then {
            private _preset = FW_Presets select _side_i;
            
            ["ACRE_PRC343", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC77", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC117F", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC152", _preset ] call acre_api_fnc_setPreset;
            ["ACRE_PRC148", _preset ] call acre_api_fnc_setPreset;
        };

        if (FW_enable_babel) then {
            {_x call acre_api_fnc_babelAddLanguageType;} foreach FW_all_languages;
            
            (FW_languages_babel select _side_i) call acre_api_fnc_babelSetSpokenLanguages;
        
            private _languages = player getVariable ["FW_Languages", []];

            if (count _languages > 0) then {
                
                _languages call acre_api_fnc_babelSetSpokenLanguages;
                
            };
        };
        
        waitUntil {[] call acre_api_fnc_isInitialized};
        
        private _channels = player getVariable ["FW_Channels", []];

        {
            _x params [
                ["_radio", ""],
                ["_channel", 1],
                ["_spatial", "CENTER"]
            ];
            private _radioID = [_radio] call acre_api_fnc_getRadioByType;
            if (!isNil "_radioID") then {
                [_radioID, _channel] call acre_api_fnc_setRadioChannel;
                [_radioID, _spatial] call acre_api_fnc_setRadioSpatial;
            };
        } foreach _channels;
		
	};
    
};