/*	It's dangerous to go alone, take this:
	_ammoArray = [];
	{
		{
			_ammoClass = getText (configFile >> "CfgMagazines" >> _x >> "ammo");
			if !(_ammoClass in _ammoArray) then {
				_ammoArray set [count _ammoArray,_ammoClass];
			};
		} forEach magazines _x;
	} forEach allMissionObjects "ALL";
	diag_log _ammoArray;
*/

	aCount_textBLU = "BLUFOR Munitions Expended:";
	aCount_textRED = "REDFOR Munitions Expended:";

	//[displayName,[[classname],[classname]]]
	aCount_masterArray = [
		["5.56x45",[
			["rhs_ammo_556x45_M855A1_Ball"],
			["rhs_ammo_556x45_M855_Ball"],
			["B_556x45_Ball"]
		]],
		["7.62x51",[
			["UK3CB_BAF_762_Ball"],
			["HLC_762x51_ball"],
			["B_762x51_Tracer_Red"],
			["HLC_762x51_MK316_20in"],
			["B_762x51_Tracer_Yellow"],
			["rhs_ammo_762x51_M80_Ball"],
			["rhs_ammo_762x51_M80A1EPR_Ball"]
		]],
		["300 WIN MAG",[
			["rhsusf_B_300winmag"]
		]],
		["8mm Mauser",[
			["rhsusf_B_300winmag"]
		]],
		["7.62x54R",[
			["rhs_B_762x54_Ball"]
		]],
		["7.62x39",[
			["rhs_B_762x39_Ball"]
		]],
		[".45 ACP",[
			["rhs_ammo_45ACP_MHP"]
		]],
		["9x18",[
			["rhs_B_9x18_57N181S"]
		]],
		["9x19",[
			["rhs_ammo_9x19_FMJ"]
		]],
		["5.45x39",[
			["rhs_B_545x39_Ball"],
			["rhs_B_545x39_7N6_Ball"],
			["rhs_B_545x39_7N10_Ball"],
			["rhs_B_545x39_Ball_Tracer_Green"]
		]],
		["40MM Grenades",[
			["rhs_g_vog25"],
			["rhsusf_40mm_HE"],
			["rhsusf_40mm_HEDP"],
			["rhs_40mm_smoke_white"],
			["rhs_g_vg40md_white"],
			["G_40mm_HE"],
			["G_40mm_Smoke"],
			["G_40mm_SmokeGreen"],
			["rhsusf_40mm_white"],
			["rhsusf_40mm_green"],
			["rhsusf_40mm_red"],
			["G_40mm_SmokeRed"]	
		]],
		["Hand Grenades",[
			["rhs_ammo_m67"],
			["rhs_ammo_rgn"],
			["rhs_ammo_rgd5"]
		]],
		["Smoke Grenades",[
			["SmokeShell"],
			["SmokeShellGreen"],
			["SmokeShellRed"],
			["rhs_ammo_nspd"],
			["rhs_ammo_m18_purple"],
			["rhs_ammo_m18_yellow"],
			["rhs_ammo_rdg2_white"]
		]],
		["Chemlights",[
			["Chemlight_yellow"]
		]],
		["14.5x114",[
			["rhs_ammo_145x115mm"]
		]],
		[".50 CAL",[
			["rhs_ammo_127x108mm"],
			["rhs_ammo_127x99_Ball_Tracer_Red"],
			["B_127x99_Ball_Tracer_Yellow"]
		]],
		["25x137",[
			["RHS_ammo_M792_HEI"],
			["RHS_ammo_M919_APFSDS"]
		]],
		["30MM",[
			["B_30mm_MP_Tracer_Yellow"],
			["B_30mm_APFSDS_Tracer_Yellow"]
		]],
		["ATGM",[
			["rhs_ammo_TOW2A_AT"],
			["rhs_ammo_TOW2_BB"],
			["M_Titan_AT"],
			["rhs_ammo_9m119"],
			["rhs_ammo_9m131m"]
		]],
		["LAT",[
			["rhs_ammo_m72a7_rocket"],
			["rhs_rpg26_rocket"],
			["rhs_rshg2_rocket"],
			["rhs_ammo_M136_rocket"]
		]],
		["MAT",[
			["rhs_rpg7v2_pg7v"],
			["rhs_rpg7v2_pg7vl"],
			["rhs_rpg7v2_pg7vr"],
			["rhs_rpg7v2_og7v"],
			["rhs_rpg7v2_tbg7v"],
			["rhs_ammo_smaw_HEAA"],
			["rhs_ammo_smaw_HEDP"],
			["rhs_ammo_maaws_HEDP"],
			["rhs_ammo_maaws_HE"],
			["rhs_ammo_maaws_HEAT"]
		]],
		["125MM Shells",[
			["rhs_ammo_3bm42"],
			["rhs_ammo_3bm46"],
			["rhs_ammo_3bk18M"],
			["rhs_ammo_3bk31"],
			["rhs_ammo_3of26"]
		]],
		["60MM Mortar",[
			["UO_Sh_60mm"],
			["UO_Flare_60mm_white"],
			["Smoke_82mm_AMOS_White"]
		]]
	];