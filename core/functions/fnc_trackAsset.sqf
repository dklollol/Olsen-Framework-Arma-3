/*
 * Author: Olsen
 *
 * Assigns name and team info to an asset.
 *
 * Arguments:
 * 0: asset <object>
 * 1: name <string>
 * 2: team <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

params [
	["_asset", objNull, [objNull]],
	["_name", "", [""]],
	["_team", "", [""]]
];

private _asset = vehicle (_asset);

_asset setVariable ["FW_AssetName", _name];

_asset setVariable ["FW_AssetTeam", _team];