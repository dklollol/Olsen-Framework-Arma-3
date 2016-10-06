#ifdef description
	
	#include "dia\rscdefinitions.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load
	#include "dia\endscreen\dia_endscreen.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load

	respawn = "BASE"; //Do not change, spectator script needs people to respawn, to be declared as dead and put into spectator mode
	respawndelay = 5; //5 seconds are needed to make sure people properly die and go into spectator
	disabledAI = 1; //disabledAI does so not slotted units do not spawn as ai
	respawnButton = 1; //Disables the respawn button
	respawnDialog = 0; //Disables the score screen while respawning
    respawnTemplates[] = {"Base"}; //Disables respawn countdown
    enableDebugConsole = 1; //Only for logged-in admins

	class Extended_PreInit_EventHandlers {
		
		class Mission {
		
			init = "'' call compile preprocessFileLineNumbers 'preinit.sqf'; FNC_GearScript = compile preprocessFileLineNumbers 'customization\gear.sqf'; FNC_VehicleGearScript = compile preprocessFileLineNumbers 'customization\vehGear.sqf';"; //Compiles the gear script for the server and client
		
		};
	};
	
#endif
	
#ifdef description_titles
	
	#include "dia\debug\dia_debug.hpp" //Must have for the end screen to work, if removed Arma 3 will crash on mission load

#endif
