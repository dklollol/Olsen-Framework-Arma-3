#ifndef PLANK_MACROS_H
#define PLANK_MACROS_H

#define FORTS_DATA                      plank_deploy_fortData
#define GET_FORT_DATA(FORTIDX,IDX)      (FORTS_DATA) select FORTIDX select IDX
#define GET_FORT_DISPLAY_NAME(IDX)      (GET_FORT_DATA(IDX,0))
#define GET_FORT_CLASS_NAME(IDX)        (GET_FORT_DATA(IDX,1))
#define GET_FORT_DISTANCE(IDX)          (GET_FORT_DATA(IDX,2))
#define GET_FORT_DIRECTION(IDX)         (GET_FORT_DATA(IDX,3))
#define GET_FORT_DIRECTION_RANGE(IDX)   (GET_FORT_DATA(IDX,4))
#define GET_FORT_CODE(IDX)              (GET_FORT_DATA(IDX,5))

#define STATE_PLACEMENT_INIT            0
#define STATE_PLACEMENT_IN_PROGRESS     1
#define STATE_PLACEMENT_DONE            2
#define STATE_PLACEMENT_CANCELLED       3

#define STR_HEIGHT_MODES                ["Snap to Terrain", "Relative to Player"]
#define COLOR_HEIGHT_MODES              [[0, 1, 0, 1], [1, 0, 0, 1]]
#define RELATIVE_TO_TERRAIN             0
#define RELATIVE_TO_UNIT                1

#define MIN_HEIGHT                      -10
#define MAX_HEIGHT                      10
#define MAX_DISTANCE_ADD                20
#define DIRECTION_RANGE                 40
#define MIN_PITCH                       -120
#define MAX_PITCH                       120
#define MIN_BANK                        -180
#define MAX_BANK                        360


#define SETTINGS_DIALOG_IDD                     143701

#define SETTINGS_BACKGROUND_IDC                 143800
#define SETTINGS_HEIGHT_TITLE_IDC               143810
#define SETTINGS_HEIGHT_SLIDER_IDC              143811
#define SETTINGS_HEIGHT_RESET_BUTTON_IDC        143812
#define SETTINGS_HEIGHT_VALUE_IDC               143813
#define SETTINGS_HEIGHT_MODE_BUTTON_IDC         143814
#define SETTINGS_DIRECTION_TITLE_IDC            143820
#define SETTINGS_DIRECTION_SLIDER_IDC           143821
#define SETTINGS_DIRECTION_RESET_BUTTON_IDC     143822
#define SETTINGS_DIRECTION_VALUE_IDC            143823
#define SETTINGS_DISTANCE_TITLE_IDC             143830
#define SETTINGS_DISTANCE_SLIDER_IDC            143831
#define SETTINGS_DISTANCE_RESET_BUTTON_IDC      143832
#define SETTINGS_DISTANCE_VALUE_IDC             143833
#define SETTINGS_PITCH_TITLE_IDC                143840
#define SETTINGS_PITCH_SLIDER_IDC               143841
#define SETTINGS_PITCH_RESET_BUTTON_IDC         143842
#define SETTINGS_PITCH_VALUE_IDC                143843
#define SETTINGS_BANK_TITLE_IDC                 143850
#define SETTINGS_BANK_SLIDER_IDC                143851
#define SETTINGS_BANK_RESET_BUTTON_IDC          143852
#define SETTINGS_BANK_VALUE_IDC                 143853



// WARNING
// Macros are sensitive for "," (comma), "(", ")" (parenthese) and " " (space).
// Provide only the asked numbers of arguments, without additional commas and without spaces beetween commas.
// Example:
//      PUSH_ALL(_units, [_unit] call getPlayersAroundUnit);
//      This will work as intended.
//      PUSH_ALL(_units, [_unit, 100] call getPlayersAroundUnit);
//      This won't work, as the macro identifies 100 as a third parameter.
//      Use AS_ARRAY_* instead of passing actual arrays.
//      PUSH_ALL(_units, AS_ARRAY_2(_unit, 100) call getPlayersAroundUnit);

// Creates private declaritions for arguments.
// Example:
//      GIVEN:
//      WHEN:
//          PVT_3(_unit,_group,_trigger); 
//      THEN:
//          private ["_unit","_group","_trigger"];
#define PVT_1(VAR1) private [#VAR1]
#define PVT_2(VAR1,VAR2) private [#VAR1,#VAR2]
#define PVT_3(VAR1,VAR2,VAR3) private [#VAR1,#VAR2,#VAR3]
#define PVT_4(VAR1,VAR2,VAR3,VAR4) private [#VAR1,#VAR2,#VAR3,#VAR4]
#define PVT_5(VAR1,VAR2,VAR3,VAR4,VAR5) private [#VAR1,#VAR2,#VAR3,#VAR4,#VAR5]
#define PVT_6(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6) private [#VAR1,#VAR2,#VAR3,#VAR4,#VAR5,#VAR6]
#define PVT_7(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7) private [#VAR1,#VAR2,#VAR3,#VAR4,#VAR5,#VAR6,#VAR7]
#define PVT_8(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8) private [#VAR1,#VAR2,#VAR3,#VAR4,#VAR5,#VAR6,#VAR7,#VAR8]
#define PVT_9(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9) private [#VAR1,#VAR2,#VAR3,#VAR4,#VAR5,#VAR6,#VAR7,#VAR8,#VAR9]


// Creates array selection for arguments. Only works if the array is a variable!
// Example:
//      GIVEN:
//          _strings = ["unit", "group", "trigger"];
//      WHEN:
//          SELECT_3(_strings,_unit,_group,_trigger); 
//      THEN:
//          _unit == "unit";
//          _group == "group";
//          _trigger == "trigger";
#define SELECT_1(ARRAY,VAR1) VAR1 = (ARRAY) select 0
#define SELECT_2(ARRAY,VAR1,VAR2) SELECT_1(ARRAY,VAR1); VAR2 = (ARRAY) select 1
#define SELECT_3(ARRAY,VAR1,VAR2,VAR3) SELECT_2(ARRAY,VAR1,VAR2); VAR3 = (ARRAY) select 2
#define SELECT_4(ARRAY,VAR1,VAR2,VAR3,VAR4) SELECT_3(ARRAY,VAR1,VAR2,VAR3); VAR4 = (ARRAY) select 3
#define SELECT_5(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5) SELECT_4(ARRAY,VAR1,VAR2,VAR3,VAR4); VAR5 = (ARRAY) select 4
#define SELECT_6(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6) SELECT_5(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5); VAR6 = (ARRAY) select 5
#define SELECT_7(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7) SELECT_6(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6); VAR7 = (ARRAY) select 6
#define SELECT_8(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8) SELECT_7(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7); VAR8 = (ARRAY) select 7
#define SELECT_9(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9) SELECT_8(ARRAY,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8); VAR9 = (ARRAY) select 8


// Creates private declarations and selection from _this array for arguments.
// Recommended for function/script argument processing.
// Example:
//      GIVEN:
//          _this = ["unit", "group", "trigger"];
//      WHEN:
//          FUN_ARGS_3(_unit,_group,_trigger);
//      THEN:
//          private ["_unit","_group","_trigger"];
//          _unit == "unit";
//          _group == "group";
//          _trigger == "trigger";
#define FUN_ARGS_1(VAR1) \
    PVT_1(VAR1); \
    SELECT_1(_this,VAR1)
    
#define FUN_ARGS_2(VAR1,VAR2) \
    PVT_2(VAR1,VAR2); \
    SELECT_2(_this,VAR1,VAR2)
    
#define FUN_ARGS_3(VAR1,VAR2,VAR3) \
    PVT_3(VAR1,VAR2,VAR3); \
    SELECT_3(_this,VAR1,VAR2,VAR3)
    
#define FUN_ARGS_4(VAR1,VAR2,VAR3,VAR4) \
    PVT_4(VAR1,VAR2,VAR3,VAR4); \
    SELECT_4(_this,VAR1,VAR2,VAR3,VAR4)
    
#define FUN_ARGS_5(VAR1,VAR2,VAR3,VAR4,VAR5) \
    PVT_5(VAR1,VAR2,VAR3,VAR4,VAR5); \
    SELECT_5(_this,VAR1,VAR2,VAR3,VAR4,VAR5)
    
#define FUN_ARGS_6(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6) \
    PVT_6(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6); \
    SELECT_6(_this,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6)
    
#define FUN_ARGS_7(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7) \
    PVT_7(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7); \
    SELECT_7(_this,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7)
    
#define FUN_ARGS_8(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8) \
    PVT_8(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8); \
    SELECT_8(_this,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8)
    
#define FUN_ARGS_9(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9) \
    PVT_9(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9); \
    SELECT_9(_this,VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9)

#endif //PLANK_MACROS_H