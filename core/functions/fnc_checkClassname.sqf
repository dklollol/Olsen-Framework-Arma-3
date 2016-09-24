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

private _class = _this;

private _result = (isClass (configfile >> "CfgWeapons" >> _class)
|| (isClass (configFile >> "CfgMagazines" >> _class))
|| (isClass (configFile >> "CfgGlasses >> _class"))
|| (isClass (configFile >> "CfgVehicles" >> _class))
);

if (!_result) then {
    if (!isMultiplayer) then {
        "Invalid classname given! - " + _class call FNC_DebugMessage;
    };
    [_class, {
        params ["_class"];
        private _msg = "Framework has detected an invalid classname - " + str _class + "! Mission will continue but some parts of gear will be missing.";
        systemChat _msg;
        diag_log _msg;
        hint _msg;
    }] remoteExec ["BIS_fnc_call", 0, true];
};

_result