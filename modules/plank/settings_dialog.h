#include "plank_macros.h"

// Magic to set default font for Arma 2 and Arma 3
__EXEC(_plank_default_font = "puristaMedium"; _stop = false; while {isNil {call compile "blufor"} && {!_stop}} do {_plank_default_font = "Zeppelin32"; _stop = true;};)

#define SETTINGS_BASE_H                         0.82
#define SETTINGS_BASE_W                         0.8

#define SETTINGS_DIALOG_H                       SETTINGS_BASE_H
#define SETTINGS_DIALOG_W                       SETTINGS_BASE_W * 3 / 4

#define SETTINGS_BASE_X                         safeZoneX + safeZoneW - (SETTINGS_BASE_W + 0.1) * 3 / 4
#define SETTINGS_BASE_Y                         safeZoneY + safeZoneH - (SETTINGS_BASE_H + 0.1)

#define CONTROL_MARGIN_RIGHT                    0.02
#define CONTROL_MARGIN_BOTTOM                   0.03

#define ROW_BASE_H                              0.035
#define TITLE_BASE_W                            0.105
#define TITLE_BASE_H                            ROW_BASE_H
#define VALUE_BASE_W                            0.11
#define VALUE_BASE_H                            ROW_BASE_H
#define SLIDER_BASE_W                           0.4
#define SLIDER_BASE_H                           ROW_BASE_H
#define RESET_BUTTON_BASE_W                     0.085
#define RESET_BUTTON_BASE_H                     ROW_BASE_H

#define CONTROL_GROUP_H                         (2 * ROW_BASE_H) + CONTROL_MARGIN_BOTTOM + 0.07

#define SETTINGS_PADDING_LEFT                   0.03
#define SETTINGS_CONTROL_BASE_X                 SETTINGS_BASE_X + SETTINGS_PADDING_LEFT

#define SETTINGS_PADDING_TOP                    0.03
#define SETTINGS_CONTROL_BASE_Y(ROW)            (SETTINGS_BASE_Y + SETTINGS_PADDING_TOP + (CONTROL_GROUP_H) * ROW)

class PlankSettingsDialog {
    idd = SETTINGS_DIALOG_IDD;
    controlsBackground[] = {};
    objects[] = {};
    onLoad = "uiNamespace setVariable ['plank_ui_settingsDialogIdd', _this select 0]";
    controls[] = {
        DialogBackground,
        HeightTitle,
        HeightModeButton,
        HeightSlider,
        HeightResetButton,
        HeightValue,
        DirectionTitle,
        DirectionSlider,
        DirectionResetButton,
        DirectionValue,
        DistanceTitle,
        DistanceSlider,
        DistanceValue,
        DistanceResetButton,
        PitchTitle,
        PitchSlider,
        PitchValue,
        PitchResetButton,
        BankTitle,
        BankSlider,
        BankValue,
        BankResetButton
    };

    class RscTextBase {
        idc = -1;
        access = 0;
        type = 0;
        colorBackground[] = {0, 0, 0, 1};
        colorText[] = {1, 1, 1, 1};
        text = "";
        fixedWidth = 0;
        x = 0;
        y = 0;
        h = 0.1;
        w = 0.1;
        style = 0;
        shadow = 2;
        font = __EVAL(_plank_default_font);
        SizeEx = 0.03921;
    };

    class TitleBase : RscTextBase {
        idc = -1;
        access = 0;
        type = 0;
        style = 0;
        shadow = 2;
        fixedWidth = 0;
        font = __EVAL(_plank_default_font);
        w = TITLE_BASE_W;
        h = TITLE_BASE_H;
        text="Height";
        colorBackground[] = {0, 0, 0, 0};
        colorText[] = {0.85, 0.85, 0.85, 1};
    };

    class ValueBase : RscTextBase {
        w = VALUE_BASE_W;
        h = VALUE_BASE_H;
        text="";
        colorBackground[] = {0, 0, 0, 0};
        colorText[] = {0.85, 0.85, 0.85, 1};
    };

    class RscSliderBase {
        access = 0;
        type = 3;
        style = 1024;
        w = 0.1;
        h = 0.035;
        color[] = {1, 1, 1, 0.8};
        colorActive[] = {1, 1, 1, 1};
        shadow = 0;
    };

    class SliderBase : RscSliderBase {
        w = SLIDER_BASE_W;
        h = SLIDER_BASE_H;
    };

    class RscButton {
        access = 0;
        type = 1;
        text = "";
        colorText[] = {0.305, 0.286, 0.301, 1};
        colorDisabled[] = {0.4, 0.4, 0.4, 0};
        colorBackground[] = {0.596, 0.576, 0.592, 1};
        colorBackgroundDisabled[] = {0, 0, 0, 0};
        colorBackgroundActive[] = {0.596, 0.576, 0.592, 1};
        colorFocused[] = {0.596, 0.576, 0.592, 1};
        colorShadow[] = {0, 0, 0, 1};
        colorBorder[] = {0, 0, 0, 1};
        soundEnter[] = {"",0.09,1};
        soundPush[] = {"",0.09,1};
        soundClick[] = {"\ca\ui\data\sound\new1",0.07,1};
        soundEscape[] = {"",0.09,1};
        style = 2;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        shadow = 0;
        font = __EVAL(_plank_default_font);
        sizeEx = 0.03921;
        offsetX = 0.003;
        offsetY = 0.003;
        offsetPressedX = 0.001;
        offsetPressedY = 0.001;
        borderSize = 0.003;
    };

    class ResetButtonBase : RscButton {
        w = RESET_BUTTON_BASE_W;
        h = RESET_BUTTON_BASE_H;
        SizeEx = 0.03921;
        text="Reset";
    };

    class HeightTitle : TitleBase {
        idc = SETTINGS_HEIGHT_TITLE_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(0);
    };

    class HeightModeButton : ResetButtonBase {
        idc = SETTINGS_HEIGHT_MODE_BUTTON_IDC;
        x = SETTINGS_CONTROL_BASE_X + TITLE_BASE_W + RESET_BUTTON_BASE_W + CONTROL_MARGIN_RIGHT * 2;
        y = SETTINGS_CONTROL_BASE_Y(0);
        w = 0.2;
        text = "Snap to Terrain";
        action = "[] call plank_ui_fnc_heightModeButtonClick";
        colorBackground[] = {1, 1, 1, 1};
        colorBackgroundActive[] = {1, 1, 1, 1};
        colorFocused[] = {1, 1, 1, 1};
    };

    class HeightSlider : SliderBase {
        idc = SETTINGS_HEIGHT_SLIDER_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(0) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
        onSliderPosChanged = "[_this select 1] call plank_ui_fnc_updateHeightSliderValue";
    };
    
    class HeightValue : ValueBase {
        idc = SETTINGS_HEIGHT_VALUE_IDC;
        x = SETTINGS_CONTROL_BASE_X + SLIDER_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(0) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
    };

    class HeightResetButton : ResetButtonBase {
        idc = SETTINGS_HEIGHT_RESET_BUTTON_IDC;
        x = SETTINGS_CONTROL_BASE_X + TITLE_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(0);
        action = "[] call plank_ui_fnc_resetHeightSlider";
    };
//--------------------------
    class DirectionTitle : TitleBase {
        idc = SETTINGS_DIRECTION_TITLE_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(1);
        text="Direction";
    };

    class DirectionSlider : SliderBase {
        idc = SETTINGS_DIRECTION_SLIDER_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(1) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
        onSliderPosChanged = "[_this select 1] call plank_ui_fnc_updateDirectiontSliderValue";
    };

    class DirectionValue : ValueBase {
        idc = SETTINGS_DIRECTION_VALUE_IDC;
        x = SETTINGS_CONTROL_BASE_X + SLIDER_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(1) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
    };

    class DirectionResetButton : ResetButtonBase {
        idc = SETTINGS_DIRECTION_RESET_BUTTON_IDC;
        x = SETTINGS_CONTROL_BASE_X + TITLE_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(1);
        action = "[] call plank_ui_fnc_resetDirectionSlider";
    };
//--------------------------
    class DistanceTitle : TitleBase {
        idc = SETTINGS_DISTANCE_TITLE_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(2);
        text="Distance";
    };

    class DistanceSlider : SliderBase {
        idc = SETTINGS_DISTANCE_SLIDER_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(2) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
        onSliderPosChanged = "[_this select 1] call plank_ui_fnc_updateDistanceSliderValue";
    };

    class DistanceValue : ValueBase {
        idc = SETTINGS_DISTANCE_VALUE_IDC;
        x = SETTINGS_CONTROL_BASE_X + SLIDER_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(2) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
    };

    class DistanceResetButton : ResetButtonBase {
        idc = SETTINGS_DISTANCE_RESET_BUTTON_IDC;
        x = SETTINGS_CONTROL_BASE_X + TITLE_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(2);
        action = "[] call plank_ui_fnc_resetDistanceSlider";
    };
//--------------------------
    class PitchTitle : TitleBase {
        idc = SETTINGS_PITCH_TITLE_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(3);
        text="Pitch";
    };

    class PitchSlider : SliderBase {
        idc = SETTINGS_PITCH_SLIDER_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(3) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
        onSliderPosChanged = "[_this select 1] call plank_ui_fnc_updatePitchSliderValue";
    };

    class PitchValue : ValueBase {
        idc = SETTINGS_PITCH_VALUE_IDC;
        x = SETTINGS_CONTROL_BASE_X + SLIDER_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(3) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
    };

    class PitchResetButton : ResetButtonBase {
        idc = SETTINGS_PITCH_RESET_BUTTON_IDC;
        x = SETTINGS_CONTROL_BASE_X + TITLE_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(3);
        action = "[] call plank_ui_fnc_resetPitchSlider";
    };
//--------------------------
    class BankTitle : TitleBase {
        idc = SETTINGS_BANK_TITLE_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(4);
        text="Bank";
    };

    class BankSlider : SliderBase {
        idc = SETTINGS_BANK_SLIDER_IDC;
        x = SETTINGS_CONTROL_BASE_X;
        y = SETTINGS_CONTROL_BASE_Y(4) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
        onSliderPosChanged = "[_this select 1] call plank_ui_fnc_updateBankSliderValue";
    };

    class BankValue : ValueBase {
        idc = SETTINGS_BANK_VALUE_IDC;
        x = SETTINGS_CONTROL_BASE_X + SLIDER_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(4) + ROW_BASE_H + CONTROL_MARGIN_BOTTOM;
    };

    class BankResetButton : ResetButtonBase {
        idc = SETTINGS_BANK_RESET_BUTTON_IDC;
        x = SETTINGS_CONTROL_BASE_X + TITLE_BASE_W + CONTROL_MARGIN_RIGHT;
        y = SETTINGS_CONTROL_BASE_Y(4);
        action = "[] call plank_ui_fnc_resetBankSlider";
    };
//--------------------------
    class DialogBackground {
        idc = SETTINGS_BACKGROUND_IDC;
        type = 0;
        style = 0;
        colorBackground[] = {0, 0, 0, 0.3};
        colorText[] = {0, 0, 0, 0};
        font = "EtelkaNarrowMediumPro";
        sizeEx = 0.03;
        text = "";
        x = SETTINGS_BASE_X;
        y = SETTINGS_BASE_Y;
        h = SETTINGS_DIALOG_H;
        w = SETTINGS_DIALOG_W;
    };
};