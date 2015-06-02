_count = count _this;

_a = 0;
_b = 0;
_c = 0;

{
	_a = _a + (_x select 0);
	_b = _b + (_x select 1);
	_c = _c + (_x select 2);

} forEach _this;

_a = _a / _count;
_b = _b / _count;
_c = _c / _count;

[_a, _b, _c]