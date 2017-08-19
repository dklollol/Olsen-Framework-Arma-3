#include "plank_macros.h"

plank_ui_fnc_createSettingsDialog = {
    if (!dialog) then {
        private "_isDialogCreated";
        _isDialogCreated = createDialog "PlankSettingsDialog";
        if (_isDialogCreated) then {
            [] call plank_ui_fnc_initDialog;
        };
    };
};

plank_ui_fnc_closeSettingsDialog = {
    if (dialog) then {
        closeDialog 0;
    };
};

plank_ui_fnc_resetHeightSlider = {
    sliderSetPosition [SETTINGS_HEIGHT_SLIDER_IDC, 0];
    [0] call plank_ui_fnc_updateHeightSliderValue;
};

plank_ui_fnc_resetDirectionSlider = {
    private "_fortDirection";
    _fortDirection = GET_FORT_DIRECTION((player getVariable "plank_deploy_fortIndex"));
    sliderSetPosition [SETTINGS_DIRECTION_SLIDER_IDC, _fortDirection];
    [_fortDirection] call plank_ui_fnc_updateDirectiontSliderValue;
};

plank_ui_fnc_resetDistanceSlider = {
    private "_fortDistance";
    _fortDistance = GET_FORT_DISTANCE((player getVariable "plank_deploy_fortIndex"));
    sliderSetPosition [SETTINGS_DISTANCE_SLIDER_IDC, _fortDistance];
    [_fortDistance] call plank_ui_fnc_updateDistanceSliderValue;
};

plank_ui_fnc_resetPitchSlider = {
    sliderSetPosition [SETTINGS_PITCH_SLIDER_IDC, 0];
    [0] call plank_ui_fnc_updatePitchSliderValue;
};

plank_ui_fnc_resetBankSlider = {
    sliderSetPosition [SETTINGS_BANK_SLIDER_IDC, 0];
    [0] call plank_ui_fnc_updateBankSliderValue;
};

plank_ui_fnc_heightModeButtonClick = {
    private "_heightMode";
    _heightMode = player getVariable ["plank_deploy_heightMode", RELATIVE_TO_UNIT];
    call {
        if (_heightMode == RELATIVE_TO_TERRAIN) exitWith {
            _heightMode = RELATIVE_TO_UNIT;
        };
        if (_heightMode == RELATIVE_TO_UNIT) exitWith {
            _heightMode = RELATIVE_TO_TERRAIN;
        };
    };
    [_heightMode] call plank_ui_fnc_setHeightModeButton;
};

plank_ui_fnc_updateHeightSliderValue = {
    FUN_ARGS_1(_value);

    [SETTINGS_HEIGHT_VALUE_IDC, "plank_deploy_fortRelativeHeight",_value] call plank_ui_fnc_updateSliderValue;
};

plank_ui_fnc_updateDirectiontSliderValue = {
    FUN_ARGS_1(_value);

    [SETTINGS_DIRECTION_VALUE_IDC, "plank_deploy_fortDirection", _value] call plank_ui_fnc_updateSliderValue;
};

plank_ui_fnc_updateDistanceSliderValue = {
    FUN_ARGS_1(_value);

    [SETTINGS_DISTANCE_VALUE_IDC, "plank_deploy_fortDistance", _value] call plank_ui_fnc_updateSliderValue;
};

plank_ui_fnc_updatePitchSliderValue = {
    FUN_ARGS_1(_value);

    [SETTINGS_PITCH_VALUE_IDC, "plank_deploy_fortPitch", _value] call plank_ui_fnc_updateSliderValue;
};

plank_ui_fnc_updateBankSliderValue = {
    FUN_ARGS_1(_value);

    [SETTINGS_BANK_VALUE_IDC, "plank_deploy_fortBank", _value] call plank_ui_fnc_updateSliderValue;
};

plank_ui_fnc_updateSliderValue = {
    FUN_ARGS_3(_idc,_varName,_value);

    ctrlSetText [_idc, str _value];
    player setVariable [_varName, _value, false]
};

plank_ui_fnc_initSliders = {
    sliderSetRange [SETTINGS_HEIGHT_SLIDER_IDC, MIN_HEIGHT, MAX_HEIGHT];
    sliderSetRange [
        SETTINGS_DIRECTION_SLIDER_IDC,
        GET_FORT_DIRECTION((player getVariable "plank_deploy_fortIndex")) - GET_FORT_DIRECTION_RANGE((player getVariable "plank_deploy_fortIndex")) / 2,
        GET_FORT_DIRECTION((player getVariable "plank_deploy_fortIndex")) + GET_FORT_DIRECTION_RANGE((player getVariable "plank_deploy_fortIndex")) / 2
    ];
    sliderSetRange [SETTINGS_DISTANCE_SLIDER_IDC, GET_FORT_DISTANCE((player getVariable "plank_deploy_fortIndex")), GET_FORT_DISTANCE((player getVariable "plank_deploy_fortIndex")) + MAX_DISTANCE_ADD];
    sliderSetRange [SETTINGS_PITCH_SLIDER_IDC, MIN_PITCH, MAX_PITCH];
    sliderSetRange [SETTINGS_BANK_SLIDER_IDC, MIN_BANK, MAX_BANK];
};

plank_ui_fnc_initSliderValues = {
    sliderSetPosition [SETTINGS_HEIGHT_SLIDER_IDC, player getVariable ["plank_deploy_fortRelativeHeight", 0]];
    sliderSetPosition [SETTINGS_DIRECTION_SLIDER_IDC, player getVariable ["plank_deploy_fortDirection", GET_FORT_DIRECTION((player getVariable "plank_deploy_fortIndex"))]];
    sliderSetPosition [SETTINGS_DISTANCE_SLIDER_IDC, player getVariable ["plank_deploy_fortDistance", GET_FORT_DISTANCE((player getVariable "plank_deploy_fortIndex"))]];
    sliderSetPosition [SETTINGS_PITCH_SLIDER_IDC, player getVariable ["plank_deploy_fortPitch", 0]];
    sliderSetPosition [SETTINGS_BANK_SLIDER_IDC, player getVariable ["plank_deploy_fortBank", 0]];
};

plank_ui_fnc_initSliderTextValues = {
    ctrlSetText [SETTINGS_HEIGHT_VALUE_IDC, str (player getVariable ["plank_deploy_fortRelativeHeight", 0])];
    ctrlSetText [SETTINGS_DIRECTION_VALUE_IDC, str (player getVariable ["plank_deploy_fortDirection", GET_FORT_DIRECTION((player getVariable "plank_deploy_fortIndex"))])];
    ctrlSetText [SETTINGS_DISTANCE_VALUE_IDC, str (player getVariable ["plank_deploy_fortDistance", GET_FORT_DISTANCE((player getVariable "plank_deploy_fortIndex"))])];
    ctrlSetText [SETTINGS_PITCH_VALUE_IDC, str (player getVariable ["plank_deploy_fortPitch", 0])];
    ctrlSetText [SETTINGS_BANK_VALUE_IDC, str (player getVariable ["plank_deploy_fortBank", 0])];
};

plank_ui_fnc_setHeightModeButton = {
    FUN_ARGS_1(_heightMode);

    player setVariable ["plank_deploy_heightMode", _heightMode, false];
    ctrlSetText [SETTINGS_HEIGHT_MODE_BUTTON_IDC, STR_HEIGHT_MODES select _heightMode];
};

plank_ui_fnc_initDialog = {
    [] call plank_ui_fnc_initSliders;
    [] call plank_ui_fnc_initSliderValues;
    [] call plank_ui_fnc_initSliderTextValues;
    [player getVariable ["plank_deploy_heightMode", RELATIVE_TO_UNIT]] call plank_ui_fnc_setHeightModeButton;
};