#include "core\vehGearCore.sqf" //DO NOT REMOVE

switch (_type) do {

	case "HUMMVEE": {

		_vehicle call FNC_RemoveAllVehicleGear;

		["30Rnd_556x45_Stanag", 8] call FNC_AddItemVehicle;
		["rhs_weap_m4a1_carryhandle"] call FNC_AddItemVehicle;

	};
};