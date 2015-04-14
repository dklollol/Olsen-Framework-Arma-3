#define ADDMAGAZINES(MAGAZINE, AMMOUNT) \
for "_i" from 1 to AMMOUNT do { \
	_unit addmagazine MAGAZINE; \
};

#define ADDWEAPON(WEAPON) \
_unit addweapon WEAPON;

#define ADDRUCKMAGAZINES(MAGAZINE, AMMOUNT) \
[_unit, MAGAZINE, AMMOUNT] call ACE_fnc_packMagazine;

#define ADDONBACKWEAPON(WEAPON) \
_unit setVariable ["ace_weaponOnBack", WEAPON];

#define ADDRUCKWEAPONS(WEAPON, AMMOUNT) \
[_unit, WEAPON, AMMOUNT] call ACE_fnc_PackWeapon;

#define PACKIFAK(SLOT1, SLOT2, SLOT3) \
[_unit, SLOT1, SLOT2, SLOT3] call ACE_fnc_PackIFAK;

_unit = _this select 0;
_type = _this select 1;
_groupName = _this select 2;

removeallweapons _unit;
removeAllItems _unit;
removebackpack _unit;

(group _unit) setGroupid [_groupName]; //Sets the name of group done for every unit to make sure its set even if there is no squad leader