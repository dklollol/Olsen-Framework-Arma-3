private ["_vehicle", "_type"];

_vehicle = _this select 0;
_type = _this select 1;

if (!local _vehicle) exitWith {};

clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

FNC_AddItemVehicle = {([_vehicle] + _this) call FNC_AddItemVehicleOrg;};