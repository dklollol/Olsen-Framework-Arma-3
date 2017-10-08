/*
 * Author: Sacher
 *
 * Spawns a AI Unit
 *
 * Arguments:
 * 0: group <group>
 * 1: className <String>
 * 2: Position <Pos>
 * Return Value:
 * unit Spawned <object>
 *
 * Public: Yes
 */

private _unit = (_this select 0) createUnit [(_this select 1),(_this select 2), [], 0, "NONE"];
if(!isNil "aCount_addEH") then { ["aCount_event_addEH", _unit] call CBA_fnc_serverEvent};
_unit call FNC_trackUnit;
_unit
