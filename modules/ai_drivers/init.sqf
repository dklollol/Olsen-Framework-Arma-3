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
    hint "Driver removed";
};

aidrivers_createUnit = {
    params ["_target", "_caller"];
    
    if (!isNull driver _target) exitWith {};
    private _turret = (assignedVehicleRole _player) select 1;
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

    [{vehicle (_this select 0) != _this select 0}, { //waiting for spawned unit to get into vehicle
        private _pfhID = [{
            _this select 0 params ["_unit", "_target", "_caller"];

            private _handle = _this select 1;
            if (vehicle _caller != _target) then {
                _unit disableAI "PATH";
                doStop _unit;
            } else {
                _unit enableAI "PATH";
            };
            if (!alive _target || !alive _caller || !alive _unit || (vehicle _unit) != _target || (driver _target) != _unit) then {
                [_target, _caller] call aidrivers_removeUnit;
            };
        }, 1, _this] call CBA_fnc_addPerFrameHandler;
        (_this select 1) setVariable ["aidrivers_pfhID", [(_this select 2), _pfhID], true];
    }, [_unit, _target, _caller]] call CBA_fnc_WaitUntilAndExecute;

    hint "Driver added";

};

private _action = ["ai_driver","Add/Remove AI driver","",{
    [_target, _player] call aidrivers_toggle;
},
{
    vehicle _player == _target && ((assignedVehicleRole _player) select 0) == "Turret"
}] call ace_interact_menu_fnc_createAction;

private _unflipAction = ["ai_driver_unflip","Unflip vehicle","",{
    [_target, surfaceNormal position _target] remoteExec ["setVectorUp", 2, false];
    _target setPos [getpos _target select 0, getpos _target select 1, (getpos _target select 2) + 2];
},
{
    vehicle _player == _target && ((assignedVehicleRole _player) select 0) == "Turret" && {(vectorUp _target) select 2 < 0}
}] call ace_interact_menu_fnc_createAction;

FNC_AddAIDriver = {
    private _vehs = _this;
    if (typeName _vehs != "ARRAY") then {
        _vehs = [_vehs];
    };
    {
        [_x, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
        [_x, 1, ["ACE_SelfActions"], _unflipAction] call ace_interact_menu_fnc_addActionToObject;
    } foreach _vehs;

};

VEHS call FNC_AddAIDriver;
