["Self actions", "Allows players to check their own team color, view other's maps and cut grass.", "TinfoilHate"] call FNC_RegisterModule;

#include "settings.sqf"

if (!isDedicated && hasInterface) then {
	[{!isNull player}, {
		player setVariable ["mis_originalSide",side player,true];


		//check own color interaction
		if (ENABLE_CHECKING_TEAM_COLOR) then {
			private _teamColor = ["colorCheck_class", "Check Team Color", "", {
				private _str = "";
				switch (assignedTeam player) do {
					case "BLUE": {_str = "<t size='1.5'>You are in <br/><t color='#0000FF'>BLUE</t> team.</t> "};
					case "RED": {_str = "<t size='1.5'>You are in <br/><t color='#FF0000'>RED</t> team.</t> "};
					case "GREEN": {_str = "<t size='1.5'>You are in <br/><t color='#00FF00'>GREEN</t> team.</t> "};
					case "YELLOW": {_str = "<t size='1.5'>You are in <br/><t color='#FFFF00'>YELLOW</t> team.</t> "};
					default {_str = "<t size='1.5'>You are in <br/><t color='#FFFFFF'>WHITE</t> team.</t> "};
				};
				hint parseText _str;
			}, {assignedTeam player != nil}] call ace_interact_menu_fnc_createAction;
			[player, 1, ["ACE_SelfActions"], _teamColor] call ace_interact_menu_fnc_addActionToObject;
		};

		//share map interaction
		if (ENABLE_VIEWING_MAP) then {
			private _shareMap = ["shareMap_class", "View Map", "", {
				params ["_target", "_player"];
	
				player linkItem "ItemMap";
				openMap true;
	
				[
					{!visibleMap || (_this select 0) distance (_this select 1) > 3},
					{openMap false; player unlinkItem "ItemMap";},
					[_target,_player]
				] call CBA_fnc_waitUntilAndExecute;
			}, {
				!("ItemMap" in assignedItems _player) &&
				"ItemMap" in assignedItems _target &&
				_target distance _player <= 3 &&
				(_player getVariable "mis_originalSide" == _target getVariable "mis_originalSide")
			}] call ace_interact_menu_fnc_createAction;

			[player, 0, ["ACE_MainActions"], _shareMap, true] call ace_interact_menu_fnc_addActionToObject;
		};

		//cut grass interaction
		if (ENABLE_CUTTING_GRASS) then {
			private _machete = ["machete_class", "Cut Grass", "", {
				mis_macheteDone = false;
				private _macheteEH = player addEventHandler ["AnimDone", {
					if (_this select 1 == "AinvPknlMstpSlayWrflDnon_medic") then {
						mis_macheteDone = true;
					};
				}];
	
				[player,"AinvPknlMstpSlayWrflDnon_medic"] remoteExec ['playMove'];
	
				[{mis_macheteDone}, {
					_cutter = "ClutterCutter_small_EP1" createVehicle [0,0,0];
					_cutter = createVehicle ["ClutterCutter_small_EP1", [getposATL player, 1, getDir player] call BIS_fnc_relPos, [], 0, "CAN_COLLIDE"];
					player removeEventHandler ["AnimDone", _this];
	
					mis_macheteDone = false;
				}, _macheteEH] call CBA_fnc_waitUntilAndExecute;
			}, {stance player == "CROUCH"}] call ace_interact_menu_fnc_createAction;
			[player, 1, ["ACE_SelfActions"], _machete] call ace_interact_menu_fnc_addActionToObject;
		};
		
	}, []] call CBA_fnc_waitUntilAndExecute;
};
