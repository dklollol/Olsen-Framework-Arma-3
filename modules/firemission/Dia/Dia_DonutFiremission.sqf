

FNC_DIA_DonutFiremissionOpenDialog =
{
	_ok = createDialog "DIA_DonutFiremission";
	[DFM_DIA_IDC_GUNSELECT,DFM_DIA_IDC_SHELLSELECT] call FNC_ArtLoadAviableArtilleries;
};

FNC_DIA_DonutFiremissionSetArtillery =
{
	[DFM_DIA_IDC_SHELLSELECT,_this] call FNC_ArtSetArtillery;
};

FNC_DIA_DonutFiremissionCloseDialog =
{
	_ok = closeDialog DFM_DIA_IDD_DISPLAY;

};

FNC_DIA_DonutFiremissionFire =
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
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel DFM_DIA_IDC_GUNSELECT));};
	_selectedAmmo = lbCurSel DFM_DIA_IDC_SHELLSELECT;
	_grid = 	ctrlText DFM_DIA_IDC_GRID;
	_innerRadius = ( ctrlText DFM_DIA_IDC_INNERRADIUS) call BIS_fnc_parseNumber;
	_outerRadius = ( ctrlText DFM_DIA_IDC_OUTERRADIUS) call BIS_fnc_parseNumber;
 	_burstNumber = (ctrlText DFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	_burstRounds = (ctrlText DFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	_burstDelay = (ctrlText DFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	_spotting =  (ctrlText DFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;
	_inputIsCorrect = true;
	_inputIsCorrect = _inputIsCorrect && [_selectedUnit,"No Arty selected/aviable"] call FNC_InputIsUnit;
	_inputIsCorrect = _inputIsCorrect && [_innerRadius,"Inner radius is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_outerRadius,"Outer radius is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstNumber,"Burst number is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstRounds,"Burst rounds is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstDelay,"Burst delay is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_spotting,"Spotting distance is not a number"] call FNC_InputIsNumber;
	if(_innerRadius > _outerRadius) then {_inputIsCorrect = false;hint "Inner Radius bigger than outer."};
	if(_inputIsCorrect ) then
	{

								private _round =  ((_selectedUnit call FNC_GetArtyAmmo) select _selectedAmmo) select 0;
								hint (([_selectedUnit,_grid call CBA_fnc_mapGridToPos,_innerRadius,_outerRadius,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call FNC_GetDonutFiremissionText)
									+ "Requested by:" + (name player)
									+ "\nETA: " + str (round ((_selectedUnit call FNC_GetArtyAimTime) + ([_selectedUnit,[_grid,true] call CBA_fnc_mapGridToPos,_round] call FNC_GetArtyEta))) + " s");
									["CallDonutFiremission", [player,_selectedUnit,_selectedAmmo,_grid,_innerRadius,_outerRadius,_burstNumber,_burstRounds,_burstDelay,_spotting]] call CBA_fnc_serverEvent;
								[] call FNC_DIA_DonutFiremissionCloseDialog;

	};




};

FNC_DIA_Server_DonutFiremissionFire =
{
	_requester  = _this select 0;
	_selectedUnit = _this select 1;
	_selectedAmmo = _this select 2;
	_grid = _this select 3;
	_innerRadius = _this select 4;
	_outerRadius = _this select 5;
	_burstNumber = _this select 6;
	_burstRounds = _this select 7;
	_burstDelay = _this select 8;
	_spotting =  _this select 9;

	[_selectedUnit,_requester] call FNC_SetArtyCaller;
	[_selectedUnit ,[_grid,true] call CBA_fnc_mapGridToPos,_innerRadius,_outerRadius,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]   call FNC_DonutFiremission;


};

if(isServer) then {_id = ["CallDonutFiremission", {_this call FNC_DIA_Server_DonutFiremissionFire;}] call CBA_fnc_addEventHandler;};
