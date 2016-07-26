private ["_sides","_marker","_wins","_intervall","_colors","_countforwins","_markerCount","_update","_start","_end","_delta","_timer","_messages","_updateContested","_updateUncontested","_run","_oldOwner","_currentOwner"];

_marker = (_this select 0) select 0;
_wins = [300,300,300,300];
_sides = [west,east,resistance,civilian];
if((count (_this select 0)) > 1) then
{
	_sides = (_this select 0) select 1;
};
if((count (_this select 0)) > 2) then
{
	_wins = (_this select 0) select 2;
};
_colors = _this select 1;
_intervall = _this select 2;
_messages = _this select 3;
_markerCount = [_marker,[]];
CZMARKERCOLLECTION set [count CZMARKERCOLLECTION,["none",_marker ,false]];
_countforwins = 0;
{
	_markerCount select 1 set [count (_markerCount select 1) ,[_x ,0,_wins select _countforwins]]; //side,count,win
	_countforwins = _countforwins + 1;
}forEach _sides;
//special format [_marker,[[_side,count,win],[_side,count,win]]];
_update = true;
_updateContested  = true;
_updateUncontested = true;
_start = 0;
_end = time;
_delta = 0;
_timer = 0;
 //ident,count,win
_oldOwner = ["temp",0,9999];
sleep(1);
_run = true;
while{_run} do
{
	start = time;
	_delta = _start - _end;
	//count all units in area n special format [_marker,[[_side,count,win],[_side,count,win]]];
	_countforwins = 0;
	{
		_markerCount select 1 set [_countforwins,[_x,0,((_markerCount select 1) select _countforwins) select 2]]; //side,count,win
		_countforwins = _countforwins + 1;
	}forEach _sides;
	
	{
		_unit = _x;

		if([_unit,_markerCount select 0] call FNC_InArea && alive _unit) then
		{
			{
			
				if(side _unit == _x select 0) then
				{
					_x set [1,(_x select 1) + 1] ;
				}
			}forEach (_markercount select 1);
		};
	}forEach allUnits;
	_currentOwner = ["UNCONTESTED",0,9999];
	{	
		
		if(_x select 1 > _currentOwner select 1) then
		{
			_currentOwner = [str (_x select 0),_x select 1,_x select 2];
		
		}
		else
		{
			if((_x select 1) == (_currentOwner select 1) && (_x select 1) != 0) then
			{
				_currentOwner = ["CONTESTED",_x select 1,9999];
			};
		}
	}forEach (_markerCount select 1);

	if(((_currentOwner select 0) != (_oldOwner select 0)) || (_currentOwner select 0 == "CONTESTED")) then
	{
		switch(_currentOwner select 0) do
		{
			case "WEST":
			{
				if(_update) then
				{
					if(_oldOwner select 0 != "CONTESTED") then
					{
						_timer = time;
						
					};
					CZMESSAGE = _messages select 0;
					publicVariable "CZMESSAGE";
					[-1, {hintSilent CZMESSAGE}] call CBA_fnc_globalExecute;
					_marker setMarkerColor (_colors select 0);
					_updateContested  = true;
					_update = false;
					_updateUncontested = true;
				};
		
			};
			case "EAST":
			{
				if(_update) then
				{
					CZMESSAGE = _messages select 1;
					publicVariable "CZMESSAGE";
					[-1, {hintSilent CZMESSAGE}] call CBA_fnc_globalExecute;
					_marker setMarkerColor (_colors select 1);
					if(_oldOwner select 0 != "CONTESTED") then
					{
						_timer = time;		
					};
					_updateContested  = true;
					_update = false;
					_updateUncontested = true;
				};
			
			};
			case "GUER":
			{
				if(_update) then
				{
					CZMESSAGE = _messages select 2;
					publicVariable "CZMESSAGE";
					[-1, {hintSilent  CZMESSAGE}] call CBA_fnc_globalExecute;
					_marker setMarkerColor (_colors select 2);
					if(_oldOwner select 0 != "CONTESTED") then
					{
						_timer = time;
						
					};
					_updateContested  = true;
					_update = false;
					_updateUncontested = true;
				};
		
			};
			case "RESISTANCE":
			{
				if(_update) then
				{
					CZMESSAGE = _messages select 2;
					publicVariable "CZMESSAGE";
					[-1, {hintSilent  CZMESSAGE}] call CBA_fnc_globalExecute;
					_marker setMarkerColor (_colors select 2);
					if(_oldOwner select 0 != "CONTESTED") then
					{
						_timer = time;
						
					};
					_updateContested  = true;
					_update = false;
					_updateUncontested = true;
				};
		
			};
			case "CIVILIAN":
			{
				if(_update) then
				{
					CZMESSAGE = _messages select 3;
					publicVariable "CZMESSAGE";
					[-1, {hintSilent CZMESSAGE}] call CBA_fnc_globalExecute;
					_marker setMarkerColor (_colors select 3);
					if(_oldOwner select 0 != "CONTESTED") then
					{
						_timer = time;
						
					};
					_updateContested  = true;
					_update = false;
					_updateUncontested = true;
					
				};
			
			};
			case "UNCONTESTED":
			{
				if(_updateUncontested) then
				{
					CZMESSAGE = _messages select 5;
					publicVariable "CZMESSAGE";
					[-1, {hintSilent CZMESSAGE}] call CBA_fnc_globalExecute;
					_marker setMarkerColor (_colors select 5);
					sleep(_intervall);
					_updateUncontested = false;
					_update = true;
					_updateContested  = true;
				}
			};
			case "CONTESTED":
			{
				if(_updateContested) then
				{
					CZMESSAGE = _messages select 4;
					publicVariable "CZMESSAGE";
					[-1, {hintSilent CZMESSAGE}] call CBA_fnc_globalExecute;
					_marker setMarkerColor (_colors select 4);
					_updateContested  = false;
					_update = true;
					_updateUncontested = true;
				};
				_timer = _timer + _delta;
			};
		};
	};
	_countforwins = 0;
	{			
		if(_marker  == _x select 1) then 
		{
			if((time - _timer) >= _currentOwner select 2) then
			{
				_temp = true;

				if(_temp) exitWith
				{
					CZMARKERCOLLECTION set [_countforwins,[_currentOwner select 0,_marker,true]];
					_run = false;
				};
			}
			else
			{
					CZMARKERCOLLECTION set [_countforwins,[_currentowner select 0,_marker,false]];
			};
		};
		_countforwins = _countforwins + 1;
	}forEach CZMARKERCOLLECTION;
	_oldOwner = _currentOwner;
	_end = _start;
	sleep(1);
};
