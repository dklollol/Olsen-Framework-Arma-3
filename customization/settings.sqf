asr_ai3_main_setskills = 0; //Stops ASR from changing the skill of the AI

if (isServer) then { //This scope is only for the server

	setViewDistance 2500; //View distance for the server (the ai's)

	FW_TimeLimit = 30; //Time limit in minutes

	[west, "USMC", "player"] call FNC_AddTeam; //Adds a player team called USMC on side west
	[east, "VDV", "ai"] call FNC_AddTeam; //Adds a ai team called VDV on side east
	
	// [resistance, "Local Militia", "player"] call FNC_AddTeam; //Adds a player team called Local Militia on side resistance (aka independent)

};

if (!isDedicated) then { //This scope is only for the player

	FW_DebugMessagesEnabled = true;//Only disable debug messages when the mission is released

	setViewDistance 2500; //View distance for the player
	
	switch (side player) do { //Checks what team the player is on

		case west: { //If player is west he receives this respawn ticket count
			
			FW_RespawnTickets = 0;
			
		}; //End of west case
	}; //End of switch
};