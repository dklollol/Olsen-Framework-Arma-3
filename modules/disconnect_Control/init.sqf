["Disconect Control", "Controls when player bodies should be deleted", "Olsen &amp; Perfk"] call FNC_RegisterModule;

ace_respawn_RemoveDeadBodiesDisconnected = false;

if (isServer) then {
	FW_EventDisconnectHandle_BodyCleanup = addMissionEventHandler ["HandleDisconnect", {_this call FNC_EventDisconnect_BodyCleanup;}];
};

FNC_EventDisconnect_BodyCleanup = {

	private ["_unit"];

	_unit = _this select 0;

	if (_unit getVariable ["FW_Tracked", false]) then {
		

		#include "settings.sqf"

		if (time < disconnect_control_time * 60 && (side _unit) in disconnect_control_sides) then {

			deleteVehicle _unit;
			
		};
	
	};

};