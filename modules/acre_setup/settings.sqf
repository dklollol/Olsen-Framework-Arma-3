FW_Presets = ["default2", "default3", "default4", "default"]; //do not change

//////////////////
//RADIO SCRAMBLE
//////////////////

FW_enable_scramble = false;

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
        ["ACRE_PRC152", "1", "label", "name west"],
        ["ACRE_PRC148", "2", "label", "name west 2"],
        ["ACRE_PRC117F", "10", "label", "CHANNEL NAME"]
    ],
    [//EAST
        ["ACRE_PRC148", "1", "label", "1PLT"]
    ],
    [//INDEPENDENT
    
    ],
    [//DEFAULT - USE THIS IF SCRAMBLE IS OFF
        ["ACRE_PRC148", "1", "label", "default"],
        ["ACRE_PRC148", "2", "label", "default 2"]
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
["en", "English"] call acre_api_fnc_babelAddLanguageType;
["ru", "Russian"] call acre_api_fnc_babelAddLanguageType;
["fr", "French"] call acre_api_fnc_babelAddLanguageType;

//define languages for different sides
FW_Languages_babel = [
    ["fr", "en"],//WEST
    ["ru", "en"],//EAST
    ["fr", "en", "ru"],//INDEPENDENT
    ["en"]//DEFAULT
];

///////////////////////
//EXTRA SETTINGS
///////////////////////

/*
 * For More info visit:
 * http://acre.idi-systems.com/api/api_general.html
*/

//Specify and value between 1.0 and 0. Setting it to 0 means the terrain loss model is disabled, 1 is default.
//Note this setting only effects loss caused by terrain, loss due to power dissipation over range will always occur.

//[1.0] call acre_api_fnc_setLossModelScale;

//Sets the duplex of radio transmissions.
//If set to true, it means that you will receive transmissions even while talking and multiple people can speak at the same time.

//[false] call acre_api_fnc_setFullDuplex;

//Sets whether transmissions will interfere with each other.
//This, by default, causes signal loss when multiple people are transmitting on the same frequency.

//[true] call acre_api_fnc_setInterference;

//Sets whether AI can detect players speaking.
//This utilizes an advanced model of inverse-square volume detection and randomization against the range of the unit, and duration and quantity of speaking.
//In a nutshell, the closer you are to an AI unit and the more you speak - the better chance he has of hearing you.

//[false] call acre_api_fnc_setRevealToAI;