/*
 * Author: Olsen
 *
 * Disable tracking of unit by framework.
 * Unit will be ignored in casualty count etc.
 *
 * Arguments:
 * 0: unit to not track <object>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

private _unit = _this;

if (isServer) then {

    _unit setVariable ["FW_DontTrack", true];

};