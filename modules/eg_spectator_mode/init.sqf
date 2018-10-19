["EG Spectator Mode", "Replaces the Olsen Framework spectator script with the Vanilla Spectator.", "BI, Perfk &amp; BlackHawk"] call FNC_RegisterModule;

#define DEBUG_MSG(MSG)
//systemchat MSG;\

if (!isDedicated) then {

	//function ran from keyHandler
	killcam_toggleFnc = {
		//37 is DIK code for K
		if ((_this select 1) == 37) then {
			if (killcam_toggle) then {
				killcam_toggle = false;
				cutText ["", "PLAIN DOWN"];
			}
			else {
				killcam_toggle = true;
				cutText ["Line shows LINE OF SIGHT from postion of enemy to player's position during the time of death.\nPress K to toggle hud markers off.\n\nTHIS FRAMEWORK FEATURE IS WIP. It may contain bugs and may be updated or changed at any point.", "PLAIN DOWN"];
			};
		};
	};
	
	eg_keyHandler_display_hidden = false;
	
	eg_keyHandler = {
		params ["_control", "_code", "_shift", "_control", "_alt"];

		private _acre = ["ACRE2", "HeadSet"] call CBA_fnc_getKeybind;
		if (!isNil "_acre") then {
			private _action = _acre select 4;
			private _keys = _acre select 5;

			if (_code == _keys select 0 && (_keys select 1) isEqualTo [_shift, _control, _alt]) then {
				call _action;
			};
		};
		
		if (_code == 35 && !_shift && _control && !_alt) then {
			if (!eg_keyHandler_display_hidden) then {
				(findDisplay 60492) closedisplay 1;
				eg_keyHandler_display_hidden = true;
			};
		};
	};
	
	eg_keyHandler2 = {
		params ["_control", "_code", "_shift", "_control", "_alt"];
		
		if (_code == 35 && !_shift && _control && !_alt &&
		!isNil "eg_keyHandler_display_hidden" &&
		{eg_keyHandler_display_hidden}
		) then {
			([] call BIS_fnc_displayMission) createDisplay "RscDisplayEGSpectator";
			eg_keyHandler_display_hidden = false;
			
			eg_keyHandle = (findDisplay 60492) displayAddEventHandler ["keyDown", {call eg_keyHandler;}];
			if (killcam_active) then {
				killcam_keyHandle = (findDisplay 60492) displayAddEventHandler ["keyDown", {call killcam_toggleFnc;}];
			};
		};
	};

	#include "settings.sqf"

	if (killcam_active) then {
		DEBUG_MSG("killcam activated")
		//hitHandler used for retrieving information if killed EH won't fire properly
		killcam_hitHandle = player addEventHandler ["Hit", {
			params ["_unit", "_causedBy", "_damage"];
			DEBUG_MSG("HIT EH")
			if (vehicle _causedBy != vehicle player && _causedBy != objNull) then {
				DEBUG_MSG("HIT data valid")
				//we store this information in case it's needed if killed EH doesn't fire
				killcam_LastHit = [_this, time, ASLtoAGL eyePos _unit, ASLtoAGL eyePos _causedBy];
			};
			if (_damage > 1) then {_damage = 1};
			killcam_LastHitDamage = _damage;
		}];

		//START OF KILLED EH///////////
		killcam_killedHandle = player addEventHandler ["Killed", {
			params ["_unit", "_killer"];
			//let's remove hit EH, it's not needed
			player removeEventHandler ["hit", killcam_hitHandle];
			
			//we check if player didn't kill himself or died for unknown reasons
			if (vehicle _killer != vehicle _unit && _killer != objNull) then {
			
				//this is the standard case (killed EH got triggered by getting shot)
				DEBUG_MSG("using killed EH")
				killcam_unit_pos = ASLtoAGL eyePos _unit;
				killcam_killer = _killer;
				killcam_killer_pos = ASLtoAGL eyePos _killer;
			} else {
				//we will try to retrieve info from our hit EH
				DEBUG_MSG("using hit EH")
				_last_hit_info = [];
				if (!isNil "killcam_LastHit") then {
					_last_hit_info = killcam_LastHit;
				};
				
				//hit info retrieved, now we check if it's not caused by fall damage etc.
				//also we won't use info that's over 10 seconds old
				private _damage = 0.5;
				if (count _last_hit_info != 0) then {
					_last_hit_info params ["_data", "_time", "_unitPos", "_killerPos"];
					if (_time + 10 > time &&
					(_data select 1) != objNull &&
					(_data select 1) != player
					) then {
						DEBUG_MSG("HIT data check successful")
						killcam_unit_pos = _unitPos;
						killcam_killer = _data select 1;
						killcam_killer_pos = _killerPos;
					}
					else {
						DEBUG_MSG("HIT data not valid")
						//everything failed, we set value we will detect later
						killcam_killer_pos = [0,0,0];
						killcam_unit_pos = ASLtoAGL eyePos _unit;
						killcam_killer = objNull;
					};
				}
				else {
					DEBUG_MSG("HIT and KILLED EHs not valid")
					killcam_killer_pos = [0,0,0];
					killcam_unit_pos = ASLtoAGL eyePos _unit;
					killcam_killer = objNull;
				};
			};

			[] spawn {
				if (eg_instant_death) then {
					private _damage = 0.5;
					if (!isNil "killcam_LastHitDamage") then {
						_damage = killcam_LastHitDamage;
					};
					sleep 0.1;
					cutText ["\n", "BLACK", 1.01-_damage, true];
					["FW_death", 0, true] call ace_common_fnc_setHearingCapability;
					sleep 1.01-_damage;
					0 fadeSound 0;
					sleep 0.89+_damage;
					
					["<t color='#FF0000'>YOU ARE DEAD</t>", 0, 0.4, 2, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;

				} else {
					("BIS_layerEstShot" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];

					sleep 0.4;

					playSound "Simulation_Fatal";
					call BIS_fnc_VRFadeOut;

					sleep 1;

					playSound ("Transition" + str (1 + floor random 3));

					sleep 1;
					call BIS_fnc_VRFadeIn;
				};
			};
			
		}];
		//END OF KILLED EH///////////

	};

	FNC_RespawnedRemoteFunc = {

		cutText ["\n","BLACK IN", 5];
		["FW_death", 0, false] call ace_common_fnc_setHearingCapability;
		0 fadeSound 1;

		private _respawnName = toLower(format ["fw_%1_respawn", side player]);
		private _respawnPoint = missionNamespace getVariable [_respawnName, objNull];
		private _loadout = (player getVariable ["FW_Loadout", ""]);

		if (_loadout != "") then {
			[player, _loadout] call FNC_GearScript;
		};

		if (!isNull(_respawnPoint)) then {
			player setPosATL getPosATL _respawnPoint;
		};


		private _p = "";
		if (FW_RespawnTickets != 1) then {
			_p = "s";
		};
		private _message2 = format ["you can respawn %1 time%2", FW_RespawnTickets, _p];

		private _sideTickets = 0;
		switch (side player) do {
			case west: {
				_sideTickets = FW_RespawnTicketsWest;
			};
			case east: {
				_sideTickets = FW_RespawnTicketsEast;
			};
			case independent: {
				_sideTickets = FW_RespawnTicketsInd;
			};
			case civilian: {
				_sideTickets = FW_RespawnTicketsCiv;
			};
		};
		private _p2 = "";
		if (_sideTickets != 1) then {
			_p2 = "s";
		};
		cutText [format ['Your side has %1 ticket%2 left, %3', _sideTickets, _p2, _message2], 'PLAIN DOWN'];


		player setVariable ["FW_Body", player, true];
	};

	FNC_SpectatingRemoteFunc = {
		player setVariable ["FW_Dead", true, true]; //Tells the framework the player is dead
		
		player hideObjectGlobal true;
		player setCaptive true;
		player allowDamage false;

		cutText ["\n","BLACK IN", 5];
		["FW_death", 0, false] call ace_common_fnc_setHearingCapability;
		0 fadeSound 1;

		player call FNC_RemoveAllGear;
		player addWeapon "itemMap";

		player setPos [0, 0, 0];
		[player] join grpNull;

		if (!(player getVariable ["FW_Spectating", false])) then {

			player setVariable ["FW_Spectating", true, true];

			[true] call acre_api_fnc_setSpectator;
			//If babel is enabled, allowed spectator to hear all languages present in mission.
			if (!isNil "FW_enable_babel" && {FW_enable_babel}) then {
				private _missionLanguages = [];
				{
					{
						if (!(_x in _missionLanguages)) then {
							_missionLanguages pushback _x;
						};
					} foreach _x;
				} forEach FW_languages_babel;
				_missionLanguages call acre_api_fnc_babelSetSpokenLanguages;
			};

			//we set default pos in case all methods fail and we end up with 0,0,0
			private _pos = [2000, 2000, 100];
			private _dir = 0;
			
			if (getMarkerColor eg_spectator_marker == "") then {
				if (!isNull killcam_body) then {
					//set camera pos on player body
					_pos = [(getpos killcam_body) select 0, (getpos killcam_body) select 1, ((getposATL killcam_body) select 2)+1.2];
					_dir = getDir killcam_body;
				};
			} else {
				_pos = getmarkerpos eg_spectator_marker;
			};
			
			if (abs(_pos select 0) < 2 && abs(_pos select 1) < 2) then {
				_pos = [2000, 2000, 100];
			};

			["Initialize", 
				[
				player,
				eg_Whitelisted_Sides,
				eg_Ai_Viewed_By_Spectator,
				eg_Free_Camera_Mode_Available,
				eg_Third_Person_Perspective_Camera_mode_Available,
				eg_Show_Focus_Info_Widget,
				eg_Show_Camera_Buttons_Widget,
				eg_Show_Controls_Helper_Widget,
				eg_Show_Header_Widget,
				eg_Show_Entities_And_Locations_Lists
				]
			] call BIS_fnc_EGSpectator;
			
			private _cam = missionNamespace getVariable ["BIS_EGSpectatorCamera_camera", objNull];
			
			if (_cam != objNull) then {
				
				[{!isNull (findDisplay 60492)}, {
						DEBUG_MSG("Display loaded, attaching key EH")
						eg_keyHandle = (findDisplay 60492) displayAddEventHandler ["keyDown", {call eg_keyHandler;}];
						eg_keyHandle = (findDisplay 46) displayAddEventHandler ["keyDown", {call eg_keyHandler2}];
				}, []] call CBA_fnc_waitUntilAndExecute;
				
				
				if (!killcam_active) then {
					//we move 2 meters back so player's body is visible
					_pos = ([_pos, -2, _dir] call BIS_fnc_relPos);
					_cam setposATL _pos;
					_cam setDir _dir;
				}
				else {
					missionNamespace setVariable ["killcam_toggle", false];
					
					//this cool piece of code adds key handler to spectator display
					//it takes some time for display to create, so we have to delay it.
					[{!isNull (findDisplay 60492)}, {
						DEBUG_MSG("Display loaded, attaching key EH")
						killcam_keyHandle = (findDisplay 60492) displayAddEventHandler ["keyDown", {call killcam_toggleFnc;}];
					}, []] call CBA_fnc_waitUntilAndExecute;
					
					if (!isNull killcam_killer) then {
						DEBUG_MSG("found valid killer")
						killcam_distance = killcam_killer distance killcam_body;
						_pos = ([_pos, -1.8, ([killcam_body, killcam_killer] call BIS_fnc_dirTo)] call BIS_fnc_relPos);
						_cam setposATL _pos;
						
						//vector magic
						_temp1 = ([getposASL _cam, getposASL killcam_killer] call BIS_fnc_vectorFromXToY);
						_temp = (_temp1 call CBA_fnc_vect2Polar);
						
						//we check if camera is not pointing up, just in case
						if (abs(_temp select 2) > 89) then {_temp set [2, 0]};
						[_cam, [_temp select 1, _temp select 2]] call BIS_fnc_setObjectRotation;
					}
					else {
						DEBUG_MSG("no valid killer")
						_cam setposATL _pos;
						_cam setDir _dir;
					};
					
					killcam_texture = "a3\ui_f\data\gui\cfg\debriefing\enddeath_ca.paa";
					
					killcam_drawHandle = addMissionEventHandler ["Draw3D", {
						//we don't draw hud unless we toggle it by keypress
						if (missionNamespace getVariable ["killcam_toggle", false]) then {
						
							if ((killcam_killer_pos select 0) != 0) then {
								
								_u = killcam_unit_pos;
								_k = killcam_killer_pos;
								if ((_u distance _k) < 2000) then {
									//TODO do it better
									drawLine3D [[(_u select 0)+0.01, (_u select 1)+0.01, (_u select 2)+0.01], [(_k select 0)+0.01, (_k select 1)+0.01, (_k select 2)+0.01], [1,0,0,1]];
									drawLine3D [[(_u select 0)-0.01, (_u select 1)-0.01, (_u select 2)-0.01], [(_k select 0)-0.01, (_k select 1)-0.01, (_k select 2)-0.01], [1,0,0,1]];
									drawLine3D [[(_u select 0)-0.01, (_u select 1)+0.01, (_u select 2)-0.01], [(_k select 0)-0.01, (_k select 1)+0.01, (_k select 2)-0.01], [1,0,0,1]];
									drawLine3D [[(_u select 0)+0.01, (_u select 1)-0.01, (_u select 2)+0.01], [(_k select 0)+0.01, (_k select 1)-0.01, (_k select 2)+0.01], [1,0,0,1]];
								};
								if (!isNull killcam_killer) then {
									private _killerName = name killcam_killer;
									drawIcon3D [killcam_texture, [1,0,0,1], [eyePos killcam_killer select 0, eyePos killcam_killer select 1, (ASLtoAGL eyePos killcam_killer select 2) + 0.4], 0.7, 0.7, 0, _killerName + ", " + (str round killcam_distance) + "m", 1, 0.04, "PuristaMedium"];
								};
							}
							else {
								cutText ["killer info unavailable", "PLAIN DOWN"];
								missionNamespace setVariable ["killcam_toggle", false];
							};
						};
					}];//draw EH
				};//killcam (not) active
			};//checking camera
			
			private _killcam_msg = "";
			if (killcam_active) then {
				_killcam_msg = "Press <t color='#FFA500'>K</t> to toggle indicator showing location where you were killed from.<br/>";
			};
			private _text = format ["<t size='0.5' color='#ffffff'>%1
			Close spectator HUD by pressing <t color='#FFA500'>CTRL+H</t>.<br/>
			Press <t color='#FFA500'>SHIFT</t>, <t color='#FFA500'>ALT</t> or <t color='#FFA500'>SHIFT+ALT</t> to modify camera speed. Open map by pressing <t color='#FFA500'>M</t> and click anywhere to move camera to that postion.<br/> 
			Spectator controls can be customized in game <t color='#FFA500'>options->controls->'Camera'</t> tab.</t>", _killcam_msg];
			
			[_text, 0.55, 0.8, 20, 1] spawn BIS_fnc_dynamicText;

			[] spawn {
				while {(player getVariable ["FW_Spectating", false])} do {
					player setOxygenRemaining 1;
					sleep 0.25;
				};
			};
		} //not already spectator check
		else {
			call BIS_fnc_VRFadeIn;
		};
	};

	FNC_SpectatePrep = {
		killcam_body = _this select 1; //needed in killcam later on (we set it here because remoteExecs)

		private _side = side player;
		if (FW_RespawnTickets > 0) then {
		FW_RespawnTickets = FW_RespawnTickets - 1;
			_side remoteExecCall ["FNC_RequestRespawnFromServer", 2];
		}
		else {
			call FNC_SpectatingRemoteFunc;
		};
	};
};

if (isServer) then {
	FW_CurrentWaveCountWest = if (FW_WaveSizeWest > 0) then { 0 } else { -1000 };
	FW_CurrentWaveCountEast = if (FW_WaveSizeEast > 0) then { 0 } else { -1000 };
	FW_CurrentWaveCountInd = if (FW_WaveSizeInd > 0) then { 0 } else { -1000 };
	FW_CurrentWaveCountCiv = if (FW_WaveSizeCiv > 0) then { 0 } else { -1000 };

	FNC_RequestRespawnFromServer = {
		private _side = _this;
		private _canRespawn = false;
		switch (_side) do {
			case west: {
				if (FW_RespawnTicketsWest > 0) then {
					FW_RespawnTicketsWest = FW_RespawnTicketsWest - 1;

					FW_CurrentWaveCountWest = FW_CurrentWaveCountWest + 1;
					if (FW_CurrentWaveCountWest >= FW_WaveSizeWest) then {
						[] spawn {
							FW_RespawnPenGateWest hideObjectGlobal true;
							sleep 30;
							FW_RespawnPenGateWest hideObjectGlobal false;
						};
						FW_CurrentWaveCountWest = 0;
					};

					publicVariable "FW_RespawnTicketsWest";
					_canRespawn = true;
				};
			};
			case east: {
				if (FW_RespawnTicketsEast > 0) then {
					FW_RespawnTicketsEast = FW_RespawnTicketsEast - 1;

					FW_CurrentWaveCountEast = FW_CurrentWaveCountEast + 1;
					if (FW_CurrentWaveCountEast >= FW_WaveSizeEast) then {
						[] spawn {
							FW_RespawnPenGateEast hideObjectGlobal true;
							sleep 30;
							FW_RespawnPenGateEast hideObjectGlobal false;
						};
						FW_CurrentWaveCountEast = 0;
					};

					publicVariable "FW_RespawnTicketsEast";
					_canRespawn = true;
				};
			};
			case independent: {
				if (FW_RespawnTicketsInd > 0) then {
					FW_RespawnTicketsInd = FW_RespawnTicketsInd - 1;

					FW_CurrentWaveCountInd = FW_CurrentWaveCountInd + 1;
					if (FW_CurrentWaveCountInd >= FW_WaveSizeInd) then {
						[] spawn {
							FW_RespawnPenGateInd hideObjectGlobal true;
							sleep 30;
							FW_RespawnPenGateInd hideObjectGlobal false;
						};
						FW_CurrentWaveCountInd = 0;
					};

					publicVariable "FW_RespawnTicketsInd";
					_canRespawn = true;
				};
			};
			case civilian: {
				if (FW_RespawnTicketsCiv > 0) then {
					FW_RespawnTicketsCiv = FW_RespawnTicketsCiv - 1;

					FW_CurrentWaveCountCiv = FW_CurrentWaveCountCiv + 1;
					if (FW_CurrentWaveCountCiv >= FW_WaveSizeCiv) then {
						[] spawn {
							FW_RespawnPenGateCiv hideObjectGlobal true;
							sleep 30;
							FW_RespawnPenGateCiv hideObjectGlobal false;
						};
						FW_CurrentWaveCountCiv = 0;
					};

					publicVariable "FW_RespawnTicketsCiv";
					_canRespawn = true;
				};
			};
		};
		if (_canRespawn) then {
			remoteExecCall ["FNC_RespawnedRemoteFunc", remoteExecutedOwner];
		}
		else {
			remoteExecCall ["FNC_SpectatingRemoteFunc", remoteExecutedOwner];
		};
	};
};