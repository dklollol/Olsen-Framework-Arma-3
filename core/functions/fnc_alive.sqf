/*
 * Author: Olsen
 *
 * Checks if unit is considered alive by framework
 *
 * Arguments:
 * 0: unit <object>
 *
 * Return Value:
 * is alive <bool>
 *
 * Public: Yes
 */

private _unit = _this;

(alive _unit) && !(_unit getVariable ["FW_Dead", false])