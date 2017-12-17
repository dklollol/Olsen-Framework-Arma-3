

FNC_DIA_LineFiremissionOpenDialog =
{
	_ok = createDialog "DIA_LineFiremission";
	[LFM_DIA_IDC_GUNSELECT,LFM_DIA_IDC_SHELLSELECT] call FNC_ArtLoadAviableArtilleries;
};

FNC_DIA_LineFiremissionSetArtillery =
{
	[LFM_DIA_IDC_SHELLSELECT,_this] call FNC_ArtSetArtillery;
};

FNC_DIA_LineFiremissionCloseDialog =
{
	_ok = closeDialog LFM_DIA_IDD_DISPLAY;

};

FNC_DIA_LineFiremissionFire =
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
	 if((count _usableGuns) > 0) then { _selectedUnit = (_usableGuns select (lbCurSel LFM_DIA_IDC_GUNSELECT));};
	_selectedAmmo = lbCurSel LFM_DIA_IDC_SHELLSELECT;
	_startGrid = 	ctrlText LFM_DIA_IDC_STARTGRID;
	_endGrid =  ctrlText LFM_DIA_IDC_ENDGRID;
 	_burstNumber = (ctrlText LFM_DIA_IDC_BURSTNUMBER) call BIS_fnc_parseNumber;
	_burstRounds = (ctrlText LFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
	_burstDelay = (ctrlText LFM_DIA_IDC_BURSTDELAY) call BIS_fnc_parseNumber;
	_spotting =  (ctrlText LFM_DIA_IDC_SPOTTING) call BIS_fnc_parseNumber;

	_inputIsCorrect = true;
	_inputIsCorrect = _inputIsCorrect && [_selectedUnit,"No Arty selected/aviable"] call FNC_InputIsUnit;
	_inputIsCorrect = _inputIsCorrect && [_burstNumber,"Burst number is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstRounds,"Burst rounds is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_burstDelay,"Burst delay is not a number"] call FNC_InputIsNumber;
	_inputIsCorrect = _inputIsCorrect && [_spotting,"Spotting distance is not a number"] call FNC_InputIsNumber;

	if(_inputIsCorrect ) then
	{

						private _round =  ((_selectedUnit call FNC_GetArtyAmmo) select _selectedAmmo) select 0;
						hint (([_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,[_endGrid,true] call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo] call FNC_GetLineFiremissionText)
							+ "Requested by:" + (name player)
							+ "\nETA: " + str (round ((_selectedUnit call FNC_GetArtyAimTime) + ([_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,_round] call FNC_GetArtyEta))) + " s");
							["CallLineFiremission", [player,_selectedUnit,_selectedAmmo,_startGrid,_endGrid,_burstNumber,_burstRounds,_burstDelay,_spotting]] call CBA_fnc_serverEvent;
						[] call FNC_DIA_LineFiremissionCloseDialog;
	};



};

FNC_DIA_Server_LineFiremissionFire =
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

	[_unit,_requester] call FNC_SetArtyCaller;
	[_selectedUnit,[_startGrid,true] call CBA_fnc_mapGridToPos,[_endGrid,true] call CBA_fnc_mapGridToPos,_burstNumber,_burstRounds,_burstDelay,_spotting,_selectedAmmo]   call FNC_LineFiremission;


};
if(isServer) then {_id = ["CallLineFiremission", {_this call FNC_DIA_Server_LineFiremissionFire;}] call CBA_fnc_addEventHandler;};
