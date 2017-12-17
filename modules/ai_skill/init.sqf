["AI skill", "Allows the mission maker to change the subskills of ai", "Sacher"] call FNC_RegisterModule;

FNC_setAISkill =
{

	private ["_aiskill", "_value","_condition","_aiskillstring","_conditions"];
	_aiskillstrings = [
						"aimingspeed",
						"spotdistance",
						"aimingaccuracy",
						"aimingshake",
						"spottime",
						"reloadspeed",
						"commanding",
						"general",
						"courage"];

	if(count _this < 2) then
	{
		_temp = format ["AI skill module:<br></br>Array in file ""modules\aiskill\settings.sqf"" is wrong."];
		_temp call FNC_DebugMessage;
	}
	else
	{
		_aiskill = 0;
		_value = 0;
		_conditions = _this;

		if(count _this == 2) then
		{
			_aiskill = _this select 0;
			_value = _this select 1;
			_conditions = [["True"]];
		}
		else
		{
			_aiskill = _this select 0;
			_value = _this select 1;
			_deletefirsttwo = [_aiskill,_value];
			_conditions = _conditions - _deletefirsttwo;
		};

		_isstringcorrect = false;
		{
			if(_aiskill ==_x) then
			{
				_isstringcorrect = true;
			};
		}forEach _aiskillstrings;

		if(_isstringcorrect && _value > 0.2 && _value <= 1) then
		{
			{
				_conditionCheck = [];
				_condition = false;
				_unit = _x;
				{
					switch(_x select 0) do
					{
						case "Distance":
						{
							if(_unit distance (_x select 2) <= (_x select 1)) then
							{
								_condition = true;
								_conditionCheck set [count _conditionCheck,true];
							}
							else
							{
								_conditionCheck set [count _conditionCheck,false];
							};
						};
						case "Side":
						{
							if(side _unit == (_x select 1)) then
							{
								_condition = true;
								_conditionCheck set [count _conditionCheck,true];
							}
							else
							{
								_conditionCheck set [count _conditionCheck,false];
							};
						};
						case "True":
						{
							_condition = true;
							_conditionCheck set [count _conditionCheck,true];
						};
						case "Group":
						{
							if(group _unit == _x select 1) then
							{
								_condition = true;
								_conditionCheck set [count _conditionCheck,true];
							}
							else
							{
								_conditionCheck set [count _conditionCheck,false];
							};
						};
						case "Vehicle":
						{
							if(count _x == 1) then
							{
								if(_unit call FNC_InVehicle) then
								{
									_condition = true;
									_conditionCheck set [count _conditionCheck,true];
								}
								else
								{
									_conditionCheck set [count _conditionCheck,false];
								};
							}
							else
							{
								if(vehicle _unit in (_x select 1)) then
								{
									_condition = true;
									_conditionCheck set [count _conditionCheck,true];
								}
								else
								{
									_conditionCheck set [count _conditionCheck,false];
								};
							}
						};
						default
						{
							_conditionCheck set [count _conditionCheck,false];
						};
					};
				}forEach _conditions;
				{
					if(!(_x)) then
					{
						_condition = false;
					};
				}forEach _conditionCheck;

				if(!(isPlayer _x) && _condition) then
				{
					_x setSkill [_aiskill , _value];
				};
			}forEach allUnits;

		}
		else
		{
			if(_value < 0.2 || _value > 1) then
			{
				_temp = format ["AI skill module:<br></br>Warning AI-Skill-Value ""%1"", in file ""modules\aiskill\settings.sqf"" , is wrong.", _value];
				_temp call FNC_DebugMessage;
			};
			if(!(_isstringcorrect)) then
			{
				_temp = format ["AI skill module:<br></br>Warning AI-skillstring ""%1"", in file ""modules\aiskill\settings.sqf"" , does not exist.", _aiskill];
				_temp call FNC_DebugMessage;
			};
		};
	};
};

if (isServer) then
{
	#include "settings.sqf"
};
