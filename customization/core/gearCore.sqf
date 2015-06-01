#define random(MIN, MAX) \
([MIN, MAX] call FNC_RandomRange)

private ["_unit", "_type"];

_unit = _this select 0;
_type = _this select 1;

if (!local _unit) exitWith {};

_unit setVariable ["BIS_enableRandomization", false];
_unit setVariable ["FW_Loadout", _type, true];

removeHeadgear _unit;
removeGoggles _unit;
removeVest _unit;
removeBackpack _unit;
removeUniform _unit;
removeAllWeapons _unit;
removeAllAssignedItems _unit;

FNC_AddItem = {([_unit, _type] + _this) call FNC_AddItemOrg;};
FNC_AddItemRandom = {([[_unit, _type]] + [_this]) call FNC_AddItemRandomOrg;};