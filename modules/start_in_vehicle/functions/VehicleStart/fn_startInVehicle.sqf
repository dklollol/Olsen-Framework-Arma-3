//check if mission is live or not
_jiptime = 30;
if (!isNil "FW_JIPDENYTIME") then {
	_jiptime = FW_JIPDENYTIME;
};

_unit = player;
_var = _unit getvariable "StartInVehicle";
if (time > _jiptime) exitwith {};
if (isNil "_var") exitwith {};
if (count "_var" <= 0) exitwith {};
_var params ["_vehicle",["_seattype","ANY"],["_seatindex",0]];

[_unit,_vehicle,_seattype,_seatindex] call StartInVehicle_fnc_moveInVehicle;