_westCasualty = "USMC" call FNC_CasualtyPercentage; //Gets the casualty percentage of team "USMC"
_eastCasualty = "VDV" call FNC_CasualtyPercentage; //Gets the casualty percentage of team "VDV"

if (_westCasualty >= 50) exitWith {
	
	"VDV DECISIVE VICTORY<br />USMC has retreated due to casualties." call FNC_EndMission;
	
};

if (_eastCasualty >= 75) exitWith {
	
	"USMC DECISIVE VICTORY<br />VDV has retreated due to casualties." call FNC_EndMission;
	
};

sleep (60); //This determines how frequently the end conditions should be checked in seconds