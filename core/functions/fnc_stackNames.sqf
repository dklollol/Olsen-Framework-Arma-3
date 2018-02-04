/*
 * Author: Olsen
 *
 * Counts how many elements in set array repeat and outputs it into array of strings in format ["count X value", ...].
 *
 * Arguments:
 * 0: array to process <array>
 *
 * Return Value:
 * array of strings <array>
 *
 * Public: No
 */

private _array = _this;
private _foundArray = [];
private _newArray = [];

{

	if (!(_x in _foundArray)) then {

		private _string = _x;

		_foundArray set [count _foundArray, _string];

		private _count = 0;

		{

			if (_string == _x) then {

				_count = _count + 1;

			};

		} forEach _array;

		_newArray set [count _newArray, format ["%1 X %2", _count, _string]];

	};

} forEach _array;

_newArray