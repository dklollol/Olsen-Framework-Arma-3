#include "dia\rscdefinitions.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load
#include "dia\endscreen\dia_endscreen.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load
#include "dia\endscreen\dia_debug.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load

respawn = "BASE"; //Do not change, spectator script needs people to respawn, to be declared as dead and put into spectator mode
respawndelay = 5; //5 seconds are needed to make sure people properly die and go into spectator
disabledAI = 1; //disabledAI does so not slotted units do not spawn as ai
respawnButton = 0; //Disables the respawn button
respawnDialog = 0; //Disables the score screen while respawning

class Extended_PreInit_EventHandlers {
	class Mission {
		init = "GEARSCRIPT = compile preprocessFileLineNumbers 'customization\gear.sqf'; VEHGEARSCRIPT = compile preprocessFileLineNumbers 'customization\vehGear.sqf'; TRACKASSET = compile preprocessFileLineNumbers 'core\trackAsset.sqf'"; //Compiles the gear script for the server and client
	};
};