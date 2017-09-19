
#include "defs.hpp"
FNC_GetArtyDisplayName =
{
	private _unit = _this;
	private	_text = _x getVariable ["ArtCustomName",""];
	if(_text == "") then { _text = getText (configfile / "CfgVehicles" /  typeOf(_x) / "displayName") };
	_text
};
FNC_ArtLoadAviableArtilleries =
{
			private _id = _this select 0;
			private _shellSelect = _this select 1;
			_guns = player getVariable ["PlayerArtilleryGuns",[]];
			_usableGuns = [];
			{
				if(alive _x && !(_x getVariable ["isInAFiremission",false])) then
				{
					_usableGuns pushBack _x;
				};
			}forEach _guns;


			lbClear _id;
			{
				lbAdd [_id,_x call FNC_GetArtyDisplayName];

			}forEach _usableGuns;
			lbSetCurSel [_id,0];
};
FNC_ArtSetArtillery =
{
	private _id = _this select 0;
	private _gun = _this select 1;
	if(_gun >= 0) then
	{
		_guns = player getVariable ["PlayerArtilleryGuns",[]];
		_usableGuns = [];
		{
			if(alive _x && !(_x getVariable ["isInAFiremission",false])) then
			{
				_usableGuns pushBack _x;
			};
		}forEach _guns;
		_actualGunUnit = _usableGuns select _gun;

		_ammo = magazinesAmmo _actualGunUnit ;

		{
			_text = (str (_x select 1)) + "x " + getText (configfile / "CfgMagazines" / (_x select 0) / "displayName");
			lbAdd [_id, _text];

		}forEach _ammo;
		lbSetCurSel [_id,0];
	}
};
