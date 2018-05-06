//this module by default teleports people into vehicles at the start of the mission and leaves JIPs at the start area in order
//to be teleported with the jipteleport module. Spawn someone in a vehicle at the start using
//this setvariable ["StartInVehicle",[VEHICLENAME,SEATTYPE,SEATINDEX]];
//this setvariable ["StartInVehicle",[boat1,"cargo",0]];
//SEATTYPE is either "driver" "gunner" "turret" "cargo" "commander". If none is listed it will put the player in any slot it finds.
//SEATINDEX is the index number of the intended seat. If none is listed, it will default to 0.
//see https://community.bistudio.com/wiki/moveInTurret when using moveinturret for vehicles with multiple turrets
//you can check full crew listing on a vehicle with https://community.bistudio.com/wiki/fullCrew : _arrayofslots = fullCrew [vehicle player,"",true];
//You can also ignore specific seat loadout and simply use this setvariable ["StartInVehicle",[VEHICLENAME]; to fill all positions
//starting with the crew and then loading the cargo slots
