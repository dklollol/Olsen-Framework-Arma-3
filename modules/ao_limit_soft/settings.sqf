//This module allows you to setup side based AO limitations. 
//The AO limits can be connected and units can move freely between them as long as their side corresponds with the AO limits side.
//A unit is only limited by the AO limit if the unit spawns inside it, and the units side corresponds with the AO limits side.
//If a unit crash landed outside the AO limit, or a squad is deployed outside the AO limit they are allowed to enter the AO limit but cannot exit.

// The amount of time in seconds a land based unit is allowed to stay outside the AO (-1 = Infinity)
FW_AOTimer = 30;
// The amount of time in seconds an air based unit is allowed to stay outside the AO (-1 = Infinity)
FW_AOTimerAir = -1;

//ADDAOMARKER(SIDE, NAME)
//SIDE is the side of the AO marker, NAME is the name of the AO marker.
//If you want all teams to have this AO limit use ANY.

//Example:
//ADDAOMARKER(ANY, "entireAO");
//ADDAOMARKER(east, "Kavala");
