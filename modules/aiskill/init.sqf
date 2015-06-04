FNC_setAISkill = 
{
	private ["_aiskill", "_value","_condition","_aiskillstring","_conditions"];

	_aiskillstrings = [
						"aimingspeed",
						"spotdistance",
						"aimingaccuracy",
						"aimingshake",
						"spottime",
						"spotdistance",
						"commanding",
						"general",
						"courage"];

	if(count _this < 2) then
	{
		_temp = format ["AI skill module:<br></br>Array in file ""modules\aiskill\settings.sqf"" is wrong."];
		_temp call FNC_DebugMessage; 
	};
	_aiskill = 0;
	_value = 0;
	_conditions = [];
	if(count _this >= 3) then
	{
		_aiskill = _this select 0;
		_value = _this select 1;
		for[{i = 2}, {i < count _this} , {i = i +1}] do
		{	
			_temp = _this select i;
			if(count _temp < 2) then
			{
				_temp = format ["AI skill module:<br></br>Conditions in file ""modules\aiskill\settings.sqf"" is wrong."];
				_temp call FNC_DebugMessage; 
			};
			switch(_temp select 0) do
				{
					case "Distance":
					{
						_conditions set [count _conditions, [_temp select 0, _temp select 1,_temp select 2]];
					};
					case "Side":
					{
						_conditions set [count _conditions, [_temp select 0, _temp select 1]];
					};
					case "True":
					{
						_conditions set [count _conditions, ["True"]];
					};
					default
					{
						_temp = format ["AI skill module:<br></br>Condition ""%1"" in file ""modules\aiskill\settings.sqf"" is wrong.",_temp select 0];
						_temp call FNC_DebugMessage; 
					};
				};
			
		};	
	};
	if(count _this == 2) then
	{
		_aiskill = _this select 0;
		_value = _this select 1;
		_conditions = [["True"]];
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
							_conditionCheck set [count _conditionCheck,true];
							_condition = true;
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
							_conditionCheck set [count _conditionCheck,true];
							_condition = true;
						}
						else
						{
							_conditionCheck set [count _conditionCheck,false];
						};
					};
					case "True":
					{
						_conditionCheck set [count _conditionCheck,true];
						_condition = true;
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

if (isServer) then 
{
	#include "settings.sqf"	
};