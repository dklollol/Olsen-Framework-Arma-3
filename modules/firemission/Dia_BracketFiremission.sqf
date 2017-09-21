
FNC_DIA_BracketFiremissionOpenDialog =
{
	_ok = createDialog "DIA_BracketFiremission";
	[BFM_DIA_IDC_GUNSELECT,BFM_DIA_IDC_SHELLSELECT] call FNC_ArtLoadAviableArtilleries;
};

FNC_DIA_BracketFiremissionSetArtillery =
{
	[BFM_DIA_IDC_SHELLSELECT,_this] call FNC_ArtSetArtillery;
};

FNC_DIA_BracketFiremissionCloseDialog =
{
	_ok = closeDialog DLM_DIA_IDD_DISPLAY;

};

FNC_DIA_BracketFiremissionFire =
{
	_guns = player getVariable ["PlayerArtilleryGuns",[]];
	_usableGuns = [];
	{
		if(alive _x && !(_x getVariable ["isInAFiremission",false])) then
		{
			_usableGuns pushBack _x;
		};
	}forEach _guns;
	_selectedUnit = objNull;
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel BFM_DIA_IDC_GUNSELECT));};
	_selectedAmmo = lbCurSel BFM_DIA_IDC_SHELLSELECT;
	_startGrid = 	ctrlText BFM_DIA_IDC_STARTGRID;
	_endGrid =  ctrlText BFM_DIA_IDC_ENDGRID;
 	_burstNumber = (ctrlText BFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	_burstRounds = (ctrlText BFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	_burstDelay = (ctrlText BFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	_spotting =  (ctrlText BFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;
		if(_selectedUnit isEqualTo objNull) then  {hint "No Arty selected/aviable";}
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
						hint (([_selectedUnit,_startGrid call CBA_fnc_mapGridToPos,_endGrid call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call FNC_GetBracketFiremissionText)
							+ "Requested by:" + (name player));
						[-1, {_this call FNC_DIA_Server_BracketFiremissionFire;}, [player,_selectedUnit,_selectedAmmo,_startGrid,_endGrid,_burstNumber,_burstRounds,_burstDelay,_spotting]] call CBA_fnc_globalExecute;
						[] call FNC_DIA_BracketFiremissionCloseDialog;
					};
				};
			};
		};


	};


};

FNC_DIA_Server_BracketFiremissionFire =
{
	_requester  = _this select 0;
	_selectedUnit = _this select 1;
	_selectedAmmo = _this select 2;
	_startGrid = _this select 3;
	_endGrid = _this select 4;
	_burstNumber = _this select 5;
	_burstRounds = _this select 6;
	_burstDelay = _this select 7;
	_spotting =  _this select 8;

	[_selectedUnit,_requester] call FNC_SetArtyCaller;
	[_selectedUnit,_startGrid call CBA_fnc_mapGridToPos,_endGrid call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]   call FNC_BracketFireMission;



};
