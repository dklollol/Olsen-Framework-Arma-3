["ACRE setup", "Module for all ACRE settings.", "BlackHawk"] call FNC_RegisterModule;

FW_Presets = ["default2", "default3", "default4", "default"];

#include "settings.sqf"

if(isServer && {FW_enable_addRacks}) then {
	[{(call acre_api_fnc_isInitialized && time > 0)}, {
		scopeName "mainLoop";
		{
			_x params ["_objString","_rackType","_mountRadio","_radioRemovable","_rackNames","_whitelistedPositions","_blacklistedPositions","_faction"];
			private ["_mountedRadio"];
			_object = missionNamespace getVariable [_objString, objNull];
			if((missionNamespace getVariable _objString) isEqualTo objNull) then {
				(format ["(ACRE_SETUP_MODULE) [ERR]: NFB ERROR ENCOUNTERED"]) call FNC_DebugMessage;
				(format ["(ACRE_SETUP_MODULE) [ERR]: OBJECT VARIABLE NAME DOES NOT EXIST OR IS INCORRECT"]) call FNC_DebugMessage;
				(format ["(ACRE_SETUP_MODULE) [ERR]: VERIFY YOUR VARIABLE STRING: %1", _objString]) call FNC_DebugMessage;
				breakTo "mainLoop";
			} else {
				if((FW_enable_scramble || FW_enable_babel) && {isNil "_faction"}) then {
					(format ["(ACRE_SETUP_MODULE) [WRN]: RADIO SCRAMBLING OR BABEL ARE ENABLED BUT %1 HAS NO ASSIGNED FACTION", _object]) call FNC_DebugMessage;
				};
				if(isNil "_rackType") then {
					(format ["(ACRE_SETUP_MODULE) [ERR]: NFB ERROR ENCOUNTERED"]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: RACK CLASSNAME: %1 DOES NOT EXIST OR A TYPO EXISTS VERIFY YOUR RACK CLASSNAME: %1", _rackType]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: VERIFY YOUR RACK CLASSNAME: %1", _rackType]) call FNC_DebugMessage;
					breakTo "mainLoop";
				};
				if(_mountRadio) then {
					switch (_rackType) do {
						case "ACRE_SEM90": {_mountedRadio = "ACRE_SEM70";};
						case "ACRE_VRC103": {_mountedRadio = "ACRE_PRC117F";};
						case "ACRE_VRC110": {_mountedRadio = "ACRE_PRC152";};
						case "ACRE_VRC111": {_mountedRadio = "ACRE_PRC148";};
						case "ACRE_VRC64": {_mountedRadio = "ACRE_PRC77";};
						default {
							(format ["(ACRE_SETUP_MODULE) [ERR]: NFB ERROR ENCOUNTERED"]) call FNC_DebugMessage;
							(format ["(ACRE_SETUP_MODULE) [ERR]: VERIFY YOUR RACK CLASSNAME: %1", _rackType]) call FNC_DebugMessage;
							breakTo "mainLoop";
						};
					};
				} else {_mountedRadio = "";};
				_rackNames params ["_longRack","_shortRack"];
				if(isNil "_longRack" || isNil "_shortRack") then {
					(format ["(ACRE_SETUP_MODULE) [ERR]: A RACKNAME IS NIL, LONG: %1 SHORT: %2", _longRack, _shortRack]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: DEFAULTING TO LONGNAME: ""DEFAULT RACK NAME: FIX ME"" AND SHORTNAME: ""FIX"" "]) call FNC_DebugMessage;
					_longRack = "DEFAULT RACK NAME: FIX ME";
					_shortRack = "FIX";
				};
				if(_whitelistedPositions isEqualTo []) then {
					(format ["(ACRE_SETUP_MODULE) [ERR]: NO POSITIONS HAVE BEEN WHITELISTED OR BLACKLISTED"]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: DEFAULTING TO 'inside' and 'all'"]) call FNC_DebugMessage;
					_whitelistedPositions = ["inside", "all"];
				} else {
					if(_whitelistedPositions isEqualTo _blacklistedPositions) then { 
						(format ["(ACRE_SETUP_MODULE) [ERR]: ALL POSITIONS ARE WHITELISTED AND BLACKLISTED"]) call FNC_DebugMessage;
						(format ["(ACRE_SETUP_MODULE) [ERR]: DEFAULTING WHITELISTED POSITIONS TO: 'inside'"]) call FNC_DebugMessage;
						_whitelistedPositions = ["inside"];
						_blacklistedPositions = [];
					};
				};
				if(!(isNil "_faction") && {FW_enable_scramble}) then {
					private _faction_i = 3;
					switch (_faction) do { 
						case west: {_faction_i = 0};
						case east: {_faction_i = 1};
						case independent: {_faction_i = 2};
						case civilian: {_faction_i = 3};
						default {_faction_i = 3;};
					};
					private _preset = FW_Presets select _faction_i;
					[_object, _preset] call acre_api_fnc_setVehicleRacksPreset;
				};

				[_object, {}] call acre_api_fnc_initVehicleRacks;
				[_object, [_rackType, _longRack, _shortRack, _radioRemovable, _whitelistedPositions, _blacklistedPositions, _mountedRadio, [], []], false, {}] call acre_api_fnc_addRackToVehicle;
				if(FW_enable_addRackDebug) then {(format ["ACRE_SETUP: RACK ADDED: %1 %2", _x, _longRack]) call FNC_DebugMessage;};
			};
		} forEach FW_ORRList;
		
	},[],30,{(format ["ACRE_SETUP: UNABLE TO ADD RACKS"]) call FNC_DebugMessage;}] call CBA_fnc_waitUntilAndExecute;
};

if(isServer && {FW_enable_channel_names}) then {
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

if(!isDedicated && hasInterface) then {
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
				case -1: {_v = 0.2;}; 
				case 0: {_v = 0.4;}; 
				case 1: {_v = 0.7;}; 
				case 2: {_v = 1.0;}; 
				default {_v = 0.4;}; 
			};
			[_v] call acre_api_fnc_setSelectableVoiceCurve;
			acre_sys_gui_VolumeControl_Level = FW_Acre_Volume_Value;
			
			[] spawn {
				sleep 1;
				acre_sys_gui_VolumeControl_Level = FW_Acre_Volume_Value;
			};
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
			["ACRE_SEM52SL", _preset ] call acre_api_fnc_setPreset;
			["ACRE_SEM70", _preset ] call acre_api_fnc_setPreset;
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