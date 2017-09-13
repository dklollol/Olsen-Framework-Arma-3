/*
 * Author: Sacher
 *
 * Spawns a Vehicle
 *
 * Arguments:
 * 0: className <String>
 * 1: Position <Pos>
 * Return Value:
 * unit Spawned <object>
 *
 * Public: Yes
 */

private _unit =(_this select 0) createVehicle (_this select 1);
if(!isNil "aCount_addEH") then { ["aCount_event_addEH", _unit] call CBA_fnc_serverEvent};
_unit
