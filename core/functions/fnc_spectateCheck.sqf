/*
 * Author: Olsen
 *
 * Locally displays the appropriate message when the player dies.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */


if (FW_RespawnTickets > 0) then {

	["<br/>You are dead.<br/><br/>Respawning...", 0, 0.2, 2.5, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;

} else {

	player setVariable ["FW_Dead", true, true]; //Tells the framework the player is dead



};