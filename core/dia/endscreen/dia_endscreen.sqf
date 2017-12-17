createDialog "DIA_ENDSCREEN";
_dia = 300;
_bg = 3000;
_endTitle = 3001;
_left = 3002;
_right = 3003;
_bottomLeft = 3004;
_bottomMiddle = 3005;
_bottomRight = 3006;

params ["_scenario", "_timeLimit", "_teams"];

{

	_x enableSimulation false;

} forEach vehicles;

[] spawn {

    sleep 4;
    {

        _x enableSimulation false;
        removeAllWeapons _x;

    } forEach allPlayers;
};

_leftText = "";
_rightText = "";
_bottomTextLeft = "";
_bottomTextMiddle = "";
_bottomTextRight = "";
_textSide = 0;
{

    _x params ["_name", "_side", "_type", "_start", "_current", "_disabled", "_destroyed"];

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

if (_timeLimit != 0) then {

	_time = ceil(time / 60);

	if (_time >= _timeLimit) then {

		_time = _timeLimit;

	};

	_timeLimitText = format ["Mission duration: %1 out of %2 minutes", _time, _timeLimit];

	_endTitleText = format ["%1<br />%2", _scenario, _timeLimitText];

};

if (!isNil "aCount_textBLU" && !isNil "aCount_textRED" && !isNil "aCount_textRES") then {
	_bottomTextLeft = format["%1",aCount_textBLU];
	_bottomTextMiddle = format["%1",aCount_textRED];
	_bottomTextRight = format["%1",aCount_textRES];
};

((findDisplay _dia) displayCtrl _endTitle) ctrlSetStructuredText parseText _endTitleText;
((findDisplay _dia) displayCtrl _left) ctrlSetStructuredText parseText _leftText;
((findDisplay _dia) displayCtrl _right) ctrlSetStructuredText parseText _rightText;
((findDisplay _dia) displayCtrl _bottomLeft) ctrlSetStructuredText parseText _bottomTextLeft;
((findDisplay _dia) displayCtrl _bottomMiddle) ctrlSetStructuredText parseText _bottomTextMiddle;
((findDisplay _dia) displayCtrl _bottomRight) ctrlSetStructuredText parseText _bottomTextRight;

for "_x" from 1 to 120 do {

	((findDisplay _dia) displayCtrl _bg) ctrlSetBackgroundColor [0, 0, 0, (_x * (1/120))];
	sleep(0.01);

};

sleep (15);
endMission "END1";
