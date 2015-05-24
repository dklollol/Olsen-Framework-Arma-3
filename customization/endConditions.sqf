_westCasualty = "USMC" call FNC_CasualtyCheck; //Gets the casualty percentage of team "USMC"
_eastCasualty = "VDV" call FNC_CasualtyCheck; //Gets the casualty percentage of team "VDV"

if (_westCasualty >= 50) exitWith {
	"VDV DECISIVE VICTORY<br />USMC has retreated due to casualties." call FNC_EndMission;
};

if (_eastCasualty >= 75) exitWith {
	"USMC DECISIVE VICTORY<br />VDV has retreated due to casualties." call FNC_EndMission;
};

if ((time / 60) >= timeLimit) exitWith { //It is recommended that you do not remove the time limit end condition 
	"TIME LIMIT REACHED!" call FNC_EndMission;
};

sleep (60); //You shouldn't change this unless your absolutely sure what your doing