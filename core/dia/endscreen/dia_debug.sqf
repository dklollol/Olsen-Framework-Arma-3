FNC_DebugMessage = {};

if (!isDedicated) then {
	
	100 cutRsc ["testHud", "PLAIN"];

	FW_DEBUG_MESSAGES = [];

	FNC_DebugMessage = {
		
		private ["_message", "_text"];
		
		_message = _this select 0;
		
		_found = false;
		
		{
			
			if (_x == _message) exitWith {
				
				_found = true;
				
			};
		
		} forEach FW_DEBUG_MESSAGES;
		
		if (!_found) then {
		
			FW_DEBUG_MESSAGES set [count FW_DEBUG_MESSAGES, _message];
			
			_text = "";
			
			{
			
				_text = _text + _x + "<br></br><br></br>";
				
			} forEach FW_DEBUG_MESSAGES;
			
			((uiNamespace getVariable "fwDebug") displayCtrl 4001) ctrlSetStructuredText parseText _text;
		
		};
	};
};