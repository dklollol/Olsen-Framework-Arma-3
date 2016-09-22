FW_Presets = ["default2", "default3", "default4", "default"]; //do not change


//use this in player init to set default radio channel and spatial (optional)
//Examples:
//[this, "ACRE_PRC343", 2] call FNC_SetRadio;
//[this, "ACRE_PRC117F", 7, "LEFT"] call FNC_SetRadio;

//use this function in player init to set player's additional language (translator for example)
//Examples:
//[this, ["ru"]] call FNC_SetLanguages;
//[this, ["fr", "en", "ru"]] call FNC_SetLanguages;


FW_enable_scramble = false;
FW_enable_channel_names = false;
FW_enable_babel = false;


//define all available languages here
["en", "English"] call acre_api_fnc_babelAddLanguageType;
["ru", "Russian"] call acre_api_fnc_babelAddLanguageType;
["fr", "French"] call acre_api_fnc_babelAddLanguageType;

//define custom radio channel names in following array
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

//define languages for different sides
FW_Languages_babel = [
    ["fr", "en"],//WEST
    ["ru", "en"],//EAST
    ["fr", "en", "ru"],//INDEPENDENT
    ["en"]//DEFAULT
];