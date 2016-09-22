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
 * Will set unit's radio to set faction's scramble setting.
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
    [//WEST
        ["ACRE_PRC148", "1", "label", "1PLT"],
        ["ACRE_PRC148", "2", "label", "2PLT"],
        ["ACRE_PRC117F", "10", "label", "CHANNEL NAME"]
    ],
    [//EAST
        ["ACRE_PRC148", "1", "label", "1PLT"],
    ],
    [//INDEPENDENT
        ["ACRE_PRC148", "1", "label", "1PLT"],
        ["ACRE_PRC148", "2", "label", "2PLT"]
    ],
    [//DEFAULT
        ["ACRE_PRC148", "1", "label", "1PLT"],
        ["ACRE_PRC148", "2", "label", "2PLT"]
    ],
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