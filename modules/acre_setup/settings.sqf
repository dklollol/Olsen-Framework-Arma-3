//////////////////
//RADIO SCRAMBLE
//////////////////

FW_enable_scramble = false;

//If enabled all sides will have different scramble frequencies.
//Function below is to switch one unit to different scramble side.

/*
 * FNC_SetScramble
 * Change unit's scramble so it matches set faction
 * 
 * Example:
 * [this, east] call FNC_SetScramble;
 * Will set unit's radio to east's scramble setting.
 * (if following example is used on west unit, that unit will hear east units on radio, but won't hear west)
*/

/////////////////
//DEFAULT RADIO CHANNEL
/////////////////

/*
 * FNC_SetRadio
 * use this in player init to set default radio channel and spatial (optional)
 *
 * Examples:
 * [this, "ACRE_PRC343", 2] call FNC_SetRadio;
 * [this, "ACRE_PRC117F", 7, "LEFT"] call FNC_SetRadio;
*/

/////////////
//CHANNEL NAMES
/////////////

FW_enable_channel_names = false;

//define custom radio channel names in following array
//don't change "label" value!

FW_ChannelNames = [
	[//WEST - USE SIDE SETTINGS ONLY IF SCRAMBLE IS ON
		[1, "label", "PLTNET 1"],
		[2, "label", "PLTNET 2"],
		[3, "label", "PLTNET 3"],
		[4, "label", "PLTNET 4"],
		[5, "label", "COY"],
		[6, "label", "CAS"],
		[7, "label", "FIRES"]
	],
	[//EAST
		[1, "label", "PLTNET 1"],
		[2, "label", "PLTNET 2"],
		[3, "label", "PLTNET 3"],
		[4, "label", "PLTNET 4"],
		[5, "label", "COY"],
		[6, "label", "CAS"],
		[7, "label", "FIRES"]
	],
	[//INDEPENDENT
		[1, "label", "PLTNET 1"],
		[2, "label", "PLTNET 2"],
		[3, "label", "PLTNET 3"],
		[4, "label", "PLTNET 4"],
		[5, "label", "COY"],
		[6, "label", "CAS"],
		[7, "label", "FIRES"]
	],
	[//DEFAULT - USE THIS IF SCRAMBLE IS OFF
		[1, "label", "PLTNET 1"],
		[2, "label", "PLTNET 2"],
		[3, "label", "PLTNET 3"],
		[4, "label", "PLTNET 4"],
		[5, "label", "COY"],
		[6, "label", "CAS"],
		[7, "label", "FIRES"]
	]
];

//////////////
//BABEL
//////////////

FW_enable_babel = false;

/*
 * FNC_SetLanguages
 * 
 * Use this function in player's init to set player's custom languages (translator for example)
 * faction setting will be overwritten by this value
 *
 * Examples:
 * [this, ["ru"]] call FNC_SetLanguages;
 * [this, ["fr", "en", "ru"]] call FNC_SetLanguages;
*/

//define all available languages here

FW_all_languages = [
	["en", "English"],
	["ru", "Russian"],
	["fr", "French"]
];

//define languages for different sides
FW_languages_babel = [
	["fr", "en"],//WEST
	["ru", "en"],//EAST
	["fr", "en", "ru"],//INDEPENDENT
	["en"]//DEFAULT/CIVILIAN
];

///////////////////////
//ADD RACKS TO VEHICLES
///////////////////////

FW_enable_addRacks = false;
FW_enable_addRackDebug = false;

/* params:
 * 0: variable name for vehicle or object rack is being added to <OBJECT>
 * 1: type of rack to mount <STRING>
 *	- ACRE_SEM90: can mount a SEM70 radio
 *	- ACRE_VRC103: can mount a PRC117F radio
 *	- ACRE_VRC110: can mount a PRC152 radio
 *	- ACRE_VRC111: can mount a PRC148 radio
 *	- ACRE_VRC64: can mount a PRC77 radio
 * 2: add a mounted radio <BOOLEAN>
 * 3: mounted radio removeable <BOOLEAN>
 * 4: Name of rack displayed to user (long and short variants, both strings) <ARRAY>
 *	- long: long rackname, suggested names are; Upper/Lower Dash
 *	- short: short rackname, max of four characters. Suggested name: Dash
 * 5: who can access the radio (whitelist) (strings) <ARRAY>
 *	0 - driver
 *	1 - gunner
 *	2 - commander
 *	3 - copilot
 *	4 - inside
 *	5 - external
 *	6 - cargo
 *	7 - turret
 *	8 - turnedOut
 *	9 - [0-8, _index]
 *	http://acre2.idi-systems.com/wiki/frameworks/vehicle-racks#configuration-examples
 * 6: who cannot access the rack (blacklist) <ARRAY>
 *  - Strings or an arrays of a string and a number for the vehicle specific position
 *  - Ex: ["driver",["cargo",0], ["cargo",1]]
 *	- 0 to 8 from param 5 
 *	- http://acre2.idi-systems.com/wiki/frameworks/vehicle-racks#configuration-examples
 * 7: side for radio to be configured for <SIDE> (west, east, independent, civilian, etc)
*/

//ORR = object receiving rack
FW_ORRList = [
	//These examples will cause errors if you do not comment them out or remove them.
	//If you want to test the module, make an object and give it the variable name accVic, or change this name to whatever you want it to be
	["accVic", "ACRE_VRC103", true, false, ["Radio Rack One", "R1"], ["driver",["cargo",0], ["cargo",1]], ["cargo"], west],
	["accVic", "ACRE_VRC103", false, true, ["Radio Rack Two", "R2"], ["driver",["cargo",0], ["cargo",1]], ["cargo"], west],
	["accVic", "ACRE_VRC103", true, true, ["Radio Rack Three", "R3"], ["driver", ["cargo",0]], ["cargo"], west]
	/*	For whitelisted/blacklisted positions
	 *	If you wish to limit access to the rack to certain specific seats use this array setyp:
	 *	[_name, _num] 
	 *	- _name being one of the possible "listable" positions
	 *	_num as the index of that position as in the case of cargo you may have multiple cargo seats
	 *	You will need to add one for each position if you say, blacklist all of cargo but make specific exceptions.
	 *	Example above.
	*/
	//["inaccVic", "ACRE_VRC103", true, false, ["Vehicle Radio", "Radio"], ["external"], ["cargo"], east]
];

///////////////////////
//EXTRA SETTINGS
///////////////////////

/*
 * For More info visit:
 * http://gitlab.idi-systems.com/idi-systems/acre2-public/wikis/home
 * http://acre.idi-systems.com/api/api_general.html
 *
 * Remove // to enable a setting.
*/

/*Specify and value between 1.0 and 0. Setting it to 0 means the terrain loss model is disabled, 1 is default.
  Note this setting only effects loss caused by terrain, loss due to power dissipation over range will always occur.*/

//[0.0] call acre_api_fnc_setLossModelScale;


/*Sets the duplex of radio transmissions.
  If set to true, it means that you will receive transmissions even while talking and multiple people can speak at the same time.*/

//[false] call acre_api_fnc_setFullDuplex;


/*Sets whether transmissions will interfere with each other.
  This, by default, causes signal loss when multiple people are transmitting on the same frequency.*/

//[false] call acre_api_fnc_setInterference;


/*Sets whether AI can detect players speaking.
  This utilizes an advanced model of inverse-square volume detection and randomization against the range of the unit, and duration and quantity of speaking.
  In a nutshell, the closer you are to an AI unit and the more you speak - the better chance he has of hearing you.*/

//[false] call acre_api_fnc_setRevealToAI;


/*This setting can be used to disable the simulation of antenna radiation patterns for both the transmitting and receiving radios.
  It will make all antennas act with perfect omni-directional behaviour. (true/false)*/


//[true] call acre_api_fnc_ignoreAntennaDirection;


/*
  Direct speech slider
  ACRE2 has a built in direct speech slider allowing you to determine how far your voice in direct speech should travel. The system has five states and by default starts in the middle state. The below table contains an approximated table with empirical testing by Bullhorn.
  
  Volume state  |  Loud (m)  |  Quiet (m)  |  Barely audible (m)
  -2			|  1		 |  2		  |  13
  -1			|  3		 |  15		 |  55
   0			|  8		 |  30		 |  100
  +1			|  12		|  45		 |  145
  +2			|  15		|  55		 |  195
*/

FW_Acre_Volume_Value = -1;

