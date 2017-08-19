private ["_unit", "_id", "_fortIndex"];
_unit = _this select 0;
_id = _this select 2;
_fortIndex = _this select 3 select 0;
[_unit, _id, _fortIndex] call plank_deploy_fnc_startFortPlacement;