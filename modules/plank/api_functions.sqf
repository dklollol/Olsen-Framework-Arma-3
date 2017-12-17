#include "plank_macros.h"

/**
 * Removes all fortifications, including the one currently being placed, from a unit.
 * Closes the currently open dialog aswell.
 * @param _unit The unit to remove the fortifications from
 */
plank_api_fnc_forceRemoveAllFortifications = {
	FUN_ARGS_1(_unit);

	[_unit] call plank_delpoy_fnc_forceRemoveAllFortifications;
};

/**
 * Adds fortifications to a unit. Removes all previous fortifications, including the one currently being placed.
 * @param _unit The unit to give fortifications to
 * @param _fortifications An array of number of fortifications, [<number of 1. fort>, <number of 2. fort>, ..., <number of n. fort>]
 *			  Fortifications are found in modules\plank\armaX_fortifications.sqf
 */
plank_api_fnc_forceAddFortifications = {
	FUN_ARGS_2(_unit,_fortifications);

	[_unit, _fortifications] call plank_deploy_fnc_init;
};