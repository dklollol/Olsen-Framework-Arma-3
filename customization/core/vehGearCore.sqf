#define random(MIN, MAX) \
([MIN, MAX] call FNC_RandomRange)

private ["_vehicle", "_type"];

_vehicle = _this select 0;
_type = _this select 1;

if (!local _vehicle) exitWith {};

FNC_AddItemVehicle = {([_vehicle, _type] + _this) call FNC_AddItemVehicleOrg;};
FNC_AddItemVehicleRandom = {([[_vehicle, _type]] + [_this]) call FNC_AddItemVehicleRandomOrg;};