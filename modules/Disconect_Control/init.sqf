["Disconect_Control", "Adds on to the default behavior for Disconects.", "Olsen &amp; Perfk"] call FNC_RegisterModule;

if (!isDedicated) then {

	FNC_EventDisconnect = {

		private ["_unit", "_side", "_type", "_total", "_current"];

		_unit = _this select 0;

		if (_unit getVariable ["FW_Tracked", false]) then {
			
			{

				_side = _x select 1;
				_type = _x select 2;
				_total = _x select 3;
				_current = _x select 4;

				if (_unit getVariable "FW_Side" == _side) exitWith {

					if (_unit call FNC_Alive) then {

						_x set [3, _total - 1];
						_x set [4, _current - 1];

					};

				};

			} forEach FW_Teams;

			#include "settings.sqf"

			if (time < Disconect_Control_Time) then {

				deleteVehicle _unit;
				
			};
		
		};

		false

	};
};