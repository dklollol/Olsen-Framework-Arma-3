
#include "defs.hpp"

FNC_IsArtyAviable =
{
	private _unit = _this;
	private _ret = (alive (_unit) && !((_unit) getVariable [VAR_SART_ARTINFIREMISSION,false]) && ((_unit) getVariable [VAR_SART_IsAviable,true]));
	_ret;

};

FNC_SetArtyAviable =
{
	(_this select 0 ) setVariable [VAR_SART_IsAviable,_this select 1,true];
};
FNC_SendArtyHint =
{
	private  _unit = _this select 0;
	private  _text = _this select 1;
	["Event_ArtyReceiveHint", _text, _unit] call CBA_fnc_targetEvent;
};

FNC_SendArtyHintGlobal =
{
	_text = _this;
	["Event_ArtyReceiveHint", _text] call CBA_fnc_globalEvent;
};
FNC_FindMarkerOnMap =
{
	private _marker = "";
	{
		if((markerText (_x))  == _this) then
		{
			_marker = _x;
		};
	}forEach allMapMarkers;
	_marker;
};

FNC_InputIsNumber =
{
	private _value = _this select 0;
	private _errorText = _this select 1;
	private _ret = true;
	if(_value < 0) then
	{
		hint _errorText;
		_ret = false;
	};
	_ret
};
FNC_InputIsUnit =
{
	private _value = _this select 0;
	private _errorText = _this select 1;
	private _ret = true;
	if(_value isEqualTo objNull) then
	{
		hint _errorText;
		_ret = false;
	};
	_ret
};
FNC_GetCompleteInfoText =
{
	private _unit = _this;
	private _rounds = _unit call FNC_GetArtyFiremissionRoundsRequired;
	private _callerName = _unit call FNC_GetArtyCallerText;
	private _fireMissionText =_unit getVariable [VAR_SART_ARTFMTEXT,"Error"];
	private _ret = _fireMissionText +"Rounds fired: " + (str (_rounds select 0)) + "/" + (str (_rounds select 1)) + "\nRequested by: " + (_unit call FNC_GetArtyCallerText);
	_ret;
};
FNC_SetArtyReadyStatus =
{
	private _unit = _this select 0;
	private _isFiring = _this select 1;

	_unit setVariable [VAR_SART_ARTINFIREMISSION,_isFiring,true];
	["Event_ArtyIsReady", [_unit,_isFiring]] call CBA_fnc_globalEvent;
};
FNC_GetArtyFiremissionRoundsRequired =
{
	private _unit = _this;
	private _ret = _unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]];
	_ret
};
FNC_GetArtyAimTime =
{
	private _unit = _this;
	private _ret = ((_unit getVariable [VAR_SART_ARTAIMSPEED,MEANAIMTIME]) + 1);
	_ret
};

FNC_GetArtyCalcTime =
{
	private _unit = _this;
	private _ret = ((_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
	_ret
};

FNC_GetArtyEta =
{
	private _unit = _this select 0;
	private _pos = _this select 1;
	private _ammo = _this select 2;
	private _ret = _unit getArtilleryETA [_pos, _ammo];
	_ret
};
FNC_SetArtyFiremissionRoundsRequired =
{
	private _unit = _this select 0;
	private _roundsFired = _this select 1;
	private _roundsRequired = _this select 2;
	_unit setVariable [VAR_SART_ARTROUNDSFIRED,[_roundsFired,_roundsRequired],true];

};

FNC_GetArtyCaller =
{
	private _unit = _this;
	private _callerUnit = _unit getVariable [VAR_SART_CALLER,objNull];
	_callerUnit
};
FNC_GetArtyCallerText =
{
	private _unit = _this;
	private _caller = _unit call FNC_GetArtyCaller;
	private _returnName = "Non specified";
	if(!(isNull  _caller)) then
	{
		_returnName = name _caller;
	};

	_returnName
};
FNC_SetArtyCaller =
{
	private _unit = _this select 0;
	private _caller = _this select 1;
	_unit setVariable [VAR_SART_CALLER,_caller,true];
};

FNC_GetArtyDisplayName =
{
	private _unit = _this;
	private	_text = _unit getVariable [VAR_SART_ARTCUSTOMNAME,""];
	if(_text == "") then { _text = getText (configfile / "CfgVehicles" /  typeOf(_unit) / "displayName") };
	_text
};
FNC_GetAmmoDisplayNameAndIndexFormated =
{
	private _unit =_this;
	private _ammo = [];
	private _ret = "";
	private _possibleMags = getArray (configfile >> "CfgWeapons">>  (((_unit) weaponsTurret [0]) select 0) >> "magazines");
	{
		_ammo pushBack [_forEachIndex,_x,getText (configfile >> "CfgMagazines">>  _x >> "displayName")];
	}forEach _possibleMags;
	{
		_ret = _ret + "Index: " + str(_x select 0) + "Classname: " + (_x select 1) + "Displayname: " + (_x select 2) + "\n";
	}forEach _ammo;
	_ret
};

FNC_GetAmmoDisplayNameAndIndex =
{
	private _unit =_this;
	private _ret = [];
	private _possibleMags = getArray (configfile >> "CfgWeapons">>  (((_unit) weaponsTurret [0]) select 0) >> "magazines");
	{
		_ret pushBack [_forEachIndex,_x,getText (configfile >> "CfgMagazines">>  _x >> "displayName")];
	}forEach _possibleMags;
	_ret
};
FNC_GetArtyIndexAmmoClassname =
{
		private _unit =_this select 0;
		private _index =_this select 1;
		private _ret = ((_unit call FNC_GetArtyAmmo) select _index) select 0;
		_ret
};
FNC_GetArtyAmmo =
{
	private _unit =_this;
	private _ammo = magazinesAmmo _unit;
	private _ret = [];
	private _possibleMags = getArray (configfile >> "CfgWeapons">>  (((_unit) weaponsTurret [0]) select 0) >> "magazines");
	{
		_ret pushBack [_x,0];
	}forEach _possibleMags;

	{
		_check = _x;
		_found = false;
		{
			if(_x select 0 == _check select 0) then
			{
				_found = true;
				_num = (_check select 1) + (_x select 1);
				_x set [1,_num];
			}
		}forEach _ret;
		if(!_found) then
		{
			hint "GetArtyAmmo Error";
		};

	}forEach _ammo;
	_ret
};

FNC_ArtLoadAviableArtilleries =
{
			private _id = _this select 0;
			private _shellSelect = _this select 1;
			private _guns = player getVariable [VAR_SART_OBSGUNS,[]];
			private _usableGuns = [];
			{
				if(_x call FNC_IsArtyAviable) then
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
		_guns = player getVariable [VAR_SART_OBSGUNS,[]];
		_usableGuns = [];
		{
			if(_x call FNC_IsArtyAviable) then
			{
				_usableGuns pushBack _x;
			};
		}forEach _guns;
		_actualGunUnit = _usableGuns select _gun;
		lbClear _id;
		_ammo = _actualGunUnit call FNC_GetArtyAmmo;

		{
			_text = (str (_x select 1)) + "x " + getText (configfile / "CfgMagazines" / (_x select 0) / "displayName");
			lbAdd [_id, _text];

		}forEach _ammo;
		lbSetCurSel [_id,0];
	}
};
