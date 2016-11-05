["EG Spectator Mode", "Replaces the Olsen Framework spectator script with the Vanilla Spectator.", "BI &amp; Perfk"] call FNC_RegisterModule;

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
                    
                    sleep 3;
                    cutText ["\n","BLACK IN", 5];
                    ["FW_death", 0, false] call ace_common_fnc_setHearingCapability;
                    0 fadeSound 1;
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

	FNC_SpectatePrep = {

		private ["_respawnName", "_respawnPoint", "_text", "_loadout", "_pos", "_dir", "_cam", "_body", "_temp", "_temp1", "_killcam_msg"];

		if (FW_RespawnTickets > 0) then {

			_respawnName = toLower(format ["fw_%1_respawn", side player]);
			_respawnPoint = missionNamespace getVariable [_respawnName, objNull];
			_loadout = (player getVariable ["FW_Loadout", ""]);

			if (_loadout != "") then {
				[player, _loadout] call FNC_GearScript;
			};

			if (!isNull(_respawnPoint)) then {
				player setPos getPosATL _respawnPoint;
			};

			FW_RespawnTickets = FW_RespawnTickets - 1;
			_text = "respawns left";

			if (FW_RespawnTickets == 1) then {
				_text = "respawn left";
			};

			cutText [format ['%1 %2', FW_RespawnTickets, _text], 'PLAIN DOWN'];
			player setVariable ["FW_Body", player, true];
		} 
		else {
			
			player setVariable ["FW_Dead", true, true]; //Tells the framework the player is dead
			
			player remoteExecCall ["hideObject", 0];
			player remoteExecCall ["hideObjectGlobal", 2];
			
			player setCaptive true;
			player allowdamage false;
			[player, true] remoteExec ["setCaptive", 2];
			[player, false] remoteExec ["allowdamage", 2];

			player call FNC_RemoveAllGear;
			player addWeapon "itemMap";

			player setPos [0, 0, 0];
			[player] join grpNull;

			if (!(player getVariable ["FW_Spectating", false])) then {

				player setVariable ["FW_Spectating", true, true];
				[true] call acre_api_fnc_setSpectator;
				
				//we set default pos in case all methods fail and we and up with 0,0,0
				_pos = [2000, 2000, 100];
				_dir = 0;
				
				//our function is called from Respawned EH, so select 1 is player's body
				_body = (_this select 1);
				if (getMarkerColor eg_spectator_marker == "") then {
					if (!isNull _body) then {
						//set camera pos on player body
						_pos = [(getpos _body) select 0, (getpos _body) select 1, ((getposATL _body) select 2)+1.2];
						_dir = getDir _body;
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
				
				_cam = missionNamespace getVariable ["BIS_EGSpectatorCamera_camera", objNull];
				
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
							_pos = ([_pos, -1.8, ([(_this select 1), killcam_killer] call BIS_fnc_dirTo)] call BIS_fnc_relPos);
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
										drawIcon3D [killcam_texture, [1,0,0,1], [eyePos killcam_killer select 0, eyePos killcam_killer select 1, (ASLtoAGL eyePos killcam_killer select 2) + 0.4], 0.7, 0.7, 0, "killer", 1, 0.04, "PuristaMedium"];
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
				
				_killcam_msg = "";
				if (killcam_active) then {
					_killcam_msg = "Press <t color='#FFA500'>K</t> to toggle indicator showing location where you were killed from.<br/>";
				};
				_text = format ["<t size='0.5' color='#ffffff'>%1
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
	};
};
