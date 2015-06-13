/*
	Task Control Module by Briland
	V1.0
	This module allows easy control of local ARMA 3 task in a multiplayer environment.

	ADD a task with:
	ADDTASK(TARGET, POSITION, TITLE, DESCRIPTION, WPTITLE);
	
	TARGET is who you want to see the task, can be a SIDE (west, east, etc.) or a GROUP
	POSITION is the location the task will be set to. It can be an object (unit or gamelogic or vehicle) or a position (getmarkerpos "marker1"). If you don't want a marker on the map use: objNull
	TITLE is what you want the task to be called and is used to refrence what task you want to edit in this file.
	DESCRIPTION is the detailed description of the task, this can be as long as you want it to be.
	WPTITLE the title of the task as it shows up on the map.
	

	Update a task with:
	COMPLETETASK(TITLE);  	// sets the task to Succeeded
	FAILTASK(TITLE);		// sets the task to Failed
	CANCELTASK(TITLE);		// sets the task to Canceled
	RESETTASK(TITLE);		// sets the task to outstanding but not currently assigned
	ASSIGNTASK(TITLE);		// sets the task to currently Assigned
	REMOVETASK(TITLE);		// removes the task from the task list. THIS IS NOT RECCOMENDED TO BE USED. YOU SHOULD USE FAILED OR CANCELED INSTEAD

	TITLE is the same as the title you set when you added the task.

	GET a task's current state with:
	_state = [TITLE] call FNC_GETTASKSTATE;

	EXAMPLE:
	ADDTASK(west, obj1, "Objective 1", "Go to this point and Destroy Objective #1 with the explosive charges that your engineers have.", "OBJ 1");
	ASSIGNTASK("Objective 1");							// make objective 1 the active objective

	while {!FW_MissionEnded} do {						// Loops while the mission is not ended
		sleep 30; 										// sleep for optimisation
		if (!(alive obj1_building)) exitwith {			// when obj1_building is no longer alive 
			COMPLETETASK("Objective 1");				// Complete the first objective
			ADDTASK(west, position airfield, "Return to Base", "Good job return to BASE!", "RTB"); // Assigned the RTB objective
			ASSIGNTASK("Return to Base");				// make the RTB objective the active objective
		};
	};
*/

ADDTASK(west, obj1, "Objective 1", "Go to this point and Destroy Objective #1 with the explosive charges that your engineers have.", "OBJ 1");
ASSIGNTASK("Objective 1");	