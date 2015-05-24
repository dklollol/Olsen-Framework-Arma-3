if (isServer) then { //This scope is only for the server

	setViewDistance 2500; //View distance for the server (the ai's)

	timeLimit = 30; //Time limit in minutes

	[west, "USMC"] call FNC_AddPlayableTeam; //Adds a player team called USMC on side west
	[east, "VDV"] call FNC_AddAiTeam; //Adds a ai team called VDV on side east
	
	// [resistance, "Local Militia"] call FNC_AddPlayableTeam; //Adds a player team called Local Militia on side resistance (aka independent)

};

if (!isDedicated) then { //This scope is only for the player

	setViewDistance 2500; //View distance for the player
	
	switch (side player) do { //Checks what team the player is on

		case west: { //If player is west he receives this respawn ticket count
			
			respawnTickets = 0;
			
		}; //End of west case
		
	}; //End of switch
	
};