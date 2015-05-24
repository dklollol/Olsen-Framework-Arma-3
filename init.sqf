asr_ai3_main_setskills = 0; //Stops ASR from changing the skill of the AI

#include "core\dia\endscreen\dia_debug.sqf" //DO NOT REMOVE
#include "core\init.sqf" //DO NOT REMOVE
#include "customization\settings.sqf" //DO NOT REMOVE

if (isServer) then {

	COUNTUNITS(STARTCOUNT); //DO NOT REMOVE

	[] spawn { //Spawns code running in parallel
	
		while {!FW_MissionEnded} do { //Loops while the mission is not ended
			
			COUNTUNITS(CURRENTCOUNT); //DO NOT REMOVE
			
			#include "customization\endConditions.sqf" //DO NOT REMOVE
			
		};	
	};
};

#include "modules\modules.sqf" //DO NOT REMOVE
#include "core\postChecks.sqf" //DO NOT REMOVE