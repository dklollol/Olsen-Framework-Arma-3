["Firemission", "Custom Artillery Strike Missions", "Sacher"] call FNC_RegisterModule;

//to say the truth, this code is a goddamm mess

#include "Dia\Dia_Global.sqf"

FNC_AddEventHandler =
{
	if(!((_this) getVariable [VAR_SART_ARTHASEH,false])) then
	{
			(_this) addeventhandler ["fired", {(_this select 0) setvehicleammo 1}];
			(_this) setVariable [VAR_SART_ARTHASEH,true];
	};

};



FNC_SetArtilleryData =
{
		//TODO do some value checking
		private _unit = _this select 0;
		private _fireRate = if((_this select 1) < 0) then {MEANFIRERATE} else {  _this select 1};;
		private	_accuracy = if((_this select 2) < 0) then { MEANPlOTTEDACCURACY} else { _this select 2 };;
		private _spottingAccuracy = if((_this select 3) < 0) then {MEANSPOTTINGACCURACY} else { _this select 3  };;
		private _aimSpeed = if((_this select 4) < 0) then {MEANAIMTIME} else {   _this select 4};;
		private _calcSpeed = if((_this select 5) < 0) then {MEANCALCULATIONTIME } else { _this select 5 };;
		private _customName = _this select 6;
		private _unlimitedAmmo = _this select 7;
		_unit setVariable [VAR_SART_ARTFIRERATE,_fireRate];
		_unit setVariable [VAR_SART_ARTACCURACY,_accuracy];
		_unit setVariable [VAR_SART_ARTSPOTACCURACY,_spottingAccuracy];
		_unit setVariable [VAR_SART_ARTAIMSPEED,_aimSpeed];
		_unit setVariable [VAR_SART_ARTCALCSPEED,_calcSpeed];
		_unit setVariable [VAR_SART_ARTCUSTOMNAME,_customName,true];
		_unit setVariable [VAR_SART_ARTAMMO,_unlimitedAmmo];
		if(_unlimitedAmmo) then {_unit call FNC_AddEventHandler;};


};
FNC_GetArtillerySkill =
{
		_unit = _this select 0;
		skills = [];
		skills pushBack (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]);
		skills pushBack (_unit getVariable [VAR_SART_ARTACCURACY,MEANPlOTTEDACCURACY]);
		skills pushBack (_unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]);
		skills pushBack (_unit getVariable [VAR_SART_ARTAIMSPEED,MEANAIMTIME]);
		skills pushBack (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]);
		skills pushBack (_unit getVariable [VAR_SART_ARTCUSTOMNAME,""]);
		skills
};

FNC_GetNewAccuracy =
{
	_ret = 0;
	if((_this select 0) > ((_this select 1) * 0.5)) then
	{
		_ret = _this select 1 / 2;
	}
	else
	{
		_ret = _dis;
	};
	_ret
};
FNC_GetPolarSpottingFiremissionText =
{
	private _unit = _this select 0;
	private _callGrid = _this select 1;
	private _mils = _this select 2;
	private _distance = _this select 3;
	private	_roundType = _this select 4;
	private	_loc = [_callGrid,true] call CBA_fnc_mapGridToPos;
	private	_degrees = MILSPERROUND / _mils * 360.0;
	private _dir = [cos _degrees,sin _degrees,0];
	private _target =  _loc vectorAdd (_dir vectorMultiply _distance);
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);
	private _text =   getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");
	private	_unitName = _unit call FNC_GetArtyDisplayName;
	private _ret = 	"Name: " + _unitName +"\n" +
												"Firemission type: Spotting-Firemission \n" +
												"Shell: " + _text +" \n" +
												"Mils: " + (str _mils) +" \n" +
												"Distance: " + (str _distance) +" \n" +
												"Grid: " + (mapGridPosition _target) +" \n";
	_ret
};

FNC_PolarSpottingFiremission =
{
	_handle = _this spawn
	{
		private _unit = _this select 0;
		private _target = _this select 1;
		private _mils = _this select 2;
		private _distance = _this select 3;
		private	_roundType = _this select 4;
		private	_loc = [_target,true] call CBA_fnc_mapGridToPos;
		private	_degrees = MILSPERROUND / _mils * 360.0;
		private _dir = [cos _degrees,sin _degrees,0];
		private _target =  _loc vectorAdd (_dir vectorMultiply _distance);

		private	_fireRate = _unit call FNC_ArtGetFireRate;
		[_unit , true] call FNC_SetArtyReadyStatus;

		private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);
		_unit setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetPolarSpottingFiremissionText,true];

		sleep((_unit call FNC_GetArtyAimTime));
		_randomPos = [[[_target, _unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]]],[]] call BIS_fnc_randomPos;
			_eta = [_unit,_randomPos, ((_unit call FNC_GetArtyAmmo) select _roundType) select 0] call FNC_GetArtyEta;
		_unit commandArtilleryFire [_randomPos,  ((_unit call FNC_GetArtyAmmo) select _roundType) select 0, 1];
		_waitTime = (_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]));
		sleep(_waitTime);
		[_unit,objNULL] call FNC_SetArtyCaller;
		[_unit, false] call FNC_SetArtyReadyStatus;
	};
};
FNC_GetGridSpottingFiremissionText =
{
	private _unit = _this select 0;
	private _target = _this select 1;
	private	_roundType = _this select 2;
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);
	private _text =  (str (_rounds select 1)) + "x " + getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");
	private	_unitName = _unit call FNC_GetArtyDisplayName;
	private _ret = "Name: " + _unitName +"\n" +
												"Firemission type: Spotting-Firemission \n" +
												"Shell: " + _text +" \n" +
												"Grid: " + (mapGridPosition _target) +" \n";
	_ret
};
FNC_GridSpottingFiremission =
{
	_handle = _this spawn
	{
		private _unit = _this select 0;
		private _target = _this select 1;
		private	_roundType = _this select 2;
		private	_fireRate = _unit call FNC_ArtGetFireRate;
		[_unit , true] call FNC_SetArtyReadyStatus;

		private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);
		_unit setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetGridSpottingFiremissionText,true];

		sleep((_unit call FNC_GetArtyAimTime));
		private _randomPos = [[[_target, _unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]]],[]] call BIS_fnc_randomPos;
		private _eta = [_unit,_randomPos, ((_unit call FNC_GetArtyAmmo) select _roundType) select 0] call FNC_GetArtyEta;
		_unit commandArtilleryFire [_randomPos,  ((_unit call FNC_GetArtyAmmo) select _roundType) select 0, 1];
		private _waitTime = (_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]));
		sleep(_waitTime);
		[_unit,objNULL] call FNC_SetArtyCaller;
		[_unit, false] call FNC_SetArtyReadyStatus;
	};
};
FNC_GetPolarFiremissionText =
{

	private _unit = _this select 0;
	private _callGrid = _this select 1;

	private _mils = _this select 2;
	private _distance = _this select 3;

	private	_dispersion = _this select 4;
	private	_burstCount = _this select 5;
	private	_burstSize = _this select 6;
	private	_burstWait = _this select 7;
	private	_minSpottedDistance = _this select 8;
	private	_roundType = _this select 9;

	private	_loc = [_callGrid,true] call CBA_fnc_mapGridToPos;
	private	_degrees = MILSPERROUND / _mils * 360;
	private _dir = [cos _degrees,sin _degrees,0];

	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);

	private _text =  getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");

	private	_unitName = _unit call FNC_GetArtyDisplayName;


	private _ret = 	"Name: " + _unitName + "\n" +
			"Firemission type: Polar to Point-Firemission \n" +
			"Shell: " + _text +" \n" +
			"Call Grid: " + (mapGridPosition _callGrid) + "\n" +
			"Mils: " +(str _mils) + "\n" +
			"Distance: " + (str _distance) + "\n" +
			"Dispersion: " + (str _dispersion) +"\n" +
			"Number of Bursts: " + (str _burstCount) +"\n" +
			"Rounds per Burst: " + (str _burstSize) +"\n" +
			"Delay per Burst: " + (str _burstWait) +"\n" +
			"Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

	_ret
};

FNC_PolarFiremission =
{

	private _unit = _this select 0;
	private _callGrid = _this select 1;

	private _mils = _this select 2;
	private _distance = _this select 3;

	private	_dispersion = _this select 4;
	private	_burstCount = _this select 5;
	private	_burstSize = _this select 6;
	private	_burstWait = _this select 7;
	private	_minSpottedDistance = _this select 8;
	private	_roundType = _this select 9;

	private	_loc = [_callGrid,true] call CBA_fnc_mapGridToPos;
	private	_degrees = MILSPERROUND / _mils * 360.0;
	private _dir = [cos _degrees,sin _degrees,0];

	[_unit,_loc vectorAdd (_dir vectorMultiply _distance),_dispersion,_burstCount,_burstSize,_burstWait,_minSpottedDistance,_roundType] call FNC_PointFiremission;
 };
FNC_GetPointFiremissionText =
{
	private _unit = _this select 0;
	private	_target = _this select 1;
	private	_dispersion = _this select 2;
	private	_burstCount = _this select 3;
	private	_burstSize = _this select 4;
	private	_burstWait = _this select 5;
	private	_minSpottedDistance = _this select 6;
	private	_roundType = _this select 7;
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType);

	private _text =  getText (configfile / "CfgMagazines" / (_rounds select 0) / "displayName");

	private	_unitName = _unit call FNC_GetArtyDisplayName;


	private _ret = 	"Name: " + _unitName + "\n" +
			"Firemission type: Point-Firemission \n" +
			"Shell: " + _text +" \n" +
			"Grid: " + (mapGridPosition _target) + "\n" +
			"Dispersion: " + (str _dispersion) +"\n" +
			"Number of Bursts: " + (str _burstCount) +"\n" +
			"Rounds per Burst: " + (str _burstSize) +"\n" +
			"Delay per Burst: " + (str _burstWait) +"\n" +
			"Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

	_ret

};
FNC_InternalSpottingFiremission =
{
	private _unit = _this select 0;
	private	_target = _this select 1;
	private	_roundClassName = _this select 2;
	sleep((_unit call FNC_GetArtyAimTime));
	private	_dis = 1000;
	private	_tempAcc = (_unit getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]) + 1;
	while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED  )} do
	{
				_randomPos = [[[_target, _tempAcc]],[]] call BIS_fnc_randomPos;
				_dis = _randomPos distance2D _target;
					_eta = [_unit,_randomPos, _roundClassName] call FNC_GetArtyEta;
				_unit commandArtilleryFire [_randomPos,  _roundClassName, 1];
				_waitTime = (_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE])) max _eta;
				sleep(_waitTime max ((_unit getVariable [VAR_SART_ARTAIMSPEED,MEANAIMTIME]) + 1));
				_tempAcc = [_dis,_tempAcc] call FNC_GetNewAccuracy;

	};
};
FNC_InternalRepackArtilleryMagazines =
{
	private _unit = _this;
	private _ammo = _unit call FNC_GetArtyAmmo;
	{_unit removeMagazine _x} forEach (magazines _unit);
	{
		_count  = _x select 1;
		_classNam = _x select 0;
		_maxAmmo = getNumber(configFile >> "CfgMagazines" >> _classNam >> "count");
		while{_count > 0} do
		{
			if(_count >= _maxAmmo) then
			{
					_unit addMagazine [_classNam,_maxAmmo];
			}
			else
			{
					_unit addMagazine [_classNam,_count];
			};
			_count = _count - _maxAmmo;
		};
	}forEach _ammo;
};
FNC_InternalFiremission =
{
	private	_unit = _this select 0;
	private	_target = _this select 1;
	private	_dispersion = _this select 2;
	private	_burstSize = _this select 3;
	private	_roundClassName = _this select 4;
	_unit call FNC_InternalRepackArtilleryMagazines;
	private _hasAmmunition = false;
	{
		if(_x select 0 == _roundClassName) then
		{
				_hasAmmunition = true;
				_burstSize = _burstSize min (_x select 1);
		};
	}forEach (_unit call FNC_GetArtyAmmo);
	if(_hasAmmunition) then
	{
		_randomPos = [[[_target, _dispersion]],[]] call BIS_fnc_randomPos;
		_randomPos =	[[[_randomPos, _unit getVariable[VAR_SART_ARTACCURACY,MEANPlOTTEDACCURACY]]],[]] call BIS_fnc_randomPos;
		_unit commandArtilleryFire [_randomPos,  _roundClassName, _burstSize];
	};

};


FNC_PointFiremission =
{
	_handle = _this spawn
	{
		private _unit = _this select 0;
		private	_target = _this select 1;
		private	_dispersion = _this select 2;
		private	_burstCount = _this select 3;
		private	_burstSize = _this select 4;
		private	_burstWait = _this select 5;
		private	_minSpottedDistance = _this select 6;
		private	_roundType = _this select 7;
		private	_fireRate = _unit call FNC_ArtGetFireRate;
		private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;

		[_unit , true] call FNC_SetArtyReadyStatus;
		_unit setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetPointFiremissionText,true];
		[_unit, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
			//calculateFiremission
		[_unit,_target,_roundClassName ] call FNC_InternalSpottingFiremission;
		sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
		for "_i" from 0 to _burstCount do
		{
				[_unit,_target,_dispersion,_burstSize,_roundClassName] call FNC_InternalFiremission;
				[_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
			  	sleep(((_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
		[_unit,objNULL] call FNC_SetArtyCaller;
		[_unit, false] call FNC_SetArtyReadyStatus;
		[_unit, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
	};
		(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
};
FNC_GetLineFiremissionText =
{
	private _unit = _this select 0;
	private	_startGrid = _this select 1;
	private	_endGrid = _this select 2;
	private	_burstCount = _this select 3;
	private	_burstSize = _this select 4;
	private	_burstWait = _this select 5;
	private	_minSpottedDistance = _this select 6;
	private	_roundType = _this select 7;
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0;
	private _text =  getText (configfile / "CfgMagazines" / _rounds / "displayName");

	_unitName = _unit call FNC_GetArtyDisplayName;


	_ret = 	"Name: " + _unitName +"\n" +
			"Firemission type: Line-Firemission \n" +
			"Shell: " + _text +" \n" +
			"Startgrid: " + (mapGridPosition _startGrid) + "\n" +
			"Endgrid: " + (mapGridPosition _endGrid) +"\n" +
			"Number of Bursts: " + (str _burstCount) +"\n" +
			"Rounds per Burst: " + (str _burstSize) +"\n" +
			"Delay per Burst: " + (str _burstWait) +"\n" +
			"Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

	_ret

};
FNC_LineFiremission =
{
	_handle = _this spawn
	{
		private _unit = _this select 0;

		private _startPoint = _this select 1;
		private _endPoint = _this select 2;
		private	_burstCount = _this select 3;
		private	_burstSize = _this select 4;
		private	_burstWait = _this select 5;
		private	_minSpottedDistance = _this select 6;
		private	_roundType = _this select 7;
		private	_fireRate = _unit call FNC_ArtGetFireRate;
		private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;

		[_unit, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
		[_unit , true] call FNC_SetArtyReadyStatus;
		_unit setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetLineFiremissionText,true];
		[_unit,_startPoint,_roundClassName ] call FNC_InternalSpottingFiremission;
		//spotting rounds finished
		sleep( _unit call FNC_GetArtyCalcTime);
	  	private	_dir = _endPoint vectorDiff  _startPoint;
		_dir = _dir vectorMultiply (1 /_burstCount);
		for "_i" from 0 to _burstCount do
		{

			[_unit,_startPoint vectorAdd (_dir vectorMultiply _i),0,_burstSize,_roundClassName] call FNC_InternalFiremission;
			[_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
			sleep(((_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
		[_unit, false] call FNC_SetArtyReadyStatus;
		[_unit,objNULL] call FNC_SetArtyCaller;
		[_unit, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
	};
	(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
};
FNC_GetBracketFiremissionText =
{
	private _unit = _this select 0;
	private	_startGrid = _this select 1;
	private	_endGrid = _this select 2;
	private	_burstCount = _this select 3;
	private	_burstSize = _this select 4;
	private	_burstWait = _this select 5;
	private	_minSpottedDistance = _this select 6;
	private	_roundType = _this select 7;
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0;
	private _text =  getText (configfile / "CfgMagazines" / _rounds / "displayName");

	_unitName = _unit call FNC_GetArtyDisplayName;


	_ret = 	"Name: " + _unitName +"\n" +
			"Firemission type: Bracket-Firemission \n" +
			"Shell: " + _text +" \n" +
			"Startgrid: " + (mapGridPosition _startGrid) + "\n" +
			"Endgrid: " + (mapGridPosition _endGrid) +"\n" +
			"Number of Bursts: " + (str _burstCount) +"\n" +
			"Rounds per Burst: " + (str _burstSize) +"\n" +
			"Delay per Burst: " + (str _burstWait) +"\n" +
			"Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

	_ret

};
FNC_BracketFiremission =
{
	_handle = _this spawn
	{
		private _unit = _this select 0;
		private _startPoint = _this select 1;
		private _endPoint = _this select 2;
		private	_burstCount = _this select 3;
		private	_burstSize = _this select 4;
		private	_burstWait = _this select 5;
		private	_minSpottedDistance = _this select 6;
		private	_roundType = _this select 7;
		private	_fireRate = _unit call FNC_ArtGetFireRate;
		private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;

		[_unit , true] call FNC_SetArtyReadyStatus;
		_unit setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetPointFiremissionText,true];
		[_unit, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
		[_unit,_startPoint,_roundClassName ] call FNC_InternalSpottingFiremission;
		//spotting rounds finished
		sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
		private	_dir = _endPoint vectorDiff  _startPoint;
		_dir = _dir vectorMultiply (1 /_burstCount);
		private _isForward = true;
		for "_i" from 0 to _burstCount do
		{
			if(_isForward) then
			{
					[_unit,_startPoint vectorAdd (_dir vectorMultiply (_i / 2)),0,_burstSize,_roundClassName] call FNC_InternalFiremission;
					[_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
					_isForward = false;
			}
			else
			{

					[_unit,_startPoint vectorAdd (_dir vectorMultiply ((_burstCount - _i) / 2)),0,_burstSize,_roundClassName] call FNC_InternalFiremission;
					[_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
					_isForward = true;
			};

					sleep(((_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
		[_unit,objNULL] call FNC_SetArtyCaller;
		[_unit, false] call FNC_SetArtyReadyStatus;
		[_unit, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
	};
	(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
};
FNC_GetDonutFiremissionText =
{
	private _unit = _this select 0;
	private	_target = _this select 1;
	private	_innerRadius = _this select 2;
	private	_outerRadius = _this select 3;
	private	_burstCount = _this select 4;
	private	_burstSize = _this select 5;
	private	_burstWait = _this select 6;
	private	_minSpottedDistance = _this select 7;
	private	_roundType = _this select 8;
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0;
	private _text =  getText (configfile / "CfgMagazines" / _rounds / "displayName");

	_unitName = _unit call FNC_GetArtyDisplayName;


	_ret = 	"Name: " + _unitName +"\n" +
			"Firemission type: Donut-Firemission \n" +
			"Shell: " + _text +" \n" +
			"Targetgrid: " + (mapGridPosition _target) + "\n" +
			"Inner radius: " + (str _innerRadius) +"\n" +
			"Outer radius: " + (str _outerRadius) +"\n" +
			"Number of Bursts: " + (str _burstCount) +"\n" +
			"Rounds per Burst: " + (str _burstSize) +"\n" +
			"Delay per Burst: " + (str _burstWait) +"\n" +
			"Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

	_ret

};
FNC_DonutFiremission =
{
	if (isServer) then
	{
		_handle = _this spawn
		{
			private _unit = _this select 0;
			private	_target = _this select 1;
			private	_innerRadius = _this select 2;
			private	_outerRadius = _this select 3;
			private	_burstCount = _this select 4;
			private	_burstSize = _this select 5;
			private	_burstWait = _this select 6;
			private	_minSpottedDistance = _this select 7;
			private	_roundType = _this select 8;
			private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;
			private	_fireRate = _unit call FNC_ArtGetFireRate;

			[_unit , true] call FNC_SetArtyReadyStatus;
			_unit setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetDonutFiremissionText,true];
			[_unit, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
			[_unit,_target,_roundClassName ] call FNC_InternalSpottingFiremission;
				//spotting rounds finished
				sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
				for "_i" from 0 to _burstCount do
				{


						_randomPos = [[[_target, _outerRadius]],[[_target, _innerRadius]]] call BIS_fnc_randomPos;
						[_unit,_randomPos,0,_burstSize,_roundClassName] call FNC_InternalFiremission;
						[_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
						sleep(((_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
				};
				[_unit,objNULL] call FNC_SetArtyCaller;
				[_unit, false] call FNC_SetArtyReadyStatus;
				[_unit, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
		};

		(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
	};
};

FNC_GetMarkerFiremissionText =
{
	private _unit = _this select 0;
	private	_target = _this select 1;
	private	_dispersion = _this select 2;
	private	_burstCount = _this select 3;
	private	_burstSize = _this select 4;
	private	_burstWait = _this select 5;
	private	_minSpottedDistance = _this select 6;
	private	_roundType = _this select 7;
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0;
	private _text =  getText (configfile / "CfgMagazines" / _rounds / "displayName");

	_unitName = _unit call FNC_GetArtyDisplayName;


	_ret = 	"Name: " + _unitName +"\n" +
			"Firemission type: Marker to Point Firemission \n" +
			"Shell: " + _text +" \n" +
			"TargetMarker: " + _target + "\n" +
			"Dispersion: " + (str _dispersion) +"\n" +
			"Number of Bursts: " + (str _burstCount) +"\n" +
			"Rounds per Burst: " + (str _burstSize) +"\n" +
			"Delay per Burst: " + (str _burstWait) +"\n" +
			"Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

	_ret

};
FNC_MarkerFiremission =
{
	if (isServer) then
	{
		_handle = _this spawn
		{
				private _unit = _this select 0;
				private	_targetMarker = _this select 1;
				private	_burstCount = _this select 2;
				private	_burstSize = _this select 3;
				private	_burstWait = _this select 4;
				private	_minSpottedDistance = _this select 5;
				private	_roundType = _this select 6;
				private	_fireRate = _unit call FNC_ArtGetFireRate;
				private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;
				[_unit , true] call FNC_SetArtyReadyStatus;
				_unit setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetPointFiremissionText,true];
				[_unit, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;

					//calculateFiremission
					[_unit,_targetMarker,_roundClassName ] call FNC_InternalSpottingFiremission;
					//spotting rounds finished
					sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
					for "_i" from 0 to _burstCount do
					{
							_randomPos = [[_targetMarker],[]] call BIS_fnc_randomPos;
							[_unit,_randomPos,0,_burstSize,_roundClassName] call FNC_InternalFiremission;
								[_unit, ((_unit getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 0) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
							sleep(((_fireRate * (_unit getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
					};

					[_unit, false] call FNC_SetArtyReadyStatus;
					[_unit,objNULL] call FNC_SetArtyCaller;
					[_unit, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
		};
		(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
	};

};
FNC_PointMarkerFiremission =
{
if (isServer) then
{
	[_this select 0,getMarkerPos (_this select 1),_this select 2,_this select 4,_this select 5,_this select 6,_this select 7,_this select 8] call FNC_PointFiremission;
	};
};
FNC_DynamicMarkerFiremission =
{
	if (isServer) then
	{

		private _marker = (_this select 1) call FNC_FindMarkerOnMap;
		if(_marker  != "") then
		{
			_pos = getMarkerPos _marker;
			_pos set [2,getTerrainHeightASL [_pos select 0,_pos select 1]];
			[_this select 0,_pos,_this select 2,_this select 3,_this select 4,_this select 5,_this select 6,_this select 7] call FNC_PointFiremission;
		};

	};
};
FNC_GetCurtainFiremissionText =
{
	private _unit = _this select 0;
	private _startPoint = _this select 1;
	private _endPoint = _this select 2;
	private _width = _this select 3;
	private	_burstCount = _this select 4;
	private	_burstSize = _this select 5;
	private	_burstWait = _this select 6;
	private	_minSpottedDistance = _this select 7;
	private	_roundType = _this select 8;;
	private	_rounds = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0;
	private _text =  getText (configfile / "CfgMagazines" / _rounds  / "displayName");

	_unitName = _unit call FNC_GetArtyDisplayName;


	_ret = 	"Name: " + _unitName +"\n" +
			"Firemission type: Curtain-Firemission \n" +
			"Shell: " + _text +" \n" +
			"Startgrid: " + (mapGridPosition _startPoint) + "\n" +
			"Endgrid: " + (mapGridPosition _endPoint) +"\n" +
			"Width: " +  (str _width) +"\n" +
			"Number of Bursts: " + (str _burstCount) +"\n" +
			"Rounds per Burst: " + (str _burstSize) +"\n" +
			"Delay per Burst: " + (str _burstWait) +"\n" +
			"Minimum Spotted distance: " + (str _minSpottedDistance) +"\n";

	_ret

};
FNC_CurtainFiremission =
{
if (isServer) then
{
_handle = _this spawn
{
		private _unit = _this select 0;
		{
			_tempArray = _this;
			_tempArray set [0,_x];
			_x setVariable [VAR_SART_ARTFMTEXT,_tempArray call FNC_GetCurtainFiremissionText,true];
				[_x , true] call FNC_SetArtyReadyStatus;
		}forEach _unit;
		private _startPoint = _this select 1;
		private _endPoint = _this select 2;
		private _width = _this select 3;
		private	_burstCount = _this select 4;
		private	_burstSize = _this select 5;
		private	_burstWait = _this select 6;
		private	_minSpottedDistance = _this select 7;

		private	_roundType = _this select 8;
		private _roundClassName = ((_unit call FNC_GetArtyAmmo) select _roundType) select 0 ;
		{
			[_x , true] call FNC_SetArtyReadyStatus;
			_x setVariable [VAR_SART_ARTFMTEXT,_this call FNC_GetPointFiremissionText,true];
			[_x, 0,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
		}forEach _unit;
		private	_fireRate = [];
		sleep((_unit call FNC_GetArtyAimTime));
		private	_dis = 1000;
		private	_tempAcc = ((_unit select 0) getVariable [VAR_SART_ARTSPOTACCURACY,MEANSPOTTINGACCURACY]) + 1;
		private	_dir = _endPoint vectorDiff  _startPoint;
		_dir = _dir vectorMultiply (1 /_burstCount);

		private _rightDir = (vectorNormalized _dir) vectorCrossProduct [0,1,0];
		private _leftDir = [0,0,0] vectorDiff _rightDir;
		private _interval = _width / ( count _unit);
		private _startingSpots = [];
		private _leftEdge = _startPoint vectorAdd (_leftDir vectorMultiply ( _width / 2));
		private _tempCount = 0;
		{
				_startingSpots pushBack (_leftEdge vectorAdd (_rightDir vectorMultiply  (_tempCount * _interval)));
				_fireRate pushBack (_x call FNC_ArtGetFireRate);
				_tempCount = _tempCount + 1;
		}forEach _unit;
		[_unit,_startPoint,_roundClassName ] call FNC_InternalSpottingFiremission;
		//spotting rounds finished


		sleep( (_unit getVariable [VAR_SART_ARTCALCSPEED,MEANCALCULATIONTIME]) + 1);
		for "_i" from 0 to _burstCount do
		{
				_row = 0;
				{
						[_unit,(_startingSpots select _row) vectorAdd (_dir vectorMultiply _i),0,_burstSize,_roundClassName] call FNC_InternalFiremission;
						[_x, ((_x getVariable [VAR_SART_ARTROUNDSFIRED,[0,0]]) select 1) + _burstSize,_burstCount * _burstSize] call FNC_SetArtyFiremissionRoundsRequired;
						_row = _row + 1;
				}forEach _unit;
					sleep((((_fireRate select 0) * ((_unit select 0) getVariable [VAR_SART_ARTFIRERATE,MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
		{
				[_x, 0,0] call FNC_SetArtyFiremissionRoundsRequired;
				[_x , false] call FNC_SetArtyReadyStatus;
				[_x,objNULL] call FNC_SetArtyCaller;
		}forEach _unit;
	};
	{
		_x setVariable [VAR_SART_FMHANDLE,_handle,true];
	}forEach (_this select 0);
};



};
FNC_RegisterForwardObserver =
{
if (isServer) then
{
	_handle = _this spawn
	{
		private _observer = _this select 0;
		private _batteries = _this select 1;
		private _minimumKnowledge = _this select 2;
		private _minRange = _this select 3;
		private _range = _this select 4;
		private _standardDispersion = _this select 5;
		private _standardRoundCount = _this select 6;
		private _standardRoundBurst = _this select 7;
		private _standardRoundBurstWait = _this select 8;
		private _minSpottedDistance = _this select 9;
		private _standardRound = _this select 10;
		private _obsSide = side _observer;

		_currentShotTargets = [];
		while{alive _observer} do
		{
				_possibleTargets = _observer nearTargets _range;
				{
					if([_obsSide, _x select 2] call BIS_fnc_sideIsEnemy) then
					{

							//found an enemy
							_target = _x select 4;
							_distance2DToClosestFiremission = 1000;
							{
								if( _distance2DToClosestFiremission > _target distance2D (_x select 1)) then
								{
										_distance2DToClosestFiremission = _target distance2D (_x select 1);
								};
							}forEach _currentShotTargets;

							if((_observer knowsAbout  _target >= _minimumKnowledge) && (_distance2DToClosestFiremission > _minRange) && (((getPosATL _target) select 2) < 10 ) ) then
							{
									//we know enough about it
									//calculate position
									_pos = [[[_target,(_observer getVariable [VAR_SART_OBSACCURACY,OBSACCURACY]) * (_target distance2D _observer) /  _range ]],[]] call BIS_fnc_randomPos;
									sleep(_observer getVariable [VAR_SART_OBSSPEED,OBSSPEED]);
									if(alive _observer) then
									{
										_hasFired = false;
										//fire a firemission
										{
												if((!(_x getVariable [VAR_SART_ARTINFIREMISSION,false])) && !(_hasFired) ) then
												{
														_currentShotTargets pushBack [_x,_pos];
														[_x,_pos,_standardDispersion,_standardRoundCount,_standardRoundBurst,_standardRoundBurstWait,_minSpottedDistance,_standardRound] call FNC_PointFiremission;
														_hasFired = true;
												};
													_freeBattery = _batteries ;

										}forEach _batteries;
									};
							};
					};
				}forEach _possibleTargets;



			sleep(5);
			_tempAdd = [];
			{
					if((_x select 0) getVariable [VAR_SART_ARTINFIREMISSION,false]) then
					{
							_tempAdd pushBack (_x);
					};
			}forEach _currentShotTargets;
			_currentShotTargets = _tempAdd;
		};
	};
		(_this select 0) setVariable [VAR_SART_FMHANDLE,_handle,true];
};
};
FNC_SetObserverSkill =
{
		private _unit  = _this select 0;
		private _accuracy = _this select 1;
		private _speed = _this select 2;
		_unit setVariable [VAR_SART_OBSACCURACY,_accuracy];
		_unit setVariable [VAR_SART_OBSSPEED,_speed];
};
FNC_GetObserverSkill =
{
		private _unit  = _this select 0;
		private _ret = [];
		_ret pushBack (_unit getVariable [VAR_SART_OBSACCURACY,OBSACCURACY]);
		_ret pushBack (_unit getVariable [VAR_SART_OBSSPEED,OBSSPEED]);
		_ret
};

FNC_ArtGetFireRate =
{
		private["_unit","_classname","_weaps","_reloadTime"];
		_unit = _this;
		_classname = typeOf(_unit);
		_weaps = _unit weaponsTurret [0];
		_reloadTime  = getNumber (configfile / "CfgWeapons" / (_weaps select 0) / "reloadTime");
		_reloadTime
};
FNC_StopArtilleryClient =
{
	[-1, {_this call FNC_StopArtillery;},_this] call CBA_fnc_globalExecute;
};
FNC_StopArtillery =
{

	if (isServer) then
	{
			[_this , false] call FNC_SetArtyReadyStatus;
			[_this , false] call FNC_SetArtyReadyStatus;
			terminate (_this getVariable [VAR_SART_FMHANDLE,scriptNULL]);

	};
};




FNC_ClientAddAceArtilleryOption =
{

	private["_unit","_guns"];
	_guns = _this;

	if(!(player getVariable [VAR_SART_PLAYERRECEIVEDGUNS,false])) then
	{
		_action = ["Artillery_Menu", "Artillery Menu", "", {true}, {(count (player getVariable [VAR_SART_OBSGUNS,[]])) > 0}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;


		_action = ["Artillery_Call_Menu", "Call Firemission", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["PointFiremission", "Point Firemission", "", {[] call FNC_DIA_PointFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["LineFiremission", "Line Firemission", "", {[] call FNC_DIA_LineFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["BracketFiremission", "Bracket Firemission", "", {[] call FNC_DIA_BracketFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["DonutFiremission", "Donut Firemission", "", {[] call FNC_DIA_DonutFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["MarkerFiremission", "Marker Firemission", "", {[] call FNC_DIA_MarkerFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["PolarFiremission", "Polar Firemission", "", {[] call FNC_DIA_PolarFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","Artillery_Call_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["SpottingFiremission", "Call Spotting Round", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;


		_action = ["SpottingFiremission", "Polar Spotting Round", "", {[] call FNC_DIA_PolarSpottingFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","SpottingFiremission"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["SpottingFiremission", "Grid Spotting Round", "", {[] call FNC_DIA_GridSpottingFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","SpottingFiremission"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["FiremissionInformation", "Firemission Information", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["StopFiremission", "Stop Firemissions", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;
		{
			_artyName =_x call FNC_GetArtyDisplayName;
			_text = ("Stop " + _artyName);
			_action = ["Stop",_text , "", {(_this select 2) call FNC_StopArtilleryClient; }, {!(( _this select 2) call FNC_IsArtyAviable)},{},_x] call ace_interact_menu_fnc_createAction;
			[player, 1, ["ACE_SelfActions","Artillery_Menu","StopFiremission"], _action] call ace_interact_menu_fnc_addActionToObject;
		}forEach _guns;

		{
			_artyName =_x call FNC_GetArtyDisplayName;
			_text = ("Info " + _artyName);
			_action = ["Info",_text , "",{hint ((_this select 2) call FNC_GetCompleteInfoText); }, { !((_this select 2) call FNC_IsArtyAviable)},{},_x] call ace_interact_menu_fnc_createAction;
			[player, 1, ["ACE_SelfActions","Artillery_Menu","FiremissionInformation"], _action] call ace_interact_menu_fnc_addActionToObject;
		}forEach _guns;

		_id = ["Event_ArtyIsReady",
		{
			[PFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[LFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[BFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[DFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[MFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[PSFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[GSFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
		}] call CBA_fnc_addEventHandler;
		player setVariable [VAR_SART_PLAYERRECEIVEDGUNS,true,true];
	};

};

#include "Dia\Dia_PointFiremission.sqf"
#include "Dia\Dia_LineFiremission.sqf"
#include "Dia\Dia_BracketFiremission.sqf"
#include "Dia\Dia_DonutFiremission.sqf"
#include "Dia\Dia_MarkerFiremission.sqf"
#include "Dia\Dia_GridSpottingFiremission.sqf"
#include "Dia\Dia_PolarSpottingFiremission.sqf"
#include "Dia\Dia_PolarFiremission.sqf"
//expected [paths aviable,units aviable,min ammount of Units spawned, max ammount of units spawned,max ammount of units in the field,delay from mission start,delay between spawns,should clean]

if(isServer) then
{

	#include "settings.sqf"
	_id = ["Event_ArtPlayerJipped", {_this call FNC_ArtMakePlayerObserverServer}] call CBA_fnc_addEventHandler;
};

_id = ["Event_ArtyReceiveHint", {hint _this;}] call CBA_fnc_addEventHandler;
_id = ["Event_ReceiveFoGuns", {_this call FNC_ClientAddAceArtilleryOption}] call CBA_fnc_addEventHandler;
