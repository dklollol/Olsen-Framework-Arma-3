//AUTHOR: Olsen
//
//[this, "USMCRiflePlatoon_SL"] call FNC_GearScript;
//[this, "USMCRiflePlatoon_TL"] call FNC_GearScript;
//[this, "USMCRiflePlatoon_AR"] call FNC_GearScript;
//[this, "USMCRiflePlatoon_MD"] call FNC_GearScript;
//[this, "USMCRiflePlatoon_RF"] call FNC_GearScript;
//[this, "USMCRiflePlatoon_RFAT"] call FNC_GearScript;

#define package "USMCRiflePlatoon_"

SET_GROUP(uniform)
	["rhs_uniform_FROG01_d"] call FNC_AddItem;
	["rhsusf_assault_eagleaiii_coy"] call FNC_AddItem;
	["rhsusf_lwh_helmet_marpatd", "rhsusf_lwh_helmet_marpatd_ess", "rhsusf_lwh_helmet_marpatd_headset"] call FNC_AddItemRandom;
END_GROUP;

//["rhs_uniform_FROG01_wd"] call FNC_AddItem; Woodland Cammo
//["rhsusf_lwh_helmet_marpatwd","rhsusf_lwh_helmet_marpatwd_ess","rhsusf_lwh_helmet_marpatwd_headset"] call FNC_AddItemRandom; Woodland Cammo
		
SET_GROUP(IFAK)
	["ACE_fieldDressing", 6, "uniform"] call FNC_AddItem;
	["ACE_elasticBandage", 6, "uniform"] call FNC_AddItem;
	["ACE_packingBandage", 6, "uniform"] call FNC_AddItem;
	["ACE_quikclot", 6, "uniform"] call FNC_AddItem;
	["ACE_morphine", 1, "uniform"] call FNC_AddItem;
	["ACE_epinephrine", 1, "uniform"] call FNC_AddItem;
	["ACE_tourniquet", 1, "uniform"] call FNC_AddItem;
END_GROUP;
	
SET_GROUP(items)
	["ACRE_PRC343", 1] call FNC_AddItem;
	["ItemMap"] call FNC_AddItem;
	["ItemCompass"] call FNC_AddItem;
	["ItemWatch"] call FNC_AddItem;
	["ACE_MapTools"] call FNC_AddItem;
	["ACE_earplugs"] call FNC_AddItem;
END_GROUP;
	
case (package + "SL"): {
	
	["rhsusf_spc_squadleader"] call FNC_AddItem; //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["ACE_Vector"] call FNC_AddItem;
	
	["ACRE_PRC152", 1] call FNC_AddItem; //Long range radio
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FNC_AddItem; //Tracer magazines
	
	["rhs_mag_an_m8hc", 2] call FNC_AddItem; //White smoke
	["rhs_mag_m18_purple", 2] call FNC_AddItem; //Purple Smoke
	["rhs_mag_m18_red", 2] call FNC_AddItem; //Red Smoke
	["rhs_mag_m67", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_weap_m4_carryhandle"] call FNC_AddItem; //Primary rifle
	["rhsusf_acc_compm4"] call FNC_AddItem; //Red dot sight

};

case (package + "TL"): {
	
	["rhsusf_spc_teamleader"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 2] call FNC_AddItem; //Tracer magazines
	
	["rhs_mag_an_m8hc", 2] call FNC_AddItem; //White smoke
	["rhs_mag_m67", 2] call FNC_AddItem; //Frag grenade
	
	
	["1Rnd_HE_Grenade_shell", 12] call FNC_AddItem; //Frag Grenade  (m203)
	["1Rnd_SmokeRed_Grenade_shell", 6] call FNC_AddItem; //Red Smoke  (m203)
	
	["rhs_mag_m18_purple", 2] call FNC_AddItem; //Purple Smoke
	["rhs_mag_m18_red", 2] call FNC_AddItem; //Red Smoke
	
	["rhs_weap_m4_m203S"] call FNC_AddItem; //Primary rifle
	["rhsusf_acc_compm4"] call FNC_AddItem; //Red dot sight
	
};

case (package + "AR"): {
	
	["rhsusf_spc_mg"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 2] call FNC_AddItem; //White smoke
	["rhs_mag_m67", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_200rnd_556x45_M_SAW", 3] call FNC_AddItem; //Magazines
	
	["rhs_weap_m249_pip_usmc"] call FNC_AddItem; //Primary rifle
	["rhsusf_acc_compm4"] call FNC_AddItem; //Red dot sight
	["ACE_SpareBarrel", 1] call FNC_AddItem;  // Spare Barrel
	
};

case (package + "RFAT"): {
	
	["rhsusf_spc_rifleman"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 2] call FNC_AddItem; //White smoke
	["rhs_mag_m67", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FNC_AddItem; //Magazines
	
	["rhs_weap_m4_carryhandle"] call FNC_AddItem; //Primary rifle
	["rhsusf_acc_compm4"] call FNC_AddItem; //Red dot sight
	
	["rhs_weap_M136_hedp"] call FNC_AddItem; //Anti tank launcher
	
};

case (package + "RF"): {
	
	["rhsusf_spc_rifleman"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 2] call FNC_AddItem; //White smoke
	["rhs_mag_m67", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FNC_AddItem; //Magazines
	
	["rhs_weap_m4_carryhandle"] call FNC_AddItem; //Primary rifle
	["rhsusf_acc_compm4"] call FNC_AddItem; //Red dot sight
	
	["rhs_200rnd_556x45_M_SAW", 1] call FNC_AddItem; //Spare AR ammo
	
};

case (package + "MD"): {
	
	["rhsusf_spc_corpsman"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_an_m8hc", 4] call FNC_AddItem; //White smoke
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag", 11] call FNC_AddItem; //Magazines
	
	["rhs_weap_m4_carryhandle"] call FNC_AddItem; //Primary rifle
	["rhsusf_acc_compm4"] call FNC_AddItem; //Red dot sight
	
	//Extra Medic Supplies
	["ACE_fieldDressing", 15] call FNC_AddItem;
	["ACE_elasticBandage", 20] call FNC_AddItem;
	["ACE_packingBandage", 20] call FNC_AddItem;
	["ACE_quikclot", 15] call FNC_AddItem;
	["ACE_atropine", 12] call FNC_AddItem;
	["ACE_morphine", 8] call FNC_AddItem;
	["ACE_epinephrine", 8] call FNC_AddItem;
	["ACE_tourniquet", 5] call FNC_AddItem;
	["ACE_salineIV_500", 1] call FNC_AddItem;
	["ACE_surgicalKit", 3] call FNC_AddItem;
	["ACE_personalAidKit", 3] call FNC_AddItem;
	
};	