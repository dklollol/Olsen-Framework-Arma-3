/*
	Author: voiper
	
	Description: Get a key input array from the player to use in an eventHandler.
	
	Parameters:
		0: String; global variable name to assign key array to.
		1: Bool; whether to save name and value to profileNameSpace; default false.

	Returns:
		None.
		
	Example:
		myVar = [];
		["myVar"] call vip_cmn_fnc_cl_keyBind;
		waitUntil {count myVar > 0};
		(findDisplay 46) displayAddEventHandler ["KeyDown", {_arr = _this; _arr deleteAt 0; if (_arr == myVar) then {hint "Hi!"}}];
*/

_name = [_this, 0, "", [""]] call BIS_fnc_param;
_save = [_this, 1, false, [true]] call BIS_fnc_param;

if (_name == "") exitWith {["Input was not a non-empty string."] call BIS_fnc_error};

vip_cmn_var_cl_keyBindName = _name;
vip_cmn_var_cl_keyBindSave = _save;
hintSilent "Press key now (Shift/Ctrl/Alt optional)";

[] spawn {
	vip_cmn_eh_cl_keyBindTemp = (findDisplay 46) displayAddEventHandler ["KeyDown", {

		if (!isNil "vip_cmn_var_cl_keyBindName") then {
			_arr = _this;
			_arr deleteAt 0;
			_key = _arr select 0;
			
			//we do not want to bind Esc, Ctrl, Alt, or Shift
			if !(_key in [1, 29, 157, 56, 184, 42, 54]) then {
				_name = vip_cmn_var_cl_keyBindName;
				_save = vip_cmn_var_cl_keyBindSave;
				[_name, _arr, _save] spawn {
					sleep 0.5; //delay so key doesn't immediately fire after binding
					missionNameSpace setVariable [_this select 0, _this select 1];
					if (_this select 2) then {profileNameSpace setVariable [_this select 0, _this select 1]};
				}; 
				vip_cmn_var_cl_keyBindName = nil;
				vip_cmn_var_cl_keyBindSave = nil;
				_keyName = [_key] call BIS_fnc_keyCode;
				hintSilent format [
					"Key assigned to %1%2%3%4 and saved to profile.",
					if (_arr select 1) then {"Shift+"} else {""},
					if (_arr select 2) then {"Ctrl+"} else {""},
					if (_arr select 3) then {"Alt+"} else {""},
					_keyName
				];
			} else {
				if (_key == 1) then {
					vip_cmn_var_cl_keyBindName = nil;
					vip_cmn_var_cl_keyBindSave = nil;
					hintSilent "Cancelled";
				};
			};
		};
			
		if (isNil "vip_cmn_var_cl_keyBindName") then {
			[] spawn {
				(findDisplay 46) displayRemoveEventHandler ["KeyDown", vip_cmn_eh_cl_keyBindTemp];
				vip_cmn_eh_cl_keyBindTemp = nil;
			};
		};
		
		true
	}];
};