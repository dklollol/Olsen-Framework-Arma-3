#define CLEARCARGO \
clearMagazineCargo _veh; \
clearWeaponCargo _veh;

#define ADDMAGAZINECARGO(MAGAZINE, AMMOUNT) \
_veh addMagazineCargo [MAGAZINE, AMMOUNT];

#define ADDWEAPONCARGO(WEAPON, AMMOUNT) \
_veh addWeaponCargo [WEAPON, AMMOUNT];

_veh = _this select 0;
_type = _this select 1;