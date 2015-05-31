createDialog "DIA_ENDSCREEN";
_dia = 300;
_bg = 3000;
_endTitle = 3001;
_left = 3002;
_right = 3003;

_scenario = _this select 0;
_timeLimt = _this select 1;
_teams = _this select 2;

disableUserInput true;

{
	
	_x enableSimulation false;
	
} forEach vehicles;

_leftText = "";
_rightText = "";
_textSide = 0;
{
	
	_name = _x select 0;
	_side = _x select 1;
	_type = _x select 2;
	_start = _x select 3;
	_current = _x select 4;
	_disabled = _x select 5;
	_destroyed = _x select 6;
	
	_temp = format ["%1<br />Casualties: %2 out of %3<br />", _name, (_start - _current), _start];

	if (count _disabled != 0) then {
	
		_temp = _temp + "<br />Disabled assets:<br />";
		
		{
		
			_temp = _temp + format ["%1<br />", _x];
			
		} forEach _disabled;
		
	};

	if (count _destroyed != 0) then {
	
		_temp = _temp + "<br />Destroyed assets:<br />";
		
		{
		
			_temp = _temp + format ["%1<br />", _x];
			
		} forEach _destroyed;
	};
	
	_temp = _temp + "<br />";
	
	if (_textSide == 0) then {
	
		_textSide = 1;
		_leftText = _leftText + _temp;
		
	} else {
	
		_textSide = 0;
		_rightText = _rightText + _temp;
		
	};
	
} forEach _teams;

_endTitleText = _scenario;

if (_timeLimt != 0) then {

	_time = ceil(time / 60);

	if (_time >= _timeLimt) then {
		
		_time = _timeLimt;
		
	};

	_timeLimitText = format ["Mission duration: %1 out of %2 minutes", _time, _timeLimt];

	_endTitleText = format ["%1<br />%2", _scenario, _timeLimitText];
	
};

((findDisplay _dia) displayCtrl _endTitle) ctrlSetStructuredText parseText _endTitleText;
((findDisplay _dia) displayCtrl _left) ctrlSetStructuredText parseText _leftText;
((findDisplay _dia) displayCtrl _right) ctrlSetStructuredText parseText _rightText;

for "_x" from 1 to 120 do {
	
	((findDisplay _dia) displayCtrl _bg) ctrlSetBackgroundColor [0, 0, 0, (_x * (1/120))];
	sleep(0.01);
	
};

sleep (15);
disableUserInput false;
endMission "END1";