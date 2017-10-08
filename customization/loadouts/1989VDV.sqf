//AUTHOR: SgtDeadly12
//
//[this, "1989VDV_RF"] call FNC_GearScript;
//[this, "1989VDV_RFLAT"] call FNC_GearScript;
//[this, "1989VDV_AR"] call FNC_GearScript;
//[this, "1989VDV_RFAT"] call FNC_GearScript;
//[this, "1989VDV_RFASST"] call FNC_GearScript;
//[this, "1989VDV_TL"] call FNC_GearScript;
//[this, "1989VDV_SL"] call FNC_GearScript;
//[this, "1989VDV_PL"] call FNC_GearScript;
//[this, "1989VDV_MRKSMN"] call FNC_GearScript;
//[this, "1989VDV_GNR"] call FNC_GearScript;
//[this, "1989VDV_DRVR"] call FNC_GearScript;

#define package "1989VDV_"

#define uniform \
	["rhsgref_uniform_ttsko_forest"] call FNC_AddItem;
	
#define IFAK \
	["ACE_fieldDressing", 3, "uniform"] call FNC_AddItem; \
	["ACE_elasticBandage", 3, "uniform"] call FNC_AddItem; \
	["ACE_packingBandage", 3, "uniform"] call FNC_AddItem; \
	["ACE_quikclot", 3, "uniform"] call FNC_AddItem; \
	["ACE_morphine", 1, "uniform"] call FNC_AddItem; \
	["ACE_epinephrine", 1, "uniform"] call FNC_AddItem; \
	["ACE_tourniquet", 1, "uniform"] call FNC_AddItem;
	
#define items \
	["ItemMap"] call FNC_AddItem; \
	["ItemCompass"] call FNC_AddItem; \
	["ItemWatch"] call FNC_AddItem; \
	["ACE_MapTools"] call FNC_AddItem; \
	["ACE_earplugs"] call FNC_AddItem;
	
case (package + "RF"): { //Rifleman
	
	["rhs_6b5_ttsko"] call FNC_AddItem;  //Vest
	
	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines
	
	["rhs_weap_aks74"] call FNC_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
};

case (package + "RFLAT"): { //AT Rifleman
	
	["rhs_6b5_ttsko"] call FNC_AddItem;  //Vest
	
	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines
	
	["rhs_weap_aks74"] call FNC_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
	["rhs_weap_rpg26"] call FNC_AddItem; //Anti tank launcher
	
};

case (package + "AR"): { //Automatic Rifleman
	
	["rhs_6b5_ttsko"] call FNC_AddItem;	//Vest
	["rhs_sidor"] call FNC_AddItem; //Backpack
	
	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_45Rnd_545X39_7N10_AK",5,"vest"] call FNC_AddItem; //Magazines
	["rhs_45Rnd_545X39_7N10_AK",5,"backpack"] call FNC_AddItem; //Magazines
	["rhs_45Rnd_545X39_AK_Green",2,"backpack"] call FNC_AddItem; //Tracer Magazines
	
	["hlc_rifle_rpk"] call FNC_AddItem;//Primary Rifle

};
	
case (package + "RFAT"): { //AT Rifleman
	
	["rhs_6b5_ttsko"] call FNC_AddItem;  //Vest
	["rhs_rpg_empty"] call FNC_AddItem;	//backpack
	
	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines
	["rhs_rpg7_PG7VL_mag",3,"backpack"] call FNC_AddItem; //HEAT Rockets
	
	["rhs_weap_aks74"] call FNC_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
	["rhs_weap_rpg7"] call FNC_AddItem; //Rocket Launcher
	_unit addSecondaryWeaponItem "rhs_acc_pgo7v2";
	
};

case (package + "RFASST"): { //Assitant RPG Gunner
	
	["rhs_6b5_ttsko"] call FNC_AddItem;  //Vest
	["rhs_rpg_empty"] call FNC_AddItem;	//backpack
	
	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines
	["rhs_rpg7_PG7VL_mag",3,"backpack"] call FNC_AddItem; //HEAT Rockets
	
	["rhs_weap_aks74"] call FNC_AddItem; //Primary rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	
};

case (package + "TL"): { //Team Leader/Efreitor

	["rhs_6b5_ttsko"] call FNC_AddItem;  //Vest
	["rhs_sidor"] call FNC_AddItem; //Backpack

	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;

	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines
	
	["rhs_VOG25",4,"backpack"] call FNC_AddItem; //GP-25 HE and Smoke Grenades
	["rhs_GRD40_White",2,"backpack"] call FNC_AddItem;
	["rhs_GRD40_Green",2,"backpack"] call FNC_AddItem;
	["rhs_GRD40_Red",2,"backpack"] call FNC_AddItem;

	["rhs_weap_aks74_gp25"] call FNC_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider

};

case (package + "SL"): { //Squad Leader

	["rhs_6b5_ttsko"] call FNC_AddItem; //Vest
	["usm_pack_st138_prc77"] call FNC_AddItem; //Backpack Radio

	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["Binocular"] call FNC_AddItem;

	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines

	["rhs_weap_aks74n"] call FNC_AddItem;
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; //4X Optic

};

case (package + "PL"): { //Platoon Leader

	["rhs_6b5_officer_ttsko"] call FNC_AddItem; //Vest
	["usm_pack_st138_prc77"] call FNC_AddItem; //Backpack Radio

	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["Binocular"] call FNC_AddItem;

	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines

	["rhs_weap_aks74n"] call FNC_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_dtk1983"; //Flash Hider
	_unit addPrimaryWeaponItem "rhs_acc_1p29"; //4X Optic

};

case (package + "MRKSMN"): { //Marksman
	
	["rhs_6b5_sniper_ttsko"] call FNC_AddItem;  //Vest
	
	["rhsgref_ssh68_ttsko_forest"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhsgref_10Rnd_792x57_m76",10,"vest"] call FNC_AddItem; call FNC_AddItem; //Magazines
	
	["rhs_weap_m76"] call FNC_AddItem; //Marksman Rifle
	_unit addPrimaryWeaponItem "rhs_acc_pso1m2"; //Scope
	
};

case (package + "GNR"): { //Vehicle Gunner
	
	["rhs_6b5_ttsko"] call FNC_AddItem;  //Vest
	["usm_pack_st138_prc77"] call FNC_AddItem; //Backpack Radio
	
	["rhs_tsh4"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["Binocular"] call FNC_AddItem;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK",6,"vest"] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green",1,"vest"] call FNC_AddItem; //Tracer Magazines
	
	["rhs_weap_aks74u"] call FNC_AddItem; //Primary Rifle
	_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u"; //Flash Hider
	
};

case (package + "DRVR"): { //Vehicle Driver
	
	["rhs_6b5_ttsko"] call FNC_AddItem;  //Vest
	["rhs_sidor"] call FNC_AddItem; //Backpack
	
	["rhs_tsh4"] call FNC_AddItem; //Helmet
	
	uniform;
	IFAK;
	items;
	
	["rhs_mag_rdg2_white", 1] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 1] call FNC_AddItem; //Frag grenade
	
	["rhs_mag_9x18_8_57N181S",4,"vest"] call FNC_AddItem; //Pistol Magazines
	["ToolKit",1,"backpack"] call FNC_AddItem; //Toolkit to Repair Tracks
	
	["rhs_weap_makarov_pm"] call FNC_AddItem; //Pistol
	
};