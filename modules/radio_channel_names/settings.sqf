//For TVT it is recommended to use this module together with the radio scrambler module.

switch (_side) do { //Checks what team the player is on

	case west: { //If the player is on side west, he receives these radio channel names

		[1, "PLTNET 1"] call FNC_SetChannelName;
		[2, "PLTNET 2"] call FNC_SetChannelName;
		[3, "PLTNET 3"] call FNC_SetChannelName;
		[4, "COY"] call FNC_SetChannelName;
		[5, "CAS"] call FNC_SetChannelName;
		[6, "FIRES"] call FNC_SetChannelName;

	}; //End of west case
}; //End of switch