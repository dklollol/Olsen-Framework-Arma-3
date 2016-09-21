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

("BIS_layerEstShot" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];

sleep 0.4;

playSound "Simulation_Fatal";
call BIS_fnc_VRFadeOut;

sleep 1;

playSound ("Transition" + str (1 + floor random 3));

sleep 1;

if (FW_RespawnTickets > 0) then {

    ["<br/>You are dead.<br/><br/>Respawning...", 0, 0.2, 2.5, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;

} else {

    player setVariable ["FW_Dead", true, true]; //Tells the framework the player is dead

    ["<br/>You are dead.<br/><br/>Entering spectator mode...", 0, 0.2, 2.5, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;

};