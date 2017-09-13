/*
 * Author: Sacher
 *
 * Spawns a Vehicle, if side is defined it will try to track it
 *
 * Arguments:
 * 0: className <String>
 * 1: Position <Pos>
 * 2: side <side>
 * Return Value:
 * unit Spawned <object>
 *
 * Public: Yes
 */

private _unit =(_this select 0) createVehicle (_this select 1);
if(!isNil "aCount_addEH") then { ["aCount_event_addEH", _unit] call CBA_fnc_serverEvent};
if (_unit getVariable ["FW_AssetName", ""] == "" && (count _this >= 3)) then
{
  {
    if (_x select 1 == (_this select 2)) exitWith {
      _vehCfg = (configFile >> "CfgVehicles" >> (typeOf _unit));
      if (isText(_vehCfg >> "displayName")) then
      {
        [_unit, getText(_vehCfg >> "displayName"), _x select 0] call FNC_TrackAsset;
      };
    };
  } forEach FW_Teams;
};
_unit
