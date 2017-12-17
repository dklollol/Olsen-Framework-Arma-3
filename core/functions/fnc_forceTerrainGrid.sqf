/*
 * Author: BlackHawk
 *
 * Force terrain grid to prevent far away objects from appearing as floating.
 * Useful for mission with long engagement ranges.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

FW_terrainGridPFH_handle = [{
	if (time > 0 && {getTerrainGrid != 2}) then {
		setTerrainGrid 2;
	};
}, 1] call CBA_fnc_addPerFrameHandler;