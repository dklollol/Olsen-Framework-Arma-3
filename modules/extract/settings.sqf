/*

FNC_Extract syntax:

[arguments] call FNC_Extract;

Arguments:
1. STRING: Helicopter Classname.
2. STRING/OBJECT: markerName/object where the helicopter should be spawned.
3. NUMBER: Altitude at which the helicopter should fly.
4. STRING/OBJECT: markerName/object where the helicopter should land.
5. SIDE/OBJECT/ARRAY/STRING: If this is a side the helicopter will wait for all playable units from this side to be mounted, same for object and same for array, you can also use a string containing code to have custom conditions.
6. STRING/OBJECT: markerName/object where the helicopter should go when taking off.
7. Optional STRING: String of code to be executed when the helicopter spawns. (Use _this to run commands on the spawned helicopter).

Note: Although the script is supposed to work with helicopters, you can use ground vehicles too.

Exemples:
["B_Heli_Transport_01_F", "spawnMarker", 15, helipad1, playableUnits, "extractMarker"] call FNC_Extract; // In this situation the helicopter will wait for ALL players to be mounted.
["B_Heli_Transport_01_F", "spawnMarker", 15, helipad1, playableUnits + [hostage], "extractMarker"] call FNC_Extract; // In this situation the helicopter will wait for ALL players AND the hostage to be mounted.
["B_Heli_Transport_01_F", "spawnMarker", 15, helipad1, east, "extractMarker"] call FNC_Extract; // In this situation the helicopter will wait for ALL OPFOR players to be mounted.
["B_Heli_Transport_01_F", "spawnMarker", 15, helipad1, playableUnits, "extractMarker", "_this setDamage 1;"] call FNC_Extract; // In this situation the helicopter will blow-up when spawned.
["B_Heli_Transport_01_F", "spawnMarker", 15, helipad1, "_this emptyPositions 'cargo' == 0", "extractMarker"] call FNC_Extract; // In this situation the helicopter will wait until it is full.

Note: Keep in mind that the script does not wait for dead units to be mounted.

 */