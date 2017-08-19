["In-game briefing utilities", "Allows an admin to trigger various commands that will help maintain order during in-game briefings.", "BlackHawk"] call FNC_RegisterModule;

FW_bu_running = true;
FW_bu_whisper = false;

if (!(serverCommandAvailable "#kick")) exitWith {
    _toggle_vt = false; //these variables ensure that we reset only one time, not every frame
    _toggle_fm = false;
    FW_bu_running_loop = true;
    while {FW_bu_running_loop} do {
        //check if player is muted
        if (!isNil "FW_bu_volume_toggle" && !(player getVariable ["FW_bu_whitelisted", false]) && 
            {FW_bu_volume_toggle == 2 || (FW_bu_volume_toggle == 1 && (rank player == "PRIVATE" || rank player == "CORPORAL"))}
        ) then {
            if (isNil "FW_bu_volume_level") then {
                FW_bu_volume_level = -1;
            };
            acre_sys_gui_VolumeControl_Level = FW_bu_volume_level;
            _toggle_vt = true;
        }
        else {
            if (_toggle_vt) then {
                acre_sys_gui_VolumeControl_Level = 0;
                _toggle_vt = false;
            }
        };
        //check if player is frozen
        if (!isNil "FW_bu_fm_toggle" && !(player getVariable ["FW_bu_whitelisted", false]) &&
            {FW_bu_fm_toggle == 2 || (FW_bu_fm_toggle == 1 && (rank player == "PRIVATE" || rank player == "CORPORAL"))}
        ) then {
            player enableSimulation false;
            _toggle_fm = true;
        }
        else {
            if (_toggle_fm) then {
                player enableSimulation true;
                _toggle_fm = false;
            }
        };
        
        if (_toggle_vt && !_toggle_vt) then {
            sleep 1;
        };
        //if we detect module got turned off, reset all variables and stop the loop
        if (!FW_bu_running) then {
            acre_sys_gui_VolumeControl_Level = 0;
            player enableSimulation true;
            FW_bu_running_loop = false;
            missionNamespace setVariable ["FW_ND_Active", false];
        };
    };
};



_hintFunc = {
    [] spawn {
        sleep 0.5;
        "Instructions" hintC [
            "'Lower ACRE volume' will reset ACRE volume to selected value until canceled",
            "'Freeze movement' will prevent players from doing anything other than staring in one spot",
            "Walk up to a player and use whitelist options to add/remove that player from whitelist",
            "Enabled Anti-ND has to be turned off manually"
        ];
    };
};

//functions used for interactive display name
_unitNameDisplay = {
    params ["_target", "_player", "_params", "_actionData"];
    _actionData set [1, format ["Add unit you are looking at (%1) to whitelist", name cursorTarget]];
};
_unitNameDisplayRemove = {
    params ["_target", "_player", "_params", "_actionData"];
    _actionData set [1, format ["Remove unit you are looking at (%1) from whitelist", name cursorTarget]];
};

_displayWhisperInfo = {
    params ["_target", "_player", "_params", "_actionData"];
    _actionData set [1, ("Toggle between whisper/semi-whisper, current: " + (["semi-whisper", "whisper"] select FW_bu_whisper))];
};

FW_bu_fnc_whitelist = {
    params ["_add", "_tgt"];
    _tgt setVariable ["FW_bu_whitelisted", _add, true];
    hint format ["%1 was %2 whitelist", name _tgt, (["removed from", "added to"] select _add)];
};

FW_bu_fnc_lower_volume = {
    params["_mode"];
    FW_bu_volume_toggle = _mode;
    publicVariable "FW_bu_volume_toggle";
    
};

FW_bu_fnc_fm = {
    params["_mode"];
    FW_bu_fm_toggle = _mode;
    publicVariable "FW_bu_fm_toggle";
};

_action = ["FW_bu_menu", "In-game briefing utility", "", {}, {FW_bu_running}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

    //INFO
    _action = ["FW_bu_info", "Display usage information", "", _hintFunc, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "FW_bu_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
    
    //TURN OFF
    _action = ["FW_bu_off", "Turn off (saves performance, can't be turned back on)", "", {FW_bu_running = false; publicVariable "FW_bu_running"; missionNamespace setVariable ["FW_ND_Active", false, true];}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "FW_bu_menu"], _action] call ace_interact_menu_fnc_addActionToObject;

    //DISABLE SETUP TIMER
    _action = ["FW_bu_disable_st", "Disable setup timer for yourself (will let you teleport around)", "", {FW_setup_start_time = 0;}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "FW_bu_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
    
    //ANTI-ND
    _action = ["FW_bu_antind", "Anti-ND", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "FW_bu_menu"], _action] call ace_interact_menu_fnc_addActionToObject;
    
        _action = ["FW_bu_antind_on", "Enable anti-ND", "", {missionNamespace setVariable ["FW_ND_Active", true, true];}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_antind"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_antind_off", "Disable anti-ND", "", {missionNamespace setVariable ["FW_ND_Active", false, true];}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_antind"], _action] call ace_interact_menu_fnc_addActionToObject;
    
    //WHITELIST
    _action = ["FW_bu_wl", "Whitelisting", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "FW_bu_menu"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_wl_add", "Add unit you are looking at to whitelist", "", {[true, cursorTarget] call FW_bu_fnc_whitelist}, {true}, {}, [], [], 0, [false, false, false, false, false], _unitNameDisplay] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_wl"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_wl_remove", "Remove unit you are looking at from whitelist", "", {[false, cursorTarget] call FW_bu_fnc_whitelist}, {true}, {}, [], [], 0, [false, false, false, false, false], _unitNameDisplayRemove] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_wl"], _action] call ace_interact_menu_fnc_addActionToObject;

    //LOWER ACRE VOLUME
    _action = ["FW_bu_lower_acre_volume", "Lower ACRE volume", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "FW_bu_menu"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_lower_acre_volume_toggle", "Toggle between whisper/semi-whisper", "", {FW_bu_whisper = !FW_bu_whisper; if (FW_bu_whisper) then {FW_bu_volume_level = -2} else {FW_bu_volume_level = -1}; publicVariable "FW_bu_volume_level";}, {true}, {}, [], [], 0, [false, false, false, false, false], _displayWhisperInfo] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_lower_acre_volume"], _action] call ace_interact_menu_fnc_addActionToObject;
    
        _action = ["FW_bu_lower_acre_volume_everyone", "For everyone except yourself", "", {[2, FW_bu_whisper] call FW_bu_fnc_lower_volume}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_lower_acre_volume"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_lower_acre_volume_lower_rank", "For everyone with rank lower than SGT", "", {[1, FW_bu_whisper] call FW_bu_fnc_lower_volume}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_lower_acre_volume"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_lower_acre_volume_reset", "Reset ACRE volume for everyone", "", {[0, FW_bu_whisper] call FW_bu_fnc_lower_volume}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_lower_acre_volume"], _action] call ace_interact_menu_fnc_addActionToObject;

    //FREEZE MOVEMENT
    _action = ["FW_bu_fm", "Freeze players in place", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "FW_bu_menu"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_fm_everyone", "For everyone except yourself", "", {[2] call FW_bu_fnc_fm}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_fm"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_fm_lower_rank", "For everyone with rank lower than SGT", "", {[1] call FW_bu_fnc_fm}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_fm"], _action] call ace_interact_menu_fnc_addActionToObject;

        _action = ["FW_bu_fm_reset", "Unfreeze everyone", "", {[0] call FW_bu_fnc_fm}, {true}] call ace_interact_menu_fnc_createAction;
        [player, 1, ["ACE_SelfActions", "FW_bu_menu", "FW_bu_fm"], _action] call ace_interact_menu_fnc_addActionToObject;