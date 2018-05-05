["Cover Map", "Covers map except specified area, allows switching between multiple AOs", "Blackhawk &amp; PIZZADOX"] call FNC_RegisterModule;

#include "settings.sqf"
//contains _AOMarkers array

//initial marker array define
FW_map_cover = [];
FW_map_currentAO = 0;

CBA_LoadedIntoMission = false;



//in game map cover and center
["CBA_loadingScreenDone", {
	CBA_LoadedIntoMission = true;
    _thisArgs call CoverMap_fnc_CoverMapLive;
}, (_AOMarkers select 0)] call CBA_fnc_addEventHandlerArgs;

//make all AOmarkers invisible
{
	(_x select 0) setMarkerAlphaLocal 0;
} foreach _AOMarkers;

//briefing map cover and center
if (!CBA_LoadedIntoMission) then {
	(_AOMarkers select 0) call CoverMap_fnc_CoverMapBriefing;
};

//[{((getClientStateNumber >= 10) && (alive player) && (!isNull player) && (missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]] isEqualTo []) && (!isNull (call BIS_fnc_displayMission)))}, {
//	(_AOMarkers select 0) call CoverMap_fnc_CoverMapLive;
//}, [_AOMarkers]] call CBA_fnc_waitUntilAndExecute;

//Add self interact option on map to switch AOs
if (count _AOMarkers > 1) then {
	[{CBA_LoadedIntoMission}, {
		params ["_AOMarkers"];
		private _MapChangeMenu = ["MapChangeMenu", "Switch Map", "", {}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","ACE_Equipment"], _MapChangeMenu] call ace_interact_menu_fnc_addActionToObject;
		{
			call compile format ["
				private _MapChangeAction%1 = ['switch_MapAO', 'Switch Map to %2', '', {%4 call FNC_AOCoverAndCenterMap;}, {(visibleMap) && (FW_map_currentAO != %3) && (player getvariable ['HasAltMaps',false])}] call ace_interact_menu_fnc_createAction;
				[player, 1, ['ACE_SelfActions','ACE_Equipment','MapChangeMenu'], _MapChangeAction%1] call ace_interact_menu_fnc_addActionToObject;
			",_forEachIndex,_x select 3,_x select 4,_x];
		} foreach _AOMarkers;
	}, [_AOMarkers]] call CBA_fnc_waitUntilAndExecute;
};


