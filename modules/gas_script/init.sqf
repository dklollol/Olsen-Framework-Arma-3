//Gas script implementation by TinfoilHate
//["FW_GAS_FIREMISSION",[position player,50,3,1,5,300]] call CBA_fnc_serverEvent;

	player setVariable ["FW_GAS_NEEDSMASK",false];

	if (!isDedicated && hasInterface) then {
		[{!isNull player}, {
			FW_GAS_DOWN = false;
		
			//Monitor gas mask usage for stamina purposes
			[] spawn {
				sleep 1;

				_maskOn = false;
				while {true} do {
					if (goggles player in FW_GAS_MASKLIST && !_maskOn) then {
						_maskOn = true;

						ace_advanced_fatigue_loadFactor				= 0.9;
						ace_advanced_fatigue_recoveryFactor			= 0.6;
						ace_advanced_fatigue_performanceFactor		= 0.6;
						ace_advanced_fatigue_terrainGradientFactor	= 0.8;
					};

					if (!(goggles player in FW_GAS_MASKLIST) && _maskOn) then {
						_maskOn = false;

						ace_advanced_fatigue_loadFactor				= 1.0;
						ace_advanced_fatigue_recoveryFactor			= 1.0;
						ace_advanced_fatigue_performanceFactor		= 1.0;
						ace_advanced_fatigue_terrainGradientFactor	= 1.0;
					};

					sleep 1;
				};
			};

			//Vehicle alarm action
			_vehAlarm_toggle_off = ["vehAlarm_off_class", "Turn CBRN Alarm Off", "", {
				params ["_target", "_player"];

				_target setVariable ["FW_GAS_VEHALARM_ON",false,true];
			}, {
				([_player, _target, []] call ace_common_fnc_canInteractWith) && (commander _target == _player || gunner _target == _player || driver _target == _player) && _target getVariable "FW_GAS_VEHALARM_ON"
			}] call ace_interact_menu_fnc_createAction;
			["LandVehicle", 1, ["ACE_SelfActions"], _vehAlarm_toggle_off, true] call ace_interact_menu_fnc_addActionToClass;

			_vehAlarm_toggle_on = ["vehAlarm_on_class", "Turn CBRN Alarm On", "", {
				params ["_target", "_player"];

				_target setVariable ["FW_GAS_VEHALARM_ON",true,true];
			}, {
				([_player, _target, []] call ace_common_fnc_canInteractWith) && (commander _target == _player || gunner _target == _player || driver _target == _player) && !(_target getVariable "FW_GAS_VEHALARM_ON")
			}] call ace_interact_menu_fnc_createAction;
			["LandVehicle", 1, ["ACE_SelfActions"], _vehAlarm_toggle_on, true] call ace_interact_menu_fnc_addActionToClass;

			//Various user actions for mask usage
			_maskUpSelf = ["maskUpSelf_class", "Put Gasmask On Self", "", {
				{	//Check player inventory for mask
					if (_x in items player && !(goggles player in FW_GAS_MASKLIST)) then {
						player addGoggles _x;
						player removeItem _x;
					};
				} forEach FW_GAS_MASKLIST;
			}, {
				{_x in items player} count FW_GAS_MASKLIST > 0 && !(goggles player in FW_GAS_MASKLIST) && !FW_GAS_DOWN
			}] call ace_interact_menu_fnc_createAction;
			[typeOf player, 1, ["ACE_SelfActions"], _maskUpSelf] call ace_interact_menu_fnc_addActionToClass;

			_maskUpFriend = ["maskUp_class", "Put Gasmask On", "", {
				params ["_target", "_player"];

				{	//Check target inventory first
					if (_x in items _target && !(goggles _target in FW_GAS_MASKLIST)) then {
						[_target,_x] remoteExec ["addGoggles", _target];
						_target removeItem _x;
					};
				} forEach FW_GAS_MASKLIST;

				{	//Check player inventory next
					if (_x in items _player && !(goggles _target in FW_GAS_MASKLIST)) then {
						[_target,_x] remoteExec ["addGoggles", _target];
						_player removeItem _x;
					};
				} forEach FW_GAS_MASKLIST;
			}, {
				([_player, _target, []] call ace_common_fnc_canInteractWith) && ({_x in items _target} count FW_GAS_MASKLIST > 0 || {_x in items _player} count FW_GAS_MASKLIST > 0) && !(goggles _target in FW_GAS_MASKLIST) && _target getVariable ["FW_GAS_NEEDSMASK",false]
			}] call ace_interact_menu_fnc_createAction;
			["MAN", 0, ["ACE_MainActions"], _maskUpFriend, true] call ace_interact_menu_fnc_addActionToClass;

			//JIP Data Sending
			if (didJIP) then {
				["FW_GAS_JIPSEND"] spawn CBA_fnc_serverEvent;
			};
		}, []] call CBA_fnc_waitUntilAndExecute;
		
		[] spawn {
			while {!(player getVariable ["FW_Dead", false])} do {
				if (goggles player in FW_GAS_MASKLIST) then {
					FW_GAS_HASMASK = true;

					ace_advanced_fatigue_loadFactor				= 1.0;
					ace_advanced_fatigue_recoveryFactor			= 0.6;
					ace_advanced_fatigue_performanceFactor		= 0.6;
					ace_advanced_fatigue_terrainGradientFactor	= 0.8;
				} else {
					FW_GAS_HASMASK = false;

					if (FW_GAS_INTENSITY <= 10) then {
						ace_advanced_fatigue_loadFactor				= 1.0;
						ace_advanced_fatigue_recoveryFactor			= 1.0;
						ace_advanced_fatigue_performanceFactor		= 1.0;
						ace_advanced_fatigue_terrainGradientFactor	= 1.0;
					};
				};

				if (count FW_GAS_AREALIST > 0) then {FW_GAS_INHOTAREA = true} else {FW_GAS_INHOTAREA = false};

				if FW_GAS_ACTIVE then {
					if (FW_GAS_INTENSITY >= 2 && FW_GAS_INHOTAREA && !FW_GAS_HASMASK) then {
						if !(player getVariable "FW_GAS_NEEDSMASK") then {player setVariable ["FW_GAS_NEEDSMASK",true,true]};

						if (!FW_GAS_COUGHING) then {
							FW_GAS_COUGHING = true;

							enableCamShake true;
							addCamShake [5, 3, 15];

							FW_GAS_BLUR ppEffectAdjust [FW_GAS_BLURSTEP - 8];
							FW_GAS_BLUR ppEffectCommit 0.8;
							FW_GAS_BLUR ppEffectAdjust [FW_GAS_BLURSTEP + 10];
							FW_GAS_BLUR ppEffectCommit 2.0;
							FW_GAS_BLUR ppEffectAdjust [FW_GAS_BLURSTEP];
							FW_GAS_BLUR ppEffectCommit 3.0;

							_sound = "";
							if (FW_GAS_INTENSITY <= 40) then {	//This should be like 20 or 25, but the damn H1/H2 sounds get cut off weirdly?
								_sound = [
									"ACE_Cough_1",
									"ACE_Cough_2",
									"ACE_Cough_3",
									"ACE_Cough_4",
									"ACE_Cough_5"
								] call BIS_fnc_selectRandom;
							} else {
								_sound = [
									"ACE_Cough_H1",
									"ACE_Cough_H2"
								] call BIS_fnc_selectRandom;
							};
							[player, [_sound,50]] remoteExec ["say3D"];

							[{
								FW_GAS_COUGHING = false;
							}, [], (8 + random 4)] call CBA_fnc_waitAndExecute;
						};
					};

					if (FW_GAS_INTENSITY >= 15 && !FW_GAS_DOWN) then {
						FW_GAS_DOWN = true;

						if (vehicle player == player) then {[player,"ainjppnemstpsnonwrfldnon"] remoteExec ['playMove']};

						FW_GAS_ANIMEH = player addEventHandler ["AnimChanged",{
							if (vehicle player == player) then {[(_this select 0),"ainjppnemstpsnonwrfldnon"] remoteExec ['playMove']};
						}];

						FW_GAS_GEAREH = player addEventHandler ["InventoryOpened",{
							true
						}];
					};

					if (FW_GAS_INTENSITY >= 25) then {
						FW_GAS_BLUR ppEffectAdjust [20];
						FW_GAS_BLUR ppEffectCommit 8;

						addCamShake [2, 15, 15];
					};

					if (FW_GAS_INTENSITY >= 35) then {
						player setDamage 1;
						FW_GAS_INTENSITY = 0;

						FW_GAS_BLUR ppEffectEnable false;
					};

					sleep 0.5 + (random 1);

					//Add or remove effects depending on if you're in a hot area.
					if ((FW_GAS_INHOTAREA && !FW_GAS_HASMASK) || FW_GAS_INTENSITY > 25) then {
						FW_GAS_INTENSITY = FW_GAS_INTENSITY + 0.5;

						if (FW_GAS_BLURSTEP < 10) then {
							FW_GAS_BLURSTEP = FW_GAS_BLURSTEP + 0.5;
						};

						FW_GAS_BLUR ppEffectEnable true;
						FW_GAS_BLUR ppEffectAdjust [FW_GAS_BLURSTEP];
						FW_GAS_BLUR ppEffectCommit 0.5;
					} else {
						if (FW_GAS_INTENSITY > 0) then {FW_GAS_INTENSITY = FW_GAS_INTENSITY - 0.15};

						if (FW_GAS_BLURSTEP > 0) then {
							FW_GAS_BLURSTEP = FW_GAS_BLURSTEP - 0.1;

							FW_GAS_BLUR ppEffectAdjust [FW_GAS_BLURSTEP];
							FW_GAS_BLUR ppEffectCommit 0.5;
						};

						if (FW_GAS_INTENSITY <= 15 && FW_GAS_DOWN) then {
							FW_GAS_DOWN = false;

							if (vehicle player == player) then {[player,"amovpknlmstpsraswrfldnon_amovppnemstpsraswrfldnon"] remoteExec ['playMove']};

							player removeEventHandler ["AnimChanged", FW_GAS_ANIMEH];
							player removeEventHandler ["InventoryOpened", FW_GAS_GEAREH];

							player setVariable ["FW_GAS_NEEDSMASK",false,true];
						};
					};
				};
			};

			FW_GAS_INTENSITY = 0;
			FW_GAS_BLUR ppEffectEnable false;			
		};
	};