/*
 * Author: BlackHawk
 *
 * Check if item classname is valid.
 *
 * Arguments:
 * 0: classname <string>
 *
 * Return Value:
 * is valid <bool>
 *
 * Public: No
 */

params [
    ["_class", "", [""]],
    ["_unit", objNull, [objNull]]
];

private _result = (isClass (configfile >> "CfgWeapons" >> _class)
|| (isClass (configFile >> "CfgMagazines" >> _class))
|| (isClass (configFile >> "CfgGlasses" >> _class))
|| (isClass (configFile >> "CfgVehicles" >> _class))
);

if (!_result) then {
    if (!isMultiplayer) then {
        "Invalid classname given! - " + _class call FNC_DebugMessage;
    };
    [_class, {
        params ["_class"];
        private _msg = "Framework has detected an invalid classname - " + str _class + "! Mission will continue but some parts of gear will be missing.";
        if (!isNil "FW_missing_gear_found") then {
            if !(_class in FW_missing_gear_found) then {
                systemChat _msg;
                diag_log _msg;
                FW_missing_gear_found pushBackUnique _class;
            };
        } else {
            systemChat _msg;
            diag_log _msg;
            FW_missing_gear_found = [_class];
        };
    }] remoteExec ["BIS_fnc_call", 0, true];
    
    if (!isNull _unit) then {
        [_class, _unit] remoteExecCall ["FNC_makeUnitsList", 2, false];
    };
};

_result