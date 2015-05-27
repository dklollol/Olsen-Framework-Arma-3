#include "core\gearCore.sqf" //DO NOT REMOVE

["ItemCompass"] call FNC_AddItem;
["ItemWatch"] call FNC_AddItem;
["ItemMap"] call FNC_AddItem;

["rhs_uniform_cu_ocp"] call FNC_AddItem;
["rhsusf_ach_helmet_ocp"] call FNC_AddItem;
["rhs_googles_black"] call FNC_AddItem;
["rhsusf_assault_eagleaiii_ocp"] call FNC_AddItem;

["ACRE_PRC343", 1, "uniform"] call FNC_AddItem;
["ACE_EarPlugs", 1, "uniform"] call FNC_AddItem;

["ACE_fieldDressing", 3, "uniform"] call FNC_AddItem;
["ACE_packingBandage", 3, "uniform"] call FNC_AddItem;
["ACE_elasticBandage", 3, "uniform"] call FNC_AddItem;
["ACE_tourniquet", 1, "uniform"] call FNC_AddItem;
["ACE_morphine", 1, "uniform"] call FNC_AddItem;
["ACE_epinephrine", 1, "uniform"] call FNC_AddItem;

switch (_type) do {
	
	case "SL": {
		
		["rhsusf_iotv_ocp_squadleader"] call FNC_AddItem;

		["16Rnd_9x21_Mag", 3, "uniform"] call FNC_AddItem;

		["ACRE_PRC148", 1, "vest"] call FNC_AddItem;
		["30Rnd_556x45_Stanag", 8, "vest"] call FNC_AddItem;
		["SmokeShell", 2, "vest"] call FNC_AddItem;
		["HandGrenade", 2, "vest"] call FNC_AddItem;

		["30Rnd_556x45_Stanag_Tracer_Red", 2, "backpack"] call FNC_AddItem;
		["FlareWhite_F", 2, "backpack"] call FNC_AddItem;

		["binocular"] call FNC_AddItem;

		["rhs_weap_m4a1_carryhandle"] call FNC_AddItem;
		["rhsusf_acc_ACOG"] call FNC_AddItem;

		["tb_p_g17_T"] call FNC_AddItem;
		["tb_acc_m6x_LLM"] call FNC_AddItem;
		
	};
};