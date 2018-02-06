//AUTHOR: SgtDeadly12
//
//[this, "1989USARMY_RF"] call FNC_GearScript;
//[this, "1989USARMY_RFAT"] call FNC_GearScript;
//[this, "1989USARMY_SL"] call FNC_GearScript;
//[this, "1989USARMY_PSG"] call FNC_GearScript;
//[this, "1989USARMY_PL"] call FNC_GearScript;
//[this, "1989USARMY_RTO"] call FNC_GearScript;
//[this, "1989USARMY_TL"] call FNC_GearScript;
//[this, "1989USARMY_TLLAT"] call FNC_GearScript;
//[this, "1989USARMY_MG"] call FNC_GearScript;
//[this, "1989USARMY_GREN"] call FNC_GearScript;
//[this, "1989USARMY_DRGN"] call FNC_GearScript;
//[this, "1989USARMY_TC"] call FNC_GearScript;
//[this, "1989USARMY_GNR"] call FNC_GearScript;
//[this, "1989USARMY_DRVR"] call FNC_GearScript;
//[this, "1989USARMY_MD"] call FNC_GearScript;

#define package "1989USARMY_"

SET_GROUP(uniform)
	["usm_bdu_w"] call FNC_AddItem;
END_GROUP;
	
SET_GROUP(IFAK)
	["ACE_fieldDressing", 3, "uniform"] call FNC_AddItem;
	["ACE_elasticBandage", 3, "uniform"] call FNC_AddItem;
	["ACE_packingBandage", 3, "uniform"] call FNC_AddItem;
	["ACE_quikclot", 3, "vest"] call FNC_AddItem;
	["ACE_morphine", 1, "vest"] call FNC_AddItem;
	["ACE_epinephrine", 1, "vest"] call FNC_AddItem;
	["ACE_tourniquet", 1, "vest"] call FNC_AddItem;
END_GROUP;
	
SET_GROUP(items)
	["ItemMap"] call FNC_AddItem;
	["ItemCompass"] call FNC_AddItem;
	["ItemWatch"] call FNC_AddItem;
	["ACE_MapTools"] call FNC_AddItem;
	["ACE_earplugs"] call FNC_AddItem;
END_GROUP;

case (package + "RF"): { //Rifleman
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "RFAT"): { //LAT Rifleman
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
	["rhs_weap_M136"] call FNC_AddItem; //Disposable AT
	
};

case (package + "SL"): { //Squad Leader
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	["usm_pack_st138_prc77"] call FNC_AddItem; //Radio Backpack
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	["Binocular"] call FNC_AddItem;
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhsusf_acc_ACOG"; //4X Optic
	
};

case (package + "PSG"): { //Platoon Sergeant
	
	["usm_vest_pasgt_lbe_gr"] call FNC_AddItem;  //Vest
	["usm_pack_st138_prc77"] call FNC_AddItem; //Radio Backpack
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	["Binocular"] call FNC_AddItem;
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	["rhs_mag_M441_HE",4,"vest"] call FNC_AddItem; //M203 HE and Smokes
	["rhs_mag_m713_Red",2,"vest"] call FNC_AddItem;
	["rhs_mag_m714_White",2,"vest"] call FNC_AddItem;
	["rhs_mag_m715_Green",2,"vest"] call FNC_AddItem;
	
	["rhs_weap_m16a4_carryhandle_M203"] call FNC_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhsusf_acc_ACOG"; //4X Optic
	
};

case (package + "PL"): { //Platoon Leader
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	["Binocular"] call FNC_AddItem;
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "RTO"): { //Radio Telephone Operator
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	["usm_pack_st138_prc77"] call FNC_AddItem; //Radio Backpack
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "TL"): { //Team Leader
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "TLLAT"): { //Team Leader with Disposable AT
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
	["rhs_weap_M136"] call FNC_AddItem; //Disposable AT
	
};

case (package + "MG"): { //Machine Gunner

	["usm_vest_pasgt_lbe_mg"] call FNC_AddItem; //Vest

	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["hlc_100Rnd_762x51_T_M60E4",1,"vest"] call FNC_AddItem; //M60 Belts
	["hlc_100Rnd_762x51_M_M60E4",2,"vest"] call FNC_AddItem;
	["hlc_100Rnd_762x51_B_M60E4",4,"vest"] call FNC_AddItem;

	["hlc_lmg_M60E4"] call FNC_AddItem; //Primary MG
	
};

case (package + "GREN"): { //Grenadier
	
	["usm_vest_pasgt_lbe_gr"] call FNC_AddItem;  //Vest
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	["rhs_mag_M441_HE",4,"vest"] call FNC_AddItem; //M203 HE and Smokes
	["rhs_mag_m713_Red",2,"vest"] call FNC_AddItem;
	["rhs_mag_m714_White",2,"vest"] call FNC_AddItem;
	["rhs_mag_m715_Green",2,"vest"] call FNC_AddItem;
	
	["rhs_weap_m16a4_carryhandle_M203"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "DRGN"): { //Dragon ATGM Gunner
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	
	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	["ACE_M47_Daysight"] call FNC_AddItem; //Dragon Optic
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenade
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Mags
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
	["ACE_M47_Dragon"] call FNC_AddItem; //Dragon ATGM
	
};

case (package + "TC"): { //Tank Commander
	
	["usm_vest_pasgt"] call FNC_AddItem;  //Vest
	["usm_pack_st138_prc77"] call FNC_AddItem; //Radio Backpack
	
	["rhsusf_cvc_green_helmet","rhsusf_cvc_green_ess"] call FNC_AddItemRandom; //Helmets
	
	["Binocular"] call FNC_AddItem;
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",1,"vest"] call FNC_AddItem; //Magazines
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "GNR"): { //Vehicle Gunner
	
	["usm_vest_pasgt"] call FNC_AddItem;  //Vest
	
	["rhsusf_cvc_green_helmet","rhsusf_cvc_green_ess"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",1,"vest"] call FNC_AddItem; //Magazines
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "DRVR"): { //Vehicle Driver
	
	["usm_vest_pasgt"] call FNC_AddItem;  //Vest
	["usm_pack_alice"] call FNC_AddItem; //Backpack
	
	["rhsusf_cvc_green_helmet","rhsusf_cvc_green_ess"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",1,"vest"] call FNC_AddItem; //Magazines
	["ToolKit",1,"backpack"] call FNC_AddItem; //Toolkit to Repair Tracks
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
};

case (package + "MD"): { //Medic
	
	["usm_vest_pasgt_lbe_rm"] call FNC_AddItem;  //Vest
	["usm_pack_m5_medic"] call FNC_AddItem; //Medic Pack

	["usm_helmet_pasgt_w","usm_helmet_pasgt_g_w"] call FNC_AddItemRandom; //Helmets
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_m67",1,"vest"] call FNC_AddItem; //Frag Grenade
	["rhs_mag_an_m8hc",2,"vest"] call FNC_AddItem; //Smoke Grenades
	
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",8,"vest"] call FNC_AddItem; //Magazines
	["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",2,"vest"] call FNC_AddItem; //Tracer Magazines
	
	["rhs_weap_m16a4_carryhandle"] call FNC_AddItem; //Primary Rifle
	
	//Extra Medic Supplies
	["ACE_fieldDressing",15] call FNC_AddItem;
	["ACE_elasticBandage",20] call FNC_AddItem;
	["ACE_packingBandage",20] call FNC_AddItem;
	["ACE_quikclot",15] call FNC_AddItem;
	["ACE_morphine",8] call FNC_AddItem;
	["ACE_epinephrine",8] call FNC_AddItem;
	["ACE_tourniquet",5] call FNC_AddItem;
	["ACE_salineIV_250",2,"backpack"] call FNC_AddItem;
	["ACE_salineIV_500",2,"backpack"] call FNC_AddItem;
	["ACE_salineIV",2,"backpack"] call FNC_AddItem;
	["ACE_surgicalKit",1,"backpack"] call FNC_AddItem;
	["ACE_personalAidKit",3,"backpack"] call FNC_AddItem;
	
};