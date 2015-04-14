#include "definitions.sqf" //DO NOT REMOVE
#include "functions.sqf" //DO NOT REMOVE

enableSaving [false, false];

if (isServer) then {
	
	CREATERESPAWNMARKER("respawn_west");
	CREATERESPAWNMARKER("respawn_east");
	CREATERESPAWNMARKER("respawn_guerrila");
	CREATERESPAWNMARKER("respawn_civilian");
	
	FW_TEAMS = []; //DO NOT REMOVE
	STARTCOUNT = []; //DO NOT REMOVE
	CURRENTCOUNT = []; //DO NOT REMOVE
	FW_MISSION_ENDED = false; //Mission has not ended
	
};

if (!isDedicated) then {

	//Anything done using "player" must be past this line for JIP compatibility
	waitUntil {!(isNull player)};
	
	//"endScreen" player event sends the received variables to the end screen
	["endScreen", {_this execVM "core\dia\endscreen\dia_endscreen.sqf";}] call CBA_fnc_addEventHandler;
	
	//Various settings
	enableEngineArtillery false; //Disable arma 3 artillery computer
	enableRadio false;
	0 fadeRadio 0; //Lower radio volume to 0
	
	//Creates the briefing notes for the player
	[] execVM "customization\briefing.sqf";
	
	respawnTickets = 0;
	
	player setVariable ["frameworkDead", false, true]; //Tells the framework the player is alive
	
	spectating = false; //Player is not spectating
	
	//Makes the player go into spectator mode when dead
	killedEh = player addEventHandler ["Killed", {[player] execVM "core\spectatePrep.sqf";}];
	
	//Various settings
	player addRating 100000; //Makes sure ai doesnt turn hostile when teamkilling
	player setVariable ["BIS_noCoreConversations", true]; //Disable scroll wheel conversations
	
};