/*
	Author: voiper
	
	Description: Broadcasts console message to all machines. Meant to be called by BIS_fnc_MP.
	
	Parameters:
		String; message to broadcast.

	Returns:
		None.
		
	Example:
		["Hello World!", "vip_cmn_fnc_gl_message"] call BIS_fnc_MP;
*/

_chat = [_this, 0, "", [""]] call BIS_fnc_param;

systemChat _chat