FNC_DebugMessage = {};

if (!isDedicated) then {
	
	100 cutRsc ["testHud", "PLAIN"];

	FW_Debug_Messages = [];

	FNC_DebugMessage = {
		
		private ["_message", "_text"];
		
		_message = _this select 0;
		
		_found = false;
		
		{
			
			if (_x == _message) exitWith {
				
				_found = true;
				
			};
		
		} forEach FW_Debug_Messages;
		
		if (!_found) then {
		
			FW_Debug_Messages set [count FW_Debug_Messages, _message];
			
			_text = "";
			
			{
			
				_text = _text + _x + "<br></br><br></br>";
				
			} forEach FW_Debug_Messages;
			
			((uiNamespace getVariable "fwDebug") displayCtrl 4001) ctrlSetStructuredText parseText _text;
		
		};
	};
};