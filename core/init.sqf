#include "definitions.sqf" //DO NOT REMOVE
#include "functions.sqf" //DO NOT REMOVE

enableSaving [false, false];

if (isServer) then {
	
	"west" call FNC_CreateRespawnMarker;
	"east" call FNC_CreateRespawnMarker;
	"guerrila" call FNC_CreateRespawnMarker;
	"civilian" call FNC_CreateRespawnMarker;
	
	FW_Teams = []; //DO NOT REMOVE
	STARTCOUNT = []; //DO NOT REMOVE
	CURRENTCOUNT = []; //DO NOT REMOVE
	FW_MissionEnded = false; //Mission has not ended
	
};

if (!isDedicated) then {

	//Anything done using "player" must be past this line for JIP compatibility
	waitUntil {!(isNull player)};
	
	//"endScreen" player event sends the received variables to the end screen
	["endScreen", {_this execVM "core\dia\endscreen\dia_endscreen.sqf";}] call CBA_fnc_addEventHandler;
	
	//Various settings
	enableEngineArtillery false; //Disable Arma 3 artillery computer
	enableRadio false; //Disable Arma 3 regular radio
	enableSentences false; //Disable Arma 3 regular radio chatter
	0 fadeRadio 0; //Lower radio volume to 0
	
	//Creates the briefing notes for the player
	[] execVM "customization\briefing.sqf";
	
	respawnTickets = 0; //Initialize respawn tickets to 0 
	
	player setVariable ["frameworkDead", false, true]; //Tells the framework the player is alive
	player setVariable ["frameworkSpectating", false, true]; //Player is not spectating
	player setVariable ["frameworkBody", player, true]; //Remembers his old body for spectating his dead body
	
	//Makes the player go into spectator mode when dead or respawn if he has respawn tickets
	killedEh = player addEventHandler ["Killed", {"" call FNC_SpectateCheck}];
	respawnEh = player addEventHandler ["Respawn", {"" call FNC_SpectatePrep;}];
	
	//Various settings
	player addRating 100000; //Makes sure ai doesnt turn hostile when teamkilling
	player setVariable ["BIS_noCoreConversations", true]; //Disable scroll wheel conversations
	
};