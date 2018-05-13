//This module covers the area on the map outside of the AO Marker. The first AO marker in the array is the initial AO shown to all players. 
//Specific units can be given the ability to switch AOs with this setvariable ["HasAltMaps",true]; 
//You can script an AO change using [MARKERNAMEINQUOTES,ISCENTERED,ZOOMLEVEL,NAME VISIBLE IN SELF INTERACT, AO NUMBER] call FNC_AOCoverAndCenterMap;
//You could have different groups/teams with different AOs, or a briefing AO different from specific AOs in game if needed.

//_AOMarkers = [MARKERNAMEINQUOTES,ISCENTERED,ZOOMLEVEL,NAME VISIBLE IN SELF INTERACT, AO NUMBER];
//_AOMarkers = [["AOMarker_1",true,0.4,"Bahnhof",1]];
_AOMarkers = [["AOMarker_1",true,0.4,"AO",1]];
