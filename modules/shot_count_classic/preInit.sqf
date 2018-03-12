["Ammo Counter", "Counts ammunition types fired and displays it in the mission endscreen.", "TinfoilHate"] call FNC_RegisterModule;

//Ammo Counter Initilization
//Much script by beta, some script by TinfoilHate
//Sets up ammo counting

	
		#include "settings.sqf"

    if (isServer) then {
		aCount_bluArray = [];
		aCount_redArray = [];
		{	//0 = varname, 1 = friendly name, 2 = array of classes
			_x params ["_name","_classArray"];

			aCount_bluArray set [count aCount_bluArray,[_name,_classArray,0]];
			aCount_redArray set [count aCount_redArray,[_name,_classArray,0]];
		} forEach aCount_masterArray;

		aCount_addEH = {	//If units are spawned, this should be run on them: ["aCount_event_addEH", UNIT] call CBA_fnc_serverEvent;
			_obj = param [0];

			_obj setVariable ["aCount_originalSide",side _obj,false];

			if (_obj isKindOf "Man") then {
				_obj addEventHandler ["fired", {[((_this select 0) getVariable "aCount_originalSide"), (_this select 4)] call aCount_shotCount;}];
				_obj setVariable ["aCount_firedEh", true, false];
			};

			if (((_obj isKindOf "Land") && !(_obj isKindOf "Man")) || (_obj isKindOf "Air") || (_obj isKindOf "Ship")) then {
				if (count crew _obj > 0) then {
					{
						_x setVariable ["aCount_firedEh", true, false];
						_x setVariable ["aCount_originalSide",side _obj,false];
					} forEach crew _obj;
				};
				_obj addEventHandler ["fired", {[((crew (_this select 0)) select 0 getVariable "aCount_originalSide"), (_this select 4)] call aCount_shotCount;}];
				_obj setVariable ["aCount_firedEh", true, false];
			};
		};
		["aCount_event_addEH",aCount_addEH] call CBA_fnc_addEventHandler;

		aCount_shotCount = {
			params ["_side","_ammo"];

			switch (_side) do {
				case WEST: {
					_i = 0;
					{	//0 = varname, 1 = friendly name, 2 = array of classes
						_x params ["_name","_classArray","_count"];

						_newCount = _count + 1;
						{
							if (_ammo in _x) then {aCount_bluArray set [_i,[_name,_classArray,_newCount]]};
						} forEach _classArray;

						_i = _i + 1;
					} forEach aCount_bluArray;
				};
				case EAST: {
					_i = 0;
					{	//0 = varname, 1 = friendly name, 2 = array of classes
						_x params ["_name","_classArray","_count"];

						_newCount = _count + 1;
						{
							if (_ammo in _x) then {aCount_redArray set [_i,[_name,_classArray,_newCount]]};
						} forEach _classArray;

						_i = _i + 1;
					} forEach aCount_redArray;
				};
			};
		};

		aCount_endCount = {
			_munitionsBLU = [];
			{	//0 = varname, 1 = friendly name, 2 = array of classes
				_x params ["_name","_classArray","_count"];

				if (_count > 0) then {_munitionsBLU set [count _munitionsBLU,[_count,_name]]};
			} forEach aCount_bluArray;

			_munitionsRED = [];
			{	//0 = varname, 1 = friendly name, 2 = array of classes
				_x params ["_name","_classArray","_count"];

				if (_count > 0) then {_munitionsRED set [count _munitionsRED,[_count,_name]]};
			} forEach aCount_redArray;
			
			["aCount_event_scoreScreen", [_munitionsBLU,_munitionsRED]] call CBA_fnc_globalEvent;
		};
	};

	if (!isDedicated && hasInterface) then {
		aCount_shotDisplay = {
			_this spawn {
				_arrayBLU = param [0];
				_arrayRED = param [1];

				{
					_count = _x select 0;
					_label = _x select 1;

					aCount_textBLU = aCount_textBLU + "<br/>" + _label + ": " + str(_count) + "<br/>";
				} forEach _arrayBLU;
				{
					_count = _x select 0;
					_label = _x select 1;

					aCount_textRED = aCount_textRED + "<br/>" +  _label + ": " + str(_count) + "<br/>";
				} forEach _arrayRED;
				
				aCount_textRES = "";
			};		
		};

		["aCount_event_scoreScreen",aCount_shotDisplay] call CBA_fnc_addEventHandler;
	};
