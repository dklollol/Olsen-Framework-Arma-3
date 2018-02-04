/*
 * Author: Olsen
 *
 * If unit respawns as playable, register it spawning, if respawns as spectator, stop tracking.
 *
 * Arguments:
 * 0: unit to track <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

private _new = _this select 0;

if (!(_new getVariable "FW_Dead")) then {

	_new call FNC_EventSpawned;

} else {

	_new call FNC_UntrackUnit;

};