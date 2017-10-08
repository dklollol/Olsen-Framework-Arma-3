PREP(getTeamVariable);
PREP(setTeamVariable);
PREP(eventKilled);
PREP(eventPlayerSpawned);
PREP(eventSpawned);
PREP(eventRespawned);
PREP(eventDisconnect);
PREP(trackUnit);
PREP(untrackUnit);
PREP(StartingCount);
PREP(stackNames);
PREP(getDamagedAssets);
PREP(createRespawnMarker);
PREP(inArea);
PREP(areaCount);
PREP(endMission);
PREP(casualtyPercentage);
PREP(casualtyCount);
PREP(alive);
PREP(hasEmptyPositions);
PREP(inVehicle);
PREP(addTeam);
PREP(spectateCheck);
PREP(spectatePrep);
PREP(countTeam);
PREP(spawnAI);
PREP(spawnVehicle);
PREP(hasExtracted);

enableSaving [false, false];

if (isServer) then {

	"west" call FNC_CreateRespawnMarker;
	"east" call FNC_CreateRespawnMarker;
	"guerrila" call FNC_CreateRespawnMarker;
	"civilian" call FNC_CreateRespawnMarker;

	FW_Teams = []; //DO NOT REMOVE
	FW_MissionEnded = false; //Mission has not ended

	FW_EventPlayerSpawnedHandle = ["FW_PlayerSpawned", {_this call FNC_EventPlayerSpawned;}] call CBA_fnc_addEventHandler;
	FW_EventRespawnedHandle = addMissionEventHandler ["EntityRespawned", {_this call FNC_EventRespawned;}];
	FW_EventKilledHandle = addMissionEventHandler ["EntityKilled", {_this call FNC_EventKilled;}];

	FW_EventDisconnectHandle = addMissionEventHandler ["HandleDisconnect", {_this call FNC_EventDisconnect;}];

};

if (!isDedicated) then {

	//Anything done using "player" must be past this line for JIP compatibility
	waitUntil {!(isNull player)};

	if (!isServer) then {

		//Tells the server the player has spawned
		["FW_PlayerSpawned", player] call CBA_fnc_serverEvent;

	};

	//"FW_EndMission" player event sends the received variables to the end screen
	FW_EndMissionEh = ["FW_EndMission", {_this execVM "core\dia\endscreen\dia_endscreen.sqf";}] call CBA_fnc_addEventHandler;

	//Various settings
	enableEngineArtillery false; //Disable Arma 3 artillery computer
	enableRadio false; //Disable Arma 3 regular radio
	enableSentences false; //Disable Arma 3 regular radio chatter
	0 fadeRadio 0; //Lower radio volume to 0

	//Creates the briefing notes for the player
	"" call FNC_Briefing;
	"" call FNC_Menu;

	FW_RespawnTickets = 0; //Initialize respawn tickets to 0

	player setVariable ["FW_Dead", false, true]; //Tells the framework the player is alive
	player setVariable ["FW_Spectating", false, true]; //Player is not spectating
	player setVariable ["FW_Body", player, true]; //Remembers his old body for spectating his dead body

	//Makes the player go into spectator mode when dead or respawn if he has respawn tickets
	FW_KilledEh = player addEventHandler ["Killed", {"" spawn FNC_SpectateCheck;}];
	FW_RespawnEh = player addEventHandler ["Respawn", {_this call FNC_SpectatePrep;}];

	//Various settings
	player addRating 100000; //Makes sure ai doesnt turn hostile when teamkilling
	player setVariable ["BIS_noCoreConversations", true]; //Disable scroll wheel conversations

};
