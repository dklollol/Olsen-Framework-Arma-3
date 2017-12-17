/*
 * Author: Olsen
 *
 * Counts number of casualties on set team
 *
 * Arguments:
 * 0: team <string>
 *
 * Return Value:
 * casualty count <number>
 *
 * Public: Yes
 */

private _team = _this;

private _count = 0;

private _start = [_team, 3] call FNC_GetTeamVariable;
private _current = [_team, 4] call FNC_GetTeamVariable;

if (_start == 0) then {

	private _tempText = format ["Casualty count:<br></br>Warning no units on team ""%1"".", _team];
	_tempText call FNC_DebugMessage;

} else {

	_count = _start - _current;

};

_count