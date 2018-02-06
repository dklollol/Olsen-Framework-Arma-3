/*
 * Author: Olsen
 *
 * Initialize tracking of unit.
 *
 * Arguments:
 * 0: unit to track <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

private _unit = _this;

if (!(_unit getVariable ["FW_Tracked", false])) then {

	_unit setVariable ["FW_Side", side _unit];
	_unit setVariable ["FW_Tracked", true];

	_unit call FNC_EventSpawned;

};