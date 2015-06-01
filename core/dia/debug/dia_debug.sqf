FNC_DebugMessage = {};

if (!isDedicated) then {
	
	if (FW_DebugMessagesEnabled) then {
		
		100 cutRsc ["DIA_DEBUG", "PLAIN"];
		
		private ["_someText", "_text"];
		
		_someText = 4001;
		
		_text = "";
		
		{
		
			_text = _text + _x + "<br></br><br></br>";
			
		} forEach FW_DebugMessages;
		
		((uiNamespace getVariable "FW_Debug") displayCtrl _someText) ctrlSetStructuredText parseText _text;

		FNC_DebugMessage = {
			
			private ["_someText", "_message", "_found", "_text"];
			
			_someText = 4001;
			
			_message = _this;
			
			_found = false;
			
			{
				
				if (_x == _message) exitWith {
					
					_found = true;
					
				};
			
			} forEach FW_DebugMessages;
			
			if (!_found) then {
			
				FW_DebugMessages set [count FW_DebugMessages, _message];
				
				_text = "";
				
				{
				
					_text = _text + _x + "<br></br><br></br>";
					
				} forEach FW_DebugMessages;
				
				((uiNamespace getVariable "FW_Debug") displayCtrl _someText) ctrlSetStructuredText parseText _text;
			
			};
		};
	};
};