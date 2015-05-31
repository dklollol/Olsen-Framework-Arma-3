#include "core\gearCore.sqf" //DO NOT REMOVE

//Default shit:
#define USMCuniform \
["rhs_uniform_FROG01_d"] call FNC_AddItem; \
["ACRE_PRC343", 1, "uniform"] call FNC_AddItem; \
["Chemlight_green", 1, "uniform"] call FNC_AddItem; \
["Chemlight_red", 1, "uniform"] call FNC_AddItem; \
["ACE_CableTie", 1, "uniform"] call FNC_AddItem;

#define USMCvest \
["rhs_mag_m67", 1, "vest"] call FNC_AddItem; \
["rhs_mag_an_m8hc", 2, "vest"] call FNC_AddItem; 

#define USMCweapon \



//Everyone gets this stuff.
#define BASIC \
["ACE_fieldDressing", 3, "uniform"] call FNC_AddItem; \
["ACE_packingBandage", 3, "uniform"] call FNC_AddItem; \
["ACE_elasticBandage", 3, "uniform"] call FNC_AddItem; \
["ACE_tourniquet", 1, "uniform"] call FNC_AddItem; \
["ACE_morphine", 1, "uniform"] call FNC_AddItem; \
["ACE_epinephrine", 1, "uniform"] call FNC_AddItem ; \
["ItemCompass"] call FNC_AddItem; \
["ItemWatch"] call FNC_AddItem; \
["ItemMap"] call FNC_AddItem; \
["ACE_EarPlugs", 1, "uniform"] call FNC_AddItem;





//["rhsusf_assault_eagleaiii_ocp"] call FNC_AddItem;
//["30Rnd_556x45_Stanag_Tracer_Red", 2, "backpack"] call FNC_AddItem;
//["rhsusf_ach_helmet_ocp"] call FNC_AddItem; \ //Helmet


switch (side player) do { //Checks what team the player is on

	case west: { //If player is west he gets this gear.

		switch (_type) do {
	
			case "SL": {
				["rhsusf_iotv_ocp_squadleader"] call FNC_AddItem;
				USMCuniform;
				USMCvest;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag", 7, "vest"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2, "vest"] call FNC_AddItem;
				["rhsusf_mich_helmet_marpatd_alt"] call FNC_AddItem;
				["rhs_weap_m4a1_grip2"] call FNC_AddItem;
				["rhsusf_acc_anpeq15_light"] call FNC_AddItem;
				["rhsusf_acc_compm4"] call FNC_AddItem;
				["16Rnd_9x21_Mag", 2, "uniform"] call FNC_AddItem;
				["tb_p_g17_T"] call FNC_AddItem;
				["tb_acc_m6x_LLM"] call FNC_AddItem;
				["binocular"] call FNC_AddItem;
				["ACE_MapTools", 1, "vest"] call FNC_AddItem;
				["ACRE_PRC148", 1, "vest"] call FNC_AddItem;
				["rhs_mag_m18_red", 2, "vest"] call FNC_AddItem;
				["rhs_mag_m18_yellow", 2, "vest"] call FNC_AddItem;
				BASIC;
			};

			case "M": {
				["rhsusf_iotv_ocp_Medic"] call FNC_AddItem;
				USMCuniform;
				USMCvest;
				["rhsusf_ach_helmet_ocp"] call FNC_AddItem;
				["rhs_weap_m4"] call FNC_AddItem;
				["rhsusf_acc_anpeq15_light"] call FNC_AddItem;
				["rhsusf_acc_compm4"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag", 8, "vest"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 1, "vest"] call FNC_AddItem;
				["rhsusf_assault_eagleaiii_coy"] call FNC_AddItem;
				["ACE_personalAidKit", 5, "backpack"] call FNC_AddItem;
				["ACE_packingBandage", 20, "backpack"] call FNC_AddItem;
				["ACE_elasticBandage", 20, "backpack"] call FNC_AddItem;
				["ACE_quikclot", 20, "backpack"] call FNC_AddItem;
				["ACE_tourniquet", 8, "backpack"] call FNC_AddItem;
				["ACE_salineIV_250", 3, "backpack"] call FNC_AddItem;
				["ACE_morphine", 10, "backpack"] call FNC_AddItem;
				["ACE_epinephrine", 10, "backpack"] call FNC_AddItem;
				["ACE_atropine", 5, "backpack"] call FNC_AddItem;
				["ACE_surgicalKit", 2, "backpack"] call FNC_AddItem;
				BASIC;
			};

			case "TL": {
				["rhsusf_iotv_ocp_Teamleader"] call FNC_AddItem;
				USMCuniform;
				USMCvest;
				["rhsusf_mich_helmet_marpatd_alt"] call FNC_AddItem;
				["rhs_weap_m4_m203"] call FNC_AddItem;
				["rhsusf_acc_anpeq15_light"] call FNC_AddItem;
				["rhsusf_acc_compm4"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag", 8, "vest"] call FNC_AddItem;
				["rhs_mag_M441_HE", 8, "vest"] call FNC_AddItem;
				["rhs_mag_m67", 2, "vest"] call FNC_AddItem;
				["ACE_MapTools", 1, "vest"] call FNC_AddItem;
				["ACRE_PRC148", 1, "vest"] call FNC_AddItem;
				["rhsusf_assault_eagleaiii_coy"] call FNC_AddItem;
				["DemoCharge_Remote_Mag", 2, "backpack"] call FNC_AddItem;
				["ACE_Clacker", 1, "backpack"] call FNC_AddItem;
				["ACE_DefusalKit", 1, "backpack"] call FNC_AddItem;
				["DemoCharge_Remote_Mag", 2, "backpack"] call FNC_AddItem;
				BASIC;
			};

			case "ARM27": {
				["rhsusf_iotv_ocp_SAW"] call FNC_AddItem;
				USMCuniform;
				USMCvest;
				["rhsusf_ach_helmet_ocp"] call FNC_AddItem;
				["rhs_weap_m4a1"] call FNC_AddItem;
				["rhsusf_acc_anpeq15_light"] call FNC_AddItem;
				["rhsusf_acc_compm4"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11, "vest"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 3, "vest"] call FNC_AddItem;
				["rhs_mag_M441_HE", 8, "vest"] call FNC_AddItem;
				["rhs_mag_m67", 2, "vest"] call FNC_AddItem;
				BASIC;
			};

			case "RIFLE": {
				["rhsusf_iotv_ocp_Rifleman"] call FNC_AddItem;
				USMCuniform;
				USMCvest;
				["rhsusf_ach_helmet_ocp"] call FNC_AddItem;
				["rhs_weap_m16a4_grip"] call FNC_AddItem;
				["rhsusf_acc_anpeq15_light"] call FNC_AddItem;
				["rhsusf_acc_compm4"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11, "vest"] call FNC_AddItem;
				["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 3, "vest"] call FNC_AddItem;
				["rhs_mag_M441_HE", 8, "vest"] call FNC_AddItem;
				["rhs_mag_m67", 2, "vest"] call FNC_AddItem;
				BASIC;
			};

		};

	}; //End of west case

	case east: { //If player is east he gets this gear.

		switch (_type) do {
	
			/* case "SL": {
				USMCBASIC;
				["rhs_weap_m4a1_grip2"] call FNC_AddItem;
				["rhsusf_acc_compm4"] call FNC_AddItem;
			}; */

		};

	}; //End of east case

}; //End of side player switch