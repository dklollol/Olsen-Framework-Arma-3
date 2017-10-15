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
    };
};

aidrivers_createUnit = {
    params ["_target", "_caller"];
    
    if (!isNull driver _target) exitWith {};
    
    private _class = "B_Soldier_F";
    if (side _caller == EAST) then {
        _class = "O_Soldier_F";
    };
    if (side _caller == INDEPENDENT) then {
        _class = "I_Soldier_F";
    };
    
    _unit = group _caller createUnit [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
    removeAllWeapons _unit;
    removeUniform _unit;
    removeVest _unit;
    removeHeadgear _unit;
    
    _unit forceAddUniform uniform _caller;
    _unit addVest vest _caller;
    _unit addHeadGear headGear _caller;
    
    _target setVariable ["aidrivers_driver", _unit];
    
    _unit moveInDriver _target;
    
    doStop _unit;
    
    [{vehicle (_this select 0) != _this select 0}, {
        [{
            _this select 0 params ["_unit", "_target", "_caller", "_id2", "_stopped"];

            private _handle = _this select 1;
            if (vehicle _caller != _target) then {
                _unit disableAI "PATH";
                doStop _unit;
                _stopped = true;
            } else {
                _unit enableAI "PATH";
            };
            if (!alive _target || !alive _caller || !alive _unit || (vehicle _unit) != _target || (driver _target) != _unit) then {
                [_target, _caller] call aidrivers_removeUnit;
                [_handle] call CBA_fnc_removePerFrameHandler;
            };
        }, 1, _this] call CBA_fnc_addPerFrameHandler;
    }, [_unit, _target, _caller, _id2, false]] call CBA_fnc_WaitUntilAndExecute;
    
};

private _action = ["ai_driver","Add/Remove AI driver","",{
    [_target, _player] remoteExecCall ["aidrivers_toggle", 2, false];
},
{
    vehicle _player == _target
}] call ace_interact_menu_fnc_createAction;
systemchat str _action;
{
    [_x, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    //_x addAction ["Add/Remove AI driver", {_this remoteExecCall ["aidrivers_toggle", 2, false];}, [], 0, false, true, "", "vehicle _this == _target"];
} foreach VEHS;
