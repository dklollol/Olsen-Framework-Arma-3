["Firemission", "Custom Artillery Strike Missions", "Sacher"] call FNC_RegisterModule;

#define MEANCALCULATIONTIME 120
#define MEANAIMTIME 10
#define MEANSPOTTINGACCURACY 300
#define MEANPlOTTEDACCURACY 50
#define MAXSPOTTINGROUNDS 3
#define MEANFIRERATE 1
#define SPOTTINGROUNDSREQUIRED true
#define OBSACCURACY 100
#define OBSSPEED 30

#include "Dia_Global.sqf"

FNC_AddEventHandler =
{
	if(!((_this) getVariable ["ArtHasEventHandler",false])) then
	{
			(_this) addeventhandler ["fired", {(_this select 0) setvehicleammo 1}];
			(_this) setVariable ["ArtHasEventHandler",true];
	};

};

FNC_SetArtyReadyStatus =
{
	private _unit = _this select 0;
	private _isFiring = _this select 1;

	_unit setVariable ["isInAFiremission",_isFiring,true];
	["Event_ArtyIsReady", [_unit,_isFiring]] call CBA_fnc_globalEvent;
};

FNC_SetArtilleryData =
{
		//TODO do some value checking
		_unit = _this select 0;
		_fireRate = if((_this select 1) < 0) then {MEANFIRERATE} else {  _this select 1};;
		_accuracy = if((_this select 2) <0) then { MEANPlOTTEDACCURACY} else { _this select 2 };;
		_spottingAccuracy = if((_this select 3) < 0) then {MEANSPOTTINGACCURACY} else { _this select 3  };;
		_aimSpeed = if((_this select 4) < 0) then {MEANAIMTIME} else {   _this select 4};;
		_calcSpeed = if((_this select 5) < 0) then {MEANCALCULATIONTIME } else { _this select 5 };;
		_customName = _this select 6;
		_unlimitedAmmo = _this select 7;
		_unit setVariable ["ArtFireRate",_fireRate];
		_unit setVariable ["ArtAccuracy",_accuracy];
		_unit setVariable ["ArtSpottingAccuracy",_spottingAccuracy];
		_unit setVariable ["ArtAimSpeed",_aimSpeed];
		_unit setVariable ["ArtCalcSpeed",_calcSpeed];
		_unit setVariable ["ArtCustomName",_customName];
		_unit setVariable ["ArtUnlimitedAmmo",_unlimitedAmmo];
		if(_unlimitedAmmo) then {_unit call FNC_AddEventHandler;};


};
FNC_GetArtillerySkill =
{
		_unit = _this select 0;
		skills = [];
		skills pushBack (_unit getVariable ["ArtFireRate",MEANFIRERATE]);
		skills pushBack (_unit getVariable ["ArtAccuracy",MEANPlOTTEDACCURACY]);
		skills pushBack (_unit getVariable ["ArtSpottingAccuracy",MEANSPOTTINGACCURACY]);
		skills pushBack (_unit getVariable ["ArtAimSpeed",MEANAIMTIME]);
		skills pushBack (_unit getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]);
		skills pushBack (_unit getVariable ["ArtCustomName",""]);
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

FNC_PointFireMission =
{
	_handle = _this spawn
	{
		private _unit = _this select 0;

	[_unit , true] call FNC_SetArtyReadyStatus;

		private	_target = _this select 1;
		private	_dispersion = _this select 2;
		private	_burstCount = _this select 3;
		private	_burstSize = _this select 4;
		private	_burstWait = _this select 5;
		private	_minSpottedDistance = _this select 6;
		private	_roundType = _this select 7;

		private	_fireRate = _unit call FNC_ArtGetFireRate;
			//calculateFireMission
			hint str ( (_unit getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]) + 1);
			sleep( (_unit getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]) + 1);
		private	_dis = 1000;
		private	_tempAcc = (_unit getVariable ["ArtSpottingAccuracy",MEANSPOTTINGACCURACY]) + 1;
			while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED  )} do
			{
						_randomPos = [[[_target, _tempAcc]],[]] call BIS_fnc_randomPos;
						_dis = _randomPos distance2D _target;
						_eta = _unit getArtilleryETA [_randomPos, (magazinesAmmo _actualGunUnit) select _roundType];
						_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, 1];
						_waitTime = (_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE])) max _eta;
						sleep(_waitTime max ((_unit getVariable ["ArtAimSpeed",MEANAIMTIME]) + 1));
						_tempAcc = [_dis,_tempAcc] call FNC_GetNewAccuracy;

			};
			for "_i" from 0 to _burstCount do
			{
					_randomPos = [[[_target, _dispersion]],[]] call BIS_fnc_randomPos;
					_randomPos =	[[[_randomPos, MEANPlOTTEDACCURACY]],[]] call BIS_fnc_randomPos;
			  	_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, _burstSize];
				  sleep(((_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE]) ) * _burstSize) max _burstWait);
			};
				[_x , false] call FNC_SetArtyReadyStatus;
	};
		(_this select 0) setVariable ["FireMissionHandle",_handle,true];
};

FNC_LineFireMission =
{
_handle = _this spawn
{
		private _unit = _this select 0;
	[_unit , true] call FNC_SetArtyReadyStatus;

		private _startPoint = _this select 1;
		private _endPoint = _this select 2;
		private	_burstCount = _this select 3;
		private	_burstSize = _this select 4;
		private	_burstWait = _this select 5;
		private	_minSpottedDistance = _this select 6;
		private	_roundType = _this select 7;
		private	_fireRate = _unit call FNC_ArtGetFireRate;

		sleep( (_unit getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]) + 1);
		private	_dis = 1000;
		private	_tempAcc = (_unit getVariable ["ArtSpottingAccuracy",MEANSPOTTINGACCURACY]) + 1;
		while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED )} do
		{
					_randomPos = [[[_startPoint, _tempAcc]],[]] call BIS_fnc_randomPos;
					_dis = _randomPos distance2D _startPoint;

					_eta = _unit getArtilleryETA [_randomPos, (magazinesAmmo _actualGunUnit) select _roundType];
					_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, 1];
					_waitTime = (_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE])) max _eta;
					sleep(_waitTime max ((_unit getVariable ["ArtAimSpeed",MEANAIMTIME]) + 1));
					_tempAcc = [_dis,_tempAcc] call FNC_GetNewAccuracy;

		};
		//spotting rounds finished
	  private	_dir = _endPoint vectorDiff  _startPoint;
		_dir = _dir vectorMultiply (1 /_burstCount);
		private _dispersion = MEANPlOTTEDACCURACY * (_unit getVariable ["ArtAccuracy",MEANPlOTTEDACCURACY]) + 1;
		for "_i" from 0 to _burstCount do
		{

			_randomPos = [[[_startPoint vectorAdd (_dir vectorMultiply _i),_dispersion ]],[]] call BIS_fnc_randomPos;
				_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, _burstSize];
				sleep(((_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
			[_x , false] call FNC_SetArtyReadyStatus;
	};

			(_this select 0) setVariable ["FireMissionHandle",_handle,true];
};

FNC_BracketFireMission =
{
_handle = _this spawn
{
		private _unit = _this select 0;
	[_unit , true] call FNC_SetArtyReadyStatus;

		private _startPoint = _this select 1;
		private _endPoint = _this select 2;
		private	_burstCount = _this select 3;
		private	_burstSize = _this select 4;
		private	_burstWait = _this select 5;
		private	_minSpottedDistance = _this select 6;
		private	_roundType = _this select 7;
		private	_fireRate = _unit call FNC_ArtGetFireRate;

		sleep( (_unit getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]) + 1);
		private	_dis = 1000;
		private	_tempAcc = (_unit getVariable ["ArtSpottingAccuracy",MEANSPOTTINGACCURACY]) + 1;
		while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED )} do
		{
					_randomPos = [[[_startPoint, _tempAcc]],[]] call BIS_fnc_randomPos;
					_dis = _randomPos distance2D _startPoint;
					_eta = _unit getArtilleryETA [_randomPos, (magazinesAmmo _actualGunUnit) select _roundType];
					_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, 1];
					_waitTime = (_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE])) max _eta;
					sleep(_waitTime max ((_unit getVariable ["ArtAimSpeed",MEANAIMTIME]) + 1));
					_tempAcc = [_dis,_tempAcc] call FNC_GetNewAccuracy;

		};
		//spotting rounds finished
		private	_dir = _endPoint vectorDiff  _startPoint;
		_dir = _dir vectorMultiply (1 /_burstCount);
		private _dispersion = MEANPlOTTEDACCURACY * (_unit getVariable ["ArtAccuracy",MEANPlOTTEDACCURACY]) + 1;
		private _isForward = true;
		for "_i" from 0 to _burstCount do
		{
			if(_isForward) then
			{
					_randomPos = [[[_startPoint vectorAdd (_dir vectorMultiply (_i / 2)),_dispersion ]],[]] call BIS_fnc_randomPos;
					_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, _burstSize];
					_isForward = false;
			}
			else
			{
					_randomPos = [[[_startPoint vectorAdd (_dir vectorMultiply ((_burstCount - _i) / 2)),_dispersion ]],[]] call BIS_fnc_randomPos;
					_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, _burstSize];
					_isForward = true;
			};

					sleep(((_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
			[_x , false] call FNC_SetArtyReadyStatus;
		};
				(_this select 0) setVariable ["FireMissionHandle",_handle,true];
};

FNC_DonutFireMission =
{
	if (isServer) then
	{
		_handle = _this spawn
		{
			private _unit = _this select 0;
		[_unit , true] call FNC_SetArtyReadyStatus;

			private	_target = _this select 1;
			private	_innerRadius = _this select 2;
			private	_outerRadius = _this select 3;
			private	_burstCount = _this select 4;
			private	_burstSize = _this select 5;
			private	_burstWait = _this select 6;
			private	_minSpottedDistance = _this select 7;
			private	_roundType = _this select 8;

			private	_fireRate = _unit call FNC_ArtGetFireRate;

				//calculateFireMission
				sleep( (_unit getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]) + 1);

			private	_dis = 1000;
			private	_tempAcc = (_unit getVariable ["ArtSpottingAccuracy",MEANSPOTTINGACCURACY]) + 1;
				_pointInDonutForSpottingRound = [[[_target, _outerRadius]],[[_target, _innerRadius]]] call BIS_fnc_randomPos;
				while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED )} do
				{
							_randomPos = [[[_pointInDonutForSpottingRound, _tempAcc]],[]] call BIS_fnc_randomPos;
							_dis = _randomPos distance2D _pointInDonutForSpottingRound;
							_eta = _unit getArtilleryETA [_randomPos, (magazinesAmmo _actualGunUnit) select _roundType];
							_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, 1];
							_waitTime = (_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE])) max _eta;
							sleep(_waitTime max ((_unit getVariable ["ArtAimSpeed",MEANAIMTIME]) + 1));
							_tempAcc = [_dis,_tempAcc] call FNC_GetNewAccuracy;

				};
				//spotting rounds finished
				for "_i" from 0 to _burstCount do
				{
						_randomPos = [[[_target, _outerRadius]],[[_target, _innerRadius]]] call BIS_fnc_randomPos;
						_randomPos =	[[[_randomPos, MEANPlOTTEDACCURACY]],[]] call BIS_fnc_randomPos;
						_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, _burstSize];
						sleep(((_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE]) ) * _burstSize) max _burstWait);
				};
				[_x , false] call FNC_SetArtyReadyStatus;
		};
		(_this select 0) setVariable ["FireMissionHandle",_handle,true];
	};
};

FNC_MarkerFireMission =
{
	if (isServer) then
	{
		_handle = _this spawn
		{
				private _unit = _this select 0;
			[_unit , true] call FNC_SetArtyReadyStatus;

				private	_targetMarker = _this select 1;
				private	_burstCount = _this select 2;
				private	_burstSize = _this select 3;
				private	_burstWait = _this select 4;
				private	_minSpottedDistance = _this select 5;
				private	_roundType = _this select 6;
				private	_fireRate = _unit call FNC_ArtGetFireRate;

					//calculateFireMission
					sleep( (_unit getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]) + 1);
				private	_dis = 1000;
				private	_tempAcc = (_unit getVariable ["ArtSpottingAccuracy",MEANSPOTTINGACCURACY]) + 1;
				private	_pointInMarker = [[_targetMarker],[]] call BIS_fnc_randomPos;
					while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED )} do
					{
								_randomPos = [[[_pointInMarker, _tempAcc]],[]] call BIS_fnc_randomPos;
								_dis = _randomPos distance2D _pointInMarker;
								_eta = _unit getArtilleryETA [_randomPos, (magazinesAmmo _actualGunUnit) select _roundType];
								_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, 1];
								_waitTime = (_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE])) max _eta;
								sleep(_waitTime max ((_unit getVariable ["ArtAimSpeed",MEANAIMTIME]) + 1));
								_tempAcc = [_dis,_tempAcc] call FNC_GetNewAccuracy;

					};
					//spotting rounds finished
					for "_i" from 0 to _burstCount do
					{
							_randomPos = [[_targetMarker],[]] call BIS_fnc_randomPos;
							_randomPos =	[[[_randomPos, MEANPlOTTEDACCURACY]],[]] call BIS_fnc_randomPos;
							_unit commandArtilleryFire [_randomPos,  (magazinesAmmo _actualGunUnit) select _roundType, _burstSize];
							sleep(((_fireRate * (_unit getVariable ["ArtFireRate",MEANFIRERATE]) ) * _burstSize) max _burstWait);
					};

						[_x , false] call FNC_SetArtyReadyStatus;
		};
		(_this select 0) setVariable ["FireMissionHandle",_handle,true];
	};

};
FNC_PointMarkerFiremission =
{
if (isServer) then
{
	[_this select 0,getMarkerPos (_this select 1),_this select 2,_this select 4,_this select 5,_this select 6,_this select 7] call PointFiremission;
	};
};
FNC_DynamicMarkerFiremission =
{
	if (isServer) then
	{
		_marker = "";
		{
			if((markerText (_x))  == _this select 1) then
			{
				_marker = _x;
			};
		}
		forEach allMapMarkers;
		[_this select 0,getMarkerPos _marker,_this select 2,_this select 4,_this select 5,_this select 6,_this select 7] call PointFiremission;
	};
};

FNC_CurtainFireMission =
{
if (isServer) then
{
_handle = _this spawn
{
		private _unit = _this select 0;
		{
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

		private	_fireRate = [];
		sleep( ((_unit select 0) getVariable ["ArtCalcSpeed",MEANCALCULATIONTIME]) + 1);
		private	_dis = 1000;
		private	_tempAcc = ((_unit select 0) getVariable ["ArtSpottingAccuracy",MEANSPOTTINGACCURACY]) + 1;
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

		while{(_dis >_minSpottedDistance && SPOTTINGROUNDSREQUIRED )} do
		{
					_randomPos = [[[_startPoint, _tempAcc]],[]] call BIS_fnc_randomPos;
					_dis = _randomPos distance2D _startPoint;
					_eta = (_unit select 0) getArtilleryETA [_randomPos, getArtilleryAmmo [(_unit select 0)] select _roundType];
					(_unit select 0) commandArtilleryFire [_randomPos,  getArtilleryAmmo [(_unit select 0)] select _roundType, 1];
					_waitTime = ((_fireRate select 0)  * ((_unit select 0) getVariable ["ArtFireRate",MEANFIRERATE])) max _eta;
					sleep(_waitTime max (((_unit select 0) getVariable ["ArtAimSpeed",MEANAIMTIME]) + 1));
					_tempAcc = [_dis,_tempAcc] call FNC_GetNewAccuracy;

		};
		//spotting rounds finished



		for "_i" from 0 to _burstCount do
		{
				_row = 0;
				{
						private _dispersion = MEANPlOTTEDACCURACY * (_x getVariable ["ArtAccuracy",MEANPlOTTEDACCURACY]) + 1;
						_randomPos = [[[(_startingSpots select _row) vectorAdd (_dir vectorMultiply _i),_dispersion ]],[]] call BIS_fnc_randomPos;
						_x commandArtilleryFire [_randomPos,  getArtilleryAmmo [_x] select _roundType, _burstSize];
						_row = _row + 1;
				}forEach _unit;
					sleep((((_fireRate select 0) * ((_unit select 0) getVariable ["ArtFireRate",MEANFIRERATE]) ) * _burstSize) max _burstWait);
		};
		{
				[_x , false] call FNC_SetArtyReadyStatus;
		}forEach _unit;
	};
	{
		_x setVariable ["FireMissionHandle",_handle,true];
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
		private _standardRoundCount = _this select 5;
		private _standardRoundBurst = _this select 6;
		private _standardRoundBurstWait = _this select 7;
		private _standardDispersion = _this select 8;
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
							_distance2DToClosestFireMission = 1000;
							{
								if( _distance2DToClosestFireMission > _target distance2D (_x select 1)) then
								{
										_distance2DToClosestFireMission = _target distance2D (_x select 1);
								};
							}forEach _currentShotTargets;

							if((_observer knowsAbout  _target >= _minimumKnowledge) && (_distance2DToClosestFireMission > _minRange)) then
							{
									//we know enough about it
									//calculate position
									_pos = [[[_target,(_observer getVariable ["ObserverAccuracy",OBSACCURACY]) * (_target distance2D _observer) /  _range ]],[]] call BIS_fnc_randomPos;
									sleep(_observer getVariable ["ObserverSpeed",OBSSPEED]);
									if(alive _observer) then
									{
										_hasFired = false;
										//fire a firemission
										{
												if((!(_x getVariable ["isInAFiremission",false])) && !(_hasFired) ) then
												{
														_currentShotTargets pushBack [_x,_pos];
														[_x,_pos,_standardDispersion,_standardRoundCount,_standardRoundBurst,_standardRoundBurstWait,_minSpottedDistance,_standardRound] call FNC_PointFireMission;
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
					if((_x select 0) getVariable ["isInAFiremission",false]) then
					{
							_tempAdd pushBack (_x);
					};
			}forEach _currentShotTargets;
			_currentShotTargets = _tempAdd;
		};
	};
		(_this select 0) setVariable ["FireMissionHandle",_handle,true];
};
};
FNC_SetObserverSkill =
{
		private _unit  = _this select 0;
		private _accuracy = _this select 1;
		private _speed = _this select 2;
		_unit setVariable ["ObserverAccuracy",_accuracy];
		_unit setVariable ["ObserverSpeed",_speed];
};
FNC_GetObserverSkill =
{
		private _unit  = _this select 0;
		private _ret = [];
		_ret pushBack (_unit getVariable ["ObserverAccuracy",OBSACCURACY]);
		_ret pushBack (_unit getVariable ["ObserverSpeed",OBSSPEED]);
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

FNC_StopArtillery =
{
	if (isServer) then
	{
			[_this , false] call FNC_SetArtyReadyStatus;
			terminate (_this getVariable ["FireMissionHandle",nil]);
	};
};

FNC_ArtMakePlayerObserver =
{
	if (isServer) then
	{
		private _unit = _this select 0;
		private	_guns = _this select 1;
		_unit setVariable ["PlayerArtilleryGuns",_guns,true];
		[[_unit,_guns],{_this call FNC_ClientAddAceArtilleryOption;}] remoteExec ["call",owner _unit];
	};
	_this spawn
	{
		waitUntil { time > 0};
		private["_unit","_guns"];
		_unit = _this select 0;
		_guns = _this select 1;
		_action = ["Artillery_Menu", "Request Artillery", "", {true}, {(count (player getVariable ["PlayerArtilleryGuns",[]])) > 0}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;


		_action = ["PointFiremission", "Point Firemission", "", {[] call FNC_DIA_PointFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["LineFiremission", "Line Firemission", "", {[] call FNC_DIA_LineFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["BracketFiremission", "Bracket Firemission", "", {[] call FNC_DIA_BracketFiremissionOpenDialog;}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["DonutFiremission", "Donut Firemission", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["MarkerFiremission", "Marker Firemission", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["StopFireMission", "Stop Firemissions", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;
		{
			_artyName =_x call FNC_GetArtyDisplayName;
			_actionText = ("Stop");
			_text = ("Stop " + _artyName);
			_action = ["stop",_text , "", {(_this select 2) call FNC_StopArtillery; }, { (alive (_this select 2) && ((_this select 2) getVariable ["isInAFiremission",false]))},{},_x] call ace_interact_menu_fnc_createAction;
			[player, 1, ["ACE_SelfActions","Artillery_Menu","StopFireMission"], _action] call ace_interact_menu_fnc_addActionToObject;
		}forEach _guns;




		_id = ["Event_ArtyIsReady",
		{
			[PFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[LFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
			[BFM_DIA_IDC_GUNSELECT] call FNC_ArtLoadAviableArtilleries;
		}] call CBA_fnc_addEventHandler;
	};




};

FNC_ClientAddAceArtilleryOption =
{
	private _unit = _this select 0;
	private _guns = _this select 1;


};
#include "Dia_PointFiremission.sqf"
#include "Dia_LineFiremission.sqf"
#include "Dia_BracketFiremission.sqf"
//expected [paths aviable,units aviable,min ammount of Units spawned, max ammount of units spawned,max ammount of units in the field,delay from mission start,delay between spawns,should clean]

	#include "settings.sqf"
