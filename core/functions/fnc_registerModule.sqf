/*
 * Author: Olsen
 *
 * Add module to list.
 *
 * Arguments:
 * 0: name <string>
 * 1: description <string>
 * 2: author <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

params ["_name", "_description", "_author"];

FW_Modules set [count FW_Modules, [_name, _description, _author]];