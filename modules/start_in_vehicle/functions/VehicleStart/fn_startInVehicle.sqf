//check if mission is live or not
params ["","_didJIP"];

if (_didJIP) then {
	if (time > FW_JIPDENYTIME) exitwith {};
};

_unit = player;
_var = _unit getvariable ["StartInVehicle",nil];
if (isNil "_var") exitwith {};
if (count "_var" <= 0) exitwith {};
_var params ["_vehicle",["_seattype","ANY"],["_seatindex",0]];

[_unit,_vehicle,_seattype,_seatindex] call StartInVehicle_fnc_moveInVehicle;