if (isServer) then {
    #include "settings.sqf"
    
    {
        _x params ["_center", "_radious"];
        if (isNil "_center") then {
            "building_replacer module is missing logic defining center of AO!" call FNC_debugMessage;
        }
        else {
            private _replacements = [
                ["Land_HouseV_1L2","Land_d_HouseV_1L2",0],
                ["Land_HouseV_1t","Land_d_HouseV_1t",0],
                ["Land_HouseV_2I","Land_d_HouseV_2I",0],
                ["Land_HouseV_2L","Land_d_HouseV_2L",0],
                ["Land_HouseV_2T1","Land_d_HouseV_2T1",0],
                ["Land_HouseV_2T2","Land_d_HouseV_2T2",0],
                ["Land_HouseV_3I1","Land_d_HouseV_3I1",0],
                ["Land_HouseV_3I2","Land_d_HouseV_3I2",0],
                ["Land_HouseV_3I3","Land_d_HouseV_3I3",0],
                ["Land_HouseV_3I4","Land_d_HouseV_3I4",0],
                ["Land_a_stationhouse","Land_Jbad_A_Stationhouse",0],
                ["Land_SS_hangar","Land_jbad_hangar_withdoor",0],
                ["Land_Mil_House","Land_Jbad_Mil_House",0],
                ["Land_Mil_Barracks","Land_Jbad_Mil_Barracks",0],
                ["Land_Mil_ControlTower","Land_Jbad_Mil_ControlTower",0],
                ["Land_Mil_Guardhouse","Land_Jbad_Mil_Guardhouse",0],
                ["Land_Mil_Barracks_L","Land_Mil_Barracks_i",90],
                ["Land_House_K_1_EP1", "Land_jbad_House_1", 0],
                ["Land_House_K_2_EP1", "Land_jbad_House2", 0],
                ["Land_House_K_3_EP1", "Land_jbad_House3", 0],
                ["Land_House_K_4_EP1", "Land_jbad_House4", 0],
                ["Land_House_K_5_EP1", "Land_jbad_House5", 0],
                ["Land_House_K_6_EP1", "Land_jbad_House6", 0],
                ["Land_House_K_7_EP1", "Land_jbad_House7", 0],
                ["Land_House_K_8_EP1", "Land_jbad_House8", 0],
                ["Land_House_C_1_EP1", "Land_jbad_House_c_1", 0],
                ["Land_House_C_1_v2_EP1", "Land_jbad_House_c_1_v2", 0],
                ["Land_House_C_2_EP1", "Land_jbad_House_c_2", 0],
                ["Land_House_C_3_EP1", "Land_jbad_House_c_3", 0],
                ["Land_House_C_4_EP1", "Land_jbad_House_c_4", 0],
                ["Land_House_C_5_EP1", "Land_jbad_House_c_5", 0],
                ["Land_House_C_5_V1_EP1", "Land_jbad_House_c_5_v1", 0],
                ["Land_House_C_5_V2_EP1", "Land_jbad_House_c_5_v2", 0],
                ["Land_House_C_5_V3_EP1", "Land_jbad_House_c_5_v3", 0],
                ["Land_House_C_6_EP1", "Land_jbad_House_c_6", 0],
                ["Land_House_C_7_EP1", "Land_jbad_House_c_7", 0],
                ["Land_House_C_8_EP1", "Land_jbad_House_c_8", 0],
                ["Land_House_C_9_EP1", "Land_jbad_House_c_9", 0],
                ["Land_House_C_10_EP1", "Land_jbad_House_c_10", 0],
                ["Land_House_C_11_EP1", "Land_jbad_House_c_11", 0],
                ["Land_House_C_12_EP1", "Land_jbad_House_c_12", 0],
                ["Land_House_L_1_EP1", "Land_jbad_House_1_old", 0],
                ["Land_House_L_3_EP1", "Land_jbad_House_3_old", 0],
                ["Land_House_L_4_EP1", "Land_jbad_House_4_old", 0],
                ["Land_House_L_5_EP1", "Land_jbad_House_5_old", 0],
                ["Land_House_L_6_EP1", "Land_jbad_House_6_old", 0],
                ["Land_House_L_7_EP1", "Land_jbad_House_7_old", 0],
                ["Land_House_L_8_EP1", "Land_jbad_House_8_old", 0],
                ["Land_House_L_9_EP1", "Land_jbad_House_9_old", 0]
             ];

            {
                private _building = _x;
                
                {
                    _x params ["_replaced", "_replacing", "_offset"];
                    
                    if ((typeOf _building) isEqualTo _replaced) exitWith {
                        _obj = _replacing createVehicle [0,0,0];
                        _obj setDir (getDir _building) + _offset;
                        _obj setPosASL getPosASLVisual _building;
                        _obj setVectorUp vectorUp _building;
                        hideObjectGlobal _building;
                        _building allowDamage false;
                    };
                    
                } foreach _replacements;
                
            } foreach (nearestTerrainObjects [getpos _center, ["HOUSE"], _radious, false])
        };
    } foreach REPLACE_AREAS;
};