_westCasualty = CASUALTYCHECK("USMC"); //Gets the casualty percentage of team "USMC"
_eastCasualty = CASUALTYCHECK("VDV"); //Gets the casualty percentage of team "VDV"

if (_westCasualty >= 50) exitWith {
	ENDMISSION("VDV DECISIVE VICTORY<br />USMC has retreated due to casualties."); 
};

if (_eastCasualty >= 75) exitWith {
	ENDMISSION("USMC DECISIVE VICTORY<br />VDV has retreated due to casualties.");
};

if ((time / 60) >= timeLimit) exitWith { //It is recommended that you do not remove the time limit end condition 
	ENDMISSION("TIME LIMIT REACHED!");
};

sleep (60); //You shouldn't change this unless your absolutely sure what your doing