CASUALTYCHECK("USMC", _westCasualty); //Stores the casualty percentage of "USMC" in _westCasualty
CASUALTYCHECK("VDV", _eastCasualty); //Stores the casualty percentage of "VDV" in _eastCasualty

if (_westCasualty >= 50) exitWith {
	ENDMISSION("VDV DECISIVE VICTORY<br />USMC has retreated due to casualties."); 
};

if (_eastCasualty >= 75) exitWith {
	ENDMISSION("USMC DECISIVE VICTORY<br />VDV has retreated due to casualties.");
};

if ((time / 60) > timeLimit) exitWith { //It is recommended that you do not remove the time limit end condition 
	ENDMISSION("TIME LIMIT REACHED!");
};

sleep (60); //You shouldn't change this unless your absolutely sure what your doing