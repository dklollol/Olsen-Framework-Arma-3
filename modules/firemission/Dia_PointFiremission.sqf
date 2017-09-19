
#include "defs.hpp"
#include "Dia_Global.sqf"

FNC_DIA_PointFiremissionOpenDialog =
{
	_ok = createDialog "DIA_PointFiremission";
	[PFM_DIA_IDC_GUNSELECT,PFM_DIA_IDC_SHELLSELECT] call FNC_ArtLoadAviableArtilleries;
};

FNC_DIA_PointFiremissionSetArtillery =
{
	[PFM_DIA_IDC_SHELLSELECT,_this] call FNC_ArtSetArtillery;
};

FNC_DIA_PointFiremissionCloseDialog =
{
	_ok = closeDialog PFM_DIA_IDD_DISPLAY;

};

FNC_DIA_PointFiremissionFire =
{
	_guns = player getVariable ["PlayerArtilleryGuns",[]];
	_usableGuns = [];
	{
		if(alive _x && !(_x getVariable ["isInAFiremission",false])) then
		{
			_usableGuns pushBack _x;
		};
	}forEach _guns;
	_selectedUnit = lbCurSel PFM_DIA_IDC_GUNSELECT;
	_selectedAmmo = lbCurSel PFM_DIA_IDC_SHELLSELECT;
	_grid = 	ctrlText PFM_DIA_IDC_GRID;
	_dispersion = ( ctrlText PFM_DIA_IDC_DISPERSION) call BIS_fnc_parseNumber;
 	_burstNumber = (ctrlText PFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	_burstRounds = (ctrlText PFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	_burstDelay = (ctrlText PFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	_spotting =  (ctrlText PFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;

	if(_dispersion < 0) then {hint "Dispersion is not a number";}
	else
	{
		if(_burstNumber < 0) then {hint "Burst number is not a number";}
		else
		{
			if(_burstRounds < 0) then {hint "Burst rounds is not a number";}
			else
			{
				if(_burstDelay < 0) then {hint "Burst delay is not a number";}
				else
				{
					if(_spotting < 0) then {hint "Spotting distance is not a number";}
					else
					{
						hint "Artilly is being fired";
						[-1, {_this call FNC_DIA_Server_PointFiremissionFire;}, [player,_selectedUnit,_selectedAmmo,_grid,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting]] call CBA_fnc_globalExecute;
						[] call FNC_DIA_PointFiremissionCloseDialog;
					};
				};
			};
		};
	};




};

FNC_DIA_Server_PointFiremissionFire =
{
	_requester  = _this select 0;
	_selectedUnit = _this select 1;
	_selectedAmmo = _this select 2;
	_grid = _this select 3;
	_dispersion = _this select 4;
	_burstNumber = _this select 5;
	_burstRounds = _this select 6;
	_burstDelay = _this select 7;
	_spotting =  _this select 8;
	_guns = _requester getVariable ["PlayerArtilleryGuns",[]];
	_usableGuns = [];
	{
		if(alive _x && !(_x getVariable ["isInAFiremission",false])) then
		{
			_usableGuns pushBack _x;
		};
	}forEach _guns;

	[_usableGuns select _selectedUnit,_grid call CBA_fnc_mapGridToPos,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]   call FNC_PointFireMission;


;
};
