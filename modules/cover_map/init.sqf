["Cover Map", "Covers map except specified area, allows switching between multiple AOs", "Blackhawk &amp; PIZZADOX"] call FNC_RegisterModule;

if (hasinterface) then {

	["CBA_loadingScreenDone", {
		CBA_LoadedIntoMission = true;
	}] call CBA_fnc_addEventHandler;
	
	//contains _AOMarkers array
	#include "settings.sqf"
	
	if (isNil "CBA_LoadedIntoMission") then {
		CBA_LoadedIntoMission = false;
	};
	
	//make all AOmarkers invisible
	{
		(_x select 0) setMarkerAlphaLocal 0;
	} foreach _AOMarkers;
	
	//initial marker array define
	FW_map_cover = [];
	FW_map_currentAO = 0;
	
	//briefing map cover and center
	(_AOMarkers select 0) call CoverMap_fnc_CoverMapBriefing;
	
	[_AOMarkers] spawn {
		params ["_AOMarkers"];
		waituntil {visibleMap};
		(_AOMarkers select 0) call CoverMap_fnc_CoverMapLive;
		
		//Add self interact option on map to switch AOs
		if (count _AOMarkers > 1) then {
			params ["_AOMarkers"];
			private _MapChangeMenu = ["MapChangeMenu", "Switch Map", "", {}, {true}] call ace_interact_menu_fnc_createAction;
			[player, 1, ["ACE_SelfActions","ACE_Equipment"], _MapChangeMenu] call ace_interact_menu_fnc_addActionToObject;
			{
				call compile format ["
					private _MapChangeAction%1 = ['switch_MapAO', 'Switch Map to %2', '', {%4 call CoverMap_fnc_CoverMapLive;}, {(visibleMap) && (FW_map_currentAO != %3) && (player getvariable ['HasAltMaps',false])}] call ace_interact_menu_fnc_createAction;
					[player, 1, ['ACE_SelfActions','ACE_Equipment','MapChangeMenu'], _MapChangeAction%1] call ace_interact_menu_fnc_addActionToObject;
				",_forEachIndex,_x select 3,_x select 4,_x];
			} foreach _AOMarkers;
		};
	};
	
};