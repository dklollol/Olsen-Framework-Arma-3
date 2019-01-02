["Radio Messaging", "Radio text messages for simulated communications.", "TinfoilHate"] call FNC_RegisterModule;

#include "settings.sqf"

if (!isDedicated && hasInterface) then {
	player createDiarySubject ["radiolog","Radio Log"];

	_cmdRadio = ["cmdRadio_class", "Radio Messages", "", {}, {!VAR_RADIO_NETBUSYBLU}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions"], _cmdRadio] call ace_interact_menu_fnc_addActionToClass;

		_cmdRadioSub1 = ["cmd_obj1", (VAR_RADIO_RADIOINTERACTSBLU select 0) select 0, "", {
			["FW_RADIO_RADIOMESSAGE",[0,mapGridPosition player]] call CBA_fnc_globalEvent;	//Message for clients
			["FW_RADIO_RADIOFLAGS", 0] call CBA_fnc_serverEvent;	//Flags for server
		},(VAR_RADIO_RADIOINTERACTSBLU select 0) select 1] call ace_interact_menu_fnc_createAction;
		[typeOf player, 1, ["ACE_SelfActions", "cmdRadio_class"], _cmdRadioSub1] call ace_interact_menu_fnc_addActionToClass;

		_cmdRadioSub2 = ["cmd_obj2", (VAR_RADIO_RADIOINTERACTSBLU select 1) select 0, "", {
			["FW_RADIO_RADIOMESSAGE",[1,mapGridPosition player]] call CBA_fnc_globalEvent;	//Message for clients
			["FW_RADIO_RADIOFLAGS", 1] call CBA_fnc_serverEvent;	//Flags for server
		}, (VAR_RADIO_RADIOINTERACTSBLU select 1) select 1] call ace_interact_menu_fnc_createAction;
		[typeOf player, 1, ["ACE_SelfActions", "cmdRadio_class"], _cmdRadioSub2] call ace_interact_menu_fnc_addActionToClass;

		_cmdRadioSub3 = ["cmd_obj3", (VAR_RADIO_RADIOINTERACTSBLU select 2) select 0, "", {
			["FW_RADIO_RADIOMESSAGE",[2,mapGridPosition player]] call CBA_fnc_globalEvent;	//Message for clients
			["FW_RADIO_RADIOFLAGS", 2] call CBA_fnc_serverEvent;	//Flags for server
		}, (VAR_RADIO_RADIOINTERACTSBLU select 2) select 1] call ace_interact_menu_fnc_createAction;
		[typeOf player, 1, ["ACE_SelfActions", "cmdRadio_class"], _cmdRadioSub3] call ace_interact_menu_fnc_addActionToClass;

		_cmdRadioSub4 = ["cmd_obj4", (VAR_RADIO_RADIOINTERACTSBLU select 3) select 0, "", {
			["FW_RADIO_RADIOMESSAGE",[3,mapGridPosition player]] call CBA_fnc_globalEvent;	//Message for clients
			["FW_RADIO_RADIOFLAGS", 3] call CBA_fnc_serverEvent;	//Flags for server
		}, (VAR_RADIO_RADIOINTERACTSBLU select 3) select 1] call ace_interact_menu_fnc_createAction;
		[typeOf player, 1, ["ACE_SelfActions", "cmdRadio_class"], _cmdRadioSub4] call ace_interact_menu_fnc_addActionToClass;

		_cmdRadioSub5 = ["cmd_obj5", (VAR_RADIO_RADIOINTERACTSBLU select 4) select 0, "", {
			["FW_RADIO_RADIOMESSAGE",[4,mapGridPosition player]] call CBA_fnc_globalEvent;	//Message for clients
			["FW_RADIO_RADIOFLAGS", 4] call CBA_fnc_serverEvent;	//Flags for server
		}, (VAR_RADIO_RADIOINTERACTSBLU select 4) select 1] call ace_interact_menu_fnc_createAction;
		[typeOf player, 1, ["ACE_SelfActions", "cmdRadio_class"], _cmdRadioSub5] call ace_interact_menu_fnc_addActionToClass;
};