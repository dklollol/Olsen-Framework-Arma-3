/*
 * Author: Olsen
 *
 * Starts tracking all units, except ones with FW_DontTrack set to true.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

{

	if (!(_x getVariable ["FW_DontTrack", false])) then {

		_x call FNC_TrackUnit;

	};

} forEach allUnits;