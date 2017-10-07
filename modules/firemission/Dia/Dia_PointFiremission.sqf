

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
	_guns = player getVariable [VAR_SART_OBSGUNS,[]];
	_usableGuns = [];
	{
		if(_x call FNC_IsArtyAviable) then
		{
			_usableGuns pushBack _x;
		};
	}forEach _guns;
	_selectedUnit = objNull;
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel PFM_DIA_IDC_GUNSELECT));};
	_selectedAmmo = lbCurSel PFM_DIA_IDC_SHELLSELECT;
	_grid = 	ctrlText PFM_DIA_IDC_GRID;
	_dispersion = ( ctrlText PFM_DIA_IDC_DISPERSION) call BIS_fnc_parseNumber;
 	_burstNumber = (ctrlText PFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	_burstRounds = (ctrlText PFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	_burstDelay = (ctrlText PFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	_spotting =  (ctrlText PFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;

	_inputIsCorrect = true;
	_inputIsCorrect = _inputIsCorrect && [_selectedUnit,"No Arty selected/aviable"] call FNC_InputIsUnit;
	_inputIsCorrect = _inputIsCorrect && [_dispersion,"Dispersion is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstNumber,"Burst number is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstRounds,"Burst rounds is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstDelay,"Burst delay is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_spotting,"Spotting distance is not a number"] call FNC_InputIsNumber;

	if(_inputIsCorrect) then
	{
							private _round =  ((_selectedUnit call FNC_GetArtyAmmo) select _selectedAmmo) select 0;
							hint (([_selectedUnit,[_grid,true] call CBA_fnc_mapGridToPos,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call FNC_GetPointFiremissionText)
								+ "Requested by: " + (name player)
								+ "\nETA: " + str (round ((_selectedUnit call FNC_GetArtyAimTime) + ([_selectedUnit,[_grid,true] call CBA_fnc_mapGridToPos,_round] call FNC_GetArtyEta)))  + " s");

							["CallPointFiremission", [player,_selectedUnit,_selectedAmmo,_grid,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting]] call CBA_fnc_serverEvent;
							[] call FNC_DIA_PointFiremissionCloseDialog;

	};



};

FNC_DIA_Server_PointFiremissionFire =
{
	private _requester  = _this select 0;
	private	_selectedUnit = _this select 1;
	private _selectedAmmo = _this select 2;
	private _grid = _this select 3;
	private _dispersion = _this select 4;
	private _burstNumber = _this select 5;
	private _burstRounds = _this select 6;
	private _burstDelay = _this select 7;
	private _spotting =  _this select 8;
	private _guns = _requester getVariable [VAR_SART_OBSGUNS,[]];

	[_selectedUnit,_requester] call FNC_SetArtyCaller;
	[_selectedUnit,[_grid,true] call CBA_fnc_mapGridToPos,_dispersion,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]   call FNC_PointFiremission;

};

if(isServer) then {_id = ["CallPointFiremission", {_this call FNC_DIA_Server_PointFiremissionFire;}] call CBA_fnc_addEventHandler;};
