["Ammo Counter", "Counts ammunition types fired and displays it in the mission endscreen.", "TinfoilHate"] call FNC_RegisterModule;

//Ammo Counter Initilization
//Much script by beta, some script by TinfoilHate
//Sets up ammo counting
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

	if (isServer) then {
		aCount_556BLU = 0;
		aCount_762BLU = 0;
		aCount_762RBLU = 0;
		aCount_762AKBLU = 0;
		aCount_792MMBLU = 0;
		aCount_45BLU = 0;
		aCount_545BLU = 0;
		aCount_40MMBLU = 0;
		aCount_GRENBLU = 0;
		aCount_SMOKEBLU = 0;
		aCount_CHEMBLU = 0;
		aCount_KPVTBLU = 0;
		aCount_DSHKMBLU = 0;
		aCount_25MMBLU = 0;
		aCount_TOWBLU = 0;
		aCount_LATBLU = 0;
		aCount_MATBLU = 0;

		aCount_556RED = 0;
		aCount_762RED = 0;
		aCount_762RRED = 0;
		aCount_762AKRED = 0;
		aCount_792MMRED = 0;
		aCount_45RED = 0;
		aCount_545RED = 0;
		aCount_40MMRED = 0;
		aCount_GRENRED = 0;
		aCount_SMOKERED = 0;
		aCount_CHEMRED = 0;
		aCount_KPVTRED = 0;
		aCount_DSHKMRED = 0;
		aCount_25MMRED = 0;
		aCount_TOWRED = 0;
		aCount_LATRED = 0;
		aCount_MATRED = 0;


		aCount_addEH = {	//If units are spawned, this should be run on them: ["aCount_event_addEH", UNIT] call CBA_fnc_serverEvent;
			_obj = param [0];

			_obj setVariable ["aCount_originalSide",side _obj,false];

			if (_obj isKindOf "Man") then {
				_obj addEventHandler ["fired", {[((_this select 0) getVariable "aCount_originalSide"), (_this select 4)] call aCount_shotCount;}];
				_obj setVariable ["aCount_firedEh", true, false];
			};

			if (((_obj isKindOf "Land") && !(_obj isKindOf "Man")) || (_obj isKindOf "Air") || (_obj isKindOf "Ship")) then {
				if (count crew _obj > 0) then {
					{
						_x setVariable ["aCount_firedEh", true, false];
						_x setVariable ["aCount_originalSide",side _obj,false];
					} forEach crew _obj;
				};
				_obj addEventHandler ["fired", {[((crew (_this select 0)) select 0 getVariable "aCount_originalSide"), (_this select 4)] call aCount_shotCount;}];
				_obj setVariable ["aCount_firedEh", true, false];
			};
		};
		["aCount_event_addEH",aCount_addEH] call CBA_fnc_addEventHandler;

		aCount_shotCount = {
			switch (_this select 0) do {
				case WEST: {
					switch (_this select 1) do {
						case "rhs_ammo_556x45_M855A1_Ball": 		{ aCount_556BLU = aCount_556BLU + 1; };

						case "UK3CB_BAF_762_Ball": 					{ aCount_762BLU = aCount_762BLU + 1; };
						case "HLC_762x51_ball": 					{ aCount_762BLU = aCount_762BLU + 1; };
						case "B_762x51_Tracer_Red": 				{ aCount_762BLU = aCount_762BLU + 1; };
						case "HLC_762x51_MK316_20in": 				{ aCount_762BLU = aCount_762BLU + 1; };
						
						case "rhs_ammo_792x57_Ball": 				{ aCount_792MMBLU = aCount_792MMBLU + 1; };

						case "rhs_B_762x54_Ball": 					{ aCount_762RBLU = aCount_762RBLU + 1; };
						case "rhs_B_762x39_Ball": 					{ aCount_762AKBLU = aCount_762AKBLU + 1; };

						case "rhs_ammo_45ACP_MHP": 					{ aCount_45BLU = aCount_45BLU + 1; };

						case "rhs_B_545x39_Ball": 					{ aCount_545BLU = aCount_545BLU + 1; };
						case "rhs_B_545x39_Ball_Tracer_Green": 		{ aCount_545BLU = aCount_545BLU + 1; };

						case "rhs_g_vog25": 						{ aCount_40MMBLU = aCount_40MMBLU + 1; };
						case "rhsusf_40mm_HE": 						{ aCount_40MMBLU = aCount_40MMBLU + 1; };
						case "rhsusf_40mm_HEDP": 					{ aCount_40MMBLU = aCount_40MMBLU + 1; };
						case "rhs_40mm_smoke_white": 				{ aCount_40MMBLU = aCount_40MMBLU + 1; };

						case "rhs_ammo_m67": 						{ aCount_GRENBLU = aCount_GRENBLU + 1; };
						case "rhs_ammo_rgn": 						{ aCount_GRENBLU = aCount_GRENBLU + 1; };
						case "rhs_ammo_rgd5": 						{ aCount_GRENBLU = aCount_GRENBLU + 1; };

						case "SmokeShell": 							{ aCount_SMOKEBLU = aCount_SMOKEBLU + 1; };
						case "SmokeShellGreen": 					{ aCount_SMOKEBLU = aCount_SMOKEBLU + 1; };
						case "SmokeShellRed": 						{ aCount_SMOKEBLU = aCount_SMOKEBLU + 1; };
						case "rhs_ammo_nspd": 						{ aCount_SMOKEBLU = aCount_SMOKEBLU + 1; };
						case "rhs_ammo_rdg2_white": 				{ aCount_SMOKEBLU = aCount_SMOKEBLU + 1; };

						case "Chemlight_yellow": 					{ aCount_CHEMBLU = aCount_CHEMBLU + 1; };

						case "rhs_ammo_145x115mm": 					{ aCount_KPVTBLU = aCount_KPVTBLU + 1; };

						case "rhs_ammo_127x108mm": 					{ aCount_DSHKMBLU = aCount_DSHKMBLU + 1; };

						case "RHS_ammo_M792_HEI": 					{ aCount_25MMBLU = aCount_25MMBLU + 1; };
						case "RHS_ammo_M919_APFSDS": 				{ aCount_25MMBLU = aCount_25MMBLU + 1; };

						case "rhs_ammo_TOW2A_AT": 					{ aCount_TOWBLU = aCount_TOWBLU + 1; };
						case "rhs_ammo_TOW2_BB": 					{ aCount_TOWBLU = aCount_TOWBLU + 1; };

						case "rhs_ammo_m72a7_rocket": 				{ aCount_LATBLU = aCount_LATBLU + 1; };
						case "rhs_rpg26_rocket": 					{ aCount_LATBLU = aCount_LATBLU + 1; };
						case "rhs_rshg2_rocket": 					{ aCount_LATBLU = aCount_LATBLU + 1; };

						case "rhs_rpg7v2_pg7v": 					{ aCount_MATBLU = aCount_MATBLU + 1; };
						case "rhs_rpg7v2_pg7vl": 					{ aCount_MATBLU = aCount_MATBLU + 1; };
						case "rhs_rpg7v2_og7v": 					{ aCount_MATBLU = aCount_MATBLU + 1; };
					};
				};

				case EAST: {
					switch (_this select 1) do {
						case "rhs_ammo_556x45_M855A1_Ball": 		{ aCount_556RED = aCount_556RED + 1; };

						case "UK3CB_BAF_762_Ball": 					{ aCount_762RED = aCount_762RED + 1; };
						case "HLC_762x51_ball": 					{ aCount_762RED = aCount_762RED + 1; };
						case "B_762x51_Tracer_Red": 				{ aCount_762RED = aCount_762RED + 1; };
						case "HLC_762x51_MK316_20in": 				{ aCount_762RED = aCount_762RED + 1; };
						
						case "rhs_ammo_792x57_Ball": 				{ aCount_792MMRED = aCount_792MMRED + 1; };

						case "rhs_B_762x54_Ball": 					{ aCount_762RRED = aCount_762RRED + 1; };
						case "rhs_B_762x39_Ball": 					{ aCount_762AKRED = aCount_762AKRED + 1; };

						case "rhs_ammo_45ACP_MHP": 					{ aCount_45RED = aCount_45RED + 1; };

						case "rhs_B_545x39_Ball": 					{ aCount_545RED = aCount_545RED + 1; };
						case "rhs_B_545x39_Ball_Tracer_Green": 		{ aCount_545RED = aCount_545RED + 1; };

						case "rhs_g_vog25": 						{ aCount_40MMRED = aCount_40MMRED + 1; };
						case "rhsusf_40mm_HE": 						{ aCount_40MMRED = aCount_40MMRED + 1; };
						case "rhsusf_40mm_HEDP": 					{ aCount_40MMRED = aCount_40MMRED + 1; };
						case "rhs_40mm_smoke_white": 				{ aCount_40MMRED = aCount_40MMRED + 1; };
						
						case "rhs_ammo_m67": 						{ aCount_GRENRED = aCount_GRENRED + 1; };
						case "rhs_ammo_rgn": 						{ aCount_GRENRED = aCount_GRENRED + 1; };
						case "rhs_ammo_rgd5": 						{ aCount_GRENRED = aCount_GRENRED + 1; };

						case "SmokeShell": 							{ aCount_SMOKERED = aCount_SMOKERED + 1; };
						case "SmokeShellGreen": 					{ aCount_SMOKERED = aCount_SMOKERED + 1; };
						case "SmokeShellRed": 						{ aCount_SMOKERED = aCount_SMOKERED + 1; };
						case "rhs_ammo_nspd": 						{ aCount_SMOKERED = aCount_SMOKERED + 1; };
						case "rhs_ammo_rdg2_white": 				{ aCount_SMOKERED = aCount_SMOKERED + 1; };										

						case "Chemlight_yellow": 					{ aCount_CHEMRED = aCount_CHEMRED + 1; };

						case "rhs_ammo_145x115mm": 					{ aCount_KPVTRED = aCount_KPVTRED + 1; };

						case "rhs_ammo_127x108mm": 					{ aCount_DSHKMRED = aCount_DSHKMRED + 1; };


						case "RHS_ammo_M792_HEI": 					{ aCount_25MMRED = aCount_25MMRED + 1; };
						case "RHS_ammo_M919_APFSDS": 				{ aCount_25MMRED = aCount_25MMRED + 1; };

						case "rhs_ammo_TOW2A_AT": 					{ aCount_TOWRED = aCount_TOWRED + 1; };
						case "rhs_ammo_TOW2_BB": 					{ aCount_TOWRED = aCount_TOWRED + 1; };

						case "rhs_ammo_m72a7_rocket": 				{ aCount_LATRED = aCount_LATRED + 1; };
						case "rhs_rpg26_rocket": 					{ aCount_LATRED = aCount_LATRED + 1; };
						case "rhs_rshg2_rocket": 					{ aCount_LATRED = aCount_LATRED + 1; };

						case "rhs_rpg7v2_pg7v": 					{ aCount_MATRED = aCount_MATRED + 1; };
						case "rhs_rpg7v2_pg7vl": 					{ aCount_MATRED = aCount_MATRED + 1; };
						case "rhs_rpg7v2_og7v": 					{ aCount_MATRED = aCount_MATRED + 1; };
					};
				};
			};
		};

		aCount_endCount = {
			_munitionsBLU = [];
			if (aCount_556BLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_556BLU,"5.56x45"]]; };
			if (aCount_762BLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_762BLU,"7.62x51"]]; };
			if (aCount_762RBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_762RBLU,"7.62x54R"]]; };
			if (aCount_762AKBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_762AKBLU,"7.62x39"]]; };
			if (aCount_792MMBLU > 0) then { _munitionsRED set [count _munitionsBLU,[aCount_792MMBLU,"7.92x57 Mauser"]]; };
			if (aCount_45BLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_45BLU,".45 ACP"]]; };
			if (aCount_545BLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_545BLU,"5.45x39"]]; };
			if (aCount_40MMBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_40MMBLU,"40MM Grenades"]]; };
			if (aCount_GRENBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_GRENBLU,"Hand Grenades"]]; };
			if (aCount_SMOKEBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_SMOKEBLU,"Smoke Grenades"]]; };
			if (aCount_CHEMBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_CHEMBLU,"Chemlights"]]; };
			if (aCount_KPVTBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_KPVTBLU,"14.5x114"]]; };
			if (aCount_DSHKMBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCoun792_DSHKMBLU,"12.7x108"]]; };
			if (aCount_25MMBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_25MMBLU,"25x137"]]; };
			if (aCount_TOWBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_TOWBLU,"TOW Missile"]]; };
			if (aCount_LATBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_LATBLU,"LAT"]]; };
			if (aCount_MATBLU > 0) then { _munitionsBLU set [count _munitionsBLU,[aCount_MATBLU,"RPG"]]; };

			_munitionsRED = [];
			if (aCount_556RED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_556RED,"5.56x45"]]; };
			if (aCount_762RED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_762RED,"7.62x51"]]; };
			if (aCount_762RRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_762RRED,"7.62x54R"]]; };
			if (aCount_762AKRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_762AKRED,"7.62x39"]]; };
			if (aCount_792MMRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_792MMRED,"7.92x57 Mauser"]]; };
			if (aCount_45RED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_45RED,".45 ACP"]]; };
			if (aCount_545RED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_545RED,"5.45x39"]]; };
			if (aCount_40MMRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_40MMRED,"40MM Grenades"]]; };
			if (aCount_GRENRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_GRENRED,"Hand Grenades"]]; };
			if (aCount_SMOKERED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_SMOKERED,"Smoke Grenades"]]; };
			if (aCount_CHEMRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_CHEMRED,"Chemlights"]]; };
			if (aCount_KPVTRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_KPVTRED,"14.5x114"]]; };
			if (aCount_DSHKMRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_DSHKMRED,"12.7x108"]]; };
			if (aCount_25MMRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_25MMRED,"25x137"]]; };
			if (aCount_TOWRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_TOWRED,"TOW Missile"]]; };
			if (aCount_LATRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_LATRED,"LAT"]]; };
			if (aCount_MATRED > 0) then { _munitionsRED set [count _munitionsRED,[aCount_MATRED,"RPG"]]; };

			["aCount_event_scoreScreen", [_munitionsBLU,_munitionsRED]] call CBA_fnc_globalEvent;
		};
	};

	if (!isDedicated && hasInterface) then {
		aCount_shotDisplay = {
			_this spawn {
				_arrayBLU = param [0];
				_arrayRED = param [1];

				aCount_textBLU = "BLUFOR Munitions Expended:<br/>";
				aCount_textRED = "REDFOR Munitions Expended:<br/>";

				{
					_count = _x select 0;
					_label = _x select 1;

					aCount_textBLU = aCount_textBLU + _label + ": " + str(_count) + "<br/>";
				} forEach _arrayBLU;
				{
					_count = _x select 0;
					_label = _x select 1;

					aCount_textRED = aCount_textRED + _label + ": " + str(_count) + "<br/>";
				} forEach _arrayRED;
			};
		};

		["aCount_event_scoreScreen",aCount_shotDisplay] call CBA_fnc_addEventHandler;
	};