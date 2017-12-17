//AUTHOR: Olsen
//
//[this, "RURiflePlatoon_SL"] call FNC_GearScript;
//[this, "RURiflePlatoon_TL"] call FNC_GearScript;
//[this, "RURiflePlatoon_AR"] call FNC_GearScript;
//[this, "RURiflePlatoon_MD"] call FNC_GearScript;
//[this, "RURiflePlatoon_RF"] call FNC_GearScript;
//[this, "RURiflePlatoon_RFAT"] call FNC_GearScript;

#define package "RURiflePlatoon_"

SET_GROUP(uniform)
	["rhs_uniform_vdv_emr_des"] call FNC_AddItem;
	["rhs_assault_umbts"] call FNC_AddItem;
	["rhs_6b28"] call FNC_AddItemRandom;
END_GROUP;
	
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
	
	["rhs_6b23_digi_6sh92_headset_mapcase"] call FNC_AddItem; //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["Binocular"] call FNC_AddItem;
	
	["ACRE_PRC152", 1] call FNC_AddItem; //Long range radio
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green", 2] call FNC_AddItem; //Magazines
	
	["rhs_mag_rdg2_white", 2] call FNC_AddItem; //White smoke
	["rhs_mag_rdg2_black", 2] call FNC_AddItem; //Black smoke
	["rhs_mag_rgd5", 2] call FNC_AddItem; //Frag grenade

	["rhs_weap_ak74m"] call FNC_AddItem; //Primary rifle
	["rhs_acc_pkas"] call FNC_AddItem; //Red dot sight
	
};

case (package + "TL"): {
	
	["rhs_6b23_digi_6sh92_radio"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FNC_AddItem; //Magazines
	["rhs_30Rnd_545x39_AK_green", 2] call FNC_AddItem; //Magazines
	
	["rhs_mag_rdg2_white", 2] call FNC_AddItem; //White smoke
	["rhs_mag_rdg2_black", 2] call FNC_AddItem; //Black smoke
	["rhs_mag_rgd5", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_VOG25", 12] call FNC_AddItem; //Frag Grenade  (m203)
	["rhs_GRD40_White", 6] call FNC_AddItem; //Red Smoke  (m203)
	
	["rhs_weap_ak74m_gp25"] call FNC_AddItem; //Primary rifle
	["rhs_acc_pkas"] call FNC_AddItem; //Red dot sight

};

case (package + "AR"): {
	
	["rhs_6b23_digi_6sh92"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 2] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_100Rnd_762x54mmR", 3] call FNC_AddItem; //Magazines
	
	["rhs_weap_pkp"] call FNC_AddItem; //Primary rifle
	["rhs_acc_pkas"] call FNC_AddItem; //Red dot sight
	["ACE_SpareBarrel", 1] call FNC_AddItem;  // Spare Barrel
	
};

case (package + "RFAT"): {
	
	["rhs_6b23_digi_6sh92"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 2] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FNC_AddItem; //Magazines
	
	["rhs_weap_ak74m"] call FNC_AddItem; //Primary rifle
	["rhs_acc_pkas"] call FNC_AddItem; //Red dot sight
	
	["rhs_weap_rpg26"] call FNC_AddItem; //Anti tank launcher
	
};

case (package + "RF"): {
	
	["rhs_6b23_digi_6sh92"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 2] call FNC_AddItem; //White smoke
	["rhs_mag_rgd5", 2] call FNC_AddItem; //Frag grenade
	
	["rhs_30Rnd_545x39_7N10_AK", 11] call FNC_AddItem; //Magazines
	
	["rhs_weap_ak74m"] call FNC_AddItem; //Primary rifle
	["rhs_acc_pkas"] call FNC_AddItem; //Red dot sight
	
	["rhs_100Rnd_762x54mmR", 1] call FNC_AddItem; //Spare AR ammo
	
};

case (package + "MD"): {
	
	["rhs_6b23_digi_6sh92"] call FNC_AddItem;  //Vest
	
	ADD_GROUP(uniform);
	ADD_GROUP(IFAK);
	ADD_GROUP(items);
	
	["rhs_mag_rdg2_white", 4] call FNC_AddItem; //White smoke
	
	["rhs_30Rnd_545x39_7N10_AK", 6] call FNC_AddItem; //Magazines
	
	["rhs_weap_ak74m"] call FNC_AddItem; //Primary rifle
	["rhs_acc_pkas"] call FNC_AddItem; //Red dot sight
	
	//Extra Medic Supplies
	["ACE_fieldDressing", 15] call FNC_AddItem;
	["ACE_elasticBandage", 20] call FNC_AddItem;
	["ACE_packingBandage", 20] call FNC_AddItem;
	["ACE_quikclot", 12] call FNC_AddItem;
	["ACE_atropine", 10] call FNC_AddItem;
	["ACE_morphine", 8] call FNC_AddItem;
	["ACE_epinephrine", 8] call FNC_AddItem;
	["ACE_tourniquet", 5] call FNC_AddItem;
	["ACE_salineIV_500", 1] call FNC_AddItem;
	["ACE_surgicalKit", 3] call FNC_AddItem;
	["ACE_personalAidKit", 3] call FNC_AddItem;
	
};