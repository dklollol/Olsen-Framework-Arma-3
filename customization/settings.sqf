if (isServer) then { //This scope is only for the server

	setViewDistance 2500; //View distance for the server (the ai's)

	timeLimit = 30; //Time limit in minutes

	ADDPLAYABLETEAM(west, "USMC"); //Adds a player team called USMC on side west
	ADDAITEAM(east, "VDV"); //Adds a ai team called VDV on side east

};

if (!isDedicated) then { //This scope is only for the player

	setViewDistance 2500; //View distance for the player
	
	switch (side player) do { //Checks what team the player is on

		case west: { //If player is west he receives this respawn ticket count
			
			respawnTickets = 0;
			
		}; //End of west case
		
	}; //End of switch
	
};