//ace_cookoff_enable = false; //this disables cookoff fire effect
//ace_cookoff_enableAmmoCookoff = false; //this disables secondary explosions

if (isServer) then {

	setViewDistance 2500; //View distance for the server (the ai's)

	FW_TimeLimit = 30; //Time limit in minutes, to disable the time limit set it to 0
	FW_TimeLimitMessage = "TIME LIMIT REACHED!"; //The message displayed when the time runs out

	[west, "USMC", "player"] call FNC_AddTeam; //Adds a player team called USMC on side west
	[east, "VDV", "ai"] call FNC_AddTeam; //Adds a ai team called VDV on side east
	
	// [resistance, "Local Militia", "player"] call FNC_AddTeam; //Adds a player team called Local Militia on side resistance (aka independent)

	//Ticket pools for different sides
	FW_RespawnTicketsWest = 0;
	publicVariable "FW_RespawnTicketsWest";
	FW_RespawnTicketsEast = 0;
	publicVariable "FW_RespawnTicketsEast";
	FW_RespawnTicketsInd = 0;
	publicVariable "FW_RespawnTicketsInd";
	FW_RespawnTicketsCiv = 0;
	publicVariable "FW_RespawnTicketsCiv";

	//wave respawn
	FW_WaveSizeWest = 0; //How many players have to respawn before wave is released
	FW_WaveSizeEast = 0;
	FW_WaveSizeInd = 0;
	FW_WaveSizeCiv = 0;

	//Players should be put in enclosed space, when their number reaches treshold, the defined "gate" will disappear for 30 seconds
	//FW_RespawnPenGateWest = YourEditorObjectName;
	//FW_RespawnPenGateEast = YourEditorObjectName;
	//FW_RespawnPenGateInd = YourEditorObjectName;
	//FW_RespawnPenGateCiv = YourEditorObjectName;
};

if (!isDedicated) then {

	FW_DebugMessagesEnabled = true; //Only disable debug messages when the mission is released

	setViewDistance 2500; //View distance for the player

	//call FNC_forceTerrainGrid; //uncomment this to force high terrain setting. This will prevent faraway objects from appearing as floating. Useful for missions with long sightlines.
	
	switch (side player) do { //Checks what team the player is on
		case west: {
			FW_RespawnTickets = 0; //If respawn is enabled you must create empty game logics, for respawn points, following the name format fw_side_respawn. Example: fw_west_respawn
		};
		//add more cases for other factions here
	};
};