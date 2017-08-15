/*
 * Author: Olsen
 *
 * Adds new team.
 *
 * Arguments:
 * 0: side of new team <side>
 * 1: name of new team <string>
 * 2: type of new team: "ai"/"player" <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

params [
    ["_side", sideUnknown, [sideUnknown]],
    ["_name", "Unknown", [""]],
    ["_type", "ai", [""]]
];

if (isMultiplayer) then {

    FW_Teams set [count FW_Teams, [_name, _side, _type,  0, 0, [], []]];

} else {

    FW_Teams set [count FW_Teams, [_name, _side, "ai",  0, 0, [], []]];

};