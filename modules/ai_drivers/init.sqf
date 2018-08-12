["AI drivers", "Adds AI commanded by players as drivers to vehicles.", "BlackHawk"] call FNC_RegisterModule;

#include "settings.sqf"

aidrivers_toggle = {
    params ["_target", "_caller"];
    if (!isNull (_target getVariable ["aidrivers_driver", objNull])) then {
        [_target] call aidrivers_removeUnit;
    } else {
        [_target, _caller] call aidrivers_createUnit;
    };
};

aidrivers_removeUnit = {
    params ["_target"];

    private _driver = _target getVariable ["aidrivers_driver", objNull];
    
    if (!isNull _driver) then {
        deleteVehicle _driver;
        private _handle = _target getVariable ["aidrivers_pfhID", []];
        if ((count _handle) != 0) then {
            [_handle select 1] remoteExec ["CBA_fnc_removePerFrameHandler", _handle select 0];
        };
    };
    FW_AiDriverVehicle = objNull;
    false call FNC_toggleDriverCam;
    hint "Driver removed";
};

aidrivers_createUnit = {
    params ["_target", "_caller"];
    
    if (!isNull driver _target) exitWith {};
    private _turret = (assignedVehicleRole _caller) select 1;
    _caller moveInDriver _target;
    _caller moveInTurret [_target, _turret];
    
    private _class = "B_Soldier_F";
    if (side _caller == EAST) then {
        _class = "O_Soldier_F";
    };
    if (side _caller == INDEPENDENT) then {
        _class = "I_Soldier_F";
    };

    _unit = createAgent [_class, [0,0,0], [], 0, "CAN_COLLIDE"];

    removeAllWeapons _unit;
    removeUniform _unit;
    removeVest _unit;
    removeHeadgear _unit;
    removeGoggles _unit;
    
    _unit forceAddUniform uniform _caller;
    _unit addVest vest _caller;
    _unit addHeadGear headGear _caller;
    
    _target setVariable ["aidrivers_driver", _unit, true];

    _unit moveInDriver _target;
    _unit setBehaviour "COMBAT";
    
    doStop _unit;

    FW_AidriverLastTimeIn = time;

    [{vehicle (_this select 0) != _this select 0}, { //waiting for spawned unit to get into vehicle
        private _pfhID = [{
            _this select 0 params ["_unit", "_target", "_caller"];

            private _handle = _this select 1;
            if (vehicle _caller != _target) then {
                false call FNC_toggleDriverCam;
                _unit disableAI "PATH";
                doStop _unit;
            } else {
                _unit enableAI "PATH";
                FW_AidriverLastTimeIn = time;
            };
            if (time > 120 + FW_AidriverLastTimeIn || !alive _target || !alive _caller || !alive _unit || (vehicle _unit) != _target || (driver _target) != _unit) then {
                [_target, _caller] call aidrivers_removeUnit;
            };
        }, 1, _this] call CBA_fnc_addPerFrameHandler;
        (_this select 1) setVariable ["aidrivers_pfhID", [(_this select 2), _pfhID], true];
    }, [_unit, _target, _caller]] call CBA_fnc_WaitUntilAndExecute;

    FW_AiDriverVehicle = _target;
    hint "Driver added";

};

FNC_toggleDriverCam = {
    if (_this) then {
        FW_driverCam = "camera" camCreate [0,0,0];
        FW_driverCam cameraEffect ["INTERNAL", "BACK","FW_rtt"];
        FW_driverCam camSetFov 0.9;
        FW_driverCam camCommit 0;

        FW_pipNvEnabled = false;
        
        _veh = vehicle player;
        _mempoint = getText ( configfile >> "CfgVehicles" >> (typeOf _veh) >> "memoryPointDriverOptics" );
        FW_driverCam attachTo [_veh,[0,0,0], _mempoint];
        
        with uiNamespace do {
            "FW_pipDriver" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
            FW_pipDisplay = uiNamespace getVariable "RscTitleDisplayEmpty";
            FW_driverPipDisplay = FW_pipDisplay ctrlCreate ["RscPicture", -1];
            FW_driverPipDisplay ctrlSetPosition [0.1,1,0.75,0.5];
            FW_driverPipDisplay ctrlCommit 0;
            FW_driverPipDisplay ctrlSetText "#(argb,512,512,1)r2t(FW_rtt,1.0)";
        };

    } else {
        if (!isNil "FW_driverCam" && {!isNull FW_driverCam}) then {
            with uiNamespace do {
                FW_pipDisplay closeDisplay 2;
            };
            detach FW_driverCam;
            FW_driverCam cameraEffect ["terminate", "back", "FW_rtt"];
            camDestroy FW_driverCam;
        };
    };
};

FNC_enableAIDriver = {
    private _vehs = _this;
    if (typeName _vehs != "ARRAY") then {
        _vehs = [_vehs];
    };

    //AI driver action
    private _action = ["ai_driver","Add/Remove AI driver","",{
        [_target, _player] call aidrivers_toggle;
    },
    {
        vehicle _player == _target && ((assignedVehicleRole _player) select 0) == "Turret" && FW_AiDriverVehicle in [objNull, vehicle _player]
    }] call ace_interact_menu_fnc_createAction;

    //unflip action
    private _unflipAction = ["ai_driver_unflip","Unflip vehicle","",{
        [_target, surfaceNormal position _target] remoteExec ["setVectorUp", _target, false];
        _target setPos [getpos _target select 0, getpos _target select 1, (getpos _target select 2) + 2];
    },
    {
        vehicle _player == _target && ((assignedVehicleRole _player) select 0) == "Turret" && (vectorUp _target) select 2 < 0
    }] call ace_interact_menu_fnc_createAction;

    //engine off action
    private _engineOffAction = ["ai_driver_engineoff","Turn off engine","",{
        [_target, false] remoteExec ["engineOn", _target];
    },
    {
        vehicle _player == _target && ((assignedVehicleRole _player) select 0) == "Turret" && isEngineOn _target
    }] call ace_interact_menu_fnc_createAction;

    //PIP action
    private _pipAction = ["ai_driver_pip","Enable/Disable driver's view","",{
        (isNil "FW_driverCam" || {isNull FW_driverCam}) call FNC_toggleDriverCam;
    },
    {
        vehicle _player == _target && ((assignedVehicleRole _player) select 0) == "Turret" && !isNull (_target getVariable ["aidrivers_driver", objNull])
    }] call ace_interact_menu_fnc_createAction;

    //toggle NV for PIP
    private _pipNvAction = ["ai_driver_pip_nv","Enable/Disable NV in driver's view","",{
        if (isNil "FW_pipNvEnabled") then {
            FW_pipNvEnabled = false;
        };
        "FW_rtt" setPiPEffect ([[1], [0]] select FW_pipNvEnabled);
        FW_pipNvEnabled = !FW_pipNvEnabled;
    },
    {
        vehicle _player == _target &&
        ((assignedVehicleRole _player) select 0) == "Turret" &&
        (!isNil "FW_driverCam" && {!isNull FW_driverCam})
    }] call ace_interact_menu_fnc_createAction;


    {
        [_x, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
        [_x, 1, ["ACE_SelfActions"], _unflipAction] call ace_interact_menu_fnc_addActionToObject;
        [_x, 1, ["ACE_SelfActions"], _engineOffAction] call ace_interact_menu_fnc_addActionToObject;
        [_x, 1, ["ACE_SelfActions"], _pipAction] call ace_interact_menu_fnc_addActionToObject;
        [_x, 1, ["ACE_SelfActions"], _pipNvAction] call ace_interact_menu_fnc_addActionToObject;
    } foreach _vehs;

};

FW_AiDriverVehicle = objNull;

VEHS call FNC_enableAIDriver;