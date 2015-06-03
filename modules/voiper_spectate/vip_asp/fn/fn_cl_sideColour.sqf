_side = _this select 0;
_b = 1;
_d = 0.35;
switch (_side) do {
	case 1: {[0.45, 0.45, _b, 0.9]};
	case 0: {[_b, _d, _d, 0.9]};
	case 2: {[_d, _b, _d, 0.9]};
	case 3: {[_b, _b, _b, 0.9]};
};