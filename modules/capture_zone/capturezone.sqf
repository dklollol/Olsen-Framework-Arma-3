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
CZMARKERCOLLECTION pushBack ["NONE",_marker,false];
_countforwins = 0;
{
	(_markerCount select 1) pushBack [_x ,0,_wins select _countforwins]; //side,count,win
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

_contester = "NONE";
while{_run} do
{

	_start = time;
	_delta = _start - _end;
	//count all units in area n special format [_marker,[[_side,count,win],[_side,count,win]]];

	{
		_x set [1,0];
	}forEach (_markerCount select 1);

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

					_mes = _messages select 0;
					//this is for ContestedZone so the timer doesn't reset
					//can probaply be done better
					if(_contester != "WEST") then
					{
						_timer = time;
						_contester = "WEST";
					};
					[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
					[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colors select 0]] call CBA_fnc_globalExecute;

			};
			case "EAST":
			{
					_mes = _messages select 1;
					//this is for ContestedZone so the timer doesn't reset
					//can probaply be done better
					if(_contester != "EAST") then
					{
						_timer = time;
						_contester = "EAST";
					};
					[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
					[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colors select 1]] call CBA_fnc_globalExecute;

			};
			case "GUER":
			{
					_mes = _messages select 2;
					//this is for ContestedZone so the timer doesn't reset
					//can probaply be done better
					if(_contester != "GUER") then
					{
						_timer = time;
						_contester = "GUER";
					};
					[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
					[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colors select 2]] call CBA_fnc_globalExecute;


			};
			case "RESISTANCE":
			{
					_mes = _messages select 2;
					//this is for ContestedZone so the timer doesn't reset
					//can probaply be done better
					if(_contester != "RESISTANCE") then
					{
						_timer = time;
						_contester = "RESISTANCE";
					};
					[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
					[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colors select 2]] call CBA_fnc_globalExecute;

			};
			case "CIVILIAN":
			{
					_mes = _messages select 3;
					//this is for ContestedZone so the timer doesn't reset
					//can probaply be done better
					if(_contester != "CIVILIAN") then
					{
						_timer = time;
						_contester = "CIVILIAN";
					};
					[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
					[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colors select 3]] call CBA_fnc_globalExecute;

			};
			case "UNCONTESTED":
			{
					_mes = _messages select 5;
					[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
					[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colors select 5]] call CBA_fnc_globalExecute;
					sleep(_intervall);
					_timer = time;
					_contester = "NONE";
			};
			case "CONTESTED":
			{
					if((_currentOwner select 0) != (_oldOwner select 0)) then
					{
						_mes = _messages select 4;
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colors select 4]] call CBA_fnc_globalExecute;

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
