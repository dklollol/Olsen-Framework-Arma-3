FNC_DebugMessage = {};

if (!isDedicated) then {
	
	100 cutRsc ["DIA_DEBUG", "PLAIN"];

	FW_Debug_Messages = [];

	FNC_DebugMessage = {
		
		private ["_someText", "_message", "_text", "_found", "_text"];
		
		_someText = 4001;
		
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
			
			((uiNamespace getVariable "fwDebug") displayCtrl _someText) ctrlSetStructuredText parseText _text;
		
		};
	};
};