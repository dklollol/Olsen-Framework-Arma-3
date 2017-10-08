
	FNC_assignMedic = {	//Make a unit a medic, also works for medical vehicles. Ex: [this,2] call FNC_assignMedic; makes a unit or medical vehicle a 'doctor' level.
		private ["_unit","_type"];

		_unit = _this select 0; //Unit to be a medic
		_type = _this select 1;	//2 Doctor, 1 Medic, 0 Normal

		if (local _unit) then {
			_unit setVariable ["ace_medical_medicClass",_type,true];
		};
	};

	FNC_assignMedicBagCargo = {	//Add packed medical packs to a vehicle's cargo. Ex: [this,"usm_pack_m5_medic",1] call FNC_assignMedicBagCargo; Be aware it will fill every once of that class name, so use something unique like a medical bag.
		if (!isServer) exitWith {};

		private ["_unit","_type","_amt"];

		_unit 	= _this select 0;	//Vehicle to add a medic bag to
		_type 	= _this select 1;	//Class of backpack to add
		_amt 	= _this select 2;	//Number of bags to add

		[{
			(_this select 0) addBackpackCargoGlobal [(_this select 1),(_this select 2)];
			{
				if (typeOf _x == (_this select 1)) then {
					clearBackpackCargoGlobal _x;
					clearItemCargoGlobal _x;
					clearMagazineCargoGlobal _x;
					clearWeaponCargoGlobal _x;

					_x addItemCargoGlobal ["ACE_salineIV",5];
					_x addItemCargoGlobal ["ACE_salineIV_500",6];

					_x addItemCargoGlobal ["ACE_adenosine",10];
					_x addItemCargoGlobal ["ACE_morphine",10];
					_x addItemCargoGlobal ["ACE_epinephrine",10];

					_x addItemCargoGlobal ["ACE_quikclot",16];
					_x addItemCargoGlobal ["ACE_packingBandage",16];
					_x addItemCargoGlobal ["ACE_fieldDressing",16];
					_x addItemCargoGlobal ["ACE_elasticBandage",20];

					_x addItemCargoGlobal ["ACE_tourniquet",5];

					_x addItemCargoGlobal ["ACE_surgicalKit",1];
				};
			} forEach everyBackpack (_this select 0);
		}, [_unit,_type,_amt], 1] call CBA_fnc_waitAndExecute;
	};

	FNC_assignMedicBagUnit = {	//Add a backpack and medical items to a unit. Ex: [this,"usm_pack_m5_medic"] call FNC_assignMedicBagUnit;
		private ["_unit","_type"];

		_unit 	= _this select 0;	//Vehicle to add a medic bag to
		_type 	= _this select 1;	//Class of backpack to add

		if (local _unit) then {
			_unit addBackpack _type;

			clearAllItemsFromBackpack _unit;

			_x addItemToBackpack ["ACE_salineIV",5];
			_x addItemToBackpack ["ACE_salineIV_500",6];

			_x addItemToBackpack ["ACE_adenosine",10];
			_x addItemToBackpack ["ACE_morphine",10];
			_x addItemToBackpack ["ACE_epinephrine",10];

			_x addItemToBackpack ["ACE_quikclot",16];
			_x addItemToBackpack ["ACE_packingBandage",16];
			_x addItemToBackpack ["ACE_fieldDressing",16];
			_x addItemToBackpack ["ACE_elasticBandage",20];

			_x addItemToBackpack ["ACE_tourniquet",5];

			_x addItemToBackpack ["ACE_surgicalKit",1];
		};
	};
