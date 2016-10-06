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

    cutText ["\n", "BLACK", 0.01, true];
    ["FW_death", 0, true] call ace_common_fnc_setHearingCapability;
    0 fadeSound 0;
    sleep 2.5;
    
    ["<t color='#FF0000'>YOU ARE DEAD</t>", 0, 0.4, 1.5, 0.5, 0, 1000] spawn BIS_fnc_dynamicText;
    
    sleep 2.5;
    cutText ["\n", "PLAIN", 0, true];
    ["FW_death", 0, false] call ace_common_fnc_setHearingCapability;
    0 fadeSound 1;

};