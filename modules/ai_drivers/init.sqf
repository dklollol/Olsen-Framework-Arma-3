["AI drivers", "Adds AI commanded by players as drivers to vehicles.", "BlackHawk"] call FNC_RegisterModule;

#include "settings.sqf"

aidrivers_removeUnit = {
    params ["_target", "_caller"];

    private _driver = _target getVariable ["AI_driver", objNull];
    
    if (!isNull _driver) then {
        deleteVehicle _driver;
        private _id = _target getVariable ["AI_driver_id", -1];
        if (_id != -1) then {
            _target removeAction _id;
        };
        _target addAction ["spawn AI driver", {_this remoteExecCall ["aidrivers_createUnit", 2, false];}, [], 0, false, true, "", "isNull (driver _target) && vehicle _this == _target"];
    };
};

aidrivers_createUnit = {
    params ["_target", "_caller", "_id"];
    
    if (!isNull driver _target) exitWith {};

    _target removeAction _id;
    
    [_target, {
        private _id = _this addAction ["remove AI driver", {_this call aidrivers_removeUnit}, [], 0, false, true, "", "vehicle _this == _target"];
        _this setVariable ["AI_driver_id", _id, false];
    }] remoteExecCall ["BIS_fnc_Call", 0, false];
    
    _unit = group _caller createUnit ["B_Soldier_F", [0,0,0], [], 0, "CAN_COLLIDE"];

    _target setVariable ["AI_driver", _unit, true];
    
    _unit setCombatMode "BLUE";
    _unit moveInDriver _target;
    
    [{vehicle (_this select 0) != _this select 0}, {
        (_this select 1) params ["_unit", "_target", "_caller", "_id2"];
        [{
            (_this select 0) params ["_unit", "_target", "_caller", "_id2"];
            private _handle = _this select 1;
            if (vehicle _caller != _target) then {
                _unit disableAI "PATH";
            } else {
                _unit enableAI "PATH";
            };
            if (!alive _target || !alive _caller || !alive _unit || (vehicle _unit) != _target) then {
                [_target, _caller] remoteExecCall ["aidrivers_removeUnit", 0, false];
                [_handle] call CBA_fnc_removePerFrameHandler;
            };
        }, 1, [_unit, _target, _caller, _id2]] call CBA_fnc_addPerFrameHandler;
    }, [_unit, [_unit, _target, _caller, _id2]]] call CBA_fnc_WaitUntilAndExecute;
    
};

{
    _x addAction ["spawn AI driver", {_this remoteExecCall ["aidrivers_createUnit", 2, false];}, [], 0, false, true, "", "isNull (driver _target) && vehicle _this == _target"];
} foreach VEHS;